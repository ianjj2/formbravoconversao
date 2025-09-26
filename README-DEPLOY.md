# 🚀 Guia de Deploy - Formulário Conversão Digital

## 📋 Pré-requisitos

- Conta no [Supabase](https://supabase.com)
- Conta no [Netlify](https://netlify.com)
- Node.js 18+ instalado

## 🗄️ Configuração do Supabase

### 1. Criar Projeto no Supabase

1. Acesse [supabase.com](https://supabase.com) e faça login
2. Clique em "New Project"
3. Escolha nome e senha para o banco
4. Aguarde a criação do projeto

### 2. Executar as Migrações SQL

1. No painel do Supabase, vá em **SQL Editor**
2. Copie e execute o conteúdo do arquivo `supabase/migrations/complete_schema.sql`
3. Verifique se todas as tabelas foram criadas corretamente

### 3. Configurar Variáveis de Ambiente

1. No Supabase, vá em **Settings > API**
2. Copie os valores:
   - **Project URL**
   - **anon/public key**

## 🌐 Deploy na Netlify

### Opção 1: Deploy via Git (Recomendado)

1. **Conecte seu repositório:**
   - Acesse [netlify.com](https://netlify.com)
   - Clique em "New site from Git"
   - Conecte com GitHub/GitLab/Bitbucket
   - Selecione seu repositório

2. **Configure o build:**
   - Build command: `npm run build`
   - Publish directory: `dist`
   - Node version: `18`

3. **Configure as variáveis de ambiente:**
   - Vá em **Site settings > Environment variables**
   - Adicione:
     ```
     VITE_SUPABASE_URL = sua_url_do_supabase
     VITE_SUPABASE_ANON_KEY = sua_chave_publica
     ```

4. **Deploy:**
   - Clique em "Deploy site"
   - Aguarde o build finalizar

### Opção 2: Deploy Manual

1. **Build local:**
   ```bash
   npm install
   npm run build
   ```

2. **Upload na Netlify:**
   - Acesse netlify.com
   - Arraste a pasta `dist` para a área de deploy
   - Configure as variáveis de ambiente no painel

## 🔧 Configurações Importantes

### Variáveis de Ambiente Necessárias

```env
VITE_SUPABASE_URL=https://seu-projeto.supabase.co
VITE_SUPABASE_ANON_KEY=sua_chave_publica_aqui
```

### Atualizar Client do Supabase

Se necessário, atualize o arquivo `src/integrations/supabase/client.ts`:

```typescript
const SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL;
const SUPABASE_PUBLISHABLE_KEY = import.meta.env.VITE_SUPABASE_ANON_KEY;
```

## 🛡️ Segurança

### Row Level Security (RLS)
- ✅ RLS habilitado na tabela `event_registrations`
- ✅ Política permite inserção anônima (formulário público)
- ✅ Política permite leitura apenas para usuários autenticados (admin)

### Validações
- ✅ Validação de CPF no banco de dados
- ✅ Validação de formato de telefone e email
- ✅ Sanitização de dados de entrada

## 📊 Monitoramento

### Acessar Dados no Supabase
1. Vá em **Table Editor** no painel do Supabase
2. Selecione a tabela `event_registrations`
3. Visualize os cadastros em tempo real

### Views para Relatórios
- `registration_stats` - Estatísticas por evento/status
- `daily_registrations` - Relatório diário de cadastros

## 🔍 Verificação de Funcionamento

1. **Teste o formulário:** Preencha com dados válidos
2. **Verifique no Supabase:** Dados devem aparecer na tabela
3. **Teste validações:** CPF inválido deve ser rejeitado
4. **Mensagem de sucesso:** Deve exibir confirmação de cadastro

## 🚨 Troubleshooting

### Erro de CORS
- Verifique se a URL do Netlify está configurada no Supabase
- Vá em **Authentication > URL Configuration**

### Erro de RLS
- Verifique se as políticas estão habilitadas
- Teste com usuário anônimo

### Build falha na Netlify
- Verifique se as variáveis de ambiente estão corretas
- Confirme que o Node.js é versão 18+

## 📝 Logs e Debug

### Netlify
- Logs de build: **Site settings > Build & deploy > Deploy logs**
- Logs de função: **Functions** (se usar)

### Supabase
- Logs de banco: **Settings > Logs**
- Logs de API: **Settings > API Logs**

---

## 💡 Dicas Adicionais

1. **Custom Domain:** Configure domínio personalizado no Netlify
2. **SSL:** SSL é automático no Netlify
3. **CDN:** CDN global está incluído
4. **Backup:** Configure backup automático no Supabase
5. **Monitoramento:** Use Supabase Analytics para acompanhar uso

---

**🎉 Pronto! Seu formulário está no ar!**

Para suporte, verifique:
- [Documentação Netlify](https://docs.netlify.com)
- [Documentação Supabase](https://supabase.com/docs)
