# Publicar o Sancta nas lojas gratuitas

Análise feita em 14/11/2026 sobre o commit `d948d0e`.

## Situação do app
| Item | Estado |
|---|---|
| Testes automáticos | ✅ 430 passando |
| Análise de código | ✅ sem erros (1 aviso sem importância: variável não usada) |
| Build de release | ✅ compila; APK universal de 66 MB, ou ~24 MB por arquitetura (`--split-per-abi`) |
| Permissões do APK final | ✅ notificações, alarmes exatos, vibração, tela acesa. **Sem internet** |
| Dependências | ✅ todas livres (MIT, BSD, Apache, MPL), sem Google Play Services |
| Doações | ✅ PIX (chave, nome e cidade), Ko-fi e Bitcoin preenchidos |
| Ficha da loja | ✅ `fastlane/metadata/android` (pt-BR e en-US, 6 capturas) |
| **Chave de assinatura** | ❌ não existe: o APK atual sai assinado com a chave de *debug* |
| **Direitos dos textos** | ❌ 325 textos a revisar em `TEXTOS_ORIGEM.md` (lista por prioridade) |
| **Teste em celular real** | ❌ falta (PIX no banco, Bitcoin na carteira, lembretes, vibração) |
| ID do app | ✅ `br.com.sancta.devocionario` (definitivo) |

## Quais lojas são gratuitas
| Loja | Custo | Quem compila | Prazo típico | Links de doação |
|---|---|---|---|---|
| **GitHub Releases** | grátis | você | imediato | sim |
| **IzzyOnDroid** (repositório F-Droid) | grátis | você (usa o APK do GitHub) | dias | sim |
| **F-Droid** oficial | grátis | o F-Droid, a partir do código | semanas | sim (campo `Donate`) |
| **Samsung Galaxy Store** | grátis | você | dias a semanas | use a versão sem links (`-Loja`) |
| Google Play | US$ 25 (uma vez) | você | dias | use a versão sem links |

Ordem sugerida: GitHub → IzzyOnDroid → F-Droid → Galaxy Store. As regras de cada loja mudam; confira a página de cada uma antes de enviar.

---

## Passo 0 — Antes de tudo (uma vez só)
1. **Decida o ID do app.** Depois de publicado, não muda. Se quiser outro (ex.: `br.com.sancta.devocionario`), me peça para trocar antes do passo 1.
2. **Confira os textos.** Abra `TEXTOS_ORIGEM.md` e comece pelos grupos de risco ALTO (Guia da Missa e salmos) e MÉDIO (ladainhas e novenas). Para cada texto: marque a fonte, troque por uma versão em domínio público ou remova. Confirme também a origem das imagens de `lib/imgs/` e do ícone.
3. **Teste no seu celular** (instale `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk`):
   - PIX: escaneie o QR com outro banco e confira se aparece *Diego Cesar Sousa Costa* e o valor (cancele antes de pagar).
   - Bitcoin: escaneie o QR com sua carteira e confira o endereço.
   - Lembretes: crie um para daqui a 2 minutos e veja se toca com o app fechado.
   - Guia, terço (vibrações) e backup/restauração.

## Passo 1 — Criar a chave de assinatura
Siga `PUBLICACAO_FASE1.md` (seção da chave). Em resumo:
```powershell
keytool -genkey -v -keystore C:\Users\diego\chaves\sancta-upload.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
Depois copie `android/key.properties.example` para `android/key.properties` e preencha.
**Guarde o `.jks` e as senhas em dois lugares seguros** (ex.: pendrive + nuvem). Sem eles você nunca mais consegue atualizar o app nas lojas onde você assina.

## Passo 2 — Gerar a versão
```powershell
.\tool\build_release.ps1
```
Gera os APKs com links de doação. Para lojas comerciais: `.\tool\build_release.ps1 -Loja` (sem PIX/cartão/cripto, só o pedido de oração).

## Passo 3 — GitHub (código + downloads)
1. Crie uma conta em <https://github.com> (se ainda não tiver) e instale o GitHub CLI (`winget install GitHub.cli`), depois `gh auth login`.
2. Atenção: o histórico inteiro fica público, incluindo o e-mail dos commits.
3. No projeto:
   ```powershell
   gh repo create sancta-devocionario --public --source . --remote origin --push
   git tag v1.0.0
   git push origin v1.0.0
   gh release create v1.0.0 build\app\outputs\flutter-apk\app-*-release.apk --title "Sancta 1.0.0" --notes-file fastlane\metadata\android\pt-BR\changelogs\1.txt
   ```
4. Pronto: qualquer pessoa já pode baixar o APK pela página *Releases*.

## Passo 4 — IzzyOnDroid (o mais rápido para aparecer no app F-Droid)
1. Abra um pedido em <https://gitlab.com/IzzyOnDroid/repo/-/issues> (modelo "inclusion request") com o link do repositório.
2. Eles leem os APKs da sua *Release* do GitHub e a ficha da pasta `fastlane/`. A cada nova release, o app atualiza sozinho.
3. Quem usa o app F-Droid ou o Neo Store adiciona o repositório IzzyOnDroid e encontra o Sancta.

## Passo 5 — F-Droid oficial
1. Crie uma conta em <https://gitlab.com> e faça um *fork* de <https://gitlab.com/fdroid/fdroiddata>.
2. Crie o arquivo `metadata/br.com.sancta.devocionario.yml` com a receita de `PUBLICACAO_FASE6.md` (troque `ogeidrasec`).
3. Abra o *merge request*. Os revisores vão compilar o app a partir do código; responda às perguntas deles (costumam pedir ajustes). Leva semanas.
4. O F-Droid assina com a chave dele: quem instalou pelo F-Droid só atualiza pelo F-Droid.

## Passo 6 — Samsung Galaxy Store (opcional)
1. Crie uma conta de vendedor gratuita em <https://seller.samsungapps.com>.
2. Envie o APK gerado com `-Loja`, preencha a ficha com os textos de `fastlane/metadata/android/pt-BR/`, as capturas e a política de privacidade (pode ser um link para o README do GitHub, seção *Privacidade*).
3. Classificação indicativa: livre. Categoria: estilo de vida ou livros/referência.

## Para cada atualização
1. Aumente a versão em `pubspec.yaml` (ex.: `1.0.1+2`; o número depois do `+` sempre sobe).
2. Escreva `fastlane/metadata/android/pt-BR/changelogs/2.txt` (e en-US).
3. `.\tool\build_release.ps1`, depois `git tag v1.0.1`, `git push --tags` e `gh release create v1.0.1 ...`.
4. IzzyOnDroid e F-Droid pegam a nova versão sozinhos pela tag.
