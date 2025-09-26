-- ====================================
-- ESQUEMA COMPLETO PARA SUPABASE
-- Formulário de Cadastro - Evento Conversão Digital
-- ====================================

-- Remover tabelas se existirem (para recriar com esquema completo)
DROP TABLE IF EXISTS public.event_registrations CASCADE;
DROP TABLE IF EXISTS public.submissions CASCADE;
DROP TABLE IF EXISTS public.tickets CASCADE;

-- ====================================
-- EXTENSÕES
-- ====================================

-- Habilitar extensões necessárias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "btree_gin";

-- ====================================
-- TABELA PRINCIPAL: EVENT_REGISTRATIONS
-- ====================================

CREATE TABLE public.event_registrations (
    id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    nome VARCHAR(100) NOT NULL CHECK (length(trim(nome)) >= 2),
    cpf VARCHAR(14) NOT NULL UNIQUE CHECK (cpf ~ '^\d{3}\.\d{3}\.\d{3}-\d{2}$'),
    telefone VARCHAR(15) NOT NULL CHECK (telefone ~ '^\(\d{2}\)\s\d{4,5}-\d{4}$'),
    email VARCHAR(255) NOT NULL CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    ip_address INET,
    user_agent TEXT,
    event_name VARCHAR(100) DEFAULT 'Conversão Digital',
    status VARCHAR(20) DEFAULT 'registered' CHECK (status IN ('registered', 'confirmed', 'cancelled')),
    source VARCHAR(50) DEFAULT 'website',
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- ====================================
-- ÍNDICES PARA PERFORMANCE
-- ====================================

-- Índice para consultas por email (busca rápida)
CREATE INDEX idx_event_registrations_email ON public.event_registrations(email);

-- Índice para consultas por CPF (busca rápida)
CREATE INDEX idx_event_registrations_cpf ON public.event_registrations(cpf);

-- Índice para consultas por data de criação
CREATE INDEX idx_event_registrations_created_at ON public.event_registrations(created_at DESC);

-- Índice para consultas por status
CREATE INDEX idx_event_registrations_status ON public.event_registrations(status);

-- Índice composto para relatórios por evento e data
CREATE INDEX idx_event_registrations_event_date ON public.event_registrations(event_name, created_at DESC);

-- ====================================
-- FUNÇÕES AUXILIARES
-- ====================================

-- Função para atualizar timestamp automaticamente
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SET search_path = public;

-- Função para validar CPF (algoritmo oficial)
CREATE OR REPLACE FUNCTION public.validate_cpf(cpf_input TEXT)
RETURNS BOOLEAN AS $$
DECLARE
    cpf_numbers TEXT;
    digit1 INTEGER;
    digit2 INTEGER;
    sum_result INTEGER;
    i INTEGER;
BEGIN
    -- Remove formatação
    cpf_numbers := regexp_replace(cpf_input, '[^0-9]', '', 'g');
    
    -- Verifica se tem 11 dígitos
    IF length(cpf_numbers) != 11 THEN
        RETURN FALSE;
    END IF;
    
    -- Verifica sequências inválidas
    IF cpf_numbers ~ '^(\d)\1{10}$' THEN
        RETURN FALSE;
    END IF;
    
    -- Calcula primeiro dígito verificador
    sum_result := 0;
    FOR i IN 1..9 LOOP
        sum_result := sum_result + (substring(cpf_numbers, i, 1)::INTEGER * (11 - i));
    END LOOP;
    
    digit1 := 11 - (sum_result % 11);
    IF digit1 >= 10 THEN
        digit1 := 0;
    END IF;
    
    -- Calcula segundo dígito verificador
    sum_result := 0;
    FOR i IN 1..10 LOOP
        sum_result := sum_result + (substring(cpf_numbers, i, 1)::INTEGER * (12 - i));
    END LOOP;
    
    digit2 := 11 - (sum_result % 11);
    IF digit2 >= 10 THEN
        digit2 := 0;
    END IF;
    
    -- Verifica se os dígitos calculados conferem
    RETURN (substring(cpf_numbers, 10, 1)::INTEGER = digit1) AND 
           (substring(cpf_numbers, 11, 1)::INTEGER = digit2);
END;
$$ LANGUAGE plpgsql;

-- ====================================
-- TRIGGERS
-- ====================================

-- Trigger para atualizar timestamp automaticamente
CREATE TRIGGER update_event_registrations_updated_at
    BEFORE UPDATE ON public.event_registrations
    FOR EACH ROW
    EXECUTE FUNCTION public.update_updated_at_column();

-- Trigger para validar CPF antes de inserir/atualizar
CREATE OR REPLACE FUNCTION public.validate_cpf_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT public.validate_cpf(NEW.cpf) THEN
        RAISE EXCEPTION 'CPF inválido: %', NEW.cpf;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validate_cpf_before_insert_update
    BEFORE INSERT OR UPDATE ON public.event_registrations
    FOR EACH ROW
    EXECUTE FUNCTION public.validate_cpf_trigger();

-- ====================================
-- ROW LEVEL SECURITY (RLS)
-- ====================================

-- Habilitar Row Level Security
ALTER TABLE public.event_registrations ENABLE ROW LEVEL SECURITY;

-- Política: Permitir inserção anônima (formulário público)
CREATE POLICY "Allow anonymous inserts for event registrations" 
ON public.event_registrations 
FOR INSERT 
TO anon
WITH CHECK (true);

-- Política: Permitir visualização apenas para usuários autenticados (admin)
CREATE POLICY "Allow authenticated users to view registrations" 
ON public.event_registrations 
FOR SELECT 
TO authenticated
USING (true);

-- Política: Permitir atualização apenas para usuários autenticados (admin)
CREATE POLICY "Allow authenticated users to update registrations" 
ON public.event_registrations 
FOR UPDATE 
TO authenticated
USING (true)
WITH CHECK (true);

-- ====================================
-- VIEWS PARA RELATÓRIOS
-- ====================================

-- View para estatísticas básicas
CREATE OR REPLACE VIEW public.registration_stats AS
SELECT 
    event_name,
    status,
    COUNT(*) as total_registrations,
    DATE(created_at) as registration_date
FROM public.event_registrations
GROUP BY event_name, status, DATE(created_at)
ORDER BY registration_date DESC;

-- View para relatório diário
CREATE OR REPLACE VIEW public.daily_registrations AS
SELECT 
    DATE(created_at) as date,
    COUNT(*) as total,
    COUNT(CASE WHEN status = 'registered' THEN 1 END) as registered,
    COUNT(CASE WHEN status = 'confirmed' THEN 1 END) as confirmed,
    COUNT(CASE WHEN status = 'cancelled' THEN 1 END) as cancelled
FROM public.event_registrations
GROUP BY DATE(created_at)
ORDER BY date DESC;

-- ====================================
-- CONFIGURAÇÕES DE SEGURANÇA
-- ====================================

-- Permitir acesso às views para usuários autenticados
GRANT SELECT ON public.registration_stats TO authenticated;
GRANT SELECT ON public.daily_registrations TO authenticated;

-- Comentários para documentação
COMMENT ON TABLE public.event_registrations IS 'Tabela principal para cadastros do evento Conversão Digital';
COMMENT ON COLUMN public.event_registrations.cpf IS 'CPF formatado (000.000.000-00) com validação automática';
COMMENT ON COLUMN public.event_registrations.telefone IS 'Telefone formatado ((00) 00000-0000)';
COMMENT ON COLUMN public.event_registrations.status IS 'Status do cadastro: registered, confirmed, cancelled';
COMMENT ON COLUMN public.event_registrations.source IS 'Origem do cadastro (website, app, etc.)';

-- ====================================
-- DADOS INICIAIS (OPCIONAL)
-- ====================================

-- Inserir configurações básicas se necessário
-- INSERT INTO public.event_registrations (nome, cpf, telefone, email, event_name, status) 
-- VALUES ('Admin Sistema', '000.000.000-00', '(11) 99999-9999', 'admin@bravobet.com', 'Sistema', 'confirmed');
