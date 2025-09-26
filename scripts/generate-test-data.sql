-- ====================================
-- SCRIPT PARA GERAR DADOS DE TESTE
-- Execute apenas em ambiente de desenvolvimento!
-- ====================================

-- ATENÇÃO: Este script insere dados fictícios para teste
-- NÃO execute em produção!

-- Verificar se estamos em ambiente de desenvolvimento
-- (Este script deve ser executado manualmente apenas para testes)

-- Dados de teste válidos
INSERT INTO public.event_registrations (nome, cpf, telefone, email, event_name, status, source) VALUES
('João Silva Santos', '123.456.789-01', '(11) 98765-4321', 'joao.silva@email.com', 'Conversão Digital', 'registered', 'website'),
('Maria Oliveira Costa', '987.654.321-00', '(21) 99876-5432', 'maria.oliveira@email.com', 'Conversão Digital', 'confirmed', 'website'),
('Pedro Henrique Lima', '456.789.123-45', '(31) 97654-3210', 'pedro.lima@email.com', 'Conversão Digital', 'registered', 'website'),
('Ana Carolina Souza', '789.123.456-78', '(41) 96543-2109', 'ana.souza@email.com', 'Conversão Digital', 'confirmed', 'website'),
('Carlos Eduardo Nunes', '321.654.987-12', '(51) 95432-1098', 'carlos.nunes@email.com', 'Conversão Digital', 'registered', 'website'),
('Fernanda Ribeiro Santos', '654.987.321-34', '(61) 94321-0987', 'fernanda.ribeiro@email.com', 'Conversão Digital', 'cancelled', 'website'),
('Ricardo Almeida Costa', '147.258.369-56', '(71) 93210-9876', 'ricardo.almeida@email.com', 'Conversão Digital', 'confirmed', 'website'),
('Juliana Pereira Silva', '258.369.147-89', '(81) 92109-8765', 'juliana.pereira@email.com', 'Conversão Digital', 'registered', 'website'),
('Marcos Antonio Ferreira', '369.147.258-01', '(91) 91098-7654', 'marcos.ferreira@email.com', 'Conversão Digital', 'confirmed', 'website'),
('Luciana Martins Rocha', '741.852.963-23', '(11) 90987-6543', 'luciana.martins@email.com', 'Conversão Digital', 'registered', 'website');

-- Verificar dados inseridos
SELECT 
    nome,
    cpf,
    telefone,
    email,
    status,
    created_at
FROM public.event_registrations 
ORDER BY created_at DESC 
LIMIT 10;

-- Verificar estatísticas
SELECT 
    status,
    COUNT(*) as total
FROM public.event_registrations 
GROUP BY status;

-- Nota: Os CPFs usados são fictícios para teste
-- Em produção, apenas CPFs reais e válidos devem ser aceitos

