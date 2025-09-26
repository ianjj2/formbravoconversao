# 🚀 Configuração Git e Deploy para GitHub

## ⚠️ Git não encontrado no sistema

Para fazer o commit para o GitHub, você precisa ter o Git instalado. Aqui estão as opções:

### Opção 1: Instalar Git (Recomendado)

1. **Download direto:**
   - Acesse: https://git-scm.com/download/win
   - Baixe e instale a versão mais recente
   - Use as configurações padrão

2. **Via winget (se disponível):**
   ```powershell
   winget install --id Git.Git -e --source winget
   ```

3. **Via Chocolatey (se instalado):**
   ```powershell
   choco install git
   ```

### Opção 2: GitHub Desktop (Mais fácil)

1. **Download:**
   - Acesse: https://desktop.github.com/
   - Baixe e instale o GitHub Desktop
   - Faça login com sua conta GitHub

2. **Usar GitHub Desktop:**
   - Abra o GitHub Desktop
   - Clique em "Add an Existing Repository from your Hard Drive"
   - Selecione a pasta: `C:\Users\Ian\Desktop\form-simples-bonito-main`
   - Conecte ao repositório: https://github.com/ianjj2/formbravoconversao

### Opção 3: Upload Manual via Interface Web

1. **Criar ZIP:**
   - Comprima toda a pasta do projeto em um arquivo ZIP
   - Exclua `node_modules` e `.git` se existirem

2. **Upload no GitHub:**
   - Vá para: https://github.com/ianjj2/formbravoconversao
   - Clique em "uploading an existing file"
   - Arraste o ZIP ou selecione os arquivos

## 📝 Após instalar o Git, execute estes comandos:

```bash
# Navegar para a pasta do projeto
cd "C:\Users\Ian\Desktop\form-simples-bonito-main"

# Inicializar repositório Git
git init

# Configurar usuário (se necessário)
git config user.name "Seu Nome"
git config user.email "seu-email@exemplo.com"

# Adicionar todos os arquivos
git add .

# Fazer commit inicial
git commit -m "🚀 Commit inicial: Formulário de cadastro Conversão Digital

✨ Funcionalidades:
- Formulário React com validação de CPF
- Integração com Supabase
- Interface moderna com shadcn/ui
- Configuração completa para Netlify

🗄️ Banco de dados:
- Schema SQL otimizado com RLS
- Validação automática de CPF
- Views para relatórios
- Índices para performance

🌐 Deploy:
- Configuração Netlify completa
- Headers de segurança
- Cache otimizado
- Redirects SPA configurados"

# Conectar ao repositório remoto
git remote add origin https://github.com/ianjj2/formbravoconversao.git

# Fazer push para o GitHub
git push -u origin main
```

## 🎯 Próximos passos após o push:

1. **Configurar Netlify:**
   - Conecte seu repositório GitHub no Netlify
   - Configure as variáveis de ambiente do Supabase

2. **Executar SQL no Supabase:**
   - Use o arquivo `supabase/migrations/complete_schema.sql`

3. **Testar aplicação:**
   - O formulário estará funcionando automaticamente

---

**💡 Dica:** Se preferir usar o GitHub Desktop, é a opção mais visual e fácil para iniciantes!

