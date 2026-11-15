# Gera o pacote de release (APK para F-Droid/GitHub ou .aab para lojas) com as verificações de segurança.
#
# Uso (na pasta do projeto):
#   pwsh tool/build_release.ps1                # APK para F-Droid/GitHub (com doações)
#   pwsh tool/build_release.ps1 -Loja          # .aab para Play Store (sem links de pagamento)
#   pwsh tool/build_release.ps1 -Rascunho      # aceita doações provisórias (só para testes!)
#   pwsh tool/build_release.ps1 -PularTestes
param(
    [switch]$Loja,
    [switch]$Rascunho,
    [switch]$PularTestes
)
$ErrorActionPreference = 'Stop'
Set-Location (Join-Path $PSScriptRoot '..')
$problemas = @()

# 1. Chave de upload
if (-not (Test-Path 'android/key.properties')) {
    $problemas += 'android/key.properties não existe: o pacote sairia com a chave de DEBUG (a Play recusa). Veja android/key.properties.example.'
} else {
    $props = (Get-Content 'android/key.properties' -Raw).Replace('\', '/') | ConvertFrom-StringData
    $storeFile = $props.storeFile
    # o Gradle resolve caminhos relativos a partir de android/app
    $existe = $storeFile -and ((Test-Path $storeFile) -or (Test-Path (Join-Path 'android/app' $storeFile)))
    if (-not $existe) {
        $problemas += "Keystore não encontrado em '$storeFile'."
    }
}

# 2. Doações provisórias (chave PIX, links e endereços "PREENCHER")
$doacoes = Get-Content 'lib/config/donation_config.dart' -Raw
if (-not $Loja -and -not $Rascunho -and ($doacoes -match "'[^']*PREENCHER[^']*'")) {
    $problemas += 'lib/config/donation_config.dart ainda tem valores PREENCHER (PIX, cartão ou cripto). Preencha ou deixe vazio o que não usar.'
}

# 3. Versão
$versao = (Select-String -Path 'pubspec.yaml' -Pattern '^version:\s*(.+)$').Matches[0].Groups[1].Value
Write-Host "Versão: $versao  (aumente o número depois do + a cada envio para a Play)"

if ($problemas.Count -gt 0) {
    Write-Host "`nNão gerei o pacote:" -ForegroundColor Red
    $problemas | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
    exit 1
}

if (-not $PularTestes) {
    Remove-Item -ErrorAction SilentlyContinue sqlite3.dll
    flutter test
    if ($LASTEXITCODE -ne 0) { Write-Host 'Testes falharam.' -ForegroundColor Red; exit 1 }
}

# Ofuscação + símbolos separados (guarde build/symbols para ler relatórios de falha)
if ($Loja) {
    # Lojas: sem links de pagamento externos (só o pedido de oração)
    flutter build appbundle --release --obfuscate --split-debug-info=build/symbols/$versao --dart-define=DONATION_LINKS=false
    if ($LASTEXITCODE -ne 0) { exit 1 }
    Write-Host "`nPronto: build/app/outputs/bundle/release/app-release.aab" -ForegroundColor Green
} else {
    # F-Droid compila ele mesmo a partir do código; este APK é para o GitHub Releases
    flutter build apk --release --split-per-abi --obfuscate --split-debug-info=build/symbols/$versao
    if ($LASTEXITCODE -ne 0) { exit 1 }
    Write-Host "`nPronto: build/app/outputs/flutter-apk/ (um APK por tipo de processador)" -ForegroundColor Green
}
Write-Host "Símbolos: build/symbols/$versao (guarde junto com esta versão)"
