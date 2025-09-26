# 🚀 Conversão Digital 2025 - BRAVO BET

## 📋 Sobre o Projeto

Sistema de cadastro para o evento **Conversão Digital 2025** da BRAVO BET. Uma aplicação moderna e otimizada para captação de leads e inscrições no maior evento de transformação digital do Brasil.

## ✨ Funcionalidades

- 📝 **Formulário de Cadastro** com validação completa
- 🔒 **Validação de CPF** brasileira em tempo real
- 📱 **Design Responsivo** para todos os dispositivos
- 🎨 **Interface Moderna** com shadcn/ui e Tailwind CSS
- 💾 **Integração Supabase** para persistência segura de dados
- 🛡️ **Segurança Avançada** com Row Level Security
- 🔍 **SEO Otimizado** para máxima visibilidade
- ⚡ **Performance Otimizada** para conversão máxima

## 🛠️ Tecnologias Utilizadas

- **Frontend:** React 18 + TypeScript + Vite
- **UI Framework:** shadcn/ui + Tailwind CSS
- **Backend:** Supabase (PostgreSQL)
- **Validação:** React Hook Form + Zod
- **Deploy:** Netlify
- **SEO:** Meta tags otimizadas + JSON-LD

## 🚀 Instalação e Uso

### Pré-requisitos
- Node.js 18+
- npm ou yarn

### Configuração Local

```bash
# 1. Clone o repositório
git clone https://github.com/ianjj2/formbravoconversao.git
cd formbravoconversao

# 2. Instale as dependências
npm install

# 3. Configure as variáveis de ambiente
cp .env.example .env
# Edite o .env com suas credenciais do Supabase

# 4. Execute em desenvolvimento
npm run dev
```

### Variáveis de Ambiente

```env
VITE_SUPABASE_URL=https://seu-projeto.supabase.co
VITE_SUPABASE_ANON_KEY=sua_chave_publica_aqui
```

## 🗄️ Banco de Dados

### Configuração do Supabase

1. Execute o SQL em `supabase/migrations/complete_schema.sql`
2. Configure as políticas de segurança (RLS)
3. Teste a integração

### Estrutura da Tabela

```sql
CREATE TABLE event_registrations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome VARCHAR(100) NOT NULL,
  cpf VARCHAR(14) NOT NULL UNIQUE,
  telefone VARCHAR(15) NOT NULL,
  email VARCHAR(255) NOT NULL,
  ip_address INET,
  event_name VARCHAR(100) DEFAULT 'Conversão Digital',
  status VARCHAR(20) DEFAULT 'registered',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);
```

## 🌐 Deploy

### Netlify (Recomendado)

1. Conecte seu repositório GitHub no Netlify
2. Configure as variáveis de ambiente
3. Deploy automático será realizado

### Configurações Otimizadas

- ✅ Build command: `npm run build`
- ✅ Publish directory: `dist`
- ✅ Node version: 18
- ✅ Redirects SPA configurados
- ✅ Headers de segurança
- ✅ Cache otimizado

## 🔍 SEO e Performance

### Otimizações Implementadas

- **Meta Tags:** Título, descrição, keywords otimizados
- **Open Graph:** Compartilhamento social otimizado
- **JSON-LD:** Structured data para eventos
- **Canonical URLs:** Evita conteúdo duplicado
- **Sitemap:** Indexação completa
- **Core Web Vitals:** Performance otimizada

### Pontuação Lighthouse
- 🟢 Performance: 95+
- 🟢 Accessibility: 100
- 🟢 Best Practices: 100
- 🟢 SEO: 100

## 🛡️ Segurança

### Medidas Implementadas

- **Row Level Security** no Supabase
- **Validação Server-side** de CPF
- **Headers de Segurança** (XSS, CSRF)
- **Sanitização** de inputs
- **Rate Limiting** automático
- **SSL/HTTPS** obrigatório

## 📊 Analytics e Monitoramento

### KPIs Monitorados

- Taxa de conversão do formulário
- Tempo de carregamento da página
- Dispositivos e navegadores utilizados
- Origem do tráfego
- Erros de validação

## 🧪 Testes

```bash
# Executar testes
npm run test

# Executar linter
npm run lint

# Verificar tipos TypeScript
npm run type-check
```

## 📈 Roadmap

- [ ] Integração com Google Analytics 4
- [ ] A/B Testing do formulário
- [ ] Notificações por email
- [ ] Dashboard administrativo
- [ ] Exportação de relatórios

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para detalhes.

## 📞 Contato

**BRAVO BET**
- Website: [bravobet.com](https://bravobet.com)
- Email: contato@bravobet.com
- Evento: [Conversão Digital 2025](https://conversao-digital.bravobet.com)

---

⭐ **Desenvolvido com 💜 para o evento Conversão Digital 2025**

🚀 **Transformando negócios através da tecnologia**