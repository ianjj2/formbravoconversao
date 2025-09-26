# ====================================
# SCRIPT PARA COMMIT NO GITHUB
# Formulário Conversão Digital - BRAVO BET
# ====================================

Write-Host "🚀 Iniciando processo de commit para GitHub..." -ForegroundColor Green
Write-Host ""

# Verificar se Git está instalado
try {
    $gitVersion = git --version 2>$null
    Write-Host "✅ Git encontrado: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Git não está instalado!" -ForegroundColor Red
    Write-Host "Por favor, instale o Git primeiro:" -ForegroundColor Yellow
    Write-Host "1. https://git-scm.com/download/win" -ForegroundColor Yellow
    Write-Host "2. ou execute: winget install --id Git.Git -e --source winget" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Pressione Enter para sair..."
    exit 1
}

# Verificar se estamos na pasta correta
$currentPath = Get-Location
Write-Host "📁 Pasta atual: $currentPath" -ForegroundColor Cyan

# Verificar se já é um repositório Git
if (Test-Path ".git") {
    Write-Host "📦 Repositório Git já existe" -ForegroundColor Yellow
} else {
    Write-Host "🔧 Inicializando repositório Git..." -ForegroundColor Cyan
    git init
    Write-Host "✅ Repositório Git inicializado" -ForegroundColor Green
}

# Configurar usuário se necessário
$userName = git config user.name 2>$null
$userEmail = git config user.email 2>$null

if (-not $userName) {
    $inputName = Read-Host "Digite seu nome para o Git"
    git config user.name "$inputName"
    Write-Host "✅ Nome configurado: $inputName" -ForegroundColor Green
}

if (-not $userEmail) {
    $inputEmail = Read-Host "Digite seu email para o Git"
    git config user.email "$inputEmail"
    Write-Host "✅ Email configurado: $inputEmail" -ForegroundColor Green
}

# Verificar status
Write-Host ""
Write-Host "📋 Status dos arquivos:" -ForegroundColor Cyan
git status --porcelain

# Adicionar todos os arquivos
Write-Host ""
Write-Host "📁 Adicionando arquivos ao staging..." -ForegroundColor Cyan
git add .

# Mostrar arquivos que serão commitados
Write-Host ""
Write-Host "📝 Arquivos que serão commitados:" -ForegroundColor Cyan
git diff --cached --name-status

# Fazer commit
Write-Host ""
Write-Host "💾 Fazendo commit..." -ForegroundColor Cyan

$commitMessage = @"
🚀 Commit inicial: Formulário de cadastro Conversão Digital

✨ Funcionalidades implementadas:
- Formulário React com validação completa de CPF brasileiro
- Integração com Supabase para persistência de dados
- Interface moderna usando shadcn/ui e Tailwind CSS
- Download automático de CSV como backup
- Validação em tempo real de formulários

🗄️ Banco de dados Supabase:
- Schema SQL otimizado com Row Level Security (RLS)
- Validação automática de CPF no banco de dados
- Índices para consultas rápidas por email, CPF e data
- Triggers para timestamps automáticos
- Views para relatórios e estatísticas
- Políticas de segurança (inserção anônima, leitura admin)

🌐 Configuração para deploy:
- Netlify.toml com configurações otimizadas
- Headers de segurança implementados
- Cache configurado para assets estáticos
- Redirects SPA para React Router
- Variáveis de ambiente para Supabase
- Scripts de build e deploy automatizados

🛡️ Segurança implementada:
- Row Level Security habilitado
- Validação de entrada sanitizada
- Headers de segurança (XSS, CSRF, etc.)
- Políticas de cache seguras
- Validação de CPF server-side

📊 Recursos adicionais:
- Dados de teste para desenvolvimento
- Documentação completa de deploy
- Scripts utilitários para verificação
- Configuração Git e .gitignore otimizado

Pronto para deploy na Netlify! 🎉
"@

git commit -m "$commitMessage"

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Commit realizado com sucesso!" -ForegroundColor Green
} else {
    Write-Host "❌ Erro ao fazer commit" -ForegroundColor Red
    Read-Host "Pressione Enter para sair..."
    exit 1
}

# Configurar remote origin
Write-Host ""
Write-Host "🔗 Configurando remote origin..." -ForegroundColor Cyan

# Remover origin existente se houver
git remote remove origin 2>$null

# Adicionar novo remote
git remote add origin https://github.com/ianjj2/formbravoconversao.git

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Remote origin configurado" -ForegroundColor Green
} else {
    Write-Host "❌ Erro ao configurar remote" -ForegroundColor Red
}

# Verificar remote
Write-Host ""
Write-Host "🔍 Verificando remote configurado:" -ForegroundColor Cyan
git remote -v

# Fazer push
Write-Host ""
Write-Host "📤 Fazendo push para GitHub..." -ForegroundColor Cyan
Write-Host "Isso pode solicitar suas credenciais do GitHub..." -ForegroundColor Yellow

git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "🎉 SUCESSO! Projeto enviado para GitHub!" -ForegroundColor Green
    Write-Host ""
    Write-Host "🔗 Seu repositório: https://github.com/ianjj2/formbravoconversao" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "📋 Próximos passos:" -ForegroundColor Yellow
    Write-Host "1. Configure o Supabase executando o SQL em: supabase/migrations/complete_schema.sql" -ForegroundColor White
    Write-Host "2. Configure o Netlify conectando seu repositório GitHub" -ForegroundColor White
    Write-Host "3. Adicione as variáveis de ambiente do Supabase no Netlify" -ForegroundColor White
    Write-Host "4. Teste o formulário no ambiente de produção" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "❌ Erro no push. Possíveis soluções:" -ForegroundColor Red
    Write-Host "1. Verifique suas credenciais do GitHub" -ForegroundColor Yellow
    Write-Host "2. Configure um Personal Access Token se necessário" -ForegroundColor Yellow
    Write-Host "3. Tente usar GitHub Desktop como alternativa" -ForegroundColor Yellow
}

Write-Host ""
Read-Host "Pressione Enter para finalizar..."

