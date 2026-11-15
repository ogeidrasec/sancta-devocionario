# Fase 6 — GitHub e F-Droid

## Já preparado neste repositório
- `LICENSE` (GPL-3.0) e `README.md`.
- Ficha do F-Droid em `fastlane/metadata/android/` (pt-BR e en-US): título, descrições, changelog `1.txt` (versionCode 1) e 6 capturas de tela (pt-BR).
- Dependências conferidas: todas as 123 do `pubspec.lock` são MIT, BSD, Apache-2.0 ou MPL-2.0. Nenhuma depende dos Serviços do Google (sem Firebase, sem Play Billing).
- O APK de release **não tem a permissão INTERNET** (só as variantes debug/profile têm): a frase "sem rastreamento" é verdadeira.

## Antes de publicar (decisões suas)
1. **Licença do código:** coloquei GPL-3.0 (a que sugeri). Se preferir outra (MIT, Apache-2.0...), troque o `LICENSE` e a última seção do README.
2. **Textos e imagens:** o F-Droid exige que tudo no repositório possa ser distribuído. Termine a conferência do `TEXTOS_ORIGEM.md` (o Missal em português, os salmos e as ladainhas são os pontos de risco ALTO/MÉDIO) e confirme a origem das imagens de `lib/imgs/` e do ícone. Se algum item não puder ser publicado, troque ou remova antes.
3. **PIX:** a chave aleatória fica pública no código. Falta o **nome do recebedor** em `lib/config/donation_config.dart` (`pixReceiverName`).
4. **E-mail de contato** público para o repositório e o F-Droid (o commit público usa o e-mail anônimo do GitHub).

## GitHub
```bash
gh repo create sancta-devocionario --public --source . --remote origin
git push -u origin master
```
Depois: crie a *release* `v1.0.0` e anexe o APK assinado (`tool/build_release.ps1`). Só execute quando os itens acima estiverem decididos: o histórico inteiro fica público.

## F-Droid
Abra um *merge request* em <https://gitlab.com/fdroid/fdroiddata> com o arquivo `metadata/br.com.sancta.devocionario.yml` abaixo (troque `ogeidrasec`):

```yaml
Categories:
  - Reading
License: GPL-3.0-only
WebSite: https://github.com/ogeidrasec/sancta-devocionario
SourceCode: https://github.com/ogeidrasec/sancta-devocionario
IssueTracker: https://github.com/ogeidrasec/sancta-devocionario/issues
Donate: https://ko-fi.com/sanctadevocionario
AutoName: Sancta Devocionário Católico

RepoType: git
Repo: https://github.com/ogeidrasec/sancta-devocionario.git

Builds:
  - versionName: 1.0.0
    versionCode: 1
    commit: v1.0.0
    output: build/app/outputs/flutter-apk/app-release.apk
    srclibs:
      - flutter@3.38.9
    rm:
      - ios
      - windows
    build:
      - $$flutter$$/bin/flutter config --no-analytics
      - $$flutter$$/bin/flutter pub get
      - $$flutter$$/bin/flutter gen-l10n
      - $$flutter$$/bin/flutter build apk --release

AutoUpdateMode: Version
UpdateCheckMode: Tags
CurrentVersion: 1.0.0
CurrentVersionCode: 1
```
A versão do Flutter acima é a que você usa hoje (3.38.9). O F-Droid compila e assina com a chave dele; costuma levar semanas e podem pedir correções.
