# Fase 1 — App pronto para release

## O que já está feito no projeto
- **Assinatura de release** configurada em `android/app/build.gradle.kts`: usa `android/key.properties` quando existe. Sem ele, assina com a chave de debug e avisa no build (serve para testar, a Play recusa).
- **Modelo** `android/key.properties.example`. O `key.properties` real e os `.jks` já estão no `.gitignore`.
- **Nome padronizado**: "Sancta Devocionário Católico" no Android (antes "Sancta Devocionário") e no iOS (antes "Sanctaconscientia").
- **Script de release** `tool/build_release.ps1`. Recusa gerar o pacote se faltar a chave de upload ou se as doações em `lib/config/donation_config.dart` ainda tiverem valores PREENCHER. Roda os testes e gera os APKs (ou o `.aab` com `-Loja`), ofuscados, com os símbolos em `build/symbols/<versão>`.
- **Build de release testado**: o `.aab` gera sem erro. Ele tem 56 MB porque leva símbolos de depuração que a Play não entrega ao usuário. O download no celular fica bem menor, porque a Play entrega só a parte do aparelho.
- **Alarmes exatos**: o app já cai para aviso aproximado quando o Android não libera o alarme exato (padrão no Android 14+). Mantive `SCHEDULE_EXACT_ALARM`, que é concedida pelo usuário. Não uso `USE_EXACT_ALARM`, que é a permissão restrita pela Play a apps de despertador/calendário.

## O que você precisa fazer: criar a chave de upload (uma vez)
1. Crie uma pasta **fora do projeto**, por exemplo `C:\Users\diego\chaves`.
2. No terminal, rode (vai pedir senha e alguns dados; nome e cidade bastam):
   ```
   keytool -genkey -v -keystore C:\Users\diego\chaves\sancta-upload.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```
3. Copie `android/key.properties.example` para `android/key.properties` e preencha as senhas e o caminho do `.jks`.
4. **Guarde uma cópia** do `.jks` e das senhas em dois lugares seguros (por exemplo um pendrive e um gerenciador de senhas). Com o *Play App Signing*, a Google guarda a chave final; se perder a de upload dá para pedir troca, mas leva dias.
5. Gere o pacote:
   ```
   pwsh tool/build_release.ps1
   ```
   Gera os APKs para o GitHub/F-Droid. Use `-Loja` para o `.aab` da Play (sem links de pagamento) e `-Rascunho` para testar enquanto `lib/config/donation_config.dart` tiver valores PREENCHER. O app agora é gratuito: o RevenueCat e o premium foram removidos (veja `PLANO_DOACOES.md`).

A cada envio para a Play, aumente o número depois do `+` em `pubspec.yaml` (`1.0.0+1` → `1.0.0+2`).

## Roteiro de teste no celular (instale o release, não o debug)
Instalar: `flutter install --release` com o celular ligado por cabo, ou envie o `.aab` para o teste interno da Play.

| # | Teste | Esperado |
|---|---|---|
| 1 | Abrir o app do zero (fechado) | Tela de entrada sem engasgo; abre em poucos segundos |
| 2 | Criar lembrete para daqui 3 min e **fechar o app** | Notificação chega no horário |
| 3 | Mesmo teste com o **celular reiniciado** antes do horário | Notificação chega |
| 4 | Mesmo teste com **economia de bateria** ligada | Chega (talvez com alguns minutos de atraso) |
| 5 | Negar a permissão de notificação no primeiro uso | App avisa em Lembretes e permite corrigir |
| 6 | Rezar o terço completo pela página do terço | Vibração nas contas; "Rosário completo" ao fechar 3 terços |
| 7 | Marcar o terço no check em Hoje | Conta no Rosário do dia |
| 8 | Missa marcada | Pétalas e quadrado verde no jardim |
| 9 | Deslizar entre Hoje, Calendário e Lembretes | Troca de aba, sem abrir menus |
| 10 | Botão ⋮ de uma oração | Abrir, Momento e lembrete, Excluir |
| 11 | Exame: senha, marcar pecados, confissão realizada | Senha pedida; lista limpa após confissão; próximo lembrete criado |
| 12 | Configurações do Android → texto **grande** | Telas sem texto cortado |
| 13 | Modo avião | Tudo funciona (exceto compra) |
| 14 | Trocar o idioma do celular para inglês | App em inglês |
| 15 | Backup: exportar, desinstalar, instalar, importar | Dados voltam (lembretes precisam ser recriados, ver abaixo) |

Anote o modelo do celular e a versão do Android de cada problema.

## Ainda pendente nesta fase
- **Lembretes no backup**: hoje o backup não leva os lembretes. Ao trocar de celular, a pessoa precisa recriá-los. Posso incluir.
- **Imagens**: as imagens de fundo somam cerca de 5 MB. Posso comprimir (WebP) sem perda visível.
- **Ícone e arte da loja**: confirmar o ícone final (ícone adaptativo do Android) e preparar ícone 512×512 e imagem de destaque 1024×500 (Fase 4).
- **Conteúdo e direitos** (sua parte): conferir a origem de cada texto. Posso gerar a lista de todos os textos com o lugar onde estão no código.
