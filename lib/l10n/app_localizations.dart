import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sancta Devocionário Católico'**
  String get appTitle;

  /// No description provided for @loginButton.
  ///
  /// In pt, this message translates to:
  /// **'ACESSAR'**
  String get loginButton;

  /// No description provided for @createPasswordButton.
  ///
  /// In pt, this message translates to:
  /// **'CRIAR SENHA'**
  String get createPasswordButton;

  /// No description provided for @forgotPasswordButton.
  ///
  /// In pt, this message translates to:
  /// **'Esqueci minha senha'**
  String get forgotPasswordButton;

  /// No description provided for @recoverAccessButton.
  ///
  /// In pt, this message translates to:
  /// **'RECUPERAR ACESSO E APAGAR DADOS'**
  String get recoverAccessButton;

  /// No description provided for @passwordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Digite sua senha'**
  String get passwordLabel;

  /// No description provided for @createPasswordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Crie uma senha'**
  String get createPasswordLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Confirme a senha'**
  String get confirmPasswordLabel;

  /// No description provided for @passwordErrorEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, digite sua senha.'**
  String get passwordErrorEmpty;

  /// No description provided for @passwordErrorIncorrect.
  ///
  /// In pt, this message translates to:
  /// **'Senha incorreta. Tente novamente.'**
  String get passwordErrorIncorrect;

  /// No description provided for @passwordErrorShort.
  ///
  /// In pt, this message translates to:
  /// **'A senha deve ter pelo menos 4 caracteres.'**
  String get passwordErrorShort;

  /// No description provided for @passwordErrorMismatch.
  ///
  /// In pt, this message translates to:
  /// **'As senhas não coincidem.'**
  String get passwordErrorMismatch;

  /// No description provided for @recoverAccessTitle.
  ///
  /// In pt, this message translates to:
  /// **'Recuperar Acesso'**
  String get recoverAccessTitle;

  /// No description provided for @recoverAccessWarning.
  ///
  /// In pt, this message translates to:
  /// **'ATENÇÃO: os itens marcados no exame, o histórico de confissões e as datas serão APAGADOS deste aparelho, e a senha será removida. Suas orações e novenas não são afetadas. Esta ação não pode ser desfeita. Deseja continuar?'**
  String get recoverAccessWarning;

  /// No description provided for @recoverAccessCancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get recoverAccessCancel;

  /// No description provided for @recoverAccessConfirm.
  ///
  /// In pt, this message translates to:
  /// **'Recuperar'**
  String get recoverAccessConfirm;

  /// No description provided for @lastConfessionLabel.
  ///
  /// In pt, this message translates to:
  /// **'Última Confissão:'**
  String get lastConfessionLabel;

  /// No description provided for @notRegistered.
  ///
  /// In pt, this message translates to:
  /// **'Não registrada'**
  String get notRegistered;

  /// No description provided for @planLabel.
  ///
  /// In pt, this message translates to:
  /// **'Planejar'**
  String get planLabel;

  /// No description provided for @timeAgoToday.
  ///
  /// In pt, this message translates to:
  /// **'hoje'**
  String get timeAgoToday;

  /// No description provided for @timeAgoDays.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{1 dia} other{{count} dias}}'**
  String timeAgoDays(num count);

  /// No description provided for @timeAgoWeeks.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{1 semana} other{{count} semanas}}'**
  String timeAgoWeeks(num count);

  /// No description provided for @timeAgoMonths.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{1 mês} other{{count} meses}}'**
  String timeAgoMonths(num count);

  /// No description provided for @timeAgoYears.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{1 ano} other{{count} anos}}'**
  String timeAgoYears(num count);

  /// No description provided for @timeAgoConnector.
  ///
  /// In pt, this message translates to:
  /// **' e '**
  String get timeAgoConnector;

  /// No description provided for @generateGuideButton.
  ///
  /// In pt, this message translates to:
  /// **'GERAR GUIA PARA CONFISSÃO'**
  String get generateGuideButton;

  /// No description provided for @nextConfessionLabel.
  ///
  /// In pt, this message translates to:
  /// **'Próxima confissão:'**
  String get nextConfessionLabel;

  /// No description provided for @daysAgo.
  ///
  /// In pt, this message translates to:
  /// **'{days} dias atrás'**
  String daysAgo(Object days);

  /// No description provided for @today.
  ///
  /// In pt, this message translates to:
  /// **'Hoje'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In pt, this message translates to:
  /// **'Ontem'**
  String get yesterday;

  /// No description provided for @settingsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get settingsTitle;

  /// No description provided for @reportTitle.
  ///
  /// In pt, this message translates to:
  /// **'Guia para Confissão'**
  String get reportTitle;

  /// No description provided for @reportEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum pecado foi selecionado.\n\nPor favor, examine sua consciência nas categorias antes de gerar o guia.'**
  String get reportEmpty;

  /// No description provided for @reportShareButton.
  ///
  /// In pt, this message translates to:
  /// **'COMPARTILHAR'**
  String get reportShareButton;

  /// No description provided for @reportCloseButton.
  ///
  /// In pt, this message translates to:
  /// **'FECHAR'**
  String get reportCloseButton;

  /// No description provided for @confessButton.
  ///
  /// In pt, this message translates to:
  /// **'CONFESSAR-SE'**
  String get confessButton;

  /// No description provided for @confessDialogTitle.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar Confissão'**
  String get confessDialogTitle;

  /// No description provided for @confessDialogContent.
  ///
  /// In pt, this message translates to:
  /// **'Deseja marcar sua confissão como realizada hoje? Isso limpará o exame atual.'**
  String get confessDialogContent;

  /// No description provided for @confessDialogCancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get confessDialogCancel;

  /// No description provided for @confessDialogConfirm.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar'**
  String get confessDialogConfirm;

  /// No description provided for @preparatoryPrayerTitle.
  ///
  /// In pt, this message translates to:
  /// **'Oração Preparatória'**
  String get preparatoryPrayerTitle;

  /// No description provided for @preparatoryPrayerSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Antes do Exame'**
  String get preparatoryPrayerSubtitle;

  /// No description provided for @preparatoryPrayerContent.
  ///
  /// In pt, this message translates to:
  /// **'Senhor, iluminai-me para que eu possa ver os meus pecados, e dai-me a graça de me arrepender verdadeiramente deles e de me confessar com sinceridade. Amém.'**
  String get preparatoryPrayerContent;

  /// No description provided for @catOracaoTitle.
  ///
  /// In pt, this message translates to:
  /// **'Oração Preparatória'**
  String get catOracaoTitle;

  /// No description provided for @catOracaoDesc.
  ///
  /// In pt, this message translates to:
  /// **'Recomendado'**
  String get catOracaoDesc;

  /// No description provided for @catOracaoSub.
  ///
  /// In pt, this message translates to:
  /// **'Recomendado'**
  String get catOracaoSub;

  /// No description provided for @catMetodoTitle.
  ///
  /// In pt, this message translates to:
  /// **'Método de Confissão'**
  String get catMetodoTitle;

  /// No description provided for @catMetodoDesc.
  ///
  /// In pt, this message translates to:
  /// **'Como se confessar'**
  String get catMetodoDesc;

  /// No description provided for @catMetodoSub.
  ///
  /// In pt, this message translates to:
  /// **'Como se confessar'**
  String get catMetodoSub;

  /// No description provided for @catExameDiarioTitle.
  ///
  /// In pt, this message translates to:
  /// **'Exame Diário'**
  String get catExameDiarioTitle;

  /// No description provided for @catExameDiarioDesc.
  ///
  /// In pt, this message translates to:
  /// **'Revisão do dia (Inaciano)'**
  String get catExameDiarioDesc;

  /// No description provided for @catExameDiarioSub.
  ///
  /// In pt, this message translates to:
  /// **'Revisão do dia'**
  String get catExameDiarioSub;

  /// No description provided for @devotionalTitle.
  ///
  /// In pt, this message translates to:
  /// **'Orações'**
  String get devotionalTitle;

  /// No description provided for @prayersTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novenas'**
  String get prayersTitle;

  /// No description provided for @rosaryTitle.
  ///
  /// In pt, this message translates to:
  /// **'Santo Terço'**
  String get rosaryTitle;

  /// No description provided for @examinationTitle.
  ///
  /// In pt, this message translates to:
  /// **'Exame de Consciência'**
  String get examinationTitle;

  /// No description provided for @examinationMenuTitle.
  ///
  /// In pt, this message translates to:
  /// **'Exame'**
  String get examinationMenuTitle;

  /// No description provided for @moreTitle.
  ///
  /// In pt, this message translates to:
  /// **'Jardim'**
  String get moreTitle;

  /// No description provided for @confessionCardTitle.
  ///
  /// In pt, this message translates to:
  /// **'Confissão'**
  String get confessionCardTitle;

  /// No description provided for @confessionMarkComplete.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar Confissão'**
  String get confessionMarkComplete;

  /// No description provided for @confessionConfirmTitle.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar Confissão?'**
  String get confessionConfirmTitle;

  /// No description provided for @confessionConfirmMessage.
  ///
  /// In pt, this message translates to:
  /// **'Ao confirmar, o exame de consciência será limpo e a data será registrada.'**
  String get confessionConfirmMessage;

  /// No description provided for @confessionConfirmed.
  ///
  /// In pt, this message translates to:
  /// **'Confissão registrada!'**
  String get confessionConfirmed;

  /// No description provided for @rosaryComplete.
  ///
  /// In pt, this message translates to:
  /// **'Terço completo'**
  String get rosaryComplete;

  /// No description provided for @rosaryCompleteNotification.
  ///
  /// In pt, this message translates to:
  /// **'Parabéns! Você completou um Rosário hoje!'**
  String get rosaryCompleteNotification;

  /// No description provided for @catAntesItem7.
  ///
  /// In pt, this message translates to:
  /// **'Recebi outro Sacramento em estado de pecado mortal.'**
  String get catAntesItem7;

  /// No description provided for @catMandamentosTitle.
  ///
  /// In pt, this message translates to:
  /// **'10 Mandamentos'**
  String get catMandamentosTitle;

  /// No description provided for @catMandamentosDesc.
  ///
  /// In pt, this message translates to:
  /// **'Lei de Deus'**
  String get catMandamentosDesc;

  /// No description provided for @catMandamentosSub.
  ///
  /// In pt, this message translates to:
  /// **'Lei de Deus'**
  String get catMandamentosSub;

  /// No description provided for @catMandamentosSub1.
  ///
  /// In pt, this message translates to:
  /// **'I Mandamento: Amar a Deus sobre todas as coisas'**
  String get catMandamentosSub1;

  /// No description provided for @catMandamentos1Item1.
  ///
  /// In pt, this message translates to:
  /// **'Fui negligente na oração, tive distrações voluntárias ou fiquei mais de um mês sem rezar.'**
  String get catMandamentos1Item1;

  /// No description provided for @catMandamentos1Item2.
  ///
  /// In pt, this message translates to:
  /// **'Fui ingrato para com Deus ou tive preguiça espiritual.'**
  String get catMandamentos1Item2;

  /// No description provided for @catMandamentos1Item3.
  ///
  /// In pt, this message translates to:
  /// **'Tentei a Deus, expondo-me a perigo para a alma, vida ou saúde sem causa grave.'**
  String get catMandamentos1Item3;

  /// No description provided for @catMandamentos1Item4.
  ///
  /// In pt, this message translates to:
  /// **'Não fiz genuflexão para o Santíssimo ou tive comportamento inadequado na Igreja.'**
  String get catMandamentos1Item4;

  /// No description provided for @catMandamentos1Item5.
  ///
  /// In pt, this message translates to:
  /// **'Tive apego excessivo a coisas ou criaturas (animais, ídolos, dinheiro, prazer ou poder).'**
  String get catMandamentos1Item5;

  /// No description provided for @catMandamentos1Item6.
  ///
  /// In pt, this message translates to:
  /// **'Cometi idolatria, superstição ou atribuí importância indevida a sonhos e destino.'**
  String get catMandamentos1Item6;

  /// No description provided for @catMandamentos1Item7.
  ///
  /// In pt, this message translates to:
  /// **'Consultei horóscopos, astrologia, leitura de mãos ou pratiquei espiritismo e adivinhação.'**
  String get catMandamentos1Item7;

  /// No description provided for @catMandamentos1Item8.
  ///
  /// In pt, this message translates to:
  /// **'Pratiquei magia, bruxaria, usei amuletos ou joguei com quadros Ouija.'**
  String get catMandamentos1Item8;

  /// No description provided for @catMandamentos1Item9.
  ///
  /// In pt, this message translates to:
  /// **'Cometi sacrilégio ao receber a Eucaristia em pecado mortal ou tratei indignamente coisas santas.'**
  String get catMandamentos1Item9;

  /// No description provided for @catMandamentos1Item10.
  ///
  /// In pt, this message translates to:
  /// **'Duvidei da fé, ignorei as verdades cristãs ou aderi a grupos maçônicos e sociedades proibidas.'**
  String get catMandamentos1Item10;

  /// No description provided for @catMandamentosSub2.
  ///
  /// In pt, this message translates to:
  /// **'II Mandamento: Não tomar seu santo nome em vão'**
  String get catMandamentosSub2;

  /// No description provided for @catMandamentos2Item1.
  ///
  /// In pt, this message translates to:
  /// **'Fiz uso profano ou desrespeitoso do Nome de Deus, de Jesus, da Virgem Maria ou dos santos.'**
  String get catMandamentos2Item1;

  /// No description provided for @catMandamentos2Item2.
  ///
  /// In pt, this message translates to:
  /// **'Blasfemei contra Deus, a Igreja ou os santos por palavras, gestos ou músicas.'**
  String get catMandamentos2Item2;

  /// No description provided for @catMandamentos2Item3.
  ///
  /// In pt, this message translates to:
  /// **'Cometi perjúrio (prometer algo sob juramento sem intenção de cumprir).'**
  String get catMandamentos2Item3;

  /// No description provided for @catMandamentos2Item4.
  ///
  /// In pt, this message translates to:
  /// **'Fiz juramentos falsos ou desnecessários chamando a Deus por testemunha de uma mentira.'**
  String get catMandamentos2Item4;

  /// No description provided for @catMandamentos2Item5.
  ///
  /// In pt, this message translates to:
  /// **'Amaldiçoei a mim mesmo ou a outros com real intenção.'**
  String get catMandamentos2Item5;

  /// No description provided for @catMandamentos2Item6.
  ///
  /// In pt, this message translates to:
  /// **'Quebrei votos ou promessas feitas a Deus ou murmurei contra a Providência Divina.'**
  String get catMandamentos2Item6;

  /// No description provided for @catMandamentosSub3.
  ///
  /// In pt, this message translates to:
  /// **'III Mandamento: Guardar domingos e festas'**
  String get catMandamentosSub3;

  /// No description provided for @catMandamentos3Item1.
  ///
  /// In pt, this message translates to:
  /// **'Omiti a oração, o culto divino ou realizei trabalho servil desnecessário no Domingo.'**
  String get catMandamentos3Item1;

  /// No description provided for @catMandamentos3Item2.
  ///
  /// In pt, this message translates to:
  /// **'Fiz comércio desnecessário (comprar ou vender) nos Domingos e Dias de Guarda.'**
  String get catMandamentos3Item2;

  /// No description provided for @catMandamentos3Item3.
  ///
  /// In pt, this message translates to:
  /// **'Profanei estes dias com companhias impiedosas, jogos de azar ou excessos com bebida.'**
  String get catMandamentos3Item3;

  /// No description provided for @catMandamentos3Item4.
  ///
  /// In pt, this message translates to:
  /// **'Faltei à Missa ou cheguei gravemente atrasado sem razão suficiente.'**
  String get catMandamentos3Item4;

  /// No description provided for @catMandamentosSub4.
  ///
  /// In pt, this message translates to:
  /// **'IV Mandamento: Honrar pai e mãe'**
  String get catMandamentosSub4;

  /// No description provided for @catMandamentos4Item1.
  ///
  /// In pt, this message translates to:
  /// **'Desobedeci, ofendi ou fui ingrato com meus pais, provocando-os à raiva.'**
  String get catMandamentos4Item1;

  /// No description provided for @catMandamentos4Item2.
  ///
  /// In pt, this message translates to:
  /// **'Não ajudei meus pais em suas necessidades ou desejei-lhes algum mal.'**
  String get catMandamentos4Item2;

  /// No description provided for @catMandamentos4Item3.
  ///
  /// In pt, this message translates to:
  /// **'Fui duro ou cruel com meus filhos ou adiei o batismo deles por mais de um mês.'**
  String get catMandamentos4Item3;

  /// No description provided for @catMandamentos4Item4.
  ///
  /// In pt, this message translates to:
  /// **'Negligenciei a instrução religiosa dos filhos ou permiti que crescessem no pecado.'**
  String get catMandamentos4Item4;

  /// No description provided for @catMandamentos4Item5.
  ///
  /// In pt, this message translates to:
  /// **'Tratei o cônjuge sem caridade, neguei o débito conjugal sem causa justa ou tive ciúmes despropositados.'**
  String get catMandamentos4Item5;

  /// No description provided for @catMandamentos4Item6.
  ///
  /// In pt, this message translates to:
  /// **'Desobedeci a superiores espirituais (Papa, bispos) ou votei em partidos comunistas/socialistas.'**
  String get catMandamentos4Item6;

  /// No description provided for @catMandamentos4Item7.
  ///
  /// In pt, this message translates to:
  /// **'Como empregado, perdi tempo no trabalho (internet) ou gastei propriedade do empregador.'**
  String get catMandamentos4Item7;

  /// No description provided for @catMandamentosSub5.
  ///
  /// In pt, this message translates to:
  /// **'V Mandamento: Não matar'**
  String get catMandamentosSub5;

  /// No description provided for @catMandamentos5Item1.
  ///
  /// In pt, this message translates to:
  /// **'Causei morte, lesão física, briguei ou tive desejos de vingança.'**
  String get catMandamentos5Item1;

  /// No description provided for @catMandamentos5Item2.
  ///
  /// In pt, this message translates to:
  /// **'Realizei, ajudei ou aconselhei um aborto (ciente da excomunhão se consumado).'**
  String get catMandamentos5Item2;

  /// No description provided for @catMandamentos5Item3.
  ///
  /// In pt, this message translates to:
  /// **'Tive pensamentos de suicídio, pratiquei eutanásia ou mutilação do corpo (castração).'**
  String get catMandamentos5Item3;

  /// No description provided for @catMandamentos5Item4.
  ///
  /// In pt, this message translates to:
  /// **'Cometi excessos no comer ou beber (gula e embriaguez) ou usei drogas.'**
  String get catMandamentos5Item4;

  /// No description provided for @catMandamentos5Item5.
  ///
  /// In pt, this message translates to:
  /// **'Pratiquei vasectomia ou ligadura (pecado mortal que exige tentativa de reversão se possível).'**
  String get catMandamentos5Item5;

  /// No description provided for @catMandamentos5Item6.
  ///
  /// In pt, this message translates to:
  /// **'Realizei inseminação artificial, fertilização in vitro ou pesquisas científicas imorais.'**
  String get catMandamentos5Item6;

  /// No description provided for @catMandamentos5Item7.
  ///
  /// In pt, this message translates to:
  /// **'Tomei contraceptivos (pílulas, profiláticos) ou utilizei métodos naturais com mentalidade contraceptiva.'**
  String get catMandamentos5Item7;

  /// No description provided for @catMandamentos5Item8.
  ///
  /// In pt, this message translates to:
  /// **'Dei mau exemplo, escandalizei o próximo ou induzi outros ao pecado.'**
  String get catMandamentos5Item8;

  /// No description provided for @catMandamentosSub6.
  ///
  /// In pt, this message translates to:
  /// **'VI Mandamento: Não pecar contra a castidade'**
  String get catMandamentosSub6;

  /// No description provided for @catMandamentos6Item1.
  ///
  /// In pt, this message translates to:
  /// **'Pratiquei impureza ou imodéstia nas palavras, olhares e ações (sozinho ou acompanhado).'**
  String get catMandamentos6Item1;

  /// No description provided for @catMandamentos6Item2.
  ///
  /// In pt, this message translates to:
  /// **'Contei piadas sujas, usei roupas imodestas (decotes, roupas transparentes ou apertadas).'**
  String get catMandamentos6Item2;

  /// No description provided for @catMandamentos6Item3.
  ///
  /// In pt, this message translates to:
  /// **'Assisti a filmes, pornografia ou li livros e revistas indecentes.'**
  String get catMandamentos6Item3;

  /// No description provided for @catMandamentos6Item4.
  ///
  /// In pt, this message translates to:
  /// **'Pratiquei masturbação, fornicação (sexo antes do casamento) ou adultério.'**
  String get catMandamentos6Item4;

  /// No description provided for @catMandamentos6Item5.
  ///
  /// In pt, this message translates to:
  /// **'Aderi a práticas homossexuais (sodomia) ou outras contrárias à natureza.'**
  String get catMandamentos6Item5;

  /// No description provided for @catMandamentos6Item6.
  ///
  /// In pt, this message translates to:
  /// **'Pratiquei o ato conjugal de modo inapto à procriação.'**
  String get catMandamentos6Item6;

  /// No description provided for @catMandamentos6Item7.
  ///
  /// In pt, this message translates to:
  /// **'Participei de danças imodestas ou namorei sem a intenção de casar ou sem precauções.'**
  String get catMandamentos6Item7;

  /// No description provided for @catMandamentosSub7.
  ///
  /// In pt, this message translates to:
  /// **'VII Mandamento: Não furtar'**
  String get catMandamentosSub7;

  /// No description provided for @catMandamentos7Item1.
  ///
  /// In pt, this message translates to:
  /// **'Cometi roubo, pequenos furtos no trabalho ou tomei dinheiro da família sem permissão.'**
  String get catMandamentos7Item1;

  /// No description provided for @catMandamentos7Item2.
  ///
  /// In pt, this message translates to:
  /// **'Trapaceei, cometi plágio ou violei direitos autorais sem causa séria.'**
  String get catMandamentos7Item2;

  /// No description provided for @catMandamentos7Item3.
  ///
  /// In pt, this message translates to:
  /// **'Mantive objetos emprestados ou perdidos sem tentativa de restituir.'**
  String get catMandamentos7Item3;

  /// No description provided for @catMandamentos7Item4.
  ///
  /// In pt, this message translates to:
  /// **'Soneguei impostos justos, aceitei suborno ou fui desonesto nos negócios.'**
  String get catMandamentos7Item4;

  /// No description provided for @catMandamentos7Item5.
  ///
  /// In pt, this message translates to:
  /// **'Não paguei dívidas no tempo correto ou paguei salários injustos aos empregados.'**
  String get catMandamentos7Item5;

  /// No description provided for @catMandamentos7Item6.
  ///
  /// In pt, this message translates to:
  /// **'Gastei dinheiro excessivamente em jogos e apostas, privando a família do necessário.'**
  String get catMandamentos7Item6;

  /// No description provided for @catMandamentosSub8.
  ///
  /// In pt, this message translates to:
  /// **'VIII Mandamento: Não levantar falso testemunho'**
  String get catMandamentosSub8;

  /// No description provided for @catMandamentos8Item1.
  ///
  /// In pt, this message translates to:
  /// **'Menti, usei de palavrões, grosserias, hipocrisia ou exagero.'**
  String get catMandamentos8Item1;

  /// No description provided for @catMandamentos8Item2.
  ///
  /// In pt, this message translates to:
  /// **'Cometi detração (revelar faltas reais escondidas) ou calúnia (falsos defeitos).'**
  String get catMandamentos8Item2;

  /// No description provided for @catMandamentos8Item3.
  ///
  /// In pt, this message translates to:
  /// **'Fiz fofocas, murmurações ou julguei precipitadamente o próximo.'**
  String get catMandamentos8Item3;

  /// No description provided for @catMandamentos8Item4.
  ///
  /// In pt, this message translates to:
  /// **'Revelei segredos sem causa justa ou recusei restituir o bom nome manchado.'**
  String get catMandamentos8Item4;

  /// No description provided for @catMandamentos8Item5.
  ///
  /// In pt, this message translates to:
  /// **'Fui irônico ou sarcástico com o objetivo de ferir o próximo.'**
  String get catMandamentos8Item5;

  /// No description provided for @catMandamentosSub9.
  ///
  /// In pt, this message translates to:
  /// **'IX Mandamento: Não desejar a mulher do próximo'**
  String get catMandamentosSub9;

  /// No description provided for @catMandamentos9Item1.
  ///
  /// In pt, this message translates to:
  /// **'Deleitei-me deliberadamente em pensamentos ou desejos impuros.'**
  String get catMandamentos9Item1;

  /// No description provided for @catMandamentos9Item2.
  ///
  /// In pt, this message translates to:
  /// **'Consenti em paixões ou pensamentos imorais quando vieram à mente.'**
  String get catMandamentos9Item2;

  /// No description provided for @catMandamentos9Item3.
  ///
  /// In pt, this message translates to:
  /// **'Desejei a esposa ou marido de outrem.'**
  String get catMandamentos9Item3;

  /// No description provided for @catMandamentosSub10.
  ///
  /// In pt, this message translates to:
  /// **'X Mandamento: Não cobiçar as coisas alheias'**
  String get catMandamentosSub10;

  /// No description provided for @catMandamentos10Item1.
  ///
  /// In pt, this message translates to:
  /// **'Tive inveja dos bens, sucessos ou talentos alheios.'**
  String get catMandamentos10Item1;

  /// No description provided for @catMandamentos10Item2.
  ///
  /// In pt, this message translates to:
  /// **'Tive ganância e desejo sem limites de possuir bens materiais (avareza).'**
  String get catMandamentos10Item2;

  /// No description provided for @catMandamentos10Item3.
  ///
  /// In pt, this message translates to:
  /// **'Desejei enriquecer a qualquer preço ou desejei cometer injustiça para obter bens.'**
  String get catMandamentos10Item3;

  /// No description provided for @catMandamentos10Item4.
  ///
  /// In pt, this message translates to:
  /// **'Alegrei-me com a miséria alheia ou com o prejuízo do próximo.'**
  String get catMandamentos10Item4;

  /// No description provided for @catIgrejaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Preceitos da Igreja'**
  String get catIgrejaTitle;

  /// No description provided for @catIgrejaDesc.
  ///
  /// In pt, this message translates to:
  /// **'Lei da Igreja'**
  String get catIgrejaDesc;

  /// No description provided for @catIgrejaSub.
  ///
  /// In pt, this message translates to:
  /// **'Lei da Igreja'**
  String get catIgrejaSub;

  /// No description provided for @catIgrejaSub1.
  ///
  /// In pt, this message translates to:
  /// **'Preceitos da Santa Igreja'**
  String get catIgrejaSub1;

  /// No description provided for @catIgrejaItem1.
  ///
  /// In pt, this message translates to:
  /// **'Não assisti à Missa inteira nos Domingos e Dias de Guarda (Natal, Circuncisão, Epifania, etc.).'**
  String get catIgrejaItem1;

  /// No description provided for @catIgrejaItem2.
  ///
  /// In pt, this message translates to:
  /// **'Não jejuei na Quarta-feira de Cinzas e Sexta-feira Santa (se entre 18 e 60 anos).'**
  String get catIgrejaItem2;

  /// No description provided for @catIgrejaItem3.
  ///
  /// In pt, this message translates to:
  /// **'Não guardei a abstinência de carne nas sextas-feiras ou não a comutei por outra penitência.'**
  String get catIgrejaItem3;

  /// No description provided for @catIgrejaItem4.
  ///
  /// In pt, this message translates to:
  /// **'Deixei de confessar os pecados mortais ao menos uma vez por ano.'**
  String get catIgrejaItem4;

  /// No description provided for @catIgrejaItem5.
  ///
  /// In pt, this message translates to:
  /// **'Não recebi a Santa Comunhão durante o período da Páscoa.'**
  String get catIgrejaItem5;

  /// No description provided for @catIgrejaItem6.
  ///
  /// In pt, this message translates to:
  /// **'Não contribuí para o sustento da Igreja conforme minhas possibilidades.'**
  String get catIgrejaItem6;

  /// No description provided for @catIgrejaItem7.
  ///
  /// In pt, this message translates to:
  /// **'Casei-me ou ajudei alguém a casar sem permissão da Igreja ou diante de ministro acatólico.'**
  String get catIgrejaItem7;

  /// No description provided for @devotionalSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Orações'**
  String get devotionalSubtitle;

  /// No description provided for @devotionalComingSoon.
  ///
  /// In pt, this message translates to:
  /// **'Orações, Terço e Devoções em breve.'**
  String get devotionalComingSoon;

  /// No description provided for @comingSoon.
  ///
  /// In pt, this message translates to:
  /// **'Em breve'**
  String get comingSoon;

  /// No description provided for @jornadaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Jornada de Confissão'**
  String get jornadaTitle;

  /// No description provided for @jornadaHeaderTitle.
  ///
  /// In pt, this message translates to:
  /// **'Caminho de Reconciliação'**
  String get jornadaHeaderTitle;

  /// No description provided for @jornadaHeaderSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Sua jornada espiritual de confissão e santidade'**
  String get jornadaHeaderSubtitle;

  /// No description provided for @jornadaEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma confissão registrada ainda.'**
  String get jornadaEmpty;

  /// No description provided for @jornadaHistoryTitle.
  ///
  /// In pt, this message translates to:
  /// **'Histórico de Confissões'**
  String get jornadaHistoryTitle;

  /// No description provided for @jornadaHistorySubtitle.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{Nenhuma confissão registrada} =1{1 confissão registrada} other{{count} confissões registradas}}'**
  String jornadaHistorySubtitle(num count);

  /// No description provided for @deleteConfessionTitle.
  ///
  /// In pt, this message translates to:
  /// **'Excluir Confissão'**
  String get deleteConfessionTitle;

  /// No description provided for @deleteConfessionContent.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja excluir a confissão de {date}?'**
  String deleteConfessionContent(Object date);

  /// No description provided for @deleteConfessionCancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get deleteConfessionCancel;

  /// No description provided for @deleteConfessionConfirm.
  ///
  /// In pt, this message translates to:
  /// **'Excluir'**
  String get deleteConfessionConfirm;

  /// No description provided for @whyConfessTitle.
  ///
  /// In pt, this message translates to:
  /// **'Por que se Confessar?'**
  String get whyConfessTitle;

  /// No description provided for @whyConfessContent.
  ///
  /// In pt, this message translates to:
  /// **'A Confissão é um Sacramento instituído por Jesus Cristo para nos reconciliar com Deus e com a Igreja. É um encontro pessoal com a misericórdia divina.\n\n**Importância Espiritual:**\nA Confissão restaura a graça santificante perdida pelo pecado mortal e aumenta a graça em nossa alma. Fortalece nossa vontade contra futuras tentações e nos dá paz de consciência.\n\n**Importância Temporal:**\nConfessar nossos erros nos libera do peso da culpa, melhora nossos relacionamentos e nos ajuda a viver uma vida mais autêntica e plena. A humildade necessária para confessar nos torna pessoas melhores.'**
  String get whyConfessContent;

  /// No description provided for @psychBenefitsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Benefícios Psicológicos'**
  String get psychBenefitsTitle;

  /// No description provided for @psychBenefitsContent.
  ///
  /// In pt, this message translates to:
  /// **'Estudos científicos demonstram diversos benefícios psicológicos da confissão:\n\n**Redução do Estresse:**\nGuardar segredos e sentimentos de culpa aumenta os níveis de cortisol. Confessar alivia esse peso emocional.\n\n**Melhoria na Saúde Mental:**\nA prática regular de examinar a consciência e confessar promove autoconhecimento e crescimento pessoal.\n\n**Superação de Vícios:**\nAdmitir nossos erros é o primeiro passo para a mudança. A confissão cria responsabilização e motivação para melhorar.\n\n**Relações Mais Saudáveis:**\nA honestidade consigo mesmo facilita relações mais autênticas e profundas com os outros.'**
  String get psychBenefitsContent;

  /// No description provided for @saintsWordsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Palavras dos Santos'**
  String get saintsWordsTitle;

  /// No description provided for @saintsWordsContent.
  ///
  /// In pt, this message translates to:
  /// **'\"Aquele que se confessa em lágrimas recebe o perdão em alegria.\"\n— São João Maria Vianney (Cura d\'Ars)\n\n\"A confissão é um ato de honestidade e coragem — um ato de confiar a si mesmo, além das palavras, ao Senhor misericordioso.\"\n— Papa São João Paulo II\n\n\"Pela confissão, o homem olha a verdade de seus pecados no rosto e assume a responsabilidade por eles; por isso, abre-se novamente a Deus.\"\n— Papa Bento XVI\n\n\"Oh! Como é grande a bondade de nosso Senhor! Na realidade, Ele esquece os nossos pecados depois da confissão.\"\n— Santa Faustina Kowalska\n\n\"A confissão não é para ser julgado, mas para ser perdoado.\"\n— São Padre Pio de Pietrelcina'**
  String get saintsWordsContent;

  /// No description provided for @tipsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Dicas para Ansiosos e Tímidos'**
  String get tipsTitle;

  /// No description provided for @tipsContent.
  ///
  /// In pt, this message translates to:
  /// **'Se você sente ansiedade ou vergonha ao confessar:\n\n1. **Prepare-se com antecedência:** Escreva seus pecados em um papel. Você pode levar esse papel ao confessionário.\n\n2. **Lembre-se: O padre não é juiz:** Ele está ali para perdoar e aconselhar, não para julgar você.\n\n3. **O padre já ouviu de tudo:** Provavelmente seu pecado não é único ou excepcional. Nada vai chocá-lo.\n\n4. **Comece pelos pecados \"mais fáceis\":** Isso pode ajudar a ganhar coragem para os mais difíceis.\n\n5. **Foque em Deus, não no padre:** Você está confessando a Jesus Cristo, através do sacerdote.\n\n6. **Confie na misericórdia:** Deus já conhece todos os seus pecados e ainda assim te ama infinitamente.\n\n7. **Vá com frequência:** Quanto mais você se confessa, mais fácil fica. A prática traz conforto.'**
  String get tipsContent;

  /// No description provided for @secrecyTitle.
  ///
  /// In pt, this message translates to:
  /// **'O Sigilo Sacramental'**
  String get secrecyTitle;

  /// No description provided for @secrecyContent.
  ///
  /// In pt, this message translates to:
  /// **'O Segredo da Confissão é ABSOLUTO e INVIOLÁVEL.\n\nO padre está proibido, sob pena de excomunhão automática, de revelar QUALQUER coisa que ouviu em confissão. Isso inclui:\n\n• Não pode contar a ninguém, nem mesmo a outro padre.\n• Não pode usar a informação de nenhuma forma.\n• Não pode dar indícios de que sabe algo.\n• Nem mesmo sob tortura ou ameaça de morte pode quebrar o sigilo.\n\n**Casos Históricos:**\nVários sacerdotes mártires preferiram morrer a quebrar o sigilo sacramental, como São João Nepomuceno, que foi martirizado em 1393 por se recusar a revelar a confissão da rainha.\n\n**Sua confissão é segura.** Nem Deus permitiria que o sigilo fosse quebrado, protegendo esse Sacramento precioso.'**
  String get secrecyContent;

  /// No description provided for @priestAttitudeTitle.
  ///
  /// In pt, this message translates to:
  /// **'A Atitude do Sacerdote'**
  String get priestAttitudeTitle;

  /// No description provided for @priestAttitudeContent.
  ///
  /// In pt, this message translates to:
  /// **'O padre manterá a mesma atitude acolhedora, não importa o pecado.\n\n**Por quê?**\n• O padre age \"in Persona Christi\" — representando Cristo.\n• Cristo acolheu a todos: prostitutas, ladrões, assassinos.\n• O padre é treinado para não demonstrar choque ou julgamento.\n• Ele sabe que todos somos pecadores em busca de misericórdia.\n\n**O que o padre pensa:**\nEm vez de julgar, o padre pensa:\n• \"Como posso ajudar esta pessoa?\"\n• \"Que conselho posso dar para evitar futuras quedas?\"\n• \"Louvo a Deus pela coragem desta alma em buscar reconciliação.\"\n\n**Sua experiência:**\nIndependente do que você confessar, você será recebido com:\n• Respeito e dignidade.\n• Compaixão e misericórdia.\n• Orientação e encorajamento.\n• A absolvição em nome de Jesus Cristo.\n\n**Lembre-se:** O padre está ali como instrumento da misericórdia de Deus, não como juiz. Sua função é perdoar e ajudar, não condenar.'**
  String get priestAttitudeContent;

  /// No description provided for @searchHint.
  ///
  /// In pt, this message translates to:
  /// **'Buscar pecados...'**
  String get searchHint;

  /// No description provided for @noSinsFound.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum pecado encontrado'**
  String get noSinsFound;

  /// No description provided for @noSinsFoundSearch.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum pecado encontrado\nTente outros termos de busca'**
  String get noSinsFoundSearch;

  /// No description provided for @saveAndReturnButton.
  ///
  /// In pt, this message translates to:
  /// **'SALVAR E VOLTAR'**
  String get saveAndReturnButton;

  /// No description provided for @configTitle.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get configTitle;

  /// No description provided for @changePasswordTitle.
  ///
  /// In pt, this message translates to:
  /// **'Alterar Senha'**
  String get changePasswordTitle;

  /// No description provided for @changePasswordDesc.
  ///
  /// In pt, this message translates to:
  /// **'Altere a senha de acesso ao aplicativo'**
  String get changePasswordDesc;

  /// No description provided for @changePasswordButton.
  ///
  /// In pt, this message translates to:
  /// **'Alterar Senha'**
  String get changePasswordButton;

  /// No description provided for @currentPasswordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Senha Atual'**
  String get currentPasswordLabel;

  /// No description provided for @newPasswordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nova Senha'**
  String get newPasswordLabel;

  /// No description provided for @confirmNewPasswordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar Nova Senha'**
  String get confirmNewPasswordLabel;

  /// No description provided for @changePasswordAction.
  ///
  /// In pt, this message translates to:
  /// **'Alterar'**
  String get changePasswordAction;

  /// No description provided for @passwordSuccessMessage.
  ///
  /// In pt, this message translates to:
  /// **'Senha alterada com sucesso!'**
  String get passwordSuccessMessage;

  /// No description provided for @recoverAccessDesc.
  ///
  /// In pt, this message translates to:
  /// **'Caso tenha esquecido a senha, você pode recuperar o acesso. ATENÇÃO: Todos os dados do exame atual serão perdidos.'**
  String get recoverAccessDesc;

  /// No description provided for @recoverAccessAction.
  ///
  /// In pt, this message translates to:
  /// **'Recuperar Acesso'**
  String get recoverAccessAction;

  /// No description provided for @clearExamTitle.
  ///
  /// In pt, this message translates to:
  /// **'Limpar Exame Atual'**
  String get clearExamTitle;

  /// No description provided for @clearExamDesc.
  ///
  /// In pt, this message translates to:
  /// **'Apaga todos os dados do exame atual e inicia um novo'**
  String get clearExamDesc;

  /// No description provided for @clearExamButton.
  ///
  /// In pt, this message translates to:
  /// **'Limpar Exame'**
  String get clearExamButton;

  /// No description provided for @clearExamDialogTitle.
  ///
  /// In pt, this message translates to:
  /// **'Limpar Exame Atual'**
  String get clearExamDialogTitle;

  /// No description provided for @clearExamDialogContent.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja limpar todos os dados do exame atual? Esta ação não pode ser desfeita.'**
  String get clearExamDialogContent;

  /// No description provided for @clearExamAction.
  ///
  /// In pt, this message translates to:
  /// **'Limpar'**
  String get clearExamAction;

  /// No description provided for @clearExamSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Exame limpo com sucesso!'**
  String get clearExamSuccess;

  /// No description provided for @fillAllFields.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, preencha todos os campos.'**
  String get fillAllFields;

  /// No description provided for @currentPasswordIncorrect.
  ///
  /// In pt, this message translates to:
  /// **'Senha atual incorreta.'**
  String get currentPasswordIncorrect;

  /// Cancel button label
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get cancelButton;

  /// No description provided for @removeButton.
  ///
  /// In pt, this message translates to:
  /// **'Remover'**
  String get removeButton;

  /// No description provided for @planningTitle.
  ///
  /// In pt, this message translates to:
  /// **'Planejar Confissão'**
  String get planningTitle;

  /// No description provided for @planningQuestion.
  ///
  /// In pt, this message translates to:
  /// **'Quando você pretende se confessar?'**
  String get planningQuestion;

  /// No description provided for @planningSaveSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Data da próxima confissão salva!'**
  String get planningSaveSuccess;

  /// No description provided for @planningSelectedDate.
  ///
  /// In pt, this message translates to:
  /// **'Data selecionada: {date}'**
  String planningSelectedDate(Object date);

  /// No description provided for @planLevelTitle.
  ///
  /// In pt, this message translates to:
  /// **'Nível Espiritual'**
  String get planLevelTitle;

  /// No description provided for @planLevelSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Passo {level}: {title}'**
  String planLevelSubtitle(Object level, Object title);

  /// No description provided for @planLevel1Title.
  ///
  /// In pt, this message translates to:
  /// **'Iniciante'**
  String get planLevel1Title;

  /// No description provided for @planLevel1Desc.
  ///
  /// In pt, this message translates to:
  /// **'Oração da Manhã, da Noite e 3 Ave-Marias'**
  String get planLevel1Desc;

  /// No description provided for @planLevel2Title.
  ///
  /// In pt, this message translates to:
  /// **'Crescimento'**
  String get planLevel2Title;

  /// No description provided for @planLevel2Desc.
  ///
  /// In pt, this message translates to:
  /// **'Adiciona o Santo Terço diário'**
  String get planLevel2Desc;

  /// No description provided for @planLevel3Title.
  ///
  /// In pt, this message translates to:
  /// **'Fervor'**
  String get planLevel3Title;

  /// No description provided for @planLevel3Desc.
  ///
  /// In pt, this message translates to:
  /// **'Adiciona o Angelus e Leitura Espiritual'**
  String get planLevel3Desc;

  /// No description provided for @planLevel4Title.
  ///
  /// In pt, this message translates to:
  /// **'União'**
  String get planLevel4Title;

  /// No description provided for @planLevel4Desc.
  ///
  /// In pt, this message translates to:
  /// **'Adiciona Exame de Consciência e Meditação'**
  String get planLevel4Desc;

  /// No description provided for @timeMorning.
  ///
  /// In pt, this message translates to:
  /// **'Manhã'**
  String get timeMorning;

  /// No description provided for @timeAfternoon.
  ///
  /// In pt, this message translates to:
  /// **'Tarde'**
  String get timeAfternoon;

  /// No description provided for @timeNight.
  ///
  /// In pt, this message translates to:
  /// **'Noite'**
  String get timeNight;

  /// No description provided for @timeAnytime.
  ///
  /// In pt, this message translates to:
  /// **'Qualquer Hora'**
  String get timeAnytime;

  /// No description provided for @timeNoon.
  ///
  /// In pt, this message translates to:
  /// **'Meio-dia'**
  String get timeNoon;

  /// No description provided for @otherPrayersSection.
  ///
  /// In pt, this message translates to:
  /// **'Outras Orações'**
  String get otherPrayersSection;

  /// No description provided for @rosarySection.
  ///
  /// In pt, this message translates to:
  /// **'ROSÁRIO'**
  String get rosarySection;

  /// No description provided for @saintOfTheDay.
  ///
  /// In pt, this message translates to:
  /// **'SANTO DO DIA'**
  String get saintOfTheDay;

  /// No description provided for @removeRosaryTitle.
  ///
  /// In pt, this message translates to:
  /// **'Remover terço?'**
  String get removeRosaryTitle;

  /// No description provided for @removeRosaryContent.
  ///
  /// In pt, this message translates to:
  /// **'Deseja remover \"{title}\" do histórico?'**
  String removeRosaryContent(String title);

  /// No description provided for @timePeriodLabel.
  ///
  /// In pt, this message translates to:
  /// **'Período do dia'**
  String get timePeriodLabel;

  /// No description provided for @enableReminderLabel.
  ///
  /// In pt, this message translates to:
  /// **'Ativar lembrete'**
  String get enableReminderLabel;

  /// No description provided for @selectTimeLabel.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar horário'**
  String get selectTimeLabel;

  /// No description provided for @planSetupTitle.
  ///
  /// In pt, this message translates to:
  /// **'Configurar Plano'**
  String get planSetupTitle;

  /// No description provided for @planSetupDesc.
  ///
  /// In pt, this message translates to:
  /// **'Escolha um nível para começar. Você pode mudar depois.'**
  String get planSetupDesc;

  /// No description provided for @planSetupButton.
  ///
  /// In pt, this message translates to:
  /// **'Atualizar Plano'**
  String get planSetupButton;

  /// No description provided for @quickPrayerTab.
  ///
  /// In pt, this message translates to:
  /// **'Oração Rápida'**
  String get quickPrayerTab;

  /// No description provided for @quickPrayerDesc.
  ///
  /// In pt, this message translates to:
  /// **'Registrar uma oração já realizada'**
  String get quickPrayerDesc;

  /// No description provided for @quickPrayerLogButton.
  ///
  /// In pt, this message translates to:
  /// **'Registrar'**
  String get quickPrayerLogButton;

  /// No description provided for @quickPrayerLogged.
  ///
  /// In pt, this message translates to:
  /// **'Oração {title} registrada!'**
  String quickPrayerLogged(String title);

  /// No description provided for @configNotificationsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Notificações'**
  String get configNotificationsTitle;

  /// No description provided for @configNotificationsDesc.
  ///
  /// In pt, this message translates to:
  /// **'Gerenciar permissões de notificação para lembretes de oração.'**
  String get configNotificationsDesc;

  /// No description provided for @configNotificationsButton.
  ///
  /// In pt, this message translates to:
  /// **'Solicitar Permissão'**
  String get configNotificationsButton;

  /// No description provided for @configNotificationsGranted.
  ///
  /// In pt, this message translates to:
  /// **'Permissões concedidas!'**
  String get configNotificationsGranted;

  /// No description provided for @configNotificationsDenied.
  ///
  /// In pt, this message translates to:
  /// **'Permissões negadas. Verifique as configurações do aparelho.'**
  String get configNotificationsDenied;

  /// No description provided for @reportWarningTitle.
  ///
  /// In pt, this message translates to:
  /// **'ATENÇÃO: Recomendações Importantes'**
  String get reportWarningTitle;

  /// No description provided for @reportWarningContent.
  ///
  /// In pt, this message translates to:
  /// **'• Por respeito ao Sacramento e ao sacerdote, recomenda-se copiar este guia para um papel e não ler diretamente do celular.\n\n• Para evitar distrações, desligue o seu celular (ou coloque em modo avião) durante a confissão.'**
  String get reportWarningContent;

  /// No description provided for @reportGuideTitle.
  ///
  /// In pt, this message translates to:
  /// **'GUIA PARA CONFISSÃO'**
  String get reportGuideTitle;

  /// No description provided for @reportKneelInstruction.
  ///
  /// In pt, this message translates to:
  /// **'Ao se ajoelhar, diga ao sacerdote:'**
  String get reportKneelInstruction;

  /// No description provided for @reportBlessMe.
  ///
  /// In pt, this message translates to:
  /// **'\"Abençoai-me, Padre, porque pequei.\"'**
  String get reportBlessMe;

  /// No description provided for @reportLastConfession.
  ///
  /// In pt, this message translates to:
  /// **'Minha última Confissão foi há {time}.'**
  String reportLastConfession(Object time);

  /// No description provided for @reportMySins.
  ///
  /// In pt, this message translates to:
  /// **'MEUS PECADOS SÃO:'**
  String get reportMySins;

  /// No description provided for @reportFinishInstruction.
  ///
  /// In pt, this message translates to:
  /// **'Ao terminar de listar os pecados, diga:'**
  String get reportFinishInstruction;

  /// No description provided for @reportFinalPrayer.
  ///
  /// In pt, this message translates to:
  /// **'\"Acuso-me destes pecados, de todos os que não me lembro e dos de minha vida passada. Deles peço perdão a Deus, e a vós, Padre, a penitência e a absolvição.\"'**
  String get reportFinalPrayer;

  /// No description provided for @reportActOfContritionTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ato de Contrição (Rezar após o sacerdote dar a penitência):'**
  String get reportActOfContritionTitle;

  /// No description provided for @reportActOfContrition.
  ///
  /// In pt, this message translates to:
  /// **'Senhor meu Jesus Cristo, Deus e homem verdadeiro, Criador e Redentor meu, por serdes vós quem sois, sumamente bom e digno de ser amado sobre todas as coisas, e porque vos amo e vos estimo, pesa-me, Senhor, de todo o meu coração, de vos ter ofendido; e proponho firmemente, ajudado com os auxílios de vossa divina graça, emendar-me e nunca mais tornar a vos ofender; espero alcançar de vossa infinita misericórdia o perdão de minhas culpas. Amém.'**
  String get reportActOfContrition;

  /// No description provided for @reportConfessButton.
  ///
  /// In pt, this message translates to:
  /// **'CONFESSAR-SE'**
  String get reportConfessButton;

  /// No description provided for @reportConfessSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Confissão registrada com sucesso!'**
  String get reportConfessSuccess;

  /// No description provided for @reportSinCount.
  ///
  /// In pt, this message translates to:
  /// **'• {sin} ({count, plural, =1{1 vez} other{{count} vezes}})'**
  String reportSinCount(String sin, int count);

  /// No description provided for @backButton.
  ///
  /// In pt, this message translates to:
  /// **'VOLTAR'**
  String get backButton;

  /// No description provided for @nextButton.
  ///
  /// In pt, this message translates to:
  /// **'Próximo'**
  String get nextButton;

  /// No description provided for @finishButton.
  ///
  /// In pt, this message translates to:
  /// **'Concluir'**
  String get finishButton;

  /// No description provided for @dailyExamTitle.
  ///
  /// In pt, this message translates to:
  /// **'Exame Diário'**
  String get dailyExamTitle;

  /// No description provided for @dailyExamStep1Title.
  ///
  /// In pt, this message translates to:
  /// **'Ação de Graças'**
  String get dailyExamStep1Title;

  /// No description provided for @dailyExamStep1Desc.
  ///
  /// In pt, this message translates to:
  /// **'Coloque-se na presença de Deus. Agradeça por todos os benefícios recebidos hoje: a vida, a saúde, a família, a fé, e até pelas dificuldades que te fizeram crescer.'**
  String get dailyExamStep1Desc;

  /// No description provided for @dailyExamStep1Prayer.
  ///
  /// In pt, this message translates to:
  /// **'Senhor, eu Vos dou graças por vossa imensa glória e por todos os benefícios que me concedestes hoje.'**
  String get dailyExamStep1Prayer;

  /// No description provided for @dailyExamStep2Title.
  ///
  /// In pt, this message translates to:
  /// **'Pedido de Luz'**
  String get dailyExamStep2Title;

  /// No description provided for @dailyExamStep2Desc.
  ///
  /// In pt, this message translates to:
  /// **'Peça ao Espírito Santo a graça de conhecer os seus pecados e de rejeitá-los. Peça luz para ver o seu dia como Deus o vê.'**
  String get dailyExamStep2Desc;

  /// No description provided for @dailyExamStep2Prayer.
  ///
  /// In pt, this message translates to:
  /// **'Vinde, Espírito Santo, enchei os corações dos vossos fiéis e acendei neles o fogo do Vosso Amor.'**
  String get dailyExamStep2Prayer;

  /// No description provided for @dailyExamStep3Title.
  ///
  /// In pt, this message translates to:
  /// **'Exame do Dia'**
  String get dailyExamStep3Title;

  /// No description provided for @dailyExamStep3Desc.
  ///
  /// In pt, this message translates to:
  /// **'Percorra as horas do seu dia, desde o levantar até agora. Examine seus pensamentos, palavras, obras e omissões. Onde você falhou no amor a Deus e ao próximo?'**
  String get dailyExamStep3Desc;

  /// No description provided for @dailyExamStep3Prayer.
  ///
  /// In pt, this message translates to:
  /// **'Sondai-me, ó Deus, e conhecei o meu coração; provai-me e conhecei os meus pensamentos.'**
  String get dailyExamStep3Prayer;

  /// No description provided for @dailyExamStep4Title.
  ///
  /// In pt, this message translates to:
  /// **'Contrição'**
  String get dailyExamStep4Title;

  /// No description provided for @dailyExamStep4Desc.
  ///
  /// In pt, this message translates to:
  /// **'Peça perdão a Deus pelas faltas cometidas. Sinta dor por ter ofendido a um Deus tão bom. Confie na Sua misericórdia infinita.'**
  String get dailyExamStep4Desc;

  /// No description provided for @dailyExamStep4Prayer.
  ///
  /// In pt, this message translates to:
  /// **'Meu Deus, porque sois tão bom, tenho muita pena de Vos ter ofendido. Ajudai-me a não pecar mais.'**
  String get dailyExamStep4Prayer;

  /// No description provided for @dailyExamStep5Title.
  ///
  /// In pt, this message translates to:
  /// **'Propósito'**
  String get dailyExamStep5Title;

  /// No description provided for @dailyExamStep5Desc.
  ///
  /// In pt, this message translates to:
  /// **'Faça um firme propósito de se corrigir amanhã. Pense em uma virtude específica para praticar ou um vício para evitar.'**
  String get dailyExamStep5Desc;

  /// No description provided for @dailyExamStep5Prayer.
  ///
  /// In pt, this message translates to:
  /// **'Com a Vossa graça, Senhor, proponho firmemente evitar o pecado e fazer a Vossa vontade. Amém.'**
  String get dailyExamStep5Prayer;

  /// No description provided for @dailyExamPrayerLabel.
  ///
  /// In pt, this message translates to:
  /// **'ORAÇÃO'**
  String get dailyExamPrayerLabel;

  /// No description provided for @confessionMethodTitle.
  ///
  /// In pt, this message translates to:
  /// **'Método de Confissão'**
  String get confessionMethodTitle;

  /// No description provided for @confessionMethodStep1.
  ///
  /// In pt, this message translates to:
  /// **'Ao chegar ao confessionário, o penitente diz:'**
  String get confessionMethodStep1;

  /// No description provided for @confessionMethodStep2.
  ///
  /// In pt, this message translates to:
  /// **'O Sacerdote abençoa. O penitente continua:'**
  String get confessionMethodStep2;

  /// No description provided for @confessionMethodStep3.
  ///
  /// In pt, this message translates to:
  /// **'Em seguida, o penitente diz:'**
  String get confessionMethodStep3;

  /// No description provided for @confessionMethodStep3Content.
  ///
  /// In pt, this message translates to:
  /// **'\"Minha última Confissão foi há...\" (dizer a data aproximada).'**
  String get confessionMethodStep3Content;

  /// No description provided for @confessionMethodStep4.
  ///
  /// In pt, this message translates to:
  /// **'Em seguida, o penitente se acusa de seus pecados. (Use o guia gerado pelo App).\nDepois da confissão dos pecados, o penitente diz:'**
  String get confessionMethodStep4;

  /// No description provided for @confessionMethodStep5.
  ///
  /// In pt, this message translates to:
  /// **'O Sacerdote dá os conselhos e a penitência. Após as palavras do Padre, o penitente recita o ato de contrição:'**
  String get confessionMethodStep5;

  /// No description provided for @confessionMethodOr.
  ///
  /// In pt, this message translates to:
  /// **'... ou ...'**
  String get confessionMethodOr;

  /// No description provided for @confessionMethodAltPrayer.
  ///
  /// In pt, this message translates to:
  /// **'\"Meu Deus, porque sois infinitamente bom e amável, tenho muita pena por vos ter ofendido. Com a vossa graça, é o meu firme propósito não mais voltar a vos ofender. Amém.\"'**
  String get confessionMethodAltPrayer;

  /// No description provided for @confessionMethodStep6.
  ///
  /// In pt, this message translates to:
  /// **'O Sacerdote então recita a fórmula da absolvição.'**
  String get confessionMethodStep6;

  /// No description provided for @catAntesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Antes da Confissão'**
  String get catAntesTitle;

  /// No description provided for @catAntesSub.
  ///
  /// In pt, this message translates to:
  /// **'Erros ao se confessar'**
  String get catAntesSub;

  /// No description provided for @catAntesDesc.
  ///
  /// In pt, this message translates to:
  /// **'Pecados contra o Sacramento'**
  String get catAntesDesc;

  /// No description provided for @catAntesSub1.
  ///
  /// In pt, this message translates to:
  /// **'Pecados contra a Confissão'**
  String get catAntesSub1;

  /// No description provided for @catAntesItem1.
  ///
  /// In pt, this message translates to:
  /// **'Não examinei minha consciência com cuidado.'**
  String get catAntesItem1;

  /// No description provided for @catAntesItem2.
  ///
  /// In pt, this message translates to:
  /// **'Ocultei deliberadamente um pecado mortal na confissão.'**
  String get catAntesItem2;

  /// No description provided for @catAntesItem3.
  ///
  /// In pt, this message translates to:
  /// **'Confessei sem arrependimento verdadeiro.'**
  String get catAntesItem3;

  /// No description provided for @catAntesItem4.
  ///
  /// In pt, this message translates to:
  /// **'Confessei sem firme propósito de correção.'**
  String get catAntesItem4;

  /// No description provided for @catAntesItem5.
  ///
  /// In pt, this message translates to:
  /// **'Confessei sem intenção de cumprir a penitência.'**
  String get catAntesItem5;

  /// No description provided for @catAntesItem6.
  ///
  /// In pt, this message translates to:
  /// **'Recebi a Santa Comunhão em estado de pecado mortal após uma má confissão.'**
  String get catAntesItem6;

  /// No description provided for @catJornadaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Jornada de Confissão'**
  String get catJornadaTitle;

  /// No description provided for @catJornadaDesc.
  ///
  /// In pt, this message translates to:
  /// **'Histórico de confissões'**
  String get catJornadaDesc;

  /// No description provided for @catJornadaSub.
  ///
  /// In pt, this message translates to:
  /// **'Histórico de confissões'**
  String get catJornadaSub;

  /// No description provided for @examinationSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Faça seu exame de consciência com base nas categorias abaixo.'**
  String get examinationSubtitle;

  /// No description provided for @dataStorageInfo.
  ///
  /// In pt, this message translates to:
  /// **'Seus dados são armazenados apenas no seu dispositivo.'**
  String get dataStorageInfo;

  /// No description provided for @preparatoryPrayerSource.
  ///
  /// In pt, this message translates to:
  /// **'(Manual da Paróquia, 1942, p. 87)'**
  String get preparatoryPrayerSource;

  /// No description provided for @catPrayersMain.
  ///
  /// In pt, this message translates to:
  /// **'Orações Principais'**
  String get catPrayersMain;

  /// No description provided for @catPrayersDaily.
  ///
  /// In pt, this message translates to:
  /// **'Orações Diárias'**
  String get catPrayersDaily;

  /// No description provided for @catPrayersSaints.
  ///
  /// In pt, this message translates to:
  /// **'Devoções aos Santos'**
  String get catPrayersSaints;

  /// No description provided for @prayerPaterNosterTitle.
  ///
  /// In pt, this message translates to:
  /// **'Pai Nosso'**
  String get prayerPaterNosterTitle;

  /// No description provided for @prayerPaterNosterContent.
  ///
  /// In pt, this message translates to:
  /// **'Pai Nosso, que estais no Céu, santificado seja o vosso Nome; venha a nós o vosso Reino; seja feita a vossa vontade, assim na terra como no Céu. O pão nosso de cada dia nos dai hoje; perdoai-nos as nossas ofensas, assim como nós perdoamos a quem nos tem ofendido; e não nos deixeis cair em tentação, mas livrai-nos do mal. Amém.'**
  String get prayerPaterNosterContent;

  /// No description provided for @prayerPaterNosterContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Pater noster, qui es in caelis, sanctificetur nomen tuum. Adveniat regnum tuum. Fiat voluntas tua, sicut in caelo et in terra. Panem nostrum quotidianum da nobis hodie, et dimitte nobis debita nostra sicut et nos dimittimus debitoribus nostris. Et ne nos inducas in tentationem, sed libera nos a malo. Amen.'**
  String get prayerPaterNosterContentLatin;

  /// No description provided for @prayerAnimaChristiTitle.
  ///
  /// In pt, this message translates to:
  /// **'Alma de Cristo'**
  String get prayerAnimaChristiTitle;

  /// No description provided for @prayerAnimaChristiContent.
  ///
  /// In pt, this message translates to:
  /// **'Alma de Cristo, santificai-me.\nCorpo de Cristo, salvai-me.\nSangue de Cristo, inebriai-me.\nÁgua do lado de Cristo, lavai-me.\nPaixão de Cristo, confortai-me.\nÓ bom Jesus, ouvi-me.\nDentro de vossas chagas, escondei-me.\nNão permitais que me separe de vós.\nDo espírito maligno, defendei-me.\nNa hora da minha morte, chamai-me\nE mandai-me ir para vós,\nPara que com vossos Santos vos louve\nPor todos os séculos dos séculos. Amém.'**
  String get prayerAnimaChristiContent;

  /// No description provided for @prayerAnimaChristiContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Anima Christi, sanctifica me.\nCorpus Christi, salva me.\nSanguis Christi, inebria me.\nAqua lateris Christi, lava me.\nPassio Christi, conforta me.\nO bone Iesu, exaudi me.\nIntra tua vulnera absconde me.\nNe permittas me separari a te.\nAb hoste maligno defende me.\nIn hora mortis meae voca me.\nEt iube me venire ad te,\nUt cum Sanctis tuis laudem te,\nIn saecula saeculorum. Amen.'**
  String get prayerAnimaChristiContentLatin;

  /// No description provided for @prayerSpiritualCommunionTitle.
  ///
  /// In pt, this message translates to:
  /// **'Comunhão Espiritual'**
  String get prayerSpiritualCommunionTitle;

  /// No description provided for @prayerSpiritualCommunionContent.
  ///
  /// In pt, this message translates to:
  /// **'Creio, meu Jesus, que estais presente no Santíssimo Sacramento.\nAmo-Vos sobre todas as coisas e desejo receber-Vos em minha alma.\nMas como agora não posso receber-Vos sacramentalmente, vinde ao menos espiritualmente ao meu coração.\nE, como se já tivésseis vindo, uno-me inteiramente a Vós; não permitais que eu jamais me separe de Vós. Amém.'**
  String get prayerSpiritualCommunionContent;

  /// No description provided for @prayerSpiritualCommunionContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Credo, mi Iesu, te in Sanctissimo Sacramento praesentem esse.\nAmo te super omnia et desidero te in anima mea recipere.\nCum iam non possim te sacramentaliter sumere, veni saltem spiritualiter in cor meum.\nEt, tamquam iam veneris, unio me totum tibi; ne permitte me unquam a te separari. Amen.'**
  String get prayerSpiritualCommunionContentLatin;

  /// No description provided for @prayerSelfOfferingTitle.
  ///
  /// In pt, this message translates to:
  /// **'Oferecimento de Si Mesmo'**
  String get prayerSelfOfferingTitle;

  /// No description provided for @prayerSelfOfferingContent.
  ///
  /// In pt, this message translates to:
  /// **'Tomai, Senhor, e recebei toda a minha liberdade, a minha memória, o meu entendimento e toda a minha vontade, tudo o que tenho e possuo; Vós me destes; a Vós, Senhor, o restituo. Tudo é vosso, disponde de tudo, à vossa inteira vontade. Dai-me apenas o vosso amor e a vossa graça, que isso me basta. Amém.'**
  String get prayerSelfOfferingContent;

  /// No description provided for @prayerSelfOfferingContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Suscipe, Domine, universam meam libertatem. Accipe memoriam, intellectum, atque voluntatem omnem. Quidquid habeo vel possideo mihi largitus es; id tibi totum restituo, ac tuae prorsus voluntati trado gubernandum. Amorem tui solum cum gratia tua mihi dones, et dives sum satis, nec aliud quidquam ultra posco. Amen.'**
  String get prayerSelfOfferingContentLatin;

  /// No description provided for @prayerAveMariaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ave Maria'**
  String get prayerAveMariaTitle;

  /// No description provided for @prayerAveMariaContent.
  ///
  /// In pt, this message translates to:
  /// **'Ave Maria, cheia de graça, o Senhor é convosco; bendita sois vós entre as mulheres e bendito é o fruto do vosso ventre, Jesus. Santa Maria, Mãe de Deus, rogai por nós, pecadores, agora e na hora da nossa morte. Amém.'**
  String get prayerAveMariaContent;

  /// No description provided for @prayerAveMariaContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Ave Maria, gratia plena, Dominus tecum. Benedicta tu in mulieribus, et benedictus fructus ventris tui, Iesus. Sancta Maria, Mater Dei, ora pro nobis peccatoribus, nunc, et in hora mortis nostrae. Amen.'**
  String get prayerAveMariaContentLatin;

  /// No description provided for @prayerCredoTitle.
  ///
  /// In pt, this message translates to:
  /// **'Credo'**
  String get prayerCredoTitle;

  /// No description provided for @prayerCredoContent.
  ///
  /// In pt, this message translates to:
  /// **'Creio em Deus Pai Todo-Poderoso, Criador do céu e da terra; e em Jesus Cristo, um só seu Filho, Nosso Senhor; o qual foi concebido do Espírito Santo; nasceu de Maria Virgem, padeceu sob o poder de Pôncio Pilatos, foi crucificado, morto e sepultado; desceu aos infernos; ao terceiro dia ressurgiu dos mortos; subiu aos céus, está sentado à mão direita de Deus Pai todo-poderoso, donde há de vir a julgar os vivos e os mortos; creio no Espírito Santo, na Santa Igreja Católica, na comunhão dos Santos, na remissão dos pecados, na ressurreição da carne, na vida eterna. Amém.'**
  String get prayerCredoContent;

  /// No description provided for @prayerCredoContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Credo in Deum Patrem omnipotentem, Creatorem caeli et terrae. Et in Iesum Christum, Filium eius unicum, Dominum nostrum, qui conceptus est de Spiritu Sancto, natus ex Maria Virgine, passus sub Pontio Pilato, crucifixus, mortuus, et sepultus, descendit ad inferos, tertia die resurrexit a mortuis, ascendit ad caelos, sedet ad dexteram Dei Patris omnipotentis, inde venturus est iudicare vivos et mortuos. Credo in Spiritum Sanctum, sanctam Ecclesiam catholicam, sanctorum communionem, remissionem peccatorum, carnis resurrectionem, vitam aeternam. Amen.'**
  String get prayerCredoContentLatin;

  /// No description provided for @prayerVeniCreatorTitle.
  ///
  /// In pt, this message translates to:
  /// **'Vinde Espírito Santo'**
  String get prayerVeniCreatorTitle;

  /// No description provided for @prayerVeniCreatorContent.
  ///
  /// In pt, this message translates to:
  /// **'Vinde Espírito Santo, enchei os corações dos vossos fiéis e acendei neles o fogo do Vosso Amor. Enviai o Vosso Espírito e tudo será criado e renovareis a face da terra.\n\nOremos: Ó Deus, que instruístes os corações dos vossos fiéis, com a luz do Espírito Santo, fazei que apreciemos retamente todas as coisas segundo o mesmo Espírito e gozemos sempre da Sua consolação. Por Cristo Senhor Nosso. Amém.'**
  String get prayerVeniCreatorContent;

  /// No description provided for @prayerVeniCreatorContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Veni, Sancte Spiritus, reple tuorum corda fidelium, et tui amoris in eis ignem accende. Emitte Spiritum tuum et creabuntur. Et renovabis faciem terrae.\n\nOremus: Deus, qui corda fidelium Sancti Spiritus illustratione docuisti: da nobis in eodem Spiritu recta sapere, et de eius semper consolatione gaudere. Per Christum Dominum nostrum. Amen.'**
  String get prayerVeniCreatorContentLatin;

  /// No description provided for @prayerBeforeWorkTitle.
  ///
  /// In pt, this message translates to:
  /// **'Antes do Trabalho'**
  String get prayerBeforeWorkTitle;

  /// No description provided for @prayerBeforeWorkContent.
  ///
  /// In pt, this message translates to:
  /// **'Ofereço-Vos, ó meu Deus, o trabalho que vou iniciar; dignai-Vos abençoá-lo. Eu Vos ofereço a minha vontade, a minha inteligência, a minha memória, a minha imaginação e o meu corpo. Aceitai, Senhor, os meus pensamentos, as minhas palavras e as minhas obras. Tudo o que eu fizer, quero que seja por Vosso amor e para a Vossa glória. Ajudai-me, Senhor, a cumprir o meu dever com perfeição e alegria. Amém.'**
  String get prayerBeforeWorkContent;

  /// No description provided for @prayerMorningTitle.
  ///
  /// In pt, this message translates to:
  /// **'Oração da Manhã'**
  String get prayerMorningTitle;

  /// No description provided for @prayerMorningContent.
  ///
  /// In pt, this message translates to:
  /// **'Pai Nosso...\n\nAve Maria...\n\nCredo...\n\nOferecimento do Dia:\nEu Vos adoro, meu Deus, e Vos amo de todo o coração. Dou-Vos graças por me terdes criado, feito cristão e conservado nesta noite. Ofereço-Vos todas as ações deste dia, fazei que sejam todas segundo a Vossa vontade e para a maior glória Vossa. Preservai-me do pecado e de todo o mal. A Vossa graça seja sempre comigo e com todos os que me são caros.\n\nRecebei, Senhor, minha liberdade inteira. Recebei minha memória, minha inteligência e toda a minha vontade. Tudo o que tenho ou possuo, de Vós me veio; tudo Vos devolvo e entrego sem reservas, para que a Vossa vontade tudo governe. Dai-me somente o Vosso amor e a Vossa graça, e nada mais Vos peço, pois já serei bastante rico.\n\nConsagração a Nossa Senhora:\nÓ minha Senhora e minha Mãe, eu me ofereço todo a vós e, em prova de minha devoção para convosco, vos consagro neste dia os meus olhos, os meus ouvidos, a minha boca, o meu coração e inteiramente todo o meu ser. E porque assim sou vosso, ó incomparável Mãe, guardai-me e defendei-me como coisa e propriedade vossa. \nAmém.'**
  String get prayerMorningContent;

  /// No description provided for @prayerNightTitle.
  ///
  /// In pt, this message translates to:
  /// **'Oração da Noite'**
  String get prayerNightTitle;

  /// No description provided for @prayerNightContent.
  ///
  /// In pt, this message translates to:
  /// **'Pai Nosso... \n\nAve Maria... \n\nCredo... \n\nAção de Graças: \nEu Vos adoro, meu Deus, e Vos amo de todo o coração. Dou-Vos graças por me terdes criado, feito cristão e conservado neste dia. Perdoai-me as faltas que hoje cometi e se fiz algum bem aceitai-o. Guardai-me durante o repouso e livrai-me de todos os perigos. A Vossa graça seja sempre comigo e com todos os que me são caros. Amém. \n\nFaça um breve exame de consciência. \n\nAto de Contrição: \nMeu Jesus, meu bom Jesus, que por mim morrestes na Cruz, perdoai os meus pecados, já não quero mais pecar. Amém. \n\nAto de Fé:\nEu creio firmemente que há um só Deus em três pessoas realmente distintas: Pai, Filho e Espírito Santo, que dá o céu aos bons e o inferno aos maus para sempre. Creio que o Filho de Deus se fez homem, padeceu e morreu na cruz para nos salvar, e que ao terceiro dia ressuscitou. Creio tudo mais que crê e ensina a Santa Igreja Católica, Apostólica, Romana, porque Deus, verdade infalível, lho revelou. E nesta crença quero viver e morrer.\n\nAto de Esperança:\nEu espero, meu Deus, com firme confiança, que pelos merecimentos de meu Senhor Jesus Cristo me dareis a salvação eterna e as graças necessárias para consegui-la, porque Vós, sumamente bom e poderoso, o haveis prometido a quem observar fielmente os Vossos mandamentos, como eu proponho fazer com o Vosso auxílio.\n\nAto de Caridade:\nEu Vos amo, meu Deus, de todo o meu coração e sobre todas as coisas, porque sois infinitamente bom e amável, e antes quero perder tudo do que Vos ofender. Por amor de Vós, amo meu próximo como a mim mesmo.'**
  String get prayerNightContent;

  /// No description provided for @prayerStudiesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Antes dos Estudos'**
  String get prayerStudiesTitle;

  /// No description provided for @prayerStudiesContent.
  ///
  /// In pt, this message translates to:
  /// **'Criador inefável, Vós que sois a verdadeira fonte da luz e da sabedoria, dignai-vos infundir o raio da vossa claridade sobre as trevas da minha inteligência, afastando de mim a dupla escuridão em que nasci: o pecado e a ignorância.\n\nVós, que tornais eloquente a língua das crianças, modelai a minha língua e derramai nos meus lábios a graça da vossa bênção. Dai-me agudeza para entender, capacidade para reter, método e facilidade para aprender, sutileza para interpretar e graça abundante para falar.\n\nDai-me acerto ao começar, direção ao progredir e perfeição ao concluir. Amém.\n(Santo Tomás de Aquino)'**
  String get prayerStudiesContent;

  /// No description provided for @prayerMealsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Antes das Refeições'**
  String get prayerMealsTitle;

  /// No description provided for @prayerMealsContent.
  ///
  /// In pt, this message translates to:
  /// **'Abençoai-nos, Senhor, e estes dons que, da vossa bondade, vamos receber. Por Cristo, Senhor nosso. Amém.'**
  String get prayerMealsContent;

  /// No description provided for @prayerAngelusTitle.
  ///
  /// In pt, this message translates to:
  /// **'O Angelus'**
  String get prayerAngelusTitle;

  /// No description provided for @prayerAngelusContent.
  ///
  /// In pt, this message translates to:
  /// **'℣. O Anjo do Senhor anunciou a Maria.\n℟. E ela concebeu do Espírito Santo.\n\nAve Maria...\n\n℣. Eis aqui a escrava do Senhor.\n℟. Faça-se em mim segundo a vossa palavra.\n\nAve Maria...\n\n℣. E o Verbo se fez carne.\n℟. E habitou entre nós.\n\nAve Maria...\n\n℣. Rogai por nós, Santa Mãe de Deus.\n℟. Para que sejamos dignos das promessas de Cristo.\n\nOremos:\nInfundi, Senhor, a vossa graça em nossas almas, para que nós, que pela anunciação do Anjo conhecemos a encarnação de Cristo, vosso Filho, cheguemos, por sua paixão e cruz, à glória da ressurreição. Pelo mesmo Cristo, Senhor nosso. Amém.'**
  String get prayerAngelusContent;

  /// No description provided for @prayerReginaCaeliTitle.
  ///
  /// In pt, this message translates to:
  /// **'Rainha do Céu (Regina Caeli)'**
  String get prayerReginaCaeliTitle;

  /// No description provided for @prayerReginaCaeliContent.
  ///
  /// In pt, this message translates to:
  /// **'℣. Rainha do Céu, alegrai-vos, aleluia.\n℟. Porque Aquele que merecestes trazer em vosso seio, aleluia.\n℣. Ressuscitou como disse, aleluia.\n℟. Rogai a Deus por nós, aleluia.\n\n℣. Exultai e alegrai-vos, ó Virgem Maria, aleluia.\n℟. Porque o Senhor ressuscitou verdadeiramente, aleluia.\n\nOremos:\nÓ Deus, que vos dignastes alegrar o mundo com a Ressurreição do vosso Filho, Nosso Senhor Jesus Cristo, concedei-nos, vos suplicamos, que por sua Mãe, a Virgem Maria, alcancemos os gozos da vida eterna. Pelo mesmo Cristo, Senhor Nosso. Amém.'**
  String get prayerReginaCaeliContent;

  /// No description provided for @prayerGuardianAngelTitle.
  ///
  /// In pt, this message translates to:
  /// **'Santo Anjo da Guarda'**
  String get prayerGuardianAngelTitle;

  /// No description provided for @prayerGuardianAngelContent.
  ///
  /// In pt, this message translates to:
  /// **'Santo Anjo do Senhor, meu zeloso guardador, se a ti me confiou a piedade divina, sempre me rege, me guarda, me governa e me ilumina. Amém.'**
  String get prayerGuardianAngelContent;

  /// No description provided for @prayerGuardianAngelContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Angele Dei, qui custos es mei, me, tibi commissum pietate superna, illumina, custodi, rege et guberna. Amen.'**
  String get prayerGuardianAngelContentLatin;

  /// No description provided for @prayerStJosephTitle.
  ///
  /// In pt, this message translates to:
  /// **'São José'**
  String get prayerStJosephTitle;

  /// No description provided for @prayerStJosephContent.
  ///
  /// In pt, this message translates to:
  /// **'A vós, São José, recorremos em nossa tribulação e, depois de ter implorado o auxílio de vossa santíssima Esposa, cheios de confiança solicitamos também o vosso patrocínio.\n\nPor esse laço sagrado de caridade que vos uniu à Imaculada Virgem Mãe de Deus, e pelo amor paternal que tivestes ao Menino Jesus, ardentemente suplicamos que lanceis um olhar benigno sobre a herança que Jesus Cristo conquistou com seu Sangue, e nos socorrais em nossas necessidades com o vosso auxílio e poder.\n\nProtegei, ó Guarda providente da divina Família, a raça eleita de Jesus Cristo. Afastai para longe de nós, ó Pai amantíssimo, a peste do erro e do vício. Assisti-nos do alto do céu, ó nosso fortíssimo sustentáculo, na luta contra o poder das trevas.\n\nE assim como outrora salvastes da morte a vida ameaçada do Menino Jesus, assim também defendei agora a Santa Igreja de Deus das ciladas de seus inimigos e de toda a adversidade. Amparai a cada um de nós com o vosso constante patrocínio, a fim de que, a vosso exemplo e sustentados com o vosso auxílio, possamos viver virtuosamente, morrer piedosamente, e obter no céu a eterna bem-aventurança. Amém.'**
  String get prayerStJosephContent;

  /// No description provided for @prayerStThereseTitle.
  ///
  /// In pt, this message translates to:
  /// **'Santa Teresinha'**
  String get prayerStThereseTitle;

  /// No description provided for @prayerStThereseContent.
  ///
  /// In pt, this message translates to:
  /// **'Ó Santa Teresinha do Menino Jesus, modelo de humildade, de confiança e de amor! Do alto dos céus, despejai sobre nós estas rosas que levais em vossos braços: a rosa da humildade, para que vençamos nosso orgulho e aceitemos o jugo do Evangelho; a rosa da confiança, para que nos abandonemos à vontade de Deus; a rosa do amor, para que, abrindo nossas almas sem medida à graça, realizemos o único fim para o qual Deus nos criou: Amá-Lo e fazê-Lo amar.\n\nVós que dissestes: \"Passarei o meu céu fazendo o bem na terra\", ajudai-me em minha aflição e socorrei-me nesta necessidade. Amém.'**
  String get prayerStThereseContent;

  /// No description provided for @prayerGuadalupeTitle.
  ///
  /// In pt, this message translates to:
  /// **'N. Sra. de Guadalupe'**
  String get prayerGuadalupeTitle;

  /// No description provided for @prayerGuadalupeContent.
  ///
  /// In pt, this message translates to:
  /// **'Ó Nossa Senhora de Guadalupe, Rosa Mística, intercedei pela Santa Igreja, protegei o Sumo Pontífice e ajudai a todos os que vos invocam nas suas necessidades.\n\nVós que sois a sempre Virgem Maria e Mãe do Verdadeiro Deus, alcançai-nos de Vosso Santíssimo Filho a graça de conservar a fé, uma doce esperança no meio das amarguras da vida, uma caridade ardente e o precioso dom da perseverança final. Amém.\n(Papa São Pio X)'**
  String get prayerGuadalupeContent;

  /// No description provided for @prayerCarloAcutisTitle.
  ///
  /// In pt, this message translates to:
  /// **'São Carlo Acutis'**
  String get prayerCarloAcutisTitle;

  /// No description provided for @prayerCarloAcutisContent.
  ///
  /// In pt, this message translates to:
  /// **'Senhor Deus, que cumulastes de graças o coração do jovem São Carlo Acutis, despertando nele um amor ardente pela Santíssima Eucaristia e uma terna devoção filial à Virgem Maria, concedei-nos a graça de imitar o seu exemplo.\n\nPor sua intercessão, ensinai-nos a buscar primeiro o vosso Reino, a frequentar com pureza de alma os sacramentos da Confissão e da Comunhão, e a usar os meios deste mundo apenas para a vossa maior glória e para o bem dos pobres e necessitados.\n\nSão Carlo Acutis, rogai por nós, para que vivamos sempre unidos a Jesus e alcancemos a vida eterna. Amém.'**
  String get prayerCarloAcutisContent;

  /// No description provided for @temptationFightTitle.
  ///
  /// In pt, this message translates to:
  /// **'Luta contra as Tentações'**
  String get temptationFightTitle;

  /// No description provided for @temptationFightDesc.
  ///
  /// In pt, this message translates to:
  /// **'Orações e auxílio em momento de tentação'**
  String get temptationFightDesc;

  /// No description provided for @temptationStep1Title.
  ///
  /// In pt, this message translates to:
  /// **'Reconheça a Tentação'**
  String get temptationStep1Title;

  /// No description provided for @temptationStep1Desc.
  ///
  /// In pt, this message translates to:
  /// **'A tentação é um perigo real para a alma. Reconheça-a imediatamente e não dialogue com ela. O demônio é astuto e usa a hesitação para nos vencer.'**
  String get temptationStep1Desc;

  /// No description provided for @temptationStep1Prayer.
  ///
  /// In pt, this message translates to:
  /// **'\"Vigiai e orai, para que não entreis em tentação.\" (Mt 26,41)'**
  String get temptationStep1Prayer;

  /// No description provided for @temptationStep2Title.
  ///
  /// In pt, this message translates to:
  /// **'Jaculatórias de Socorro'**
  String get temptationStep2Title;

  /// No description provided for @temptationStep2Desc.
  ///
  /// In pt, this message translates to:
  /// **'Orações curtas e poderosas para momentos de tentação. Repita-as com fervor até sentir a tentação diminuir.'**
  String get temptationStep2Desc;

  /// No description provided for @temptationStep2Prayer.
  ///
  /// In pt, this message translates to:
  /// **'• Jesus e Maria, eu vos amo, salvai almas.\n• Meu Jesus, misericórdia!\n• Jesus, manso e humilde de coração, fazei o nosso coração semelhante ao Vosso.\n• Refúgio dos Pecadores, rogai por nós.'**
  String get temptationStep2Prayer;

  /// No description provided for @temptationStep3Title.
  ///
  /// In pt, this message translates to:
  /// **'São Miguel Arcanjo'**
  String get temptationStep3Title;

  /// No description provided for @temptationStep3Desc.
  ///
  /// In pt, this message translates to:
  /// **'O Príncipe da Milícia Celeste é nosso defensor contra as ciladas do demônio. Invoque-o com confiança!'**
  String get temptationStep3Desc;

  /// No description provided for @temptationStep3Prayer.
  ///
  /// In pt, this message translates to:
  /// **'São Miguel Arcanjo, defendei-nos no combate; sede nosso refúgio contra a maldade e as ciladas do demônio. Ordene-lhe Deus, instantemente o pedimos, e Vós, Príncipe da Milícia Celeste, pela virtude divina, precipitai no inferno a Satanás e aos outros espíritos malignos que andam pelo mundo para a perdição das almas. Amém.'**
  String get temptationStep3Prayer;

  /// No description provided for @temptationStep4Title.
  ///
  /// In pt, this message translates to:
  /// **'Lembrai-Vos'**
  String get temptationStep4Title;

  /// No description provided for @temptationStep4Desc.
  ///
  /// In pt, this message translates to:
  /// **'A Virgem Maria nunca abandona quem a Ela recorre. Confie em sua intercessão maternal.'**
  String get temptationStep4Desc;

  /// No description provided for @temptationStep4Prayer.
  ///
  /// In pt, this message translates to:
  /// **'Lembrai-Vos, ó piíssima Virgem Maria, que nunca se ouviu dizer que algum daqueles que têm recorrido à Vossa proteção, implorado a Vossa assistência e reclamado o Vosso socorro, fosse por Vós desamparado. Animado eu com igual confiança, a Vós recorro, ó Virgem das Virgens, minha Mãe. De Vós me valho, a Vós venho, e gemendo sob o peso de meus pecados, me prostro a Vossos pés. Não desprezeis as minhas súplicas, ó Mãe do Verbo de Deus humanado, mas dignai-Vos de as ouvir propícia, e de me alcançar o que Vos rogo. Amém.'**
  String get temptationStep4Prayer;

  /// No description provided for @temptationStep5Title.
  ///
  /// In pt, this message translates to:
  /// **'A Fuga é Vitória'**
  String get temptationStep5Title;

  /// No description provided for @temptationStep5Desc.
  ///
  /// In pt, this message translates to:
  /// **'Na tentação da impureza, a vitória consiste na fuga. Não lute corpo a corpo com a tentação – fuja dela! Os santos venceram fugindo, não enfrentando.'**
  String get temptationStep5Desc;

  /// No description provided for @temptationStep5Prayer.
  ///
  /// In pt, this message translates to:
  /// **'\"Fugi da fornicação.\" (1 Cor 6,18)\n\n\"Aquele que se expõe voluntariamente ao perigo, nele perecerá.\" (Eclo 3,27)'**
  String get temptationStep5Prayer;

  /// No description provided for @temptationStep6Title.
  ///
  /// In pt, this message translates to:
  /// **'Mude o Ambiente'**
  String get temptationStep6Title;

  /// No description provided for @temptationStep6Desc.
  ///
  /// In pt, this message translates to:
  /// **'Dicas práticas para fugir da tentação:\n\n• Mude de pensamento: ocupe a mente com algo neutro\n• Mude de lugar: saia do ambiente de tentação\n• Faça uma tarefa: trabalho manual, exercício, leitura\n• Busque companhia: não fique sozinho\n• Desligue dispositivos: afaste-se da ocasião próxima'**
  String get temptationStep6Desc;

  /// No description provided for @temptationStep6Prayer.
  ///
  /// In pt, this message translates to:
  /// **'Senhor, dai-me a sabedoria para fugir das ocasiões de pecado e a força para me afastar do perigo.'**
  String get temptationStep6Prayer;

  /// No description provided for @temptationStep7Title.
  ///
  /// In pt, this message translates to:
  /// **'Rompa o Cerco'**
  String get temptationStep7Title;

  /// No description provided for @temptationStep7Desc.
  ///
  /// In pt, this message translates to:
  /// **'Jaculatórias para quando o desânimo ataca. Não desista! Deus permite a tentação para nos fortalecer, não para nos derrubar.'**
  String get temptationStep7Desc;

  /// No description provided for @temptationStep7Prayer.
  ///
  /// In pt, this message translates to:
  /// **'• Senhor, eu creio! Ajudai a minha incredulidade.\n• Mãe Santíssima, não me deixeis!\n• Coração Sagrado de Jesus, em Vós confio!\n• São José, guardião da pureza, rogai por nós!'**
  String get temptationStep7Prayer;

  /// No description provided for @temptationStep8Title.
  ///
  /// In pt, this message translates to:
  /// **'Propósito e Consagração'**
  String get temptationStep8Title;

  /// No description provided for @temptationStep8Desc.
  ///
  /// In pt, this message translates to:
  /// **'Renove seu propósito de fidelidade a Deus. Consagre-se à proteção de Nossa Senhora.'**
  String get temptationStep8Desc;

  /// No description provided for @temptationStep8Prayer.
  ///
  /// In pt, this message translates to:
  /// **'Ó minha Senhora e minha Mãe, eu me ofereço todo a vós e, em prova de minha devoção para convosco, vos consagro neste dia os meus olhos, os meus ouvidos, a minha boca, o meu coração e inteiramente todo o meu ser. E porque assim sou vosso, ó incomparável Mãe, guardai-me e defendei-me como coisa e propriedade vossa. Amém.'**
  String get temptationStep8Prayer;

  /// No description provided for @joyful1Title.
  ///
  /// In pt, this message translates to:
  /// **'1º Mistério: A Anunciação do Anjo a Maria'**
  String get joyful1Title;

  /// No description provided for @joyful1Short.
  ///
  /// In pt, this message translates to:
  /// **'Pedimos, por este mistério e pela intercessão de Maria, uma profunda humildade de coração.'**
  String get joyful1Short;

  /// No description provided for @joyful1Full.
  ///
  /// In pt, this message translates to:
  /// **'Nós vos oferecemos, Senhor Jesus, esta primeira dezena, em honra de vossa Encarnação no seio de Maria; e vos pedimos, por este mistério e por sua intercessão, uma profunda humildade de coração. Amém.'**
  String get joyful1Full;

  /// No description provided for @joyful2Title.
  ///
  /// In pt, this message translates to:
  /// **'2º Mistério: A Visitação de Maria a Isabel'**
  String get joyful2Title;

  /// No description provided for @joyful2Short.
  ///
  /// In pt, this message translates to:
  /// **'Pedimos, por este mistério e pela intercessão de Maria, a perfeita caridade para com o próximo.'**
  String get joyful2Short;

  /// No description provided for @joyful2Full.
  ///
  /// In pt, this message translates to:
  /// **'Nós vos oferecemos, Senhor Jesus, esta segunda dezena, em honra da Visitação de vossa Santíssima Mãe à sua prima Santa Isabel e da santificação de São João Batista; e vos pedimos, por este mistério e pela intercessão de vossa Mãe Santíssima, uma perfeita caridade para com o nosso próximo. Amém.'**
  String get joyful2Full;

  /// No description provided for @joyful3Title.
  ///
  /// In pt, this message translates to:
  /// **'3º Mistério: O Nascimento de Jesus'**
  String get joyful3Title;

  /// No description provided for @joyful3Short.
  ///
  /// In pt, this message translates to:
  /// **'Pedimos, por este mistério e pela intercessão de Maria, o desapego dos bens materiais e o amor à pobreza.'**
  String get joyful3Short;

  /// No description provided for @joyful3Full.
  ///
  /// In pt, this message translates to:
  /// **'Nós vos oferecemos, Senhor Jesus, esta terceira dezena, em honra de vosso Nascimento no estábulo de Belém; e vos pedimos, por este mistério e pela intercessão de vossa Santíssima Mãe, o desapego dos bens da terra, o desapego de nós mesmos e o amor à pobreza e aos pobres. Amém.'**
  String get joyful3Full;

  /// No description provided for @joyful4Title.
  ///
  /// In pt, this message translates to:
  /// **'4º Mistério: A Apresentação de Jesus no Templo'**
  String get joyful4Title;

  /// No description provided for @joyful4Short.
  ///
  /// In pt, this message translates to:
  /// **'Pedimos, por este mistério e pela intercessão de Maria, uma grande pureza e perfeita obediência.'**
  String get joyful4Short;

  /// No description provided for @joyful4Full.
  ///
  /// In pt, this message translates to:
  /// **'Nós vos oferecemos, Senhor Jesus, esta quarta dezena, em honra de vossa Apresentação no Templo e da Purificação de Maria; e vos pedimos, por este mistério e por sua intercessão, uma grande pureza de corpo e de espírito e uma perfeita obediência à santa vontade de Deus. Amém.'**
  String get joyful4Full;

  /// No description provided for @joyful5Title.
  ///
  /// In pt, this message translates to:
  /// **'5º Mistério: A Perda e o Encontro de Jesus no Templo'**
  String get joyful5Title;

  /// No description provided for @joyful5Short.
  ///
  /// In pt, this message translates to:
  /// **'Pedimos, por este mistério e pela intercessão de Maria, a verdadeira sabedoria e conversão de vida.'**
  String get joyful5Short;

  /// No description provided for @joyful5Full.
  ///
  /// In pt, this message translates to:
  /// **'Nós vos oferecemos, Senhor Jesus, esta quinta dezena, em honra de vosso Encontro no Templo por Maria; e vos pedimos, por este mistério e por sua intercessão, a verdadeira sabedoria, a conversão de nossa vida e a de todos os pecadores. Amém.'**
  String get joyful5Full;

  /// No description provided for @sorrowful1Title.
  ///
  /// In pt, this message translates to:
  /// **'1º Mistério: A Agonia de Jesus no Jardim das Oliveiras'**
  String get sorrowful1Title;

  /// No description provided for @sorrowful1Short.
  ///
  /// In pt, this message translates to:
  /// **'Pedimos, por este mistério e pela intercessão de Maria, a contrição de nossos pecados e a conformidade com a vontade de Deus.'**
  String get sorrowful1Short;

  /// No description provided for @sorrowful1Full.
  ///
  /// In pt, this message translates to:
  /// **'Nós vos oferecemos, Senhor Jesus, esta primeira dezena dos mistérios dolorosos, em honra de vossa agonia mortal no Jardim das Oliveiras; e vos pedimos, por este mistério e pela intercessão de vossa Mãe Santíssima, a contrição de nossos pecados e uma perfeita conformidade com a vossa santa vontade. Amém.'**
  String get sorrowful1Full;

  /// No description provided for @sorrowful2Title.
  ///
  /// In pt, this message translates to:
  /// **'2º Mistério: A Flagelação de Jesus'**
  String get sorrowful2Title;

  /// No description provided for @sorrowful2Short.
  ///
  /// In pt, this message translates to:
  /// **'Pedimos, por este mistério e pela intercessão de Maria, a mortificação de nossos sentidos e a perfeita castidade.'**
  String get sorrowful2Short;

  /// No description provided for @sorrowful2Full.
  ///
  /// In pt, this message translates to:
  /// **'Nós vos oferecemos, Senhor Jesus, esta segunda dezena dos mistérios dolorosos, em honra de vossa cruel Flagelação; e vos pedimos, por este mistério e pela intercessão de vossa Mãe Santíssima, a mortificação de nossos sentidos e a perfeita castidade. Amém.'**
  String get sorrowful2Full;

  /// No description provided for @sorrowful3Title.
  ///
  /// In pt, this message translates to:
  /// **'3º Mistério: A Coroação de Espinhos'**
  String get sorrowful3Title;

  /// No description provided for @sorrowful3Short.
  ///
  /// In pt, this message translates to:
  /// **'Pedimos, por este mistério e pela intercessão de Maria, o desprezo do mundo e o desapego das vaidades.'**
  String get sorrowful3Short;

  /// No description provided for @sorrowful3Full.
  ///
  /// In pt, this message translates to:
  /// **'Nós vos oferecemos, Senhor Jesus, esta terceira dezena dos mistérios dolorosos, em honra de vossa Coroação de espinhos; e vos pedimos, por este mistério e pela intercessão de vossa Mãe Santíssima, o desprezo do mundo e o desapego das honras e vaidades. Amém.'**
  String get sorrowful3Full;

  /// No description provided for @sorrowful4Title.
  ///
  /// In pt, this message translates to:
  /// **'4º Mistério: Jesus Carrega a Cruz'**
  String get sorrowful4Title;

  /// No description provided for @sorrowful4Short.
  ///
  /// In pt, this message translates to:
  /// **'Pedimos, por este mistério e pela intercessão de Maria, uma grande paciência para carregar a nossa cruz.'**
  String get sorrowful4Short;

  /// No description provided for @sorrowful4Full.
  ///
  /// In pt, this message translates to:
  /// **'Nós vos oferecemos, Senhor Jesus, esta quarta dezena dos mistérios dolorosos, em honra do carregamento de vossa pesada Cruz; e vos pedimos, por este mistério e pela intercessão de vossa Mãe Santíssima, uma grande paciência para carregar a nossa cruz a vosso exemplo por toda a nossa vida. Amém.'**
  String get sorrowful4Full;

  /// No description provided for @sorrowful5Title.
  ///
  /// In pt, this message translates to:
  /// **'5º Mistério: A Crucifixão e Morte de Jesus'**
  String get sorrowful5Title;

  /// No description provided for @sorrowful5Short.
  ///
  /// In pt, this message translates to:
  /// **'Pedimos, por este mistério e pela intercessão de Maria, a conversão dos pecadores e a perseverança final.'**
  String get sorrowful5Short;

  /// No description provided for @sorrowful5Full.
  ///
  /// In pt, this message translates to:
  /// **'Nós vos oferecemos, Senhor Jesus, esta quinta dezena dos mistérios dolorosos, em honra de vossa Crucifixão e morte dolorosa no Calvário; e vos pedimos, por este mistério e pela intercessão de vossa Mãe Santíssima, a conversão dos pecadores, a nossa perseverança final e o alívio das almas do Purgatório. Amém.'**
  String get sorrowful5Full;

  /// No description provided for @glorious1Title.
  ///
  /// In pt, this message translates to:
  /// **'1º Mistério: A Ressurreição de Jesus'**
  String get glorious1Title;

  /// No description provided for @glorious1Short.
  ///
  /// In pt, this message translates to:
  /// **'Pedimos, por este mistério e pela intercessão de Maria, uma fé viva.'**
  String get glorious1Short;

  /// No description provided for @glorious1Full.
  ///
  /// In pt, this message translates to:
  /// **'Nós vos oferecemos, Senhor Jesus, esta primeira dezena dos mistérios gloriosos, em honra de vossa gloriosa Ressurreição; e vos pedimos, por este mistério e pela intercessão de vossa Mãe Santíssima, uma fé viva. Amém.'**
  String get glorious1Full;

  /// No description provided for @glorious2Title.
  ///
  /// In pt, this message translates to:
  /// **'2º Mistério: A Ascensão de Jesus ao Céu'**
  String get glorious2Title;

  /// No description provided for @glorious2Short.
  ///
  /// In pt, this message translates to:
  /// **'Pedimos, por este mistério e pela intercessão de Maria, um firme desejo do Céu e grande confiança em Deus.'**
  String get glorious2Short;

  /// No description provided for @glorious2Full.
  ///
  /// In pt, this message translates to:
  /// **'Nós vos oferecemos, Senhor Jesus, esta segunda dezena dos mistérios gloriosos, em honra de vossa gloriosa Ascensão ao Céu; e vos pedimos, por este mistério e pela intercessão de vossa Mãe Santíssima, um firme desejo do Céu e uma grande confiança em Vós. Amém.'**
  String get glorious2Full;

  /// No description provided for @glorious3Title.
  ///
  /// In pt, this message translates to:
  /// **'3º Mistério: A Descida do Espírito Santo sobre os Apóstolos'**
  String get glorious3Title;

  /// No description provided for @glorious3Short.
  ///
  /// In pt, this message translates to:
  /// **'Pedimos, por este mistério e pela intercessão de Maria, a descida do Espírito Santo e a caridade divina.'**
  String get glorious3Short;

  /// No description provided for @glorious3Full.
  ///
  /// In pt, this message translates to:
  /// **'Nós vos oferecemos, Senhor Jesus, esta terceira dezena dos mistérios gloriosos, em honra do mistério de Pentecostes; e vos pedimos, por este mistério e pela intercessão de vossa Mãe Santíssima, a descida do Espírito Santo em nossas almas e o dom da verdadeira caridade divina. Amém.'**
  String get glorious3Full;

  /// No description provided for @glorious4Title.
  ///
  /// In pt, this message translates to:
  /// **'4º Mistério: A Assunção de Nossa Senhora ao Céu'**
  String get glorious4Title;

  /// No description provided for @glorious4Short.
  ///
  /// In pt, this message translates to:
  /// **'Pedimos, por este mistério e pela intercessão de Maria, uma perfeita união com ela e uma terna devoção a tão boa Mãe.'**
  String get glorious4Short;

  /// No description provided for @glorious4Full.
  ///
  /// In pt, this message translates to:
  /// **'Nós vos oferecemos, Senhor Jesus, esta quarta dezena dos mistérios gloriosos, em honra da gloriosa Assunção de vossa Santíssima Mãe ao Céu; e vos pedimos, por este mistério e por sua intercessão, uma perfeita união com ela e uma terna devoção a tão boa Mãe. Amém.'**
  String get glorious4Full;

  /// No description provided for @glorious5Title.
  ///
  /// In pt, this message translates to:
  /// **'5º Mistério: A Coroação de Nossa Senhora como Rainha do Céu e da Terra'**
  String get glorious5Title;

  /// No description provided for @glorious5Short.
  ///
  /// In pt, this message translates to:
  /// **'Pedimos, por este mistério e pela intercessão de Maria, a perseverança na graça e a coroa da glória eterna.'**
  String get glorious5Short;

  /// No description provided for @glorious5Full.
  ///
  /// In pt, this message translates to:
  /// **'Nós vos oferecemos, Senhor Jesus, esta quinta dezena dos mistérios gloriosos, em honra da Coroação de vossa Santíssima Mãe no Céu; e vos pedimos, por este mistério e por sua intercessão, a perseverança na graça e a coroa da glória eterna. Amém.'**
  String get glorious5Full;

  /// No description provided for @luminous1Title.
  ///
  /// In pt, this message translates to:
  /// **'1º Mistério: O Batismo de Jesus no Jordão'**
  String get luminous1Title;

  /// No description provided for @luminous1Short.
  ///
  /// In pt, this message translates to:
  /// **'Jesus é batizado por João no Rio Jordão. O céu se abre, o Espírito Santo desce como pomba, e o Pai declara: \"Este é meu Filho amado\".'**
  String get luminous1Short;

  /// No description provided for @luminous1Full.
  ///
  /// In pt, this message translates to:
  /// **'Então veio Jesus da Galileia ter com João ao Jordão, para ser batizado por ele. Mas João opunha-se-lhe, dizendo: \"Eu sou o que devo ser batizado por ti, e vens tu a mim?\" Jesus, porém, respondendo, disse-lhe: \"Deixa por agora; porque assim nos convém cumprir toda a justiça\". Então ele o consentiu. E sendo Jesus batizado, saiu logo da água; e eis que se lhe abriram os céus, e viu o Espírito de Deus que descia como uma pomba, e vinha sobre ele. E eis que uma voz dos céus dizia: \"Este é o meu Filho amado, em quem tenho posto toda a minha complacência\". Neste mistério, contemplamos a humildade de Jesus, que não precisava de batismo, mas quis santificar as águas e dar-nos o exemplo. É também a epifania da Santíssima Trindade: o Pai que fala, o Filho que é batizado, o Espírito Santo que desce.'**
  String get luminous1Full;

  /// No description provided for @luminous2Title.
  ///
  /// In pt, this message translates to:
  /// **'2º Mistério: As Bodas de Caná'**
  String get luminous2Title;

  /// No description provided for @luminous2Short.
  ///
  /// In pt, this message translates to:
  /// **'Nas bodas de Caná, Jesus realiza seu primeiro milagre, transformando água em vinho, por intercessão de sua Mãe Maria.'**
  String get luminous2Short;

  /// No description provided for @luminous2Full.
  ///
  /// In pt, this message translates to:
  /// **'E, ao terceiro dia, fizeram-se umas bodas em Caná da Galileia; e estava ali a mãe de Jesus. E foram também convidados Jesus e os seus discípulos para as bodas. E, faltando o vinho, a mãe de Jesus lhe disse: \"Não têm vinho\". Disse-lhe Jesus: \"Mulher, que tenho eu contigo? Ainda não é chegada a minha hora\". Disse sua mãe aos serventes: \"Fazei tudo quanto ele vos disser\". E estavam ali postas seis talhas de pedra, segundo a purificação dos judeus, que tinham cada uma duas ou três medidas. Disse-lhes Jesus: \"Enchei as talhas de água\". E encheram-nas até acima. E disse-lhes: \"Tirai agora, e levai ao que tem o encargo da mesa\". E levaram-lho. E, logo que o chefe da mesa provou a água feita vinho (não sabendo donde vinha, se bem que os serventes que tinham tirado a água o sabiam), chamou o esposo, e disse-lhe: \"Todo o homem põe primeiro o vinho bom, e, quando já têm bebido bem, então o inferior; mas tu guardaste até agora o vinho bom\". Este princípio dos milagres o fez Jesus em Caná da Galileia; e manifestou a sua glória, e os seus discípulos creram nele.'**
  String get luminous2Full;

  /// No description provided for @luminous3Title.
  ///
  /// In pt, this message translates to:
  /// **'3º Mistério: O Anúncio do Reino de Deus'**
  String get luminous3Title;

  /// No description provided for @luminous3Short.
  ///
  /// In pt, this message translates to:
  /// **'Jesus percorre a Galileia pregando o Evangelho e chamando à conversão: \"O Reino de Deus está próximo: arrependei-vos e crede no Evangelho\".'**
  String get luminous3Short;

  /// No description provided for @luminous3Full.
  ///
  /// In pt, this message translates to:
  /// **'E, depois que João foi entregue à prisão, veio Jesus para a Galileia, pregando o evangelho do Reino de Deus, e dizendo: \"O tempo está cumprido, e o Reino de Deus está próximo: arrependei-vos, e crede no evangelho\". E percorria Jesus toda a Galileia, ensinando nas suas sinagogas e pregando o evangelho do reino, e curando todas as enfermidades e moléstias entre o povo. E a sua fama correu por toda a Síria, e traziam-lhe todos os que padeciam de vários males e dores, os endemoninhados, lunáticos e paralíticos, e ele os curava. E seguia-o uma grande multidão da Galileia, de Decápolis, de Jerusalém, da Judeia e de além do Jordão. E Jesus, vendo a multidão, subiu a um monte; e, assentando-se, os seus discípulos chegaram-se a ele. E, abrindo a sua boca, os ensinava, dizendo: \"Bem-aventurados os pobres de espírito, porque deles é o reino dos céus. Bem-aventurados os que choram, porque eles serão consolados\".'**
  String get luminous3Full;

  /// No description provided for @luminous4Title.
  ///
  /// In pt, this message translates to:
  /// **'4º Mistério: A Transfiguração de Jesus'**
  String get luminous4Title;

  /// No description provided for @luminous4Short.
  ///
  /// In pt, this message translates to:
  /// **'No Monte Tabor, Jesus se transfigura diante de Pedro, Tiago e João. Seu rosto brilha como o sol e suas vestes tornam-se brancas como a luz.'**
  String get luminous4Short;

  /// No description provided for @luminous4Full.
  ///
  /// In pt, this message translates to:
  /// **'E, seis dias depois, Jesus tomou consigo a Pedro, a Tiago e a João, e os levou sós, em particular, a um alto monte; e transfigurou-se diante deles. E os seus vestidos tornaram-se resplandecentes, em extremo brancos, como a neve, como nenhum lavadeiro sobre a terra os poderia branquear. E apareceu-lhes Elias, com Moisés, e falavam com Jesus. E Pedro, tomando a palavra, disse a Jesus: \"Rabi, bom é que nós estejamos aqui, e façamos três cabanas, uma para ti, outra para Moisés, e outra para Elias\". Pois não sabia o que dizia, porque estavam atemorizados. E formou-se uma nuvem que os cobriu com a sua sombra, e saiu da nuvem uma voz que dizia: \"Este é o meu Filho amado; a ele ouvi\". E, tendo olhado em roda, ninguém mais viram, senão só Jesus, com eles. E, ao descerem do monte, ordenou-lhes que a ninguém contassem o que tinham visto, senão depois que o Filho do homem tivesse ressuscitado dentre os mortos.'**
  String get luminous4Full;

  /// No description provided for @luminous5Title.
  ///
  /// In pt, this message translates to:
  /// **'5º Mistério: A Instituição da Eucaristia'**
  String get luminous5Title;

  /// No description provided for @luminous5Short.
  ///
  /// In pt, this message translates to:
  /// **'Na Última Ceia, Jesus institui a Eucaristia, dando-nos seu Corpo e Sangue: \"Isto é o meu Corpo. Fazei isto em memória de mim\".'**
  String get luminous5Short;

  /// No description provided for @luminous5Full.
  ///
  /// In pt, this message translates to:
  /// **'No primeiro dia dos pães asmos, quando sacrificavam a Páscoa, perguntaram-lhe seus discípulos: \"Onde queres que vamos preparar para que comas a Páscoa?\" E, comendo eles, tomou Jesus pão, e, abençoando-o, o partiu, e deu-lho, e disse: \"Tomai, isto é o meu corpo\". E, tomando o cálice e dando graças, deu-lho; e todos beberam dele. E disse-lhes: \"Isto é o meu sangue, o sangue da nova aliança, que por muitos é derramado. Em verdade vos digo que não beberei mais do fruto da vide, até àquele dia em que o beber novo, no Reino de Deus\". Antes do dia da festa da Páscoa, sabendo Jesus que era chegada a sua hora de passar deste mundo para o Pai, como tivesse amado os seus que estavam no mundo, amou-os até o fim. Este é o maior dom: Jesus permanece conosco na Eucaristia até o fim dos tempos.'**
  String get luminous5Full;

  /// No description provided for @prayerGloriaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Glória'**
  String get prayerGloriaTitle;

  /// No description provided for @prayerGloriaContent.
  ///
  /// In pt, this message translates to:
  /// **'Glória ao Pai, ao Filho e ao Espírito Santo. Como era no princípio, agora e sempre, por todos os séculos dos séculos. Amém.'**
  String get prayerGloriaContent;

  /// No description provided for @prayerGloriaContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Gloria Patri, et Filio, et Spiritui Sancto. Sicut erat in principio, et nunc, et semper, et in saecula saeculorum. Amen.'**
  String get prayerGloriaContentLatin;

  /// No description provided for @prayerSalveTitle.
  ///
  /// In pt, this message translates to:
  /// **'Salve Rainha'**
  String get prayerSalveTitle;

  /// No description provided for @prayerSalveContent.
  ///
  /// In pt, this message translates to:
  /// **'Infinitas graças vos damos, Soberana Rainha, pelos benefícios que todos os dias recebemos de vossas mãos liberais. Dignai-vos, agora e para sempre, tomar-nos debaixo do vosso poderoso amparo e, para mais vos obrigar, vos saudamos com uma Salve-Rainha. \n\nSalve, Rainha, Mãe de misericórdia, vida, doçura e esperança nossa, salve! A vós bradamos, os degredados filhos de Eva. A vós suspiramos, gemendo e chorando neste vale de lágrimas. Eia, pois, Advogada nossa, esses vossos olhos misericordiosos a nós volvei. E depois deste desterro, mostrai-nos Jesus, bendito fruto do vosso ventre. Ó clemente, ó piedosa, ó doce sempre Virgem Maria. Rogai por nós, Santa Mãe de Deus, para que sejamos dignos das promessas de Cristo. Amém.'**
  String get prayerSalveContent;

  /// No description provided for @prayerSalveContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Infinitas gratias tibi agimus, suprema Regina, pro beneficiis quae quotidie ex manibus tuis liberalibus accipimus. Dignare nunc et in aeternum nos sub potenti tuo patrocinio suscipere, et tibi gratias agentes, te Salve Regina salutamus.\n\nSalve, Regina, mater misericordiae, vita, dulcedo, et spes nostra, salve. Ad te clamamus, exsules filii Hevae. Ad te suspiramus, gementes et flentes in hac lacrimarum valle. Eia, ergo, advocata nostra, illos tuos misericordes oculos ad nos converte. Et Iesum, benedictum fructum ventris tui, nobis post hoc exsilium ostende. O clemens, O pia, O dulcis Virgo Maria.\n\n℣. Ora pro nobis, sancta Dei Genetrix.\n℟. Ut digni efficiamur promissionibus Christi. Amen.'**
  String get prayerSalveContentLatin;

  /// No description provided for @prayerFatimaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Oração de Fátima'**
  String get prayerFatimaTitle;

  /// No description provided for @prayerFatimaContent.
  ///
  /// In pt, this message translates to:
  /// **'Ó meu Jesus, perdoai-nos, livrai-nos do fogo do inferno, levai as almas todas para o Céu, principalmente as que mais precisarem.'**
  String get prayerFatimaContent;

  /// No description provided for @prayerMariaImaculadaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Oratio ad Beatam Virginem Mariam (Oração da Noite)'**
  String get prayerMariaImaculadaTitle;

  /// No description provided for @prayerMariaImaculadaContent.
  ///
  /// In pt, this message translates to:
  /// **'Ó Maria concebida sem pecado, livrai-nos nesta noite de todo pecado mortal, venial e de toda imperfeição. Amém.'**
  String get prayerMariaImaculadaContent;

  /// No description provided for @prayerMariaImaculadaContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'O Maria, sine labe concepta, libera nos hac nocte ab omni peccato mortali, veniali et ab omni imperfectione. Amen.'**
  String get prayerMariaImaculadaContentLatin;

  /// No description provided for @prayerMariaImaculadaMorningTitle.
  ///
  /// In pt, this message translates to:
  /// **'Oratio ad Beatam Virginem Mariam (Oração da Manhã)'**
  String get prayerMariaImaculadaMorningTitle;

  /// No description provided for @prayerMariaImaculadaMorningContent.
  ///
  /// In pt, this message translates to:
  /// **'Ó Maria concebida sem pecado, livrai-nos neste dia de todo pecado mortal, venial e de toda imperfeição. Amém.'**
  String get prayerMariaImaculadaMorningContent;

  /// No description provided for @prayerMariaImaculadaMorningContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'O Maria, sine labe concepta, libera nos hoc die ab omni peccato mortali, veniali et ab omni imperfectione. Amen.'**
  String get prayerMariaImaculadaMorningContentLatin;

  /// No description provided for @prayerSignCrossTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sinal da Cruz'**
  String get prayerSignCrossTitle;

  /// No description provided for @prayerSignCrossContent.
  ///
  /// In pt, this message translates to:
  /// **'Em nome do Pai, e do Filho, e do Espírito Santo. Amém.'**
  String get prayerSignCrossContent;

  /// No description provided for @prayerSignCrossContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'In nomine Patris, et Filii, et Spiritus Sancti. Amen.'**
  String get prayerSignCrossContentLatin;

  /// No description provided for @prayerOfferingTitle.
  ///
  /// In pt, this message translates to:
  /// **'Oferecimento do Terço'**
  String get prayerOfferingTitle;

  /// No description provided for @prayerOfferingContent.
  ///
  /// In pt, this message translates to:
  /// **'Divino Jesus, eu Vos ofereço este terço que vou rezar, contemplando os mistérios de nossa Redenção. Concedei-me, por intercessão de Maria, Vossa Mãe Santíssima, a quem me dirijo, as virtudes que me são necessárias para bem rezá-lo e a graça de ganhar as indulgências desta santa devoção.'**
  String get prayerOfferingContent;

  /// No description provided for @rosaryBeadOurFather.
  ///
  /// In pt, this message translates to:
  /// **'Pai Nosso'**
  String get rosaryBeadOurFather;

  /// No description provided for @rosaryBeadHailMary.
  ///
  /// In pt, this message translates to:
  /// **'Ave Maria'**
  String get rosaryBeadHailMary;

  /// No description provided for @rosaryBeadGlory.
  ///
  /// In pt, this message translates to:
  /// **'Glória'**
  String get rosaryBeadGlory;

  /// No description provided for @rosaryBeadFatima.
  ///
  /// In pt, this message translates to:
  /// **'Oração de Fátima'**
  String get rosaryBeadFatima;

  /// No description provided for @rosaryBeadCreed.
  ///
  /// In pt, this message translates to:
  /// **'Credo'**
  String get rosaryBeadCreed;

  /// No description provided for @rosaryBeadSignCross.
  ///
  /// In pt, this message translates to:
  /// **'Sinal da Cruz'**
  String get rosaryBeadSignCross;

  /// No description provided for @rosaryBeadSalveRegina.
  ///
  /// In pt, this message translates to:
  /// **'Salve Rainha'**
  String get rosaryBeadSalveRegina;

  /// No description provided for @rosaryBeadOffering.
  ///
  /// In pt, this message translates to:
  /// **'Oferecimento'**
  String get rosaryBeadOffering;

  /// No description provided for @mysteryJoyfulTitle.
  ///
  /// In pt, this message translates to:
  /// **'Mistérios Gozosos'**
  String get mysteryJoyfulTitle;

  /// No description provided for @mysteryJoyfulDays.
  ///
  /// In pt, this message translates to:
  /// **'Segunda e Quinta-feira'**
  String get mysteryJoyfulDays;

  /// No description provided for @mysterySorrowfulTitle.
  ///
  /// In pt, this message translates to:
  /// **'Mistérios Dolorosos'**
  String get mysterySorrowfulTitle;

  /// No description provided for @mysterySorrowfulDays.
  ///
  /// In pt, this message translates to:
  /// **'Terça e Sexta-feira'**
  String get mysterySorrowfulDays;

  /// No description provided for @mysteryGloriousTitle.
  ///
  /// In pt, this message translates to:
  /// **'Mistérios Gloriosos'**
  String get mysteryGloriousTitle;

  /// No description provided for @mysteryGloriousDays.
  ///
  /// In pt, this message translates to:
  /// **'Quarta, Sábado e Domingo'**
  String get mysteryGloriousDays;

  /// No description provided for @mysteryLuminousTitle.
  ///
  /// In pt, this message translates to:
  /// **'Mistérios Luminosos'**
  String get mysteryLuminousTitle;

  /// No description provided for @mysteryLuminousDays.
  ///
  /// In pt, this message translates to:
  /// **'Quinta-feira'**
  String get mysteryLuminousDays;

  /// No description provided for @temptationPrayerLabel.
  ///
  /// In pt, this message translates to:
  /// **'ORAÇÃO'**
  String get temptationPrayerLabel;

  /// No description provided for @rosaryNextBead.
  ///
  /// In pt, this message translates to:
  /// **'Próxima'**
  String get rosaryNextBead;

  /// No description provided for @rosaryPrevBead.
  ///
  /// In pt, this message translates to:
  /// **'Anterior'**
  String get rosaryPrevBead;

  /// No description provided for @rosaryHailMaryFaith.
  ///
  /// In pt, this message translates to:
  /// **'Ave Maria (pela Fé)'**
  String get rosaryHailMaryFaith;

  /// No description provided for @rosaryHailMaryHope.
  ///
  /// In pt, this message translates to:
  /// **'Ave Maria (pela Esperança)'**
  String get rosaryHailMaryHope;

  /// No description provided for @rosaryHailMaryCharity.
  ///
  /// In pt, this message translates to:
  /// **'Ave Maria (pela Caridade)'**
  String get rosaryHailMaryCharity;

  /// No description provided for @rosaryMeditationTitle.
  ///
  /// In pt, this message translates to:
  /// **'Meditação'**
  String get rosaryMeditationTitle;

  /// No description provided for @rosaryMeditationResume.
  ///
  /// In pt, this message translates to:
  /// **'Fruto do Mistério'**
  String get rosaryMeditationResume;

  /// No description provided for @rosaryMeditationComplete.
  ///
  /// In pt, this message translates to:
  /// **'Oferecimento do Mistério'**
  String get rosaryMeditationComplete;

  /// No description provided for @catJaculatoriasTitle.
  ///
  /// In pt, this message translates to:
  /// **'Jaculatórias'**
  String get catJaculatoriasTitle;

  /// No description provided for @catJaculatoriasDesc.
  ///
  /// In pt, this message translates to:
  /// **'Orações curtas e fervorosas'**
  String get catJaculatoriasDesc;

  /// No description provided for @jaculatoriaSacredHeartTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sagrado Coração de Jesus'**
  String get jaculatoriaSacredHeartTitle;

  /// No description provided for @jaculatoriaSacredHeartContent.
  ///
  /// In pt, this message translates to:
  /// **'Sagrado Coração de Jesus, eu confio em Vós!'**
  String get jaculatoriaSacredHeartContent;

  /// No description provided for @jaculatoriaMeekHeartTitle.
  ///
  /// In pt, this message translates to:
  /// **'Coração Manso e Humilde'**
  String get jaculatoriaMeekHeartTitle;

  /// No description provided for @jaculatoriaMeekHeartContent.
  ///
  /// In pt, this message translates to:
  /// **'Jesus, manso e humilde de coração, fazei o nosso coração semelhante ao vosso.'**
  String get jaculatoriaMeekHeartContent;

  /// No description provided for @jaculatoriaMarySalvationTitle.
  ///
  /// In pt, this message translates to:
  /// **'Doce Coração de Maria'**
  String get jaculatoriaMarySalvationTitle;

  /// No description provided for @jaculatoriaMarySalvationContent.
  ///
  /// In pt, this message translates to:
  /// **'Doce Coração de Maria, sede a nossa salvação.'**
  String get jaculatoriaMarySalvationContent;

  /// No description provided for @jaculatoriaHolyFamilyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sagrada Família'**
  String get jaculatoriaHolyFamilyTitle;

  /// No description provided for @jaculatoriaHolyFamilyContent.
  ///
  /// In pt, this message translates to:
  /// **'Jesus, Maria e José, a nossa família vossa é.'**
  String get jaculatoriaHolyFamilyContent;

  /// No description provided for @jaculatoriaImmaculateConceptionTitle.
  ///
  /// In pt, this message translates to:
  /// **'Imaculada Conceição'**
  String get jaculatoriaImmaculateConceptionTitle;

  /// No description provided for @jaculatoriaImmaculateConceptionContent.
  ///
  /// In pt, this message translates to:
  /// **'Ó Maria, concebida sem pecado, rogai por nós que recorremos a Vós.'**
  String get jaculatoriaImmaculateConceptionContent;

  /// No description provided for @jaculatoriaMercyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Misericórdia'**
  String get jaculatoriaMercyTitle;

  /// No description provided for @jaculatoriaMercyContent.
  ///
  /// In pt, this message translates to:
  /// **'Meu Jesus, misericórdia!'**
  String get jaculatoriaMercyContent;

  /// No description provided for @catLitaniesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ladainhas'**
  String get catLitaniesTitle;

  /// No description provided for @litanyLorettoTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ladainha de Nossa Senhora (Lauretana)'**
  String get litanyLorettoTitle;

  /// No description provided for @litanyLorettoContent.
  ///
  /// In pt, this message translates to:
  /// **'Senhor, tende piedade de nós.\nCristo, tende piedade de nós.\nSenhor, tende piedade de nós.\n\nCristo, ouvi-nos.\nCristo, atendei-nos.\n\nDeus Pai do Céu, tende piedade de nós.\nDeus Filho, Redentor do mundo, tende piedade de nós.\nDeus Espírito Santo, tende piedade de nós.\nSantíssima Trindade, que sois um só Deus, tende piedade de nós.\n\nSanta Maria, rogai por nós.\nSanta Mãe de Deus, rogai por nós.\nSanta Virgem das Virgens, rogai por nós.\nMãe de Cristo, rogai por nós.\nMãe da Igreja, rogai por nós.\nMãe da Divina Graça, rogai por nós.\nMãe puríssima, rogai por nós.\nMãe castíssima, rogai por nós.\nMãe sempre Virgem, rogai por nós.\nMãe imaculada, rogai por nós.\nMãe amável, rogai por nós.\nMãe admirável, rogai por nós.\nMãe do bom conselho, rogai por nós.\nMãe do Criador, rogai por nós.\nMãe do Salvador, rogai por nós.\nMãe de misericórdia, rogai por nós.\nVirgem prudentíssima, rogai por nós.\nVirgem venerável, rogai por nós.\nVirgem louvável, rogai por nós.\nVirgem poderosa, rogai por nós.\nVirgem clemente, rogai por nós.\nVirgem fiel, rogai por nós.\nEspelho de justiça, rogai por nós.\nSede da sabedoria, rogai por nós.\nCausa de nossa alegria, rogai por nós.\nVaso espiritual, rogai por nós.\nVaso honorífico, rogai por nós.\nVaso insigne de devoção, rogai por nós.\nRosa mística, rogai por nós.\nTorre de Davi, rogai por nós.\nTorre de marfim, rogai por nós.\nCasa de ouro, rogai por nós.\nArca da aliança, rogai por nós.\nPorta do céu, rogai por nós.\nEstrela da manhã, rogai por nós.\nSaúde dos enfermos, rogai por nós.\nRefúgio dos pecadores, rogai por nós.\nConsoladora dos aflitos, rogai por nós.\nAuxílio dos cristãos, rogai por nós.\nRainha dos Anjos, rogai por nós.\nRainha dos Patriarcas, rogai por nós.\nRainha dos Profetas, rogai por nós.\nRainha dos Apóstolos, rogai por nós.\nRainha dos Mártires, rogai por nós.\nRainha dos Confessores, rogai por nós.\nRainha das Virgens, rogai por nós.\nRainha de todos os Santos, rogai por nós.\nRainha concebida sem pecado original, rogai por nós.\nRainha assunta ao Céu, rogai por nós.\nRainha do Santíssimo Rosário, rogai por nós.\nRainha da família, rogai por nós.\nRainha da paz, rogai por nós.\n\nCordeiro de Deus, que tirais o pecado do mundo, perdoai-nos, Senhor.\nCordeiro de Deus, que tirais o pecado do mundo, ouvi-nos, Senhor.\nCordeiro de Deus, que tirais o pecado do mundo, tende piedade de nós.\n\n℣. Rogai por nós, Santa Mãe de Deus.\n℟. Para que sejamos dignos das promessas de Cristo.\n\nOremos:\nConcedei-nos, Senhor Deus, a nós vossos servos, gozar de contínua saúde de alma e de corpo; e, pela gloriosa intercessão da bem-aventurada sempre Virgem Maria, livrai-nos das tristezas da vida presente e dai-nos a alegria da vida eterna. Por Cristo, Nosso Senhor. Amém.'**
  String get litanyLorettoContent;

  /// No description provided for @litanySacredHeartTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ladainha do Sagrado Coração de Jesus'**
  String get litanySacredHeartTitle;

  /// No description provided for @litanySacredHeartContent.
  ///
  /// In pt, this message translates to:
  /// **'Senhor, tende piedade de nós.\nCristo, tende piedade de nós.\nSenhor, tende piedade de nós.\n\nCristo, ouvi-nos.\nCristo, atendei-nos.\n\nDeus Pai do Céu, tende piedade de nós.\nDeus Filho, Redentor do mundo, tende piedade de nós.\nDeus Espírito Santo, tende piedade de nós.\nSantíssima Trindade, que sois um só Deus, tende piedade de nós.\n\nCoração de Jesus, Filho do Eterno Pai, tende piedade de nós.\nCoração de Jesus, formado pelo Espírito Santo no seio da Virgem Mãe, tende piedade de nós.\nCoração de Jesus, unido substancialmente ao Verbo de Deus, tende piedade de nós.\nCoração de Jesus, de majestade infinita, tende piedade de nós.\nCoração de Jesus, templo santo de Deus, tende piedade de nós.\nCoração de Jesus, tabernáculo do Altíssimo, tende piedade de nós.\nCoração de Jesus, casa de Deus e porta do Céu, tende piedade de nós.\nCoração de Jesus, fornalha ardente de caridade, tende piedade de nós.\nCoração de Jesus, santuário da justiça e do amor, tende piedade de nós.\nCoração de Jesus, cheio de bondade e de amor, tende piedade de nós.\nCoração de Jesus, abismo de todas as virtudes, tende piedade de nós.\nCoração de Jesus, digníssimo de todo o louvor, tende piedade de nós.\nCoração de Jesus, Rei e centro de todos os corações, tende piedade de nós.\nCoração de Jesus, em quem estão todos os tesouros da sabedoria e da ciência, tende piedade de nós.\nCoração de Jesus, em quem habita toda a plenitude da divindade, tende piedade de nós.\nCoração de Jesus, em quem o Pai põe todas as suas complacências, tende piedade de nós.\nCoração de Jesus, de cuja plenitude todos nós recebemos, tende piedade de nós.\nCoração de Jesus, desejo das colinas eternas, tende piedade de nós.\nCoração de Jesus, paciente e cheio de misericórdia, tende piedade de nós.\nCoração de Jesus, rico para todos os que Vos invocam, tende piedade de nós.\nCoração de Jesus, fonte de vida e de santidade, tende piedade de nós.\nCoração de Jesus, propiciação pelos nossos pecados, tende piedade de nós.\nCoração de Jesus, saturado de opróbrios, tende piedade de nós.\nCoração de Jesus, despedaçado por causa de nossos pecados, tende piedade de nós.\nCoração de Jesus, feito obediente até à morte, tende piedade de nós.\nCoração de Jesus, traspassado pela lança, tende piedade de nós.\nCoração de Jesus, fonte de toda consolação, tende piedade de nós.\nCoração de Jesus, nossa vida e ressurreição, tende piedade de nós.\nCoração de Jesus, nossa paz e reconciliação, tende piedade de nós.\nCoração de Jesus, vítima pelos pecadores, tende piedade de nós.\nCoração de Jesus, salvação dos que em Vós esperam, tende piedade de nós.\nCoração de Jesus, esperança dos que em Vós morrem, tende piedade de nós.\nCoração de Jesus, delícias de todos os Santos, tende piedade de nós.\n\nCordeiro de Deus, que tirais o pecado do mundo, perdoai-nos, Senhor.\nCordeiro de Deus, que tirais o pecado do mundo, ouvi-nos, Senhor.\nCordeiro de Deus, que tirais o pecado do mundo, tende piedade de nós.\n\n℣. Jesus manso e humilde de Coração.\n℟. Fazei o nosso coração semelhante ao Vosso.\n\nOremos:\nDeus onipotente e eterno, olhai para o Coração do vosso diletíssimo Filho, para os louvores e satisfações que em nome dos pecadores Vos tributa e, a quantos imploram a vossa misericórdia, concedei benigno o perdão, em nome do mesmo Jesus Cristo vosso Filho, que convosco vive e reina, na unidade do Espírito Santo. Amém.'**
  String get litanySacredHeartContent;

  /// No description provided for @litanyAllSaintsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ladainha de Todos os Santos'**
  String get litanyAllSaintsTitle;

  /// No description provided for @litanyAllSaintsContent.
  ///
  /// In pt, this message translates to:
  /// **'Senhor, tende piedade de nós.\nCristo, tende piedade de nós.\nSenhor, tende piedade de nós.\n\nCristo, ouvi-nos.\nCristo, atendei-nos.\n\nDeus Pai do Céu, tende piedade de nós.\nDeus Filho, Redentor do mundo, tende piedade de nós.\nDeus Espírito Santo, tende piedade de nós.\nSantíssima Trindade, que sois um só Deus, tende piedade de nós.\n\nSanta Maria, rogai por nós.\nSanta Mãe de Deus, rogai por nós.\nSanta Virgem das virgens, rogai por nós.\nSão Miguel, rogai por nós.\nSão Gabriel, rogai por nós.\nSão Rafael, rogai por nós.\nTodos os santos Anjos e Arcanjos, rogai por nós.\nTodas as santas ordens celestes, rogai por nós.\nSão João Batista, rogai por nós.\nSão José, rogai por nós.\nTodos os santos Patriarcas e Profetas, rogai por nós.\nSão Pedro, rogai por nós.\nSão Paulo, rogai por nós.\nSanto André, rogai por nós.\nSão Tiago, rogai por nós.\nSão João, rogai por nós.\nSão Tomé, rogai por nós.\nSão Tiago, rogai por nós.\nSão Filipe, rogai por nós.\nSão Bartolomeu, rogai por nós.\nSão Mateus, rogai por nós.\nSão Simão, rogai por nós.\nSão Tadeu, rogai por nós.\nSão Matias, rogai por nós.\nSão Barnabé, rogai por nós.\nSão Lucas, rogai por nós.\nSão Marcos, rogai por nós.\nTodos os santos Apóstolos e Evangelistas, rogai por nós.\nTodos os santos Discípulos do Senhor, rogai por nós.\nTodos os santos Inocentes, rogai por nós.\nSanto Estêvão, rogai por nós.\nSão Lourenço, rogai por nós.\nSão Vicente, rogai por nós.\nSantos Fabiano e Sebastião, rogai por nós.\nSantos João e Paulo, rogai por nós.\nSantos Cosme e Damião, rogai por nós.\nSantos Gervásio e Protásio, rogai por nós.\nTodos os santos Mártires, rogai por nós.\nSão Silvestre, rogai por nós.\nSão Gregório, rogai por nós.\nSanto Ambrósio, rogai por nós.\nSanto Agostinho, rogai por nós.\nSão Jerônimo, rogai por nós.\nSão Martinho, rogai por nós.\nSão Nicolau, rogai por nós.\nTodos os santos Bispos e Confessores, rogai por nós.\nTodos os santos Doutores, rogai por nós.\nSanto Antônio, rogai por nós.\nSão Bento, rogai por nós.\nSão Bernardo, rogai por nós.\nSão Domingos, rogai por nós.\nSão Francisco, rogai por nós.\nTodos os santos Sacerdotes e Levitas, rogai por nós.\nTodos os santos Monges e Eremitas, rogai por nós.\nSanta Maria Madalena, rogai por nós.\nSanta Ágata, rogai por nós.\nSanta Luzia, rogai por nós.\nSanta Inês, rogai por nós.\nSanta Cecília, rogai por nós.\nSanta Catarina, rogai por nós.\nSanta Anastácia, rogai por nós.\nTodas as santas Virgens e Viúvas, rogai por nós.\nTodos os Santos e Santas de Deus, intercedei por nós.\n\nSede-nos propício, perdoai-nos, Senhor.\nSede-nos propício, ouvi-nos, Senhor.\nDe todo o mal, livrai-nos, Senhor.\nDe todo o pecado, livrai-nos, Senhor.\nDa vossa ira, livrai-nos, Senhor.\nDa morte súbita e imprevista, livrai-nos, Senhor.\nDas insídias do demônio, livrai-nos, Senhor.\nDa ira, do ódio e de toda má vontade, livrai-nos, Senhor.\nDo espírito de impureza, livrai-nos, Senhor.\nDo raio e da tempestade, livrai-nos, Senhor.\nDo flagelo da terra, livrai-nos, Senhor.\nDa peste, da fome e da guerra, livrai-nos, Senhor.\nDa morte eterna, livrai-nos, Senhor.\n\nPelo mistério da vossa santa Encarnação, livrai-nos, Senhor.\nPela vossa vinda, livrai-nos, Senhor.\nPelo vosso Nascimento, livrai-nos, Senhor.\nPelo vosso Batismo e santo Jejum, livrai-nos, Senhor.\nPela vossa Cruz e Paixão, livrai-nos, Senhor.\nPela vossa Morte e Sepultura, livrai-nos, Senhor.\nPela vossa santa Ressurreição, livrai-nos, Senhor.\nPela vossa admirável Ascensão, livrai-nos, Senhor.\nPela vinda do Espírito Santo Consolador, livrai-nos, Senhor.\nNo dia do Juízo, livrai-nos, Senhor.\n\nNós, pecadores, nós Vos rogamos, ouvi-nos.\nQue nos perdoeis, nós Vos rogamos, ouvi-nos.\nQue nos conduzais à verdadeira penitência, nós Vos rogamos, ouvi-nos.\nQue Vos digneis governar e conservar a vossa santa Igreja, nós Vos rogamos, ouvi-nos.\nQue Vos digneis conservar na santa religião o Sumo Pontífice e todas as ordens eclesiásticas, nós Vos rogamos, ouvi-nos.\nQue Vos digneis humilhar os inimigos da santa Igreja, nós Vos rogamos, ouvi-nos.\nQue Vos digneis dar a paz e a verdadeira concórdia aos reis e príncipes cristãos, nós Vos rogamos, ouvi-nos.\nQue Vos digneis conceder a paz e a união a todo o povo cristão, nós Vos rogamos, ouvi-nos.\nQue Vos digneis chamar à unidade da Igreja todos os que andam transviados e conduzir todos os infiéis à luz do Evangelho, nós Vos rogamos, ouvi-nos.\nQue nos digneis confirmar e conservar no vosso santo serviço, nós Vos rogamos, ouvi-nos.\nQue elevais o nosso espírito ao desejo das coisas celestiais, nós Vos rogamos, ouvi-nos.\nQue retribuais a todos os nossos benfeitores os bens eternos, nós Vos rogamos, ouvi-nos.\nQue livreis as nossas almas, as de nossos irmãos, parentes e benfeitores, da eterna condenação, nós Vos rogamos, ouvi-nos.\nQue Vos digneis dar e conservar os frutos da terra, nós Vos rogamos, ouvi-nos.\nQue Vos digneis dar o eterno descanso a todos os fiéis defuntos, nós Vos rogamos, ouvi-nos.\nQue Vos digneis ouvir-nos, nós Vos rogamos, ouvi-nos.\nFilho de Deus, nós Vos rogamos, ouvi-nos.\n\nCordeiro de Deus, que tirais o pecado do mundo, perdoai-nos, Senhor.\nCordeiro de Deus, que tirais o pecado do mundo, ouvi-nos, Senhor.\nCordeiro de Deus, que tirais o pecado do mundo, tende piedade de nós.\n\nCristo, ouvi-nos.\nCristo, atendei-nos.\n\nSenhor, tende piedade de nós.\nCristo, tende piedade de nós.\nSenhor, tende piedade de nós.'**
  String get litanyAllSaintsContent;

  /// No description provided for @litanyStJosephTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ladainha de São José'**
  String get litanyStJosephTitle;

  /// No description provided for @litanyStJosephContent.
  ///
  /// In pt, this message translates to:
  /// **'Senhor, tende piedade de nós.\nCristo, tende piedade de nós.\nSenhor, tende piedade de nós.\n\nCristo, ouvi-nos.\nCristo, atendei-nos.\n\nDeus Pai do Céu, tende piedade de nós.\nDeus Filho, Redentor do mundo, tende piedade de nós.\nDeus Espírito Santo, tende piedade de nós.\nSantíssima Trindade, que sois um só Deus, tende piedade de nós.\n\nSanta Maria, rogai por nós.\nSão José, rogai por nós.\nIlustre descendente de Davi, rogai por nós.\nLuz dos Patriarcas, rogai por nós.\nEsposo da Mãe de Deus, rogai por nós.\nCustódio da Virgem, rogai por nós.\nPai nutrício do Filho de Deus, rogai por nós.\nSolícito defensor de Cristo, rogai por nós.\nChefe da sagrada Família, rogai por nós.\nJosé justíssimo, rogai por nós.\nJosé castíssimo, rogai por nós.\nJosé prudentíssimo, rogai por nós.\nJosé fortíssimo, rogai por nós.\nJosé obedientíssimo, rogai por nós.\nJosé fidelíssimo, rogai por nós.\nEspelho de paciência, rogai por nós.\nAmante da pobreza, rogai por nós.\nModelo dos operários, rogai por nós.\nEsplendor da vida doméstica, rogai por nós.\nGuarda das Virgens, rogai por nós.\nAmparo das famílias, rogai por nós.\nConsolo dos infelizes, rogai por nós.\nEsperança dos doentes, rogai por nós.\nPadroeiro dos moribundos, rogai por nós.\nTerror dos demônios, rogai por nós.\nProtetor da Santa Igreja, rogai por nós.\n\nCordeiro de Deus, que tirais o pecado do mundo, perdoai-nos, Senhor.\nCordeiro de Deus, que tirais o pecado do mundo, ouvi-nos, Senhor.\nCordeiro de Deus, que tirais o pecado do mundo, tende piedade de nós.\n\n℣. Constituiu-o senhor da sua casa.\n℟. E príncipe de todas as suas possessões.\n\nOremos:\nÓ Deus, que em vossa inefável providência vos dignastes escolher o bem-aventurado José para Esposo de vossa Mãe Santíssima, fazei, Vos rogamos, que tenhamos como intercessor no Céu aquele a quem, na Terra, veneramos como protetor. Vós, que viveis e reinais pelos séculos dos séculos. Amém.'**
  String get litanyStJosephContent;

  /// No description provided for @litanyHolyNameTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ladainha do Santíssimo Nome de Jesus'**
  String get litanyHolyNameTitle;

  /// No description provided for @litanyHolyNameContent.
  ///
  /// In pt, this message translates to:
  /// **'Senhor, tende piedade de nós.\nCristo, tende piedade de nós.\nSenhor, tende piedade de nós.\n\nJesus, ouvi-nos.\nJesus, atendei-nos.\n\nDeus Pai do Céu, tende piedade de nós.\nDeus Filho, Redentor do mundo, tende piedade de nós.\nDeus Espírito Santo, tende piedade de nós.\nSantíssima Trindade, que sois um só Deus, tende piedade de nós.\n\nJesus, Filho do Deus vivo, tende piedade de nós.\nJesus, esplendor do Pai, tende piedade de nós.\nJesus, candor da luz eterna, tende piedade de nós.\nJesus, Rei da glória, tende piedade de nós.\nJesus, Sol de justiça, tende piedade de nós.\nJesus, Filho da Virgem Maria, tende piedade de nós.\nJesus, amável, tende piedade de nós.\nJesus, admirável, tende piedade de nós.\nJesus, Deus forte, tende piedade de nós.\nJesus, Pai do século futuro, tende piedade de nós.\nJesus, Anjo do grande conselho, tende piedade de nós.\nJesus, poderosíssimo, tende piedade de nós.\nJesus, pacientíssimo, tende piedade de nós.\nJesus, obedientíssimo, tende piedade de nós.\nJesus, manso e humilde de coração, tende piedade de nós.\nJesus, amante da castidade, tende piedade de nós.\nJesus, amante de todos nós, tende piedade de nós.\nJesus, Deus da paz, tende piedade de nós.\nJesus, autor da vida, tende piedade de nós.\nJesus, modelo das virtudes, tende piedade de nós.\nJesus, zeloso das almas, tende piedade de nós.\nJesus, nosso Deus, tende piedade de nós.\nJesus, nosso Refúgio, tende piedade de nós.\nJesus, Pai dos pobres, tende piedade de nós.\nJesus, tesouro dos fiéis, tende piedade de nós.\nJesus, bom Pastor, tende piedade de nós.\nJesus, luz verdadeira, tende piedade de nós.\nJesus, sabedoria eterna, tende piedade de nós.\nJesus, bondade infinita, tende piedade de nós.\nJesus, nosso Caminho e nossa Vida, tende piedade de nós.\nJesus, alegria dos Anjos, tende piedade de nós.\nJesus, Rei dos Patriarcas, tende piedade de nós.\nJesus, Mestre dos Apóstolos, tende piedade de nós.\nJesus, Doutor dos Evangelistas, tende piedade de nós.\nJesus, fortaleza dos Mártires, tende piedade de nós.\nJesus, luz dos Confessores, tende piedade de nós.\nJesus, pureza das Virgens, tende piedade de nós.\nJesus, coroa de todos os Santos, tende piedade de nós.\n\nSede-nos propício, perdoai-nos, Jesus.\nSede-nos propício, ouvi-nos, Jesus.\n\nDe todo o mal, livrai-nos, Jesus.\nDe todo o pecado, livrai-nos, Jesus.\nDa vossa ira, livrai-nos, Jesus.\nDas insídias do demônio, livrai-nos, Jesus.\nDo espírito de impureza, livrai-nos, Jesus.\nDa morte eterna, livrai-nos, Jesus.\nDo desprezo das vossas inspirações, livrai-nos, Jesus.\nPelo mistério da vossa santa Encarnação, livrai-nos, Jesus.\nPelo vosso Nascimento, livrai-nos, Jesus.\nPela vossa infância, livrai-nos, Jesus.\nPela vossa vida santíssima, livrai-nos, Jesus.\nPelos vossos trabalhos, livrai-nos, Jesus.\nPela vossa Agonia e Paixão, livrai-nos, Jesus.\nPela vossa Cruz e abandono, livrai-nos, Jesus.\nPelos vossos sofrimentos, livrai-nos, Jesus.\nPela vossa Morte e sepultura, livrai-nos, Jesus.\nPela vossa Ressurreição, livrai-nos, Jesus.\nPela vossa Ascensão, livrai-nos, Jesus.\nPela vossa instituição da Santíssima Eucaristia, livrai-nos, Jesus.\nPelas vossas alegrias, livrai-nos, Jesus.\nPela vossa glória, livrai-nos, Jesus.\n\nCordeiro de Deus, que tirais o pecado do mundo, perdoai-nos, Jesus.\nCordeiro de Deus, que tirais o pecado do mundo, ouvi-nos, Jesus.\nCordeiro de Deus, que tirais o pecado do mundo, tende piedade de nós, Jesus.\n\nJesus, ouvi-nos.\nJesus, atendei-nos.\n\nOremos:\nSenhor Jesus Cristo, que dissestes: Pedi e recebereis, buscai e encontrareis, batei e abrir-se-vos-á; concedei-nos, Vos pedimos, o afeto do vosso diviníssimo amor, para que Vos amemos de todo o coração, com palavras e obras, e nunca cessemos de Vos louvar. Fazei, Senhor, que tenhamos permanentemente o temor e o amor do vosso santo Nome, porque nunca deixais de governar aqueles a quem firmais solidamente no vosso amor. Vós, que viveis e reinais pelos séculos dos séculos. Amém.'**
  String get litanyHolyNameContent;

  /// No description provided for @litanySevenSorrowsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Coroa de Nossa Senhora das Dores'**
  String get litanySevenSorrowsTitle;

  /// No description provided for @litanySevenSorrowsContent.
  ///
  /// In pt, this message translates to:
  /// **'Deus, vinde em meu auxílio.\nSenhor, apressai-Vos em me socorrer.\n\nPai Nosso... 3 Ave Marias... Glória\n\nEstrofe: Na morte de Jesus, fazei que, em vossas dores, meu coração vos acompanhe, ó Mãe dos pecadores.\n\n— As Sete Dores de Maria —\n\n1ª DOR: A apresentação de Jesus no Templo e a profecia de Simeão\n\nContemplamos a dor de Nossa Senhora quando o santo velho Simeão lhe profetizou que uma espada de dor transpassaria a sua alma.\n\nReza-se: 7 Ave-Marias.\nEstrofe: Na morte de Jesus, fazei que, em vossas dores, meu coração vos acompanhe, ó Mãe dos pecadores.\n\n2ª DOR: A fuga para o Egito\n\nContemplamos a dor de Nossa Senhora quando teve que fugir para o Egito com o Menino Jesus e São José, para salvar a vida de seu Filho da perseguição de Herodes.\n\nReza-se: 7 Ave-Marias.\nEstrofe: Na morte de Jesus, fazei que, em vossas dores, meu coração vos acompanhe, ó Mãe dos pecadores.\n\n3ª DOR: A perda do menino Jesus no Templo\n\nContemplamos a dor de Nossa Senhora quando perdeu o Menino Jesus em Jerusalém por três dias, procurando-O com profunda aflição.\n\nReza-se: 7 Ave-Marias.\nEstrofe: Na morte de Jesus, fazei que, em vossas dores, meu coração vos acompanhe, ó Mãe dos pecadores.\n\n4ª DOR: O encontro com Jesus no caminho do calvário\n\nContemplamos a dor de Nossa Senhora ao encontrar o seu Divino Filho carregando a pesada cruz e ensanguentado a caminho do Calvário.\n\nReza-se: 7 Ave-Marias.\nEstrofe: Na morte de Jesus, fazei que, em vossas dores, meu coração vos acompanhe, ó Mãe dos pecadores.\n\n5ª DOR: Maria fica de pé junto à Cruz de Jesus\n\nContemplamos a dor de Nossa Senhora ao ver o seu Filho cravado na Cruz, permanecendo heroicamente de pé enquanto Ele expirava e morria por nossa salvação.\n\nReza-se: 7 Ave-Marias.\nEstrofe: Na morte de Jesus, fazei que, em vossas dores, meu coração vos acompanhe, ó Mãe dos pecadores.\n\n6ª DOR: O coração de Jesus é transpassado pela lança\n\nContemplamos a dor de Nossa Senhora quando a lança cruel transpassou o coração inanimado de seu Filho, abrindo uma profunda chaga em sua própria alma.\n\nReza-se: 7 Ave-Marias.\nEstrofe: Na morte de Jesus, fazei que, em vossas dores, meu coração vos acompanhe, ó Mãe dos pecadores.\n\n7ª DOR: Maria deposita Jesus no sepulcro\n\nContemplamos a dor e a profunda solidão de Nossa Senhora ao depositar o corpo sem vida de Jesus no sepulcro, despedindo-se Dele com imensa desolação.\n\nReza-se: 7 Ave-Marias.\nEstrofe: Na morte de Jesus, fazei que, em vossas dores, meu coração vos acompanhe, ó Mãe dos pecadores.\n\n— Oração Final —\n\n℣. Rogai por nós, Virgem Dolorosíssima.\n℟. Para que sejamos dignos das promessas de Cristo.\n\nOremos:\nDeus, em cuja Paixão, segundo a profecia de Simeão, uma espada de dor traspassou a dulcíssima alma da gloriosa Virgem e Mãe Maria, concedei-nos, propícios, que celebrando devotamente as suas dores, consigamos o feliz efeito da vossa Paixão. Por Cristo, Senhor nosso. Amém.'**
  String get litanySevenSorrowsContent;

  /// No description provided for @novenaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novenas'**
  String get novenaTitle;

  /// No description provided for @catNovenasTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novenas'**
  String get catNovenasTitle;

  /// No description provided for @novenaSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Oração durante 9 dias'**
  String get novenaSubtitle;

  /// No description provided for @novenaStartButton.
  ///
  /// In pt, this message translates to:
  /// **'Iniciar Novena'**
  String get novenaStartButton;

  /// No description provided for @novenaContinueButton.
  ///
  /// In pt, this message translates to:
  /// **'Continuar'**
  String get novenaContinueButton;

  /// No description provided for @novenaDay.
  ///
  /// In pt, this message translates to:
  /// **'Dia {day}/9'**
  String novenaDay(int day);

  /// No description provided for @novenaDayLabel.
  ///
  /// In pt, this message translates to:
  /// **'Dia'**
  String get novenaDayLabel;

  /// No description provided for @novenaScheduled.
  ///
  /// In pt, this message translates to:
  /// **'Agendada: {date}'**
  String novenaScheduled(String date);

  /// No description provided for @novenaCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Concluída'**
  String get novenaCompleted;

  /// No description provided for @novenaNotStarted.
  ///
  /// In pt, this message translates to:
  /// **'Não iniciada'**
  String get novenaNotStarted;

  /// No description provided for @novenaCancelTitle.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar Novena'**
  String get novenaCancelTitle;

  /// No description provided for @novenaCancelContent.
  ///
  /// In pt, this message translates to:
  /// **'Deseja cancelar esta novena? O progresso será perdido.'**
  String get novenaCancelContent;

  /// No description provided for @novenaCancelConfirm.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar Novena'**
  String get novenaCancelConfirm;

  /// No description provided for @novenaCancelDismiss.
  ///
  /// In pt, this message translates to:
  /// **'Manter'**
  String get novenaCancelDismiss;

  /// No description provided for @novenaRestartTitle.
  ///
  /// In pt, this message translates to:
  /// **'Reiniciar Novena'**
  String get novenaRestartTitle;

  /// No description provided for @quickPrayer.
  ///
  /// In pt, this message translates to:
  /// **'Oração rápida'**
  String get quickPrayer;

  /// No description provided for @backupTitle.
  ///
  /// In pt, this message translates to:
  /// **'Backup e Restauração'**
  String get backupTitle;

  /// No description provided for @backupExportTitle.
  ///
  /// In pt, this message translates to:
  /// **'Exportar Dados'**
  String get backupExportTitle;

  /// No description provided for @backupExportSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Salvar backup do jardim e orações'**
  String get backupExportSubtitle;

  /// No description provided for @backupImportTitle.
  ///
  /// In pt, this message translates to:
  /// **'Importar Dados'**
  String get backupImportTitle;

  /// No description provided for @backupImportSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Restaurar backup de arquivo'**
  String get backupImportSubtitle;

  /// No description provided for @backupImportDialogTitle.
  ///
  /// In pt, this message translates to:
  /// **'Importar Backup'**
  String get backupImportDialogTitle;

  /// No description provided for @backupImportDialogContent.
  ///
  /// In pt, this message translates to:
  /// **'Atenção: Importar dados irá substituir os dados atuais. Deseja continuar?'**
  String get backupImportDialogContent;

  /// No description provided for @backupImportConfirm.
  ///
  /// In pt, this message translates to:
  /// **'Importar'**
  String get backupImportConfirm;

  /// No description provided for @frequencyCustom.
  ///
  /// In pt, this message translates to:
  /// **'Personalizado'**
  String get frequencyCustom;

  /// No description provided for @confessionReminderDaysCustomTitle.
  ///
  /// In pt, this message translates to:
  /// **'Frequência Personalizada'**
  String get confessionReminderDaysCustomTitle;

  /// No description provided for @confessionReminderDaysCustomLabel.
  ///
  /// In pt, this message translates to:
  /// **'Dias'**
  String get confessionReminderDaysCustomLabel;

  /// No description provided for @daysUnit.
  ///
  /// In pt, this message translates to:
  /// **'dias'**
  String get daysUnit;

  /// No description provided for @saveButton.
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get saveButton;

  /// No description provided for @dateLabel.
  ///
  /// In pt, this message translates to:
  /// **'Data'**
  String get dateLabel;

  /// No description provided for @novenaRestartContent.
  ///
  /// In pt, this message translates to:
  /// **'Deseja recomeçar esta novena do dia 1?'**
  String get novenaRestartContent;

  /// No description provided for @novenaRestartConfirm.
  ///
  /// In pt, this message translates to:
  /// **'Recomeçar'**
  String get novenaRestartConfirm;

  /// No description provided for @novenaStartedMessage.
  ///
  /// In pt, this message translates to:
  /// **'Novena iniciada! Bom tempo de oração.'**
  String get novenaStartedMessage;

  /// No description provided for @novenaPrayerInstruction.
  ///
  /// In pt, this message translates to:
  /// **'5 Pai-Nossos, 5 Ave-Marias e 5 Glórias ao Pai, em honra dos 15 anos de vida do servo de Deus nesta Terra.'**
  String get novenaPrayerInstruction;

  /// No description provided for @novenaCompletedTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novena Concluída!'**
  String get novenaCompletedTitle;

  /// No description provided for @novenaCompletedMessage.
  ///
  /// In pt, this message translates to:
  /// **'Você completou os 9 dias de oração.'**
  String get novenaCompletedMessage;

  /// No description provided for @subscriptionActive.
  ///
  /// In pt, this message translates to:
  /// **'Assinatura Ativa (Premium)'**
  String get subscriptionActive;

  /// No description provided for @subscriptionManage.
  ///
  /// In pt, this message translates to:
  /// **'Gerenciar Assinatura'**
  String get subscriptionManage;

  /// No description provided for @betaLabel.
  ///
  /// In pt, this message translates to:
  /// **'BETA'**
  String get betaLabel;

  /// No description provided for @novenaCarloAcutisTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novena a São Carlo Acutis'**
  String get novenaCarloAcutisTitle;

  /// No description provided for @novenaCarloAcutisDesc.
  ///
  /// In pt, this message translates to:
  /// **'Padroeiro da juventude e da internet'**
  String get novenaCarloAcutisDesc;

  /// No description provided for @novenaCarloAcutisIcon.
  ///
  /// In pt, this message translates to:
  /// **'computer'**
  String get novenaCarloAcutisIcon;

  /// No description provided for @novenaCarloAcutisOpening.
  ///
  /// In pt, this message translates to:
  /// **'Ó Deus eterno e misericordioso, que manifestais a vossa glória na santidade dos pequenos e humildes, nós Vos louvamos pelas virtudes cristãs com que ornastes a vida de São Carlo Acutis. Pela sua intercessão, suplicamos humildemente que nos concedais a graça que ardentemente Vos pedimos nesta novena, se for para a vossa honra e salvação das nossas almas. (Faz-se o pedido). Por Cristo, Nosso Senhor. Amém.'**
  String get novenaCarloAcutisOpening;

  /// No description provided for @novenaCarloAcutisClosing.
  ///
  /// In pt, this message translates to:
  /// **'Senhor Jesus Cristo, pão vivo descido do Céu, que fostes o centro da vida e o tesouro do coração de São Carlo Acutis, inflamai também as nossas almas no amor ao vosso Sacrário e na fidelidade à Santa Igreja. Pela intercessão de Maria Santíssima e de São Carlo Acutis, conservai-nos em vossa graça até a hora da morte. Amém.'**
  String get novenaCarloAcutisClosing;

  /// No description provided for @novenaCarloAcutisDay1Title.
  ///
  /// In pt, this message translates to:
  /// **'1º Dia - Amor a Deus acima de tudo'**
  String get novenaCarloAcutisDay1Title;

  /// No description provided for @novenaCarloAcutisDay1Meditation.
  ///
  /// In pt, this message translates to:
  /// **'São Carlo Acutis, que desde a infância colocastes a vontade divina acima dos desejos terrenos, alcançai-nos o desapego do mundo e o desejo sincero de agradar somente a Deus. Amém.'**
  String get novenaCarloAcutisDay1Meditation;

  /// No description provided for @novenaCarloAcutisDay2Title.
  ///
  /// In pt, this message translates to:
  /// **'2º Dia - União constante com Jesus'**
  String get novenaCarloAcutisDay2Title;

  /// No description provided for @novenaCarloAcutisDay2Meditation.
  ///
  /// In pt, this message translates to:
  /// **'São Carlo Acutis, que fizestes da amizade com Nosso Senhor a regra de cada instante do vosso dia, obtende-nos a graça da presença de Deus em todas as nossas ações. Amém.'**
  String get novenaCarloAcutisDay2Meditation;

  /// No description provided for @novenaCarloAcutisDay3Title.
  ///
  /// In pt, this message translates to:
  /// **'3º Dia - Devoção ao Santo Anjo da Guarda'**
  String get novenaCarloAcutisDay3Title;

  /// No description provided for @novenaCarloAcutisDay3Meditation.
  ///
  /// In pt, this message translates to:
  /// **'São Carlo Acutis, que cultivastes filial confiança nos santos Anjos enviados por Deus para nos guardar, ensinai-nos a ouvir o nosso Anjo da Guarda e a evitar toda ocasião de pecado. Amém.'**
  String get novenaCarloAcutisDay3Meditation;

  /// No description provided for @novenaCarloAcutisDay4Title.
  ///
  /// In pt, this message translates to:
  /// **'4º Dia - Pureza de alma e Confissão frequente'**
  String get novenaCarloAcutisDay4Title;

  /// No description provided for @novenaCarloAcutisDay4Meditation.
  ///
  /// In pt, this message translates to:
  /// **'São Carlo Acutis, que buscáveis com assiduidade o sacramento da Penitência para manter limpa a veste batismal, alcançai-nos verdadeira contrição e firme propósito de emenda. Amém.'**
  String get novenaCarloAcutisDay4Meditation;

  /// No description provided for @novenaCarloAcutisDay5Title.
  ///
  /// In pt, this message translates to:
  /// **'5º Dia - Alegria que nasce da contemplação'**
  String get novenaCarloAcutisDay5Title;

  /// No description provided for @novenaCarloAcutisDay5Meditation.
  ///
  /// In pt, this message translates to:
  /// **'São Carlo Acutis, que encontrastes na oração e no esquecimento de si a verdadeira alegria cristã, livrai-nos do egoísmo e voltai os nossos olhos para os bens eternos. Amém.'**
  String get novenaCarloAcutisDay5Meditation;

  /// No description provided for @novenaCarloAcutisDay6Title.
  ///
  /// In pt, this message translates to:
  /// **'6º Dia - Desejo ardente da santidade'**
  String get novenaCarloAcutisDay6Title;

  /// No description provided for @novenaCarloAcutisDay6Meditation.
  ///
  /// In pt, this message translates to:
  /// **'São Carlo Acutis, que nada mais pedistes a Deus senão corresponder fielmente à vocação à santidade, acendei em nós a fome e a sede da perfeição evangélica. Amém.'**
  String get novenaCarloAcutisDay6Meditation;

  /// No description provided for @novenaCarloAcutisDay7Title.
  ///
  /// In pt, this message translates to:
  /// **'7º Dia - Piedade filial à Virgem Maria'**
  String get novenaCarloAcutisDay7Title;

  /// No description provided for @novenaCarloAcutisDay7Meditation.
  ///
  /// In pt, this message translates to:
  /// **'São Carlo Acutis, que honrastes todos os dias a Mãe de Deus com a recitação devota do Santo Rosário, alcançai-nos uma terna confiança na proteção materna de Maria. Amém.'**
  String get novenaCarloAcutisDay7Meditation;

  /// No description provided for @novenaCarloAcutisDay8Title.
  ///
  /// In pt, this message translates to:
  /// **'8º Dia - Fervor diante da Santíssima Eucaristia'**
  String get novenaCarloAcutisDay8Title;

  /// No description provided for @novenaCarloAcutisDay8Meditation.
  ///
  /// In pt, this message translates to:
  /// **'São Carlo Acutis, que adoráveis Jesus realmente presente no Santíssimo Sacramento e propagastes a fé nos milagres eucarísticos, aumentai em nós a fé viva no Altar. Amém.'**
  String get novenaCarloAcutisDay8Meditation;

  /// No description provided for @novenaCarloAcutisDay9Title.
  ///
  /// In pt, this message translates to:
  /// **'9º Dia - Caridade para com os pobres e perseverança final'**
  String get novenaCarloAcutisDay9Title;

  /// No description provided for @novenaCarloAcutisDay9Meditation.
  ///
  /// In pt, this message translates to:
  /// **'São Carlo Acutis, que socorrestes os necessitados e oferecestes vossos últimos sofrimentos pela Igreja e pelo Papa, alcançai-nos a graça da perseverança final e de uma santa morte. Amém.'**
  String get novenaCarloAcutisDay9Meditation;

  /// No description provided for @novenaOpeningPrayerLabel.
  ///
  /// In pt, this message translates to:
  /// **'ORAÇÃO INICIAL'**
  String get novenaOpeningPrayerLabel;

  /// No description provided for @novenaMeditationLabel.
  ///
  /// In pt, this message translates to:
  /// **'MEDITAÇÃO DO DIA'**
  String get novenaMeditationLabel;

  /// No description provided for @novenaPrayersLabel.
  ///
  /// In pt, this message translates to:
  /// **'ORAÇÕES'**
  String get novenaPrayersLabel;

  /// No description provided for @novenaClosingPrayerLabel.
  ///
  /// In pt, this message translates to:
  /// **'ORAÇÃO FINAL'**
  String get novenaClosingPrayerLabel;

  /// No description provided for @novenaTeresaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novena das Rosas'**
  String get novenaTeresaTitle;

  /// No description provided for @novenaTeresaDesc.
  ///
  /// In pt, this message translates to:
  /// **'Santa Teresinha do Menino Jesus'**
  String get novenaTeresaDesc;

  /// No description provided for @novenaTeresaOpening.
  ///
  /// In pt, this message translates to:
  /// **'Santíssima Trindade, Pai, Filho e Espírito Santo, eu Vos agradeço todos os favores, todas as graças com que enriquecestes a alma de Vossa serva Teresa do Menino Jesus durante os 24 anos que passou na Terra. Pelos méritos de tão querida santinha, concedei-me a graça que ardentemente Vos peço (fazer o pedido), se for conforme a Vossa Santíssima vontade e para salvação de minha alma. Ajudai minha fé e minha esperança, ó Santa Teresinha, cumprindo, mais uma vez, sua promessa de que ninguém vos invocaria em vão, fazendo-me ganhar uma rosa, sinal de que alcançarei a graça pedida.'**
  String get novenaTeresaOpening;

  /// No description provided for @novenaTeresaPrayers.
  ///
  /// In pt, this message translates to:
  /// **'Em seguida, reza-se 24 vezes: Glória ao Pai, ao Filho e ao Espírito Santo, assim como era no princípio, agora e sempre, por todos os séculos dos séculos. Amém!\n\nA cada Glória ao Pai pode-se acrescentar a jaculatória:\n\nSanta Teresinha do Menino Jesus, rogai por nós!\n\nOremos:\nPai-Nosso e Ave-Maria.'**
  String get novenaTeresaPrayers;

  /// No description provided for @novenaTeresaDay1Title.
  ///
  /// In pt, this message translates to:
  /// **'\"Para mim, a oração é um impulso do coração, um simples olhar dirigido para o Céu, um grito de agradecimento e de amor, tanto em meio ao sofrimento como em meio a alegria. Em uma palavra, é algo grande, algo sobrenatural que me dilata a alma e me une a Jesus.\"'**
  String get novenaTeresaDay1Title;

  /// No description provided for @novenaTeresaDay2Title.
  ///
  /// In pt, this message translates to:
  /// **'\"O mérito não consiste em fazer nem em dar muito, mas, antes, em receber, em amar muito!\"'**
  String get novenaTeresaDay2Title;

  /// No description provided for @novenaTeresaDay3Title.
  ///
  /// In pt, this message translates to:
  /// **'\"O que me impulsiona a ir para o Céu é o pensamento de poder acender no amor de Deus uma multidão de almas que O louvarão eternamente.\"'**
  String get novenaTeresaDay3Title;

  /// No description provided for @novenaTeresaDay4Title.
  ///
  /// In pt, this message translates to:
  /// **'\"Como é grande o poder da oração! É como uma rainha que em todo o momento tem acesso direto ao rei e pode conseguir tudo o que lhe pede.\"'**
  String get novenaTeresaDay4Title;

  /// No description provided for @novenaTeresaDay5Title.
  ///
  /// In pt, this message translates to:
  /// **'\"Não prefiro nem morrer nem viver… O que o Bom Deus prefere e escolhe para mim, eis o que me agrada mais.\"'**
  String get novenaTeresaDay5Title;

  /// No description provided for @novenaTeresaDay6Title.
  ///
  /// In pt, this message translates to:
  /// **'\"Depois da minha morte, farei cair do Céu uma chuva de rosas.\"'**
  String get novenaTeresaDay6Title;

  /// No description provided for @novenaTeresaDay7Title.
  ///
  /// In pt, this message translates to:
  /// **'\"Quando eu chegar ao Céu, quantas graças vou pedir para vocês! Atormentarei tanto a Nosso Senhor que, se Ele a princípio pensar em me recusar, minha insistência vai obrigá-lo a atender meus desejos.\"'**
  String get novenaTeresaDay7Title;

  /// No description provided for @novenaTeresaDay8Title.
  ///
  /// In pt, this message translates to:
  /// **'\"A caridade não deve consistir em simples sentimentos, mas em obras.\"'**
  String get novenaTeresaDay8Title;

  /// No description provided for @novenaTeresaDay9Title.
  ///
  /// In pt, this message translates to:
  /// **'\"Quero passar o Céu, a fazer bem sobre a Terra. Não olharei para as almas somente, mas hei de descer para junto delas. Vai começar a minha missão que é ensinar os homens a amar a Deus como eu O amo. Só descansarei no fim do mundo quando estiver completo o número dos eleitos.\"'**
  String get novenaTeresaDay9Title;

  /// No description provided for @novenaSagradoCoracaoTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novena ao Sagrado Coração'**
  String get novenaSagradoCoracaoTitle;

  /// No description provided for @novenaSagradoCoracaoDesc.
  ///
  /// In pt, this message translates to:
  /// **'Em honra ao Coração de Jesus'**
  String get novenaSagradoCoracaoDesc;

  /// No description provided for @novenaSagradoCoracaoOpening.
  ///
  /// In pt, this message translates to:
  /// **'Lembrai-vos, ó dulcíssimo Jesus, que nunca se ouviu dizer que alguém, recorrendo com confiança ao vosso Sagrado Coração, implorando vossa divina assistência e reclamando a vossa infinita misericórdia, fosse por Vós abandonado. Possuído, pois, e animado da mesma confiança, ó Coração Sagrado de Jesus, Rei de todos os corações, recorro a Vós, e gemendo sob o peso de meus pecados, me prostro diante de Vós. Meu Jesus, pelo vosso precioso Sangue e pelo amor de vosso divino Coração, não desprezeis as minhas súplicas, mas ouvi-as favoravelmente e dignai-vos atender-me. Amém.'**
  String get novenaSagradoCoracaoOpening;

  /// No description provided for @novenaSagradoCoracaoClosing.
  ///
  /// In pt, this message translates to:
  /// **'Dulcíssimo Coração de Jesus, vosso precioso Sangue é a vida da minha alma; só em Vós quero viver, só a Vós quero amar e servir. Pela sede ardente que vos abrasa de me salvar, iluminai o meu espírito com a luz de vossa divina graça. Santificai o meu coração, fortalecei a minha vontade, perdoai os meus pecados e curai todas as minhas misérias. Aumentai minha fé, fortificai a minha esperança e acendei em mim cada vez mais o fogo do vosso santo amor. Concedei-me, enfim, todas as graças que espero alcançar com esta novena. Ó dulcíssimo Jesus, vivei em mim agora e por todo o sempre. Amém.\n\n℣. Doce Coração de Jesus,\n℟. fazei que eu vos ame cada vez mais!'**
  String get novenaSagradoCoracaoClosing;

  /// No description provided for @novenaSagradoCoracaoPrayers.
  ///
  /// In pt, this message translates to:
  /// **'Pai-nosso, Ave-Maria e Glória.\n\n℣. Jesus, manso e humilde de coração,\n℟. Fazei o nosso coração semelhante ao vosso.'**
  String get novenaSagradoCoracaoPrayers;

  /// No description provided for @novenaSagradoCoracaoDay1Title.
  ///
  /// In pt, this message translates to:
  /// **'Coração de Jesus, Templo da Santíssima Trindade'**
  String get novenaSagradoCoracaoDay1Title;

  /// No description provided for @novenaSagradoCoracaoDay1Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Pondera, alma minha, como o Coração de Jesus foi o templo mais sagrado que neste mundo teve a Trindade Santíssima e Beatíssima. Um só ato de amor ou de reverência, ou de adoração, ou de outra qualquer virtude que saiu deste Coração unido à Pessoa do divino Verbo era para Deus de estima infinitamente maior que todos os atos que podiam formar todas as criaturas do mundo, ainda que todas fossem abrasados serafins. Considera, pois, alma minha, que aumentos de glória teria a Santíssima Trindade com as adorações e louvores que Jesus Cristo lhe deu neste templo? E se tu, alma minha, também deves ser templo da Santíssima Trindade pela graça, pede a este Senhor que faça o teu coração conforme a este ardentíssimo Coração.'**
  String get novenaSagradoCoracaoDay1Meditation;

  /// No description provided for @novenaSagradoCoracaoDay2Title.
  ///
  /// In pt, this message translates to:
  /// **'Coração de Jesus, Artífice do Santíssimo Sacramento'**
  String get novenaSagradoCoracaoDay2Title;

  /// No description provided for @novenaSagradoCoracaoDay2Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Pondera, alma minha, que do soberano Coração de Jesus saiu o Diviníssimo Sacramento, onde temos depositado o Sangue sacratíssimo que manou do seu lado; e foi tal a fineza do Coração de Jesus, disse o Senhor a uma serva sua, que, se não se deixara no Santíssimo Sacramento, não poderia morrer na Cruz. Tão apegado estava aquele amante Coração aos homens que, impaciente de ausências, vendo que havia de partir para o Pai, inventou esta indústria amorosa de partir e ficar juntamente, de glorificar os santos no Céu e nos fazer companhia na terra. Considera, alma minha, quanto deves ao abrasado Coração do teu Senhor, e confunde-te de tão pouco lhe agradeceres por realizar, com a instituição do Santíssimo Sacramento, a ideia de boa obra em que Ele te comunica infinitos bens.'**
  String get novenaSagradoCoracaoDay2Meditation;

  /// No description provided for @novenaSagradoCoracaoDay3Title.
  ///
  /// In pt, this message translates to:
  /// **'Coração de Jesus, Sarça de penetrantes espinhos'**
  String get novenaSagradoCoracaoDay3Title;

  /// No description provided for @novenaSagradoCoracaoDay3Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Pondera, alma minha, que desde que principiaram neste Coração os alentos da vida, até que se exalaram na morte, nunca viveu sem penas este inocente Coração, porque, como, logo que esteve animado, aceitou o preceito de padecer pelos homens, logo com a vida principiaram suas penas. Antes que chegassem os tormentos exteriores, Jesus tolerava interiormente as penas, vendo as grandes ofensas que os homens faziam ao seu Eterno Pai. No Horto foi tão viva a representação de suas penas, que rompeu-se-lhe o sangue por todos os poros. E se as penas somente consideradas causaram-lhe tanta amargura, que seriam quando verdadeiramente padecidas? Confunde-te, alma minha, da tibieza com que amas este Divino Coração, e da negligência com que não o imitas, pois tanto te repugna padecer, e tanto foges de mortificar-te.'**
  String get novenaSagradoCoracaoDay3Meditation;

  /// No description provided for @novenaSagradoCoracaoDay4Title.
  ///
  /// In pt, this message translates to:
  /// **'Coração de Jesus, Fornalha abrasadíssima de caridade'**
  String get novenaSagradoCoracaoDay4Title;

  /// No description provided for @novenaSagradoCoracaoDay4Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Pondera, alma minha, que o extremo com que este Sagrado Coração amou e ama a Deus, só o mesmo Deus o pode compreender. O peito era fornalha de incêndios, o Coração era mina de labaredas que subiam tão alto, que lá iam rematar em Deus. Veio à terra este ardentíssimo Coração para lhe pôr fogo, e sendo o mundo tão grande, ainda sobrariam incêndios, se o mundo fôra infinitas vezes maior. As raras finezas que o Senhor obrou por nós e os contínuos benefícios que nos está fazendo, tudo são chamas que continuamente saem dessa fornalha de abrasadíssima caridade. E é possível, alma minha, que vendo o teu coração rodeado de tantas chamas quantos são os benefícios que recebes do Coração de Jesus, ainda esteja tão fria e tíbia?'**
  String get novenaSagradoCoracaoDay4Meditation;

  /// No description provided for @novenaSagradoCoracaoDay5Title.
  ///
  /// In pt, this message translates to:
  /// **'Coração de Jesus, Paraíso de delícias celestiais'**
  String get novenaSagradoCoracaoDay5Title;

  /// No description provided for @novenaSagradoCoracaoDay5Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Pondera, alma minha, que neste suavíssimo Coração se encerram todas as delícias do Paraíso. Ele é o mar onde elas entram, e de onde saem todos os rios dos divinos regalos; entram nele, comunicados por Deus, e saem dele para deliciarem as almas justas. No paraíso deste Coração deu o Senhor entrada a muitos santos que se singularizaram em virtudes eminentes, e vendo-se eles quase submergidos em um mar de consolações, pediam ao Senhor que os moderasse, porque sem desfalecerem não podiam suportar abundância tão excessiva. Pobre de ti, alma minha, que tão pouco participas destas riquezas! Mas de que te admiras, se tu não amas aquele centro de amor? Aprende tu a amá-lo, e far-te-ás digna das delícias deste paraíso.'**
  String get novenaSagradoCoracaoDay5Meditation;

  /// No description provided for @novenaSagradoCoracaoDay6Title.
  ///
  /// In pt, this message translates to:
  /// **'Coração de Jesus, Tesouro riquíssimo de graças'**
  String get novenaSagradoCoracaoDay6Title;

  /// No description provided for @novenaSagradoCoracaoDay6Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Pondera, alma minha, que assim como o tesouro é um agregado de muitas riquezas, também o Coração de Jesus é um depósito de infinitas graças. Aqui acharás uma inocência suma, uma humildade profundíssima, uma fortaleza imensa, uma sabedoria infinda; e enfim, para fazeres conceito das graças e riquezas deste tesouro, hás de primeiro considerar quem as comunicou e a quem se comunicaram. O Eterno Pai foi quem as comunicou, e o Filho de Deus foi a quem se comunicaram. E tendo o Eterno Pai uma liberalidade infinita, que graças não receberia o Filho de Deus desta infinita liberalidade? Aqui se perde o juízo e aqui se abisma a consideração humana. Alma minha, se as graças deste tesouro são tantas, ama tu a este Coração para poderes participar das suas riquezas.'**
  String get novenaSagradoCoracaoDay6Meditation;

  /// No description provided for @novenaSagradoCoracaoDay7Title.
  ///
  /// In pt, this message translates to:
  /// **'Coração de Jesus, Abismo de imensa piedade'**
  String get novenaSagradoCoracaoDay7Title;

  /// No description provided for @novenaSagradoCoracaoDay7Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Pondera, alma minha, que é tão piedoso este amante Coração, que a ninguém nega sua piedade; tanto que, se alguma alma aflita recorre a Ele com viva fé, logo acode a consolá-la com seu remédio; tanto que, quando vê algum atribulado, logo corre, piedoso, com seu afeto para o socorrer. Vendo-se ofendido com as nossas culpas, dissimula tudo, e espera o nosso arrependimento para nos perdoar. Se depois de arrependidos tornamos a cair nas mesmas misérias, ainda não cansa a sua paciência, ainda não esgota a sua misericórdia, ainda não fecha as portas da sua piedade, mas antes nos busca com auxílios e nos chama com repetidas inspirações, e se nos voltamos para Ele, logo se alegra e se põe bem conosco. E crendo tu, alma minha, tudo isto, não morres de amor por este Coração?'**
  String get novenaSagradoCoracaoDay7Meditation;

  /// No description provided for @novenaSagradoCoracaoDay8Title.
  ///
  /// In pt, this message translates to:
  /// **'Coração de Jesus, Atrativo dos nossos corações'**
  String get novenaSagradoCoracaoDay8Title;

  /// No description provided for @novenaSagradoCoracaoDay8Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Pondera, alma minha, o que disse Nosso Senhor: que só depois de ser exaltado na Cruz, e não antes, é que lhe abririam o lado, ficando assim patente o seu amante Coração. Porque julgou o Senhor que quem pusesse os olhos nele, atraído por uma suavíssima violência, certissimamente se havia de render. E se tu, alma minha, te não rendes, é porque não pões nele os olhos. Se tu viras que deste Coração manam as celestes verdades, com que se afugentam as trevas das culpas; se tu viras que dele mana o fogo que abrasa as almas frias, as luzes que desterram as nossas ignorâncias, as misericórdias que lavam as nossas culpas, as doçuras, os auxílios, as inspirações... e enfim, se viras que deste Coração mana todo o bem, deixarias tu, alma minha, de amar este Coração? Deixarias de ficar presa em laços de tanto amor?'**
  String get novenaSagradoCoracaoDay8Meditation;

  /// No description provided for @novenaSagradoCoracaoDay9Title.
  ///
  /// In pt, this message translates to:
  /// **'Coração de Jesus, Penhor de vida eterna'**
  String get novenaSagradoCoracaoDay9Title;

  /// No description provided for @novenaSagradoCoracaoDay9Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Pondera, alma minha, que assim como o coração humano é o princípio da vida temporal, assim o Coração de Jesus é para nós o princípio da vida eterna; porque, se para a vida eterna é necessário o perdão das culpas e a remissão dos pecados, saindo deste Coração sangue e água, e tendo nós o Sangue de Cristo como fundamento de nossa redenção, e na água uma representação do Batismo, sem o qual ninguém entra na glória, segue-se daqui que este Coração é a porta por onde todos entram para a vida eterna. Assim como Deus lá no Paraíso deu a vida ao homem com um sopro, também com um outro sopro infundiu Cristo nos seus discípulos a graça do Espírito Santo, porque, como o hálito da boca sai do coração, quis Cristo mostrar que do seu Coração é que nos vem a graça. Pois, alma minha, se tu crês tudo isto, sabe, que se amares a este Divino Coração, e o imitares, alcançarás a graça, e conseguirás a glória na vida eterna.'**
  String get novenaSagradoCoracaoDay9Meditation;

  /// No description provided for @novenaConceicaoTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novena à Imaculada Conceição'**
  String get novenaConceicaoTitle;

  /// No description provided for @novenaConceicaoDesc.
  ///
  /// In pt, this message translates to:
  /// **'Novena tradicional a Nossa Senhora da Conceição'**
  String get novenaConceicaoDesc;

  /// No description provided for @novenaConceicaoOpening.
  ///
  /// In pt, this message translates to:
  /// **'Vinde, Espírito Santo, enchei o coração dos vossos fiéis e acendei neles o fogo do vosso amor.\n℣. Enviai o vosso Espírito, e tudo será criado.\n℟. E renovareis a face da terra.\n\nOremos.\nÓ Deus, que instruístes os corações dos vossos fiéis com a luz do Espírito Santo, concedei-nos amar, no mesmo Espírito, o que é reto e gozar sempre a sua consolação. Por Cristo, Senhor nosso. Amém.\n\nÓ Virgem puríssima concebida sem pecado, desde o primeiro instante toda bela e sem mancha. Ó gloriosa Maria, cheia de graça e Mãe de meu Deus, Rainha dos anjos e dos homens. Humildemente vos venero como Mãe do meu Salvador, que, sendo Deus, me ensinou com sua estima, respeito e submissão a vós a honra e a homenagem que vos devo prestar. Dignai-vos acolher-me a mim, que nesta novena a vós me consagro. Sendo vós refúgio seguro dos pecadores arrependidos, tenho razão para recorrer a vós; sendo Mãe de misericórdia, não podeis não vos compadecer de minha miséria; sendo, depois de Jesus Cristo, toda a minha esperança, não podeis não vos agradar da tenra confiança que em vós tenho. Fazei-me digno de chamar-me vosso filho, a fim de que possa dizer com confiança: Mostrais que sois Mãe.'**
  String get novenaConceicaoOpening;

  /// No description provided for @novenaConceicaoClosing.
  ///
  /// In pt, this message translates to:
  /// **'℣. Toda bela sois, Maria.\n℟. Toda bela sois, Maria.\n℣. E sem a mancha original.\n℟. E sem a mancha original.\n℣. Sois a glória de Jerusalém.\n℟. Sois a alegria de Israel.\n℣. Sois a honra do nosso povo.\n℟. Sois a Advogada dos pecadores.\n℣. Ó Maria.\n℟. Ó Maria.\n℣. Virgem prudentíssima.\n℟. Mãe clementíssima.\n℣. Rogai por nós.\n℟. Intercedei por nós ao Senhor Jesus Cristo.\n\n℣. Em vossa Conceição, ó Virgem, fostes imaculada.\n℟. Rogai por nós ao Pai cujo Filho destes à luz.\n\nOremos.\nÓ Deus, que pela Imaculada Conceição da Virgem Maria preparastes uma digna morada para o vosso Filho e em atenção aos méritos futuros da morte de Cristo a preservastes de toda mancha, concedei-nos, por sua intercessão, a graça de chegarmos purificados junto de Vós.\nÓ Deus, pastor e guia de todos os fiéis, olhai propício para o vosso servo o Papa, que constituístes pastor de vossa Igreja; dai-lhe, nós vos pedimos, servir por palavra e exemplo aqueles a quem governa, a fim de alcançar a vida eterna com o rebanho que lhe foi confiado.\nÓ Deus, nosso refúgio e fortaleza, ouvi as piedosas súplicas de vossa Igreja, Vós que sois o autor da piedade, e concedei-nos alcançar eficazmente o que com confiança vos pedimos. Por Cristo, Senhor nosso. Amém.'**
  String get novenaConceicaoClosing;

  /// No description provided for @novenaConceicaoPrayers.
  ///
  /// In pt, this message translates to:
  /// **'Rezar uma Ave-Maria e um Glória.'**
  String get novenaConceicaoPrayers;

  /// No description provided for @novenaConceicaoDay1Title.
  ///
  /// In pt, this message translates to:
  /// **'Primeiro Dia'**
  String get novenaConceicaoDay1Title;

  /// No description provided for @novenaConceicaoDay1Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Eis-me aqui aos vossos pés santíssimos, ó Virgem Imaculada. Alegro-me grandemente convosco, eleita desde a eternidade para ser Mãe do Verbo eterno e preservada da culpa original. Dou graças e bendigo à Santíssima Trindade, que vos enriqueceu com este privilégio em vossa Conceição, e suplico-vos humildemente que me alcanceis a graça de vencer as tristes sequelas que em mim deixou o pecado original. Fazei que eu as supere e não deixe mais de amar ao meu Deus.'**
  String get novenaConceicaoDay1Meditation;

  /// No description provided for @novenaConceicaoDay2Title.
  ///
  /// In pt, this message translates to:
  /// **'Segundo Dia'**
  String get novenaConceicaoDay2Title;

  /// No description provided for @novenaConceicaoDay2Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Ó Maria, lírio imaculado de pureza, alegro-me convosco, que desde o primeiro instante de vossa Conceição fostes cumulada de graça e recebestes o uso perfeito da razão. Dou graças e adoro à Santíssima Trindade, que vos concedeu dons tão sublimes. Confundo-me todo diante de vós, vendo-me tão pobre de graça. Vós, que fostes plenamente cumulada de graça celeste, fazei-me participar e compartilhar dos tesouros de vossa Imaculada Conceição.'**
  String get novenaConceicaoDay2Meditation;

  /// No description provided for @novenaConceicaoDay3Title.
  ///
  /// In pt, this message translates to:
  /// **'Terceiro Dia'**
  String get novenaConceicaoDay3Title;

  /// No description provided for @novenaConceicaoDay3Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Ó Maria, rosa mística de pureza, alegro-me convosco, que em vossa Imaculada Conceição triunfastes gloriosamente da serpente infernal e fostes concebida sem a mancha do pecado original. Dou graças e louvo com todo o coração à Santíssima Trindade, que vos concedeu tal privilégio, e vos suplico que me alcanceis a força para superar todas as insídias do inimigo infernal e não manchar com o pecado a minha alma. Ajudai-me sempre e fazei-me, com vossa proteção, triunfar sempre do inimigo comum de nossa eterna salvação.'**
  String get novenaConceicaoDay3Meditation;

  /// No description provided for @novenaConceicaoDay4Title.
  ///
  /// In pt, this message translates to:
  /// **'Quarto Dia'**
  String get novenaConceicaoDay4Title;

  /// No description provided for @novenaConceicaoDay4Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Ó Imaculada Virgem Maria, espelho de pureza, encho-me de sumo gozo ao ver que vos foram infusos desde a vossa Conceição os dons mais sublimes e perfeitos de virtude e também todos os dons do Espírito Santo. Dou graças e louvo à Santíssima Trindade, que vos favoreceu com estes privilégios, e vos suplico, ó Mãe benigna, que me alcanceis a prática da virtude e a graça de tornar-me digno de receber os dons e a graça do Espírito Santo.'**
  String get novenaConceicaoDay4Meditation;

  /// No description provided for @novenaConceicaoDay5Title.
  ///
  /// In pt, this message translates to:
  /// **'Quinto Dia'**
  String get novenaConceicaoDay5Title;

  /// No description provided for @novenaConceicaoDay5Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Ó Maria, lua reluzente de pureza, alegro-me convosco, pois o mistério de vossa Imaculada Conceição foi o início da salvação de todo o gênero humano e a alegria do mundo inteiro. Dou graças e bendigo à Santíssima Trindade, que assim vos engrandeceu e glorificou, e vos suplico que me alcanceis a graça de saber aproveitar-me da paixão e morte do vosso Jesus. Que não seja para mim inútil o Sangue derramado na cruz, mas que eu viva santamente e me salve.'**
  String get novenaConceicaoDay5Meditation;

  /// No description provided for @novenaConceicaoDay6Title.
  ///
  /// In pt, this message translates to:
  /// **'Sexto Dia'**
  String get novenaConceicaoDay6Title;

  /// No description provided for @novenaConceicaoDay6Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Ó Maria Imaculada, estrela esplendorosa de pureza, alegro-me convosco, porque a vossa Imaculada Conceição foi motivo de grandíssima alegria para todos os anjos do paraíso. Dou graças e bendigo à Santíssima Trindade, que vos enriqueceu de tão belo privilégio. Fazei-me entrar um dia nesta alegria e poder, na companhia dos anjos, louvar-vos e bendizer-vos eternamente.'**
  String get novenaConceicaoDay6Meditation;

  /// No description provided for @novenaConceicaoDay7Title.
  ///
  /// In pt, this message translates to:
  /// **'Sétimo Dia'**
  String get novenaConceicaoDay7Title;

  /// No description provided for @novenaConceicaoDay7Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Ó Maria Imaculada, aurora nascente de pureza, alegro-me convosco, admirado de que no momento mesmo de vossa Conceição fostes confirmada em graça e tornada impecável. Dou graças e exalto à Santíssima Trindade, que vos distinguiu somente a vós com este particular privilégio. Impetrai-me, ó Virgem santa, um total e contínuo horror ao pecado, mais do que a qualquer outro mal, e que eu prefira antes morrer que voltar a pecar.'**
  String get novenaConceicaoDay7Meditation;

  /// No description provided for @novenaConceicaoDay8Title.
  ///
  /// In pt, this message translates to:
  /// **'Oitavo Dia'**
  String get novenaConceicaoDay8Title;

  /// No description provided for @novenaConceicaoDay8Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Ó Virgem Maria, sol sem mancha, alegro-me convosco, cheio de gozo por terdes recebido de Deus em vossa Conceição uma graça maior e mais copiosa que a alcançada por todos os anjos e santos no auge de seus méritos. Dou graças à Santíssima Trindade, admirado da suma beneficência com que vos dispensou este privilégio. Fazei-me corresponder à graça divina e a dela não mais abusar. Transformai-me o coração e fazei que eu me arrependa desde agora de minhas culpas.'**
  String get novenaConceicaoDay8Meditation;

  /// No description provided for @novenaConceicaoDay9Title.
  ///
  /// In pt, this message translates to:
  /// **'Nono Dia'**
  String get novenaConceicaoDay9Title;

  /// No description provided for @novenaConceicaoDay9Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Ó Maria, Virgem Imaculada, luz viva de santidade, exemplo de pureza e Mãe minha. Vós, apenas concebida, adorastes profundamente a Deus e lhe rendestes graças, já que por meio de vós, desfeita a antiga maldição, derramou-se a maior bênção sobre os filhos de Adão. Fazei que esta bênção acenda em meu coração um amor ardente a Deus. Inflamai-o vós, para que eu o ame constantemente e dele goze depois para sempre no paraíso, onde poderei dar-lhe graças mais ardentemente pelos singulares privilégios que vos concedeu e gozar de vós coroada de tanta glória.'**
  String get novenaConceicaoDay9Meditation;

  /// No description provided for @novenaNatalTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novena de Natal'**
  String get novenaNatalTitle;

  /// No description provided for @novenaNatalDesc.
  ///
  /// In pt, this message translates to:
  /// **'Meditações de Santo Afonso de Ligório. Uma preparação profunda para receber o Menino Jesus.'**
  String get novenaNatalDesc;

  /// No description provided for @novenaNatalOpening.
  ///
  /// In pt, this message translates to:
  /// **'Cântico Inicial: Puer Natus\n(Ou outro cântico de Natal)'**
  String get novenaNatalOpening;

  /// No description provided for @novenaNatalClosing.
  ///
  /// In pt, this message translates to:
  /// **'Cântico Final: Adeste Fideles\n(Ou outro cântico de Natal)'**
  String get novenaNatalClosing;

  /// No description provided for @novenaNatalPrayers.
  ///
  /// In pt, this message translates to:
  /// **'Ao final da meditação e oração, reza-se o Terço e a Ladainha de Nossa Senhora.'**
  String get novenaNatalPrayers;

  /// No description provided for @novenaNatalDay1Title.
  ///
  /// In pt, this message translates to:
  /// **'Primeiro Dia - 16 de Dezembro'**
  String get novenaNatalDay1Title;

  /// No description provided for @novenaNatalDay1Meditation.
  ///
  /// In pt, this message translates to:
  /// **'DEUS NOS DEU SEU FILHO UNIGÊNITO POR SALVADOR\n\nEu te constitui em luz para os gentios, para que minha salvação chegue até os confins da terra. (Is. 49, 6)\n\nConsideremos como o Pai eterno disse ao Menino Jesus no instante de sua concepção estas palavras: Filho, eu te dei ao mundo como luz e vida das gentes, para que busques sua salvação, que estimo tanto como se fosse a minha. É necessário, pois, que te empenhes completamente em benefício dos homens. \'Dado completamente aos homens, e inteiramente entregue a suas necessidades\'. É necessário que ao nascer padeças extrema pobreza, para que o homem se enriqueça; é necessário que sejas vendido como escravo, para que o homem seja livre; é necessário que, como escravo, sejas açoitado e crucificado, para pagar à minha justiça a pena devida pelos homens; é necessário que sacrifiques sangue e vida, para livrar o homem da morte eterna. Fica sabendo, enfim, que já não és teu, mas do homem. Pois um filho lhes nasceu, e um menino lhes foi dado. Assim amado Filho meu, o homem voltará a amar-me a ser meu, vendo que te dou inteiramente a ele, meu Filho Unigênito, e que já não me resta mais o que lhe possa dar.\n\nAssim amou Deus - oh, amor infinito, digno somente de um Deus infinito - assim amou Deus o mundo de tal forma, que lhe entregou seu Filho Unigênito. O Menino Jesus não se entristeceu com esta proposta, mas, ao contrário, comprazeu-se nela e a aceitou com amor e alegria: \'como um esposo procedente de seu tálamo, exultou como gigante a percorrer seu caminho\' (Sl. 18,6). E desde o primeiro momento de sua encarnação se entregou por completo ao homem e abraçou com gosto todas as dores e ignomínias que havia de sofrer na terra por amor dos homens. Esses foram, segundo São Bernardo, as colinas e vales que com tanta pressa devia atravessar Jesus Cristo, segundo o Cântico dos Cânticos, para salvar os homens. Ei-lo que vem saltando pelas montanhas, brincando pelas colinas.\n\nReflitamos aqui como o Pai, enviando-nos seu Filho para ser nosso Redentor e para selar a paz entre Ele e os homens, obrigou-se de certo modo a perdoar-nos e a amar-nos, em razão do pacto que fez de receber-nos em sua graça, posto que o Filho satisfaz por nós a justiça divina. Por sua vez, o Verbo divino, tendo aceito a missão que lhe foi dada pelo Pai, o qual, enviando-o para redimir-nos no-lo deu, obrigou-se também a amar-nos, não por nossos méritos, mas para cumprir a piedosa vontade de seu Pai.'**
  String get novenaNatalDay1Meditation;

  /// No description provided for @novenaNatalDay2Title.
  ///
  /// In pt, this message translates to:
  /// **'Segundo Dia - 17 de Dezembro'**
  String get novenaNatalDay2Title;

  /// No description provided for @novenaNatalDay2Meditation.
  ///
  /// In pt, this message translates to:
  /// **'AFLIÇÃO DO CORAÇÃO DE JESUS NO SEIO DE MARIA\n\nHóstias e oblações não quisestes, mas formastes-me um corpo. (Hebr. 10,5)\n\nConsidera a grande amargura com que devia sentir-se afligido e oprimido o coração do Menino Jesus no seio de Maria, naquele primeiro instante em que o Pai lhe propôs a série de desprezos, trabalhos e agonias que havia de sofrer em sua vida para libertar os homens de suas misérias: \'Pela manhã chama a meus ouvidos..., não retrocedi..., entreguei meu corpo aos que me feriam\' (Is. 50, 4-6). Assim falou Jesus pela boca do Profeta: \'Pela manhã...\', quer dizer, desde o primeiro instante de minha concepção, meu Pai me fez compreender sua vontade: que eu tivesse uma vida de sofrimento e fosse, finalmente, sacrificado na cruz; \'não retrocedi; entreguei meu corpo aos que me feriam\'. E tudo aceitei pela salvação das almas e, desde então, entreguei meu corpo aos açoites, aos cravos, e à morte.\n\nPondera então quanto padeceu Jesus Cristo em sua vida e em sua paixão; tudo lhe foi posto ante os olhos desde o seio de sua Mãe e tudo Ele abraçou com amor; mas, ao consentir nessa aceitação e vencer a natural repugnância dos sentidos, quanta angústia e opressão não teve que sofrer o inocente Coração de Jesus! Conhecia bem o que primeiramente tinha que padecer; os sofrimentos e opróbrios do nascimento numa fria gruta, estábulo de animais; os trinta anos de trabalho como artesão; o considerar que seria tratado pelos homens como ignorante, escravo, sedutor e réu da morte mais infame e dolorosa que se reservava aos criminosos.\n\nTudo aceitou nosso amável Redentor a cada momento, e a cada momento em que o aceitava, padecia reunidas todas as penas a abatimentos que depois padeceria até sua morte. O próprio conhecimento de sua dignidade divina contribuía para que sentisse mais as injúrias recebidas dos homens: \'Tenho sempre presente a minha ignomínia\'. Continuamente teve diante dos olhos sua vergonha, especialmente a confusão que sentiria ao ver-se um dia despido, açoitado, pregado com três cravos de ferro, entregando assim sua vida entre vitupérios e maldições daqueles que se beneficiavam com sua morte. \'Feito obediente até a morte e morte de cruz\' (Phil. 2,8) e para quê? Para salvar-nos, a nós, míseros e ingratos pecadores.\n\nORAÇÃO\nAmado Redentor nosso, quanto vos custou desde que entrastes no mundo, tirar-nos do abismo em que nosso pecados nos haviam submergido. Para livrar-nos da escravidão do demônio, ao qual nós mesmos nos vendemos voluntariamente, aceitastes ser tratado como o pior dos escravos; e, nós que o sabíamos, tantas vezes tivemos a ousadia de amargurar vosso amabilíssimo Coração, que tanto nos amou. Mas já que Vós, nosso Deus, sendo inocente, aceitastes vida e morte tão penosas, aceitamos por vosso amor, Jesus, todas as dores que nos venham de vossas mãos. Aceitamo-las e abraçamo-las porque procedem daquelas mãos transpassadas um dia para livrar-nos do inferno, que tantas vezes merecemos. Vosso amor, nosso Redentor, ao oferecer-vos para sofrer tanto por nós, obriga-nos a aceitar por Vós qualquer pena e desprezo. Dai-nos a aceitar por Vós qualquer pena e desprezo. Dai-nos, Senhor, por vossos méritos, vosso santo amor, que nos torna doces todas as dores e todas as ignomínias. Amamo-vos acima de todas as coisas, amamo-vos com todo o coração, amamo-vos mais que a nós mesmos. Vós, em vossa vida, nos destes tantas e tão grandes provas de afeto e nós, ingratos, que prova de amor vos damos? Fazei, pois, ó nosso Deus, que durante os anos que nos restam de vida vos demos alguma prova de amor. Não nos atreveríamos, no dia do juízo, a comparecer diante de Vós tão pobres como somos agora e sem fazer nada por vosso amor; mas que podemos fazer sem vossa graça? Apenas rogar-vos que nos socorrais, e ainda essa nossa súplica é graça vossa. Oh, Jesus, socorrei-nos pelo mérito de vossas dores e do sangue que derramastes por mim.\nMaria Santíssima, recomendai-nos a Vosso Filho, já que por nosso amor o tivestes em vosso seio. Lembrai-vos que somos daquelas almas por quem morreu vosso Filho.'**
  String get novenaNatalDay2Meditation;

  /// No description provided for @novenaNatalDay3Title.
  ///
  /// In pt, this message translates to:
  /// **'Terceiro Dia - 18 de Dezembro'**
  String get novenaNatalDay3Title;

  /// No description provided for @novenaNatalDay3Meditation.
  ///
  /// In pt, this message translates to:
  /// **'JESUS FAZ-SE MENINO PARA CONQUISTAR NOSSA CONFIANÇA E NOSSO AMOR\n\nUm menino nos nasceu, um filho nos foi dado. (Is. 9,6)\n\nConsideremos como depois de tantos séculos, depois de tantas orações e pedidos, veio, nasceu e se deu todo a nós o Messias, que não foram dignos de ver os santos patriarcas e profetas; o desejado pelos gentios, o desejado pelas colinas eternas, nosso Salvador: \'Um menino nos nasceu, um filho nos foi dado\'. O Filho de Deus se fez pequeno para fazer-nos grandes: deu-se a nós para que nos déssemos a Ele; veio mostrar-nos seu amor, para que lhe déssemos o nosso. Recebamo-lo, pois com afeto, amemo-lo e recorramos a Ele em todas as nossas necessidade. As crianças, diz São Bernardo, facilmente concedem o que se lhes pede. Jesus veio como criança, para mostrar-nos que está disposto a dar-nos todos os seus bens. \'No qual se acham todos os tesouros\' (Col. 2,3). \'O Pai...entregou tudo em suas mãos\' (Jo. 3,35). Se queremos luz, Ele veio para nos iluminar; se queremos força para resistir aos inimigos, Ele veio para nos fortalecer; se queremos o perdão e a salvação, Ele veio precisamente para nos perdoar e nos salvar; se queremos, em uma palavra, o supremo dom do amor divino, Ele veio para nos abrasar; e, para isto, sobretudo, se fez menino e quis apresentar-se a nós pobre e humilde, para parecer mais amável, para tirar-nos todo o temor e conquistar nosso afeto: \'Assim devia vir quem quis desterrar o temor e buscar a caridade\', diz São Pedro Crisólogo.\n\nAlém disso, Jesus Cristo quis vir criança, para que o amássemos não só com amor apreciativo, mas com amor terno. Todas as crianças sabem conquistar para si afetuoso carinho daqueles que a rodeiam e, quem não amará com ternura seu Deus, vendo-o criancinha, com frio, pobre, humilhado e abandonado, que chora sobre as palhas de um presépio?\n\nVinde amar Deus feito menino e feito pobre, e que é tão amável que desceu do céu para entregar-se por completo a nós.\n\nORAÇÃO\nÓ amável Jesus, tão desprezado por nós! Descestes do céu para resgatar-nos do inferno e dar-vos por completo a nós, como pudemos tantas vezes, voltar-vos as costas, ó Deus! Os homens são tão gratos às criaturas que se alguém lhes dá um presente, se lhes envia um cumprimento, se lhes dá qualquer prova de afeto, não se esquecem e se sentem forçados a corresponder. E, pelo contrário, são tão ingratos convosco, que sois seu Deus, e tão amável que por seu amor não recusastes dar o sangue e a vida. Mas, ai de nós, nós fomos ainda piores que os outros, porque fomos mais amados e mais ingratos. Ah! Se as graças que nos destes, as tivesses dado a um herege, a um idólatra, talvez se tivessem santificado, e nós vos ofendemos. Por favor, não vos lembreis, Senhor, das injúrias que vos fizemos. Dissestes que, quando um pecador se arrepende, esquecei-vos de todos os pecados cometidos: \'Nenhum dos pecados que cometeu lhe será recordado\' (Ez. 18, 22). Se no passado não nos amamos, no futuro não queremos senão vos amar. Já que vos destes completamente a nós, damo-vos em troca toda a nossa vontade; com ela vos amamos e que vos amamos queremos repetir para sempre. Queremos viver repetindo-o e repetindo-o morrer, para começarmos desde o instante que entramos na eternidade a amar-vos com um amor contínuo que durará eternamente. Entretanto, Senhor, nosso único bem e único amor, propomo-nos a antepor vossa vontade a todos os nossos prazeres. Por nada queremos deixar de amar quem nos amou tanto; não queremos mais desgostar a quem devemos amor infinito. Secundai, Jesus, nosso desejo com vossa graça.\nRainha nossa, Maria, reconhecemos que todas as graças recebidas de Deus são devidas à vossa intercessão; continuai a interceder por nós, alcançai-nos a perseverança, vós que sois a Mãe de todas as graças.'**
  String get novenaNatalDay3Meditation;

  /// No description provided for @novenaNatalDay4Title.
  ///
  /// In pt, this message translates to:
  /// **'Quarto Dia - 19 de Dezembro'**
  String get novenaNatalDay4Title;

  /// No description provided for @novenaNatalDay4Meditation.
  ///
  /// In pt, this message translates to:
  /// **'A PAIXÃO DE JESUS CRISTO DUROU TODA SUA VIDA\n\nMinha dor está sempre diante de mim. (Ps. 37,18)\n\nConsideremos como naquele primeiro instante em que foi criada e unida a alma de Jesus Cristo a seu corpo, no seio de Maria, o Padre Eterno mostrou a seu Filho sua vontade de que morresse pela redenção do mundo; e naquele mesmo instante lhe mostrou todas as penas que devia sofrer até a morte para redimir os homens. Mostrou-lhe então todos os trabalho, desprezos e pobreza que devia padecer em sua vida, tanto em Belém como no Egito e em Nazaré, e depois todas as dores e ignomínias da paixão: açoites, espinhos, cravos e cruz; todos os tédios, tristezas, agonias e abandonos no meio dos quais havia de terminar sua vida no Calvário.\n\nAbrão, conduzindo seu filho à morte, não quis afligi-lo dizendo-lhe antecipadamente que morreria, e isso no pouco tempo que era necessário para chegar ao monte. Mas o Eterno Pai quis que seu Filho encarnado, destinado como vítima de nossos pecados à sua justiça, padecesse imediatamente, pelo conhecimento delas, todas as penas a que depois teria que sujeitar-se durante sua vida e em sua morte. Daí, a tristeza padecida por Jesus no Horto, capaz de tirar-lhe a vida, como ele declarou: \'Minha alma está triste até a morte\' (Mt. 26,38), padeceu-a também constantemente desde o primeiro momento em que esteve no seio de sua Mãe. Assim, desde então sentiu vivamente e sofreu o peso reunido de todas as dores e vitupérios que O esperavam.\n\nA vida inteira e todos os anos de nosso Redentor foram cheios de penas e lágrimas: \'Na dor se consome minha vida, e em soluços meus anos\' (Ps. 30,11). Seu divino Coração não teve um momento livre de sofrimentos; quer vigiasse ou dormisse, quer trabalhasse ou descansasse, rezasse ou falasse, sempre tinha diante dos olhos essa amarga representação, que atormentava mais sua santíssima Alma do que atormentaram aos santos mártires todas as suas penas. Eles padeceram, mas, ajudados pela graça divina, padeceram com alegria e fervor. Jesus Cristo sofreu, mas sofreu sempre com o coração cheio de tédio e tristeza, e tudo aceitou por nosso amor.\n\nORAÇÃO\nÓ doce, ó amável, ó amante Coração de Jesus, assim desde menino fostes amargurado e agonizáveis no seio de Maria? Tudo isto sofrestes, Jesus, para satisfazer pela pena e agonia eterna que nos cabia padecer no inferno por nosso pecados. Vós pois, padecestes sem nenhum alívio para salvar-nos, depois de nós termos nos atrevido a abandonar a Deus e voltar-lhe as costas, para satisfazer nossos gostos miseráveis. Graças vos damos, Coração amante e aflito de Nosso Senhor. Agradecemo-vos e nos compadecemos de Vós ao considerar que padecestes tanto pelos homens e que estes não se compadecem de Vós. Como são grandes o amor de Deus e a ingratidão dos homens. Ó Redentor nosso, como são poucos os homens que pensam em vossas dores e em vosso amor. Ó Deus, como são poucos os que vos amam. E desgraçados de nós que também vivemos tantos anos sem lembrarmo-nos de Vós! Vós padecestes tanto para que vos amássemos e não vos amamos. Perdoai-nos, Jesus, perdoai-nos que queremos nos emendar e queremos vos amar. Pobres de nós, Senhor, se resistirmos à Vossa graça e por nossa resistência nos condenarmos. Quantas misericórdias usastes conosco e especialmente vossa voz que agora nos convida a amar-vos, seriam nossas maiores penas no inferno. Amado Jesus, tende piedade de nós, não permitais que vivamos mais ingratos a vosso amor; dai-nos luz e força para vencer tudo e para cumprir vossa vontade. Escutai-nos, rogamo-vos, pelos méritos de vossa Paixão.\nDe Vós esperamos tudo e de vossa intercessão, ó Maria. Querida Mãe, socorrei-nos, Vós que nos alcançastes todas as graças que recebemos de Deus; continuai a nos ajudar, pois se não o fazeis seremos infiéis, como o fomos no passado. Vós sois toda a nossa esperança e toda a razão de nossa confiança.'**
  String get novenaNatalDay4Meditation;

  /// Title for the Catholic Life Plan page
  ///
  /// In pt, this message translates to:
  /// **'Plano de Oração'**
  String get planoVidaTitle;

  /// No description provided for @planoVidaCalendarTab.
  ///
  /// In pt, this message translates to:
  /// **'Calendário'**
  String get planoVidaCalendarTab;

  /// No description provided for @planoVidaPrayersTab.
  ///
  /// In pt, this message translates to:
  /// **'Orações'**
  String get planoVidaPrayersTab;

  /// No description provided for @planoVidaConfessionTab.
  ///
  /// In pt, this message translates to:
  /// **'Confissão'**
  String get planoVidaConfessionTab;

  /// No description provided for @liturgicalSeasonAdvent.
  ///
  /// In pt, this message translates to:
  /// **'Advento'**
  String get liturgicalSeasonAdvent;

  /// No description provided for @liturgicalSeasonChristmas.
  ///
  /// In pt, this message translates to:
  /// **'Natal'**
  String get liturgicalSeasonChristmas;

  /// No description provided for @liturgicalSeasonLent.
  ///
  /// In pt, this message translates to:
  /// **'Quaresma'**
  String get liturgicalSeasonLent;

  /// No description provided for @liturgicalSeasonEaster.
  ///
  /// In pt, this message translates to:
  /// **'Páscoa'**
  String get liturgicalSeasonEaster;

  /// No description provided for @liturgicalSeasonOrdinary.
  ///
  /// In pt, this message translates to:
  /// **'Tempo Comum'**
  String get liturgicalSeasonOrdinary;

  /// No description provided for @nextConfessionTitle.
  ///
  /// In pt, this message translates to:
  /// **'Próxima Confissão'**
  String get nextConfessionTitle;

  /// No description provided for @noConfessionPlanned.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma confissão planejada'**
  String get noConfessionPlanned;

  /// No description provided for @confessionPlannedFor.
  ///
  /// In pt, this message translates to:
  /// **'Planejada para:'**
  String get confessionPlannedFor;

  /// No description provided for @daysRemaining.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{Hoje} =1{Amanhã} other{Faltam {count} dias}}'**
  String daysRemaining(num count);

  /// No description provided for @startExaminationButton.
  ///
  /// In pt, this message translates to:
  /// **'REALIZAR EXAME DE CONSCIÊNCIA'**
  String get startExaminationButton;

  /// No description provided for @confessionHistoryTitle.
  ///
  /// In pt, this message translates to:
  /// **'Histórico de Confissões'**
  String get confessionHistoryTitle;

  /// No description provided for @confessionReminderTitle.
  ///
  /// In pt, this message translates to:
  /// **'Lembrete de Confissão'**
  String get confessionReminderTitle;

  /// No description provided for @confessionReminderNotSet.
  ///
  /// In pt, this message translates to:
  /// **'Toque para configurar um lembrete'**
  String get confessionReminderNotSet;

  /// No description provided for @confessionReminderSet.
  ///
  /// In pt, this message translates to:
  /// **'Lembrete configurado com sucesso!'**
  String get confessionReminderSet;

  /// No description provided for @confessionReminderTimeSet.
  ///
  /// In pt, this message translates to:
  /// **'Lembrete às {time}'**
  String confessionReminderTimeSet(Object time);

  /// No description provided for @confessionReminderCancelled.
  ///
  /// In pt, this message translates to:
  /// **'Lembrete cancelado.'**
  String get confessionReminderCancelled;

  /// No description provided for @confessionReminderQuestion.
  ///
  /// In pt, this message translates to:
  /// **'Deseja configurar um lembrete para esta confissão?'**
  String get confessionReminderQuestion;

  /// No description provided for @confessionReminderConfigTitle.
  ///
  /// In pt, this message translates to:
  /// **'Configurar Lembrete'**
  String get confessionReminderConfigTitle;

  /// No description provided for @confessionReminderDaysLabel.
  ///
  /// In pt, this message translates to:
  /// **'Quantos dias de antecedência?'**
  String get confessionReminderDaysLabel;

  /// No description provided for @confessionReminderDaysOption.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{No dia} =1{1 dia antes} other{{count} dias antes}}'**
  String confessionReminderDaysOption(num count);

  /// No description provided for @confessionReminderTimeLabel.
  ///
  /// In pt, this message translates to:
  /// **'Em qual horário?'**
  String get confessionReminderTimeLabel;

  /// No description provided for @noLabel.
  ///
  /// In pt, this message translates to:
  /// **'Não'**
  String get noLabel;

  /// No description provided for @yesLabel.
  ///
  /// In pt, this message translates to:
  /// **'Sim'**
  String get yesLabel;

  /// No description provided for @confirmLabel.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar'**
  String get confirmLabel;

  /// Morning Offering prayer
  ///
  /// In pt, this message translates to:
  /// **'Oferecimento da Manhã'**
  String get morningOffering;

  /// Angelus prayer
  ///
  /// In pt, this message translates to:
  /// **'Angelus / Regina Caeli'**
  String get angelus;

  /// Rosary prayer
  ///
  /// In pt, this message translates to:
  /// **'Santo Terço'**
  String get rosary;

  /// Examination of Conscience
  ///
  /// In pt, this message translates to:
  /// **'Exame de Consciência'**
  String get examination;

  /// Night Prayer
  ///
  /// In pt, this message translates to:
  /// **'Oração da Noite'**
  String get nightPrayer;

  /// No description provided for @addPrayerForDay.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar oração neste dia'**
  String get addPrayerForDay;

  /// No description provided for @prayersOfTheDay.
  ///
  /// In pt, this message translates to:
  /// **'Orações do dia:'**
  String get prayersOfTheDay;

  /// No description provided for @deletePrayerTitle.
  ///
  /// In pt, this message translates to:
  /// **'Remover oração?'**
  String get deletePrayerTitle;

  /// No description provided for @deletePrayerContent.
  ///
  /// In pt, this message translates to:
  /// **'Esta ação não pode ser desfeita.'**
  String get deletePrayerContent;

  /// No description provided for @selectPrayerType.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar tipo de oração'**
  String get selectPrayerType;

  /// No description provided for @customPrayerOption.
  ///
  /// In pt, this message translates to:
  /// **'Outra oração...'**
  String get customPrayerOption;

  /// No description provided for @customPrayerName.
  ///
  /// In pt, this message translates to:
  /// **'Nome da oração'**
  String get customPrayerName;

  /// No description provided for @customPrayerHint.
  ///
  /// In pt, this message translates to:
  /// **'Digite o nome...'**
  String get customPrayerHint;

  /// No description provided for @prayerAddedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Oração adicionada com sucesso!'**
  String get prayerAddedSuccess;

  /// No description provided for @dailyPrayersCategory.
  ///
  /// In pt, this message translates to:
  /// **'Orações Diárias'**
  String get dailyPrayersCategory;

  /// No description provided for @mainPrayersCategory.
  ///
  /// In pt, this message translates to:
  /// **'Orações Principais'**
  String get mainPrayersCategory;

  /// No description provided for @specialPrayersCategory.
  ///
  /// In pt, this message translates to:
  /// **'Orações Especiais'**
  String get specialPrayersCategory;

  /// No description provided for @saintsPrayersCategory.
  ///
  /// In pt, this message translates to:
  /// **'Devoções aos Santos'**
  String get saintsPrayersCategory;

  /// No description provided for @jaculatoriasCategory.
  ///
  /// In pt, this message translates to:
  /// **'Jaculatórias'**
  String get jaculatoriasCategory;

  /// No description provided for @litaniesCategory.
  ///
  /// In pt, this message translates to:
  /// **'Ladainhas'**
  String get litaniesCategory;

  /// No description provided for @novenaCategory.
  ///
  /// In pt, this message translates to:
  /// **'Novenas'**
  String get novenaCategory;

  /// No description provided for @selectNovenaDay.
  ///
  /// In pt, this message translates to:
  /// **'Qual dia da novena?'**
  String get selectNovenaDay;

  /// Title for calendar events section
  ///
  /// In pt, this message translates to:
  /// **'Eventos do Dia'**
  String get calendarEventsTitle;

  /// No description provided for @novenaNatalDay5Title.
  ///
  /// In pt, this message translates to:
  /// **'Quinto Dia - 20 de Dezembro'**
  String get novenaNatalDay5Title;

  /// No description provided for @novenaNatalDay5Meditation.
  ///
  /// In pt, this message translates to:
  /// **'JESUS CRISTO SE OFERECEU DESDE O PRINCÍPIO POR NOSSA SALVAÇÃO\n\nFoi imolado, porque Ele mesmo quis. (Is. 53,7)\n\nO Verbo divino, desde o primeiro instante em que se viu feito homem e criança no seio de Maria, se ofereceu por si mesmo às penas e à morte para resgate do mundo. Sabia que todos os sacrifícios dos cordeiros e dos touros oferecidos a Deus na Antigüidade não tinham podido satisfazer pelas culpas dos homens, mas que era necessário que uma pessoa divina satisfizesse por eles o preço de sua redenção. Pelo que disse, como afirma o Apóstolo: \'Não quiseste hóstia nem oblação, mas me formaste um corpo. Então eu disse; Eis-me aqui presente\' (Heb. 10,5). Meu Pai, disse Jesus Cristo, todas as vítimas que vos foram oferecidas até agora não bastam nem bastarão para satisfazer vossa justiça; destes-me um corpo passível para que com a efusão de meu sangue vos aplaque e salve os homens: eis-me aqui presente, \'ecce venio\', tudo aceito e tudo submeto a vossa vontade.\n\nA parte inferior de sua vontade experimentava, naturalmente, repugnância e recusava-se a viver e a morrer entre tantas dores e opróbrios, mas venceu a parte racional, que estava completamente subordinada à vontade do Pai, e aceitou tudo, começando Jesus a padecer desde aquele instante, todas as angústias e dores que sofreria nos anos de sua vida, assim agiu nosso divino Redentor desde os primeiros instantes de sua entrada no mundo.\n\nE como nos portamos nós com Jesus Cristo, desde que, chegados ao uso da razão, começamos a conhecer, com as luzes da fé, os sagrados mistérios da redenção? Que pensamentos, que desígnios, que bens temos amado? Prazeres, passatempos, soberbas, vinganças, sensualidade, eis os bens que aprisionaram os afetos de nosso coração. Mas, se temos fé, mudemos de vida e de amores; amemos a um Deus que tanto padeceu por nós. Lembremo-nos das penas que o Coração de Jesus padeceu por nós desde criança, e assim não poderemos amar senão esse Coração, que tanto nos amou.\n\nORAÇÃO\nSenhor nosso, quereis saber como nos portamos convosco em nossa vida? Desde que começamos a ter o uso da razão começamos a menosprezar vossa graça e vosso amor. Mas melhor que nós o sabeis vós e, apesar disso, nos suportastes porque nos amais muito. Fugíamos de Vós, e vós vos aproximastes chamando-nos. Aquele mesmo amor que vos fez baixar do céu para buscar as ovelhas perdidas, fez com que nos suportásseis. Jesus, agora nos buscais e nós vos buscamos. Percebemos que vossa graça nos assiste; assiste-nos com a dor de nossos pecados, que odiamos mais que todos os outros males; assisti-nos com o desejo que temos de vos amar e de vos dar gosto. Sim Senhor nosso, queremos amar-vos e tanto quanto possamos. Certo que tememos por nossa fragilidade e debilidade contraídas por causa de nossos pecados, mas muito amor é a confiança que vossa graça nos infunde, fazendo-nos esperar em vossos méritos e dando-nos grande ânimo para exclamar: \'Tudo posso naquele que me conforta\' (Phil. 4,13). Se somos débeis, Vós nos dareis força contra nossos inimigos; se estamos enfermos, esperamos que vosso sangue seja nossa medicina; se somos pecadores, confiamos em que nos santificareis. Confessamos que no passado cooperamos com nossa ruína porque deixamos de recorrer a Vós nos perigos. De hoje em diante, Deus e esperança nossa, a Vós queremos recorrer e de Vós esperamos toda ajuda e todo o bem. Amamos-vos sobre todas as coisas e nada queremos amar fora de vós. Ajudai-nos, por piedade, pelo mérito de tantos sofrimentos que desde o princípio sofrestes por nós. Eterno Pai, por amor de Jesus Cristo, aceitai que vos amemos. Se vos iramos, aplacai-vos ao ver as lágrimas do menino Jesus, que vos roga por nós: \'Põe teus olhos na face de teu ungido\' (Ps. 83,10). Não merecemos graças, mas merece-as esse Filho inocente, que vos oferece uma vida de penas para que sejais conosco misericordioso.\nE Vós, Maria, Maria, Mãe Misericordiosa, não deixeis de interceder por nós; sabeis quanto confiamos em Vós, e sabemos bem que não abandonais a quem recorre a Vós.'**
  String get novenaNatalDay5Meditation;

  /// No description provided for @novenaNatalDay6Title.
  ///
  /// In pt, this message translates to:
  /// **'Sexto Dia - 21 de Dezembro'**
  String get novenaNatalDay6Title;

  /// No description provided for @novenaNatalDay6Meditation.
  ///
  /// In pt, this message translates to:
  /// **'JESUS NO SEIO DE MARIA\n\nSou contado entre os que descem à cova, tornei-me como um homem sem força. (Ps. 87,5)\n\nConsideremos a vida penosa por que passou Jesus Cristo no seio de sua Mãe. Era livre, porque se tinha feito voluntariamente prisioneiro de amor, mas o amor o privava do uso da liberdade e o mantinha em cadeias tão apertadas que não podia mover-se. Ó grande paciência do Salvador! Ao pensar nas penas de Nosso Senhor ainda no seio de sua Mãe.\n\nVejamos a que se reduz o Filho de Deus por amor dos homens: priva-se de sua liberdade e se encadeia para livrar-nos das cadeias do inferno. Muito, pois, merece ser reconhecida com gratidão e amor a graça de nosso libertador e fiador, que, não por obrigação, mas por afeto, se ofereceu para pagar e pagou nossas dívidas e nossas penas, dando por elas sua vida: \'Não te esqueças do benefício que te fez o que ficou por teu fiador, porque ele expôs a sua vida por ti\' (Eccli. 29,20).\n\nORAÇÃO\n\'Não te esqueças do benefício que te fez o que ficou por teu fiador\'. Sim, ó Jesus, com razão nos adverte o Profeta de que não nos esqueçamos da imensa graça que nos fizeste. Nós éramos devedores e réus, e, Vós inocente. Vós, nosso Deus, quisestes satisfazer por nossos pecados com vossas penas e com vossa morte. E depois esquecemos esta graça e vosso amor e nos atrevemos a voltar-vos as costas, como se não fosseis nosso Senhor, o Senhor que nos amou tanto. Mas, se no passado o esquecemos, não queremos, Redentor nosso, esquecer-vos no futuro. Vossas penas e vossa morte serão nosso contínuo pensamento, e elas nos recordarão sempre o amor que nos tivestes. Maldizemos os dias em que, esquecidos de quanto sofrestes por nós, abusamos lamentavelmente da liberdade que nos destes para amar-vos e empregamos em desprezar-vos. Essa liberdade que nos destes, hoje vo-la consagramos. Livrai-nos, ó Jesus, da desgraça de ver-nos de novo separados de Vós e feitos escravos do demônio. Prendei a vossos pés nossas almas a fim de que não nos separemos mais de vós. Padre Eterno, pelo cativeiro que o Menino Jesus padeceu no seio de Maria, livrai-nos das cadeias do demônio e do inferno.\nE Vós, Mãe de Deus, socorrei-nos. Carregai-nos aprisionados e estreitados ao Filho de Deus. Pois, já que Jesus é vosso prisioneiro, fará tudo o que mandardes. Dizei-lhe que nos perdoe e que nos faça santo. Ajudai-nos, nossa Mãe, pela graça e honra que vos fez Jesus Cristo de habitar nove meses em vosso seio.'**
  String get novenaNatalDay6Meditation;

  /// No description provided for @novenaNatalDay7Title.
  ///
  /// In pt, this message translates to:
  /// **'Sétimo Dia - 22 de Dezembro'**
  String get novenaNatalDay7Title;

  /// No description provided for @novenaNatalDay7Meditation.
  ///
  /// In pt, this message translates to:
  /// **'DOR QUE CAUSOU A JESUS CRISTO A INGRATIDÃO DOS HOMENS\n\nVeio para o que era seu e os seus não o receberam. (Jo. 1,11)\n\nEm certo Natal andava São Francisco pela floresta e pelos caminhos gemendo e suspirando, e, ao perguntarem-lhe a causa de sua tristeza, respondeu: \'Como quereis que não chore vendo que o amor não é amado? Vejo Deus inebriado de amor pelos homens e os homens tão ingratos para com esse Deus\'. Se tanto afligia essa ingratidão dos homens a São Francisco, consideremos quanto mais afligirão ao Coração de Jesus. Tão logo foi concebido no seio de Maria viu a cruel correspondência que havia de receber dos homens. Tinha vindo do céu para atear o fogo do amor divino, e esse desejo o tinha feito descer à terra e sofrer um abismo de penas e ignomínias: \'Vim trazer o fogo à terra e que quero senão que se ateie?\' (Lc. 12,49). E depois via o abismo de pecados que cometeriam os homens apesar de terem sido testemunhas de tantas provas de seu amor. Esse foi, disse São Bernardino de Sena, o que lhe fez padecer uma dor infinita. Ainda entre nós, quando alguém se Vê tratado ingratamente por outro é uma dor insuportável, pois a ingratidão freqüentemente aflige a alma mais que outra dor ao corpo. Que dor, pois, ocasionaria a Jesus, que era nosso Deus, ver que, por nossa ingratidão, seus benefícios e seu amor seriam pagos com desgostos e injúrias? \'Deram-me males em troca de bens e ódio em troca do amor que eu lhes tinha\'. (Ps. 108,5). E ainda hoje se lamenta Jesus Cristo: \'Fui um estrangeiro para meus irmãos\' (Ps. 68,9), pois vê que não é amado nem conhecido de muitos, como se não lhes tivesse feito bem nenhum nem tivesse sofrido nada por seu amor.\n\nÓ meu Deus, que caso fazemos, mesmo os cristãos, do amor de Jesus Cristo? Apareceu um dia Ele ao Beato Henrique Suso como um peregrino que mendigava de porta em porta, sendo sempre posto fora com injúrias. Quantos são semelhantes àqueles de quem falou Jó: \'Eles diziam a Deus: Retira-te de nós, e julgavam o Onipotente, como se não pudesse fazer nada; sendo que ele cumulou de bens as suas casas\' (Job,22,17). Nós, ainda que no passado nos tenhamos unido a esses ingratos, queremos continuar com nossa ingratidão no futuro? Não, porque não o merece aquele amável Menino que veio do céu padecer e morrer por nós para que o amássemos.\n\nORAÇÃO\nSenhor Jesus, que descestes do céu para que nós vos amássemos, tomando uma vida cheia de trabalho e a morte numa cruz, como pudemos tantas vezes dizer-vos: \'Retirai-vos de nós\', não vos queremos, ó nosso Deus, se não fôsseis bondade infinita nem tivésseis dado a vida para perdoar-nos, não nos atreveríamos a pedir-vos perdão; mas sabemos que Vós mesmo nos quereis dar a paz: \'Convertei-vos a mim, diz o Senhor Deus dos exércitos e eu me voltarei para Vós\' (Zach. 1,3). Vós mesmo, Jesus, que sois o ofendido, intercedeis por nós. Não queremos, pois, ofender-vos ainda uma vez, desconfiados de vossa misericórdia. Arrependemo-nos com toda a alma de vos ter desprezado, meu sumo Bem. Dignai-vos receber-nos em vossa graça pelo sangue derramado por Vós. \'Pai, não sou digno de ser chamado teu filho\' (Lc.15,21). Não, nosso Redentor e Pai, não somos dignos de ser vossos filhos, porque tantas vezes renunciamos ao vosso amor; mas Vós nos tornais dignos com vossos merecimentos. Que só o pensamento da paciência com que suportastes nossos pecados durante tantos anos e das graças que nos concedestes, depois de todas as injúrias que vos fizemos, faça-nos viver ardendo nas chamas de vosso amor. Vinde, pois, Senhor, que não vos expulsaremos mais, vinde habitar nosso pobre coração. Amamo-vos e queremos amar-vos para sempre, e Vós abrasai-nos sempre mais, com a lembrança do amor que nos tivestes.'**
  String get novenaNatalDay7Meditation;

  /// No description provided for @novenaNatalDay8Title.
  ///
  /// In pt, this message translates to:
  /// **'Oitavo Dia - 23 de Dezembro'**
  String get novenaNatalDay8Title;

  /// No description provided for @novenaNatalDay8Meditation.
  ///
  /// In pt, this message translates to:
  /// **'AMOR DE DEUS AOS HOMENS NO NASCIMENTO DE JESUS\n\nPorque apareceu a graça de Deus nosso Salvador a todos os homens, ensinando-nos que renunciando à impiedade... vivamos piedosamente no presente século, aguardando a esperança bem-aventurada e a vinda gloriosa do grande Deus e Salvador Nosso Senhor Jesus Cristo. (Tit. 2, 12-14)\n\nConsideremos que a graça salvadora de Deus que se manifestou a todos os homens foi o profundíssimo amor de Jesus Cristo aos homens. Esse amor, embora tenha sido da parte de Deus sempre idêntico, nem sempre foi igualmente manifesto.\n\nAntes fora prometido muitas profecias e encoberto sob o véu de muitas figuras. Mas, no nascimento do Redentor, deixou-se ver claramente, aparecendo aos homens o Verbo eterno como menino deitado sobre o feno, gemendo e tremendo de frio, começando já assim a satisfazer pelas penas que merecíamos e dando-nos a conhecer o afeto que nos tinha, sacrificando por nós a vida: \'Nisto conhecemos a caridade de Deus, porque Ele deu sua vida por nós\'. Manifestou-se, pois, a graça salvadora de Deus, e manifestou-se a todos os homens. Mas porque não o conheceram todos e ainda hoje há tantos que, podendo, não o conhecem? Porque \'a luz veio ao mundo e os homens amaram mais as trevas que a luz\' (Jo. 3,19). Não o conheceram nem o conhecem porque não querem conhecê-lo e amam mais as trevas do pecado do que a luz da graça. Não pertençamos ao número desses infelizes. Se até aqui temos fechado os olhos à luz, pensando pouco no amor de Jesus Cristo, procuremos, até o fim de nossa vida, ter sempre ante os olhos os sofrimentos e a morte de nosso Redentor, para amar a quem tanto nos amou: \'Aguardando a bem-aventurada esperança e a vinda gloriosa do grande Deus e Salvador Nosso Jesus Cristo\' (Tit. 2,13).\n\nAssim poderemos confiar fundadamente, segundo as divinas promessas, alcançar aquele paraíso que Jesus Cristo nos conquistou com seu sangue. Nesta primeira manifestação vem Jesus Cristo como menino, pobre e desprezado, nascido num estábulo, coberto de pobres panos e reclinado na palha, mas na segunda aparição virá sobre um trono de majestade: \'E verão o Filho do Homem vir sobre as nuvens do céu com grande poder e majestade\' (Mt. 24,30). Feliz naquela hora quem não o tenha odiado ou desprezado.\n\nORAÇÃO\nOh, Santo Menino, agora vos contemplamos sobre a palha, pobre, aflito e abandonado; mas sabemos que vireis um dia para julgar-nos sobre esplendoroso trono, rodeado de anjos. Perdoai-nos antes de julgar-nos. Então sereis um juiz rigoroso, mas agora sois nosso Redentor e nosso Pai misericordioso. Ingratos fomos, não vos conhecendo por não querer conhecer-vos, e em vez de pensar em amar-vos, considerando o amor que nos tivestes, só pensamos em satisfazer nosso apetite, desprezando vossa graça e vosso amor. Em vossas mãos pomos nossa alma, que tantas vezes nos esforçamos por perder, para que Vós as salveis. \'Em tuas mãos entrego meu espírito: tu me livrarás. Senhor, Deus de Verdade\' (Ps. 30,6). Em Vós deposito minhas esperanças, pois seis que, para resgatar-me do inferno, destes sangue e vida. Tu me livrarás, Senhor, Deus de Verdade. Não me fizestes morrer quando eu estava em pecado e me esperastes com tanta paciência para que, entrando em mim, me arrependesse de vos ter ofendido, começasse a amar-vos e assim pudésseis perdoar-me e salvar-me. Sim, meu Jesus, quero agradar-vos; arrependo-me de todo o mal e desgosto que vos tenho causado. Salvai-me por vossa misericórdia e seja minha salvação amar-vos sempre nesta vida e por toda a eternidade.\nMinha amada Mãe, recomendai-me a vosso Filho, fazei-o ver que sou servo vosso e que em Vós pus minha esperança, pois Ele vos ouve e não vos nega nada.'**
  String get novenaNatalDay8Meditation;

  /// No description provided for @novenaNatalDay9Title.
  ///
  /// In pt, this message translates to:
  /// **'Nono Dia - 24 de Dezembro'**
  String get novenaNatalDay9Title;

  /// No description provided for @novenaNatalDay9Meditation.
  ///
  /// In pt, this message translates to:
  /// **'VIAGEM DE SÃO JOSÉ E MARIA SANTÍSSIMA A BELÉM\n\nSubiu também José para inscrever-se no censo com Maria, sua esposa, que estava prestes a dar à luz. (Lc. 2,5)\n\nTinha Deus decretado que seu Filho nascesse nem sequer na casa de José, mas numa gruta, num estábulo, do modo mais pobre e penoso que possa nascer uma criança; já para isso dispôs que César Augusto publicasse um édito no qual ordenava que fossem todos recensear-se em sua cidade natal. José, ao ter notícia dessa ordem, certamente hesitou sobre deixar ou levar consigo Maria Santíssima, próxima de dar à luz, uma vez que não tinha riqueza para proporcionar-lhe uma viagem conveniente, nem queria, por outro lado, deixá-la sozinha e sem amparo.\n\nSabia, contudo, Maria que, como anunciara o profeta Miquéias, devia o Salvador nascer em Belém; por isso, tomando os panos e roupas que preparara para seu Filho, partiu Ela com José, pobremente, em tempo de inverno, prestes a dar à luz, para submeter-se à vontade de Deus.\n\nUna-nos a eles, e através das penas e dores da nossa viagem por esta vida, louvemos a Deus, sejamos-lhe gratos, pedindo-lhe apenas que esteja sempre conosco Nosso Senhor Jesus Cristo.\n\nPeçamos a José e a Maria que pelo mérito das penas padecidas em sua viagem, nos acompanhem na viagem que estamos fazendo para a eternidade.\n\nORAÇÃO\nMeu amado Redentor, acompanhado na terra apenas por José e Maria, ao ir a Belém, permiti-me que vos acompanhe também eu, Vós descestes do céu para ser meu companheiro na terra, e eu tantas vezes já vos abandonei ofendendo-vos ingratamente. Quando penso que, tantas vezes, para seguir minhas malditas inclinações, separei-me de Vós, renunciando a vossa amizade, quisera morrer de dor. Vós viestes para perdoar-me; assim, pois, perdoai-me imediatamente, pois com toda a alma me arrependo de vos ter dado tantas vezes as costas e abandonado. Proponho e espero, com vossa graça, não vos deixar mais nem separar-me mais de Vós. Uni-me, estreitai-me com os suaves laços de vosso santo amor, meu Redentor e meu Deus.\nMaria Santíssima, venho acompanhar-vos em vossa viagem; não deixeis de assistir-me na que estou fazendo para a eternidade. Assisti-me sempre e, especialmente, quando me achar no fim de minha vida, próximo ao instante de que depende estar sempre convosco para amar a Jesus no paraíso, ou estar sempre longe de vós, para odiar a Jesus no inferno. Minha Rainha, salvai-me por vossa intercessão, e seja a minha salvação amar-vos, a vós e a Jesus, para sempre, no tempo e na eternidade. Sois minha esperança; em vós confio.'**
  String get novenaNatalDay9Meditation;

  /// No description provided for @novenaTemplateTitle.
  ///
  /// In pt, this message translates to:
  /// **'[TEMPLATE] Nome da Novena'**
  String get novenaTemplateTitle;

  /// No description provided for @novenaTemplateDesc.
  ///
  /// In pt, this message translates to:
  /// **'Descrição breve da novena'**
  String get novenaTemplateDesc;

  /// No description provided for @novenaTemplateOpening.
  ///
  /// In pt, this message translates to:
  /// **'Oração inicial da novena. Esta oração é rezada no início de cada dia.'**
  String get novenaTemplateOpening;

  /// No description provided for @novenaTemplateClosing.
  ///
  /// In pt, this message translates to:
  /// **'Oração final da novena. Esta oração é rezada ao final de cada dia. (Deixe vazio se não houver)'**
  String get novenaTemplateClosing;

  /// No description provided for @novenaTemplatePrayers.
  ///
  /// In pt, this message translates to:
  /// **'Instruções de orações (ex: Pai-nosso, Ave-Maria e Glória).'**
  String get novenaTemplatePrayers;

  /// No description provided for @novenaTemplateDay1Title.
  ///
  /// In pt, this message translates to:
  /// **'Título do Dia 1'**
  String get novenaTemplateDay1Title;

  /// No description provided for @novenaTemplateDay1Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Meditação do Dia 1. Texto completo da reflexão deste dia.'**
  String get novenaTemplateDay1Meditation;

  /// No description provided for @novenaTemplateDay2Title.
  ///
  /// In pt, this message translates to:
  /// **'Título do Dia 2'**
  String get novenaTemplateDay2Title;

  /// No description provided for @novenaTemplateDay2Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Meditação do Dia 2. Texto completo da reflexão deste dia.'**
  String get novenaTemplateDay2Meditation;

  /// No description provided for @novenaTemplateDay3Title.
  ///
  /// In pt, this message translates to:
  /// **'Título do Dia 3'**
  String get novenaTemplateDay3Title;

  /// No description provided for @novenaTemplateDay3Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Meditação do Dia 3. Texto completo da reflexão deste dia.'**
  String get novenaTemplateDay3Meditation;

  /// No description provided for @novenaTemplateDay4Title.
  ///
  /// In pt, this message translates to:
  /// **'Título do Dia 4'**
  String get novenaTemplateDay4Title;

  /// No description provided for @novenaTemplateDay4Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Meditação do Dia 4. Texto completo da reflexão deste dia.'**
  String get novenaTemplateDay4Meditation;

  /// No description provided for @novenaTemplateDay5Title.
  ///
  /// In pt, this message translates to:
  /// **'Título do Dia 5'**
  String get novenaTemplateDay5Title;

  /// No description provided for @novenaTemplateDay5Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Meditação do Dia 5. Texto completo da reflexão deste dia.'**
  String get novenaTemplateDay5Meditation;

  /// No description provided for @novenaTemplateDay6Title.
  ///
  /// In pt, this message translates to:
  /// **'Título do Dia 6'**
  String get novenaTemplateDay6Title;

  /// No description provided for @novenaTemplateDay6Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Meditação do Dia 6. Texto completo da reflexão deste dia.'**
  String get novenaTemplateDay6Meditation;

  /// No description provided for @novenaTemplateDay7Title.
  ///
  /// In pt, this message translates to:
  /// **'Título do Dia 7'**
  String get novenaTemplateDay7Title;

  /// No description provided for @novenaTemplateDay7Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Meditação do Dia 7. Texto completo da reflexão deste dia.'**
  String get novenaTemplateDay7Meditation;

  /// No description provided for @novenaTemplateDay8Title.
  ///
  /// In pt, this message translates to:
  /// **'Título do Dia 8'**
  String get novenaTemplateDay8Title;

  /// No description provided for @novenaTemplateDay8Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Meditação do Dia 8. Texto completo da reflexão deste dia.'**
  String get novenaTemplateDay8Meditation;

  /// No description provided for @novenaTemplateDay9Title.
  ///
  /// In pt, this message translates to:
  /// **'Título do Dia 9'**
  String get novenaTemplateDay9Title;

  /// No description provided for @novenaTemplateDay9Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Meditação do Dia 9. Texto completo da reflexão deste dia.'**
  String get novenaTemplateDay9Meditation;

  /// Title for the Daily Prayers section
  ///
  /// In pt, this message translates to:
  /// **'Orações Diárias'**
  String get dailyPrayersTitle;

  /// Title for the Weekly Commitments section
  ///
  /// In pt, this message translates to:
  /// **'Compromissos Semanais'**
  String get weeklyCommitmentsTitle;

  /// Title for the History section
  ///
  /// In pt, this message translates to:
  /// **'Calendário'**
  String get historyTitle;

  /// Sunday Mass commitment
  ///
  /// In pt, this message translates to:
  /// **'Missa Dominical'**
  String get sundayMass;

  /// Confession commitment
  ///
  /// In pt, this message translates to:
  /// **'Confissão'**
  String get confession;

  /// Fasting commitment
  ///
  /// In pt, this message translates to:
  /// **'Jejum / Abstinência'**
  String get fasting;

  /// Eucharistic Adoration commitment
  ///
  /// In pt, this message translates to:
  /// **'Adoração Eucarística'**
  String get adoration;

  /// Status completed
  ///
  /// In pt, this message translates to:
  /// **'Concluído'**
  String get completed;

  /// Status pending
  ///
  /// In pt, this message translates to:
  /// **'Pendente'**
  String get pending;

  /// Title for add prayer dialog
  ///
  /// In pt, this message translates to:
  /// **'Adicionar Oração'**
  String get addPrayerTitle;

  /// Hint for prayer name input
  ///
  /// In pt, this message translates to:
  /// **'Nome da oração'**
  String get prayerNameHint;

  /// Add button label
  ///
  /// In pt, this message translates to:
  /// **'Adicionar'**
  String get addButton;

  /// Title for delete confirmation
  ///
  /// In pt, this message translates to:
  /// **'Confirmar exclusão'**
  String get confirmDeleteTitle;

  /// Message for delete confirmation
  ///
  /// In pt, this message translates to:
  /// **'Deseja remover esta oração do seu plano?'**
  String get confirmDeleteMessage;

  /// Message when no events for the day
  ///
  /// In pt, this message translates to:
  /// **'Nenhum evento registrado.'**
  String get noEventsForDay;

  /// Title for completed confession event
  ///
  /// In pt, this message translates to:
  /// **'Confissão Realizada'**
  String get confessionCompletedTitle;

  /// No description provided for @cancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get save;

  /// No description provided for @defaultTimeLabel.
  ///
  /// In pt, this message translates to:
  /// **'Horário Padrão'**
  String get defaultTimeLabel;

  /// No description provided for @reminderActive.
  ///
  /// In pt, this message translates to:
  /// **'Lembrete Ativo'**
  String get reminderActive;

  /// No description provided for @reminderTimeLabel.
  ///
  /// In pt, this message translates to:
  /// **'Horário'**
  String get reminderTimeLabel;

  /// No description provided for @selectTime.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar horário'**
  String get selectTime;

  /// No description provided for @frequencyLabel.
  ///
  /// In pt, this message translates to:
  /// **'Frequência'**
  String get frequencyLabel;

  /// No description provided for @frequencyOnce.
  ///
  /// In pt, this message translates to:
  /// **'Apenas hoje'**
  String get frequencyOnce;

  /// No description provided for @frequencyDaily.
  ///
  /// In pt, this message translates to:
  /// **'Diariamente'**
  String get frequencyDaily;

  /// No description provided for @frequencyWeekly.
  ///
  /// In pt, this message translates to:
  /// **'Semanalmente'**
  String get frequencyWeekly;

  /// No description provided for @frequencyBiweekly.
  ///
  /// In pt, this message translates to:
  /// **'Quinzenalmente'**
  String get frequencyBiweekly;

  /// No description provided for @frequencyMonthly.
  ///
  /// In pt, this message translates to:
  /// **'Mensalmente'**
  String get frequencyMonthly;

  /// No description provided for @prayerUpdatedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'{prayerName} atualizada com sucesso!'**
  String prayerUpdatedSuccess(String prayerName);

  /// No description provided for @confessionReminderEnabled.
  ///
  /// In pt, this message translates to:
  /// **'Ativar lembrete'**
  String get confessionReminderEnabled;

  /// No description provided for @confessionReminderDaysBefore.
  ///
  /// In pt, this message translates to:
  /// **'Lembrar'**
  String get confessionReminderDaysBefore;

  /// No description provided for @confessionReminder1Day.
  ///
  /// In pt, this message translates to:
  /// **'1 dia antes'**
  String get confessionReminder1Day;

  /// No description provided for @confessionReminder2Days.
  ///
  /// In pt, this message translates to:
  /// **'2 dias antes'**
  String get confessionReminder2Days;

  /// No description provided for @confessionReminder3Days.
  ///
  /// In pt, this message translates to:
  /// **'3 dias antes'**
  String get confessionReminder3Days;

  /// No description provided for @confessionReminder1Week.
  ///
  /// In pt, this message translates to:
  /// **'1 Semana'**
  String get confessionReminder1Week;

  /// No description provided for @confessionReminderTime.
  ///
  /// In pt, this message translates to:
  /// **'Horário'**
  String get confessionReminderTime;

  /// No description provided for @confessionReminderSaved.
  ///
  /// In pt, this message translates to:
  /// **'Lembrete de confissão configurado!'**
  String get confessionReminderSaved;

  /// No description provided for @confessionReminderCanceled.
  ///
  /// In pt, this message translates to:
  /// **'Lembrete de confissão cancelado.'**
  String get confessionReminderCanceled;

  /// No description provided for @confessionReminderNotificationTitle.
  ///
  /// In pt, this message translates to:
  /// **'Lembrete: Confissão'**
  String get confessionReminderNotificationTitle;

  /// No description provided for @confessionReminderNotificationBody.
  ///
  /// In pt, this message translates to:
  /// **'Sua confissão está marcada para {date}.'**
  String confessionReminderNotificationBody(String date);

  /// No description provided for @nextConfessionScheduled.
  ///
  /// In pt, this message translates to:
  /// **'Próxima Confissão Agendada'**
  String get nextConfessionScheduled;

  /// No description provided for @scheduleDialogTitle.
  ///
  /// In pt, this message translates to:
  /// **'Agendar \"{title}\"'**
  String scheduleDialogTitle(String title);

  /// No description provided for @scheduleDialogQuestion.
  ///
  /// In pt, this message translates to:
  /// **'Deseja definir um horário para lembrete?'**
  String get scheduleDialogQuestion;

  /// No description provided for @reminderTypeLabel.
  ///
  /// In pt, this message translates to:
  /// **'Tipo de Lembrete'**
  String get reminderTypeLabel;

  /// No description provided for @selectPrayer.
  ///
  /// In pt, this message translates to:
  /// **'Selecione uma oração'**
  String get selectPrayer;

  /// No description provided for @selectNovena.
  ///
  /// In pt, this message translates to:
  /// **'Selecione uma novena'**
  String get selectNovena;

  /// No description provided for @selectMystery.
  ///
  /// In pt, this message translates to:
  /// **'Selecione um mistério'**
  String get selectMystery;

  /// No description provided for @selectTypeLabel.
  ///
  /// In pt, this message translates to:
  /// **'Selecione o tipo'**
  String get selectTypeLabel;

  /// No description provided for @choosePrayerLabel.
  ///
  /// In pt, this message translates to:
  /// **'Escolha a Oração'**
  String get choosePrayerLabel;

  /// No description provided for @chooseNovenaLabel.
  ///
  /// In pt, this message translates to:
  /// **'Escolha a Novena'**
  String get chooseNovenaLabel;

  /// No description provided for @chooseMysteryLabel.
  ///
  /// In pt, this message translates to:
  /// **'Escolha o Mistério'**
  String get chooseMysteryLabel;

  /// No description provided for @chooseExamTypeLabel.
  ///
  /// In pt, this message translates to:
  /// **'Tipo de Exame'**
  String get chooseExamTypeLabel;

  /// No description provided for @timesLabel.
  ///
  /// In pt, this message translates to:
  /// **'Horários'**
  String get timesLabel;

  /// No description provided for @addTimeButton.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar Horário'**
  String get addTimeButton;

  /// No description provided for @everyLabel.
  ///
  /// In pt, this message translates to:
  /// **'A cada'**
  String get everyLabel;

  /// No description provided for @weekdaysLabel.
  ///
  /// In pt, this message translates to:
  /// **'Dias da Semana'**
  String get weekdaysLabel;

  /// No description provided for @dayOfMonthLabel.
  ///
  /// In pt, this message translates to:
  /// **'Dia do Mês'**
  String get dayOfMonthLabel;

  /// No description provided for @titleLabel.
  ///
  /// In pt, this message translates to:
  /// **'Título'**
  String get titleLabel;

  /// No description provided for @validationSelectWeekday.
  ///
  /// In pt, this message translates to:
  /// **'Selecione pelo menos um dia da semana'**
  String get validationSelectWeekday;

  /// No description provided for @validationSelectDayOfMonth.
  ///
  /// In pt, this message translates to:
  /// **'Selecione um dia do mês'**
  String get validationSelectDayOfMonth;

  /// No description provided for @dayNumberLabel.
  ///
  /// In pt, this message translates to:
  /// **'Dia {day}'**
  String dayNumberLabel(int day);

  /// No description provided for @editButton.
  ///
  /// In pt, this message translates to:
  /// **'Editar'**
  String get editButton;

  /// No description provided for @removeReminderTitle.
  ///
  /// In pt, this message translates to:
  /// **'Remover Lembrete'**
  String get removeReminderTitle;

  /// No description provided for @removeReminderContent.
  ///
  /// In pt, this message translates to:
  /// **'Deseja remover o lembrete \"{title}\"?'**
  String removeReminderContent(String title);

  /// No description provided for @reminderUpdatedMessage.
  ///
  /// In pt, this message translates to:
  /// **'Lembrete \"{title}\" atualizado!'**
  String reminderUpdatedMessage(String title);

  /// No description provided for @reminderRemovedMessage.
  ///
  /// In pt, this message translates to:
  /// **'Lembrete \"{title}\" removido!'**
  String reminderRemovedMessage(String title);

  /// No description provided for @reminderCreatedMessage.
  ///
  /// In pt, this message translates to:
  /// **'Lembrete \"{title}\" criado!'**
  String reminderCreatedMessage(String title);

  /// No description provided for @removePrayerTitle.
  ///
  /// In pt, this message translates to:
  /// **'Remover do plano?'**
  String get removePrayerTitle;

  /// No description provided for @removePrayerContent.
  ///
  /// In pt, this message translates to:
  /// **'Deseja remover \"{title}\" do seu plano de oração?'**
  String removePrayerContent(String title);

  /// No description provided for @prayerRemovedMessage.
  ///
  /// In pt, this message translates to:
  /// **'{title} removida do plano'**
  String prayerRemovedMessage(String title);

  /// No description provided for @editPrayerTitle.
  ///
  /// In pt, this message translates to:
  /// **'Editar \"{title}\"'**
  String editPrayerTitle(String title);

  /// No description provided for @prayerLevelLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nível de Oração'**
  String get prayerLevelLabel;

  /// No description provided for @currentLevelLabel.
  ///
  /// In pt, this message translates to:
  /// **'Atual: Nível {level}'**
  String currentLevelLabel(int level);

  /// No description provided for @activePrayersLabel.
  ///
  /// In pt, this message translates to:
  /// **'Orações Ativas'**
  String get activePrayersLabel;

  /// No description provided for @noPrayersConfigured.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma oração configurada.'**
  String get noPrayersConfigured;

  /// No description provided for @confessionRegisteredMessage.
  ///
  /// In pt, this message translates to:
  /// **'Confissão registrada!'**
  String get confessionRegisteredMessage;

  /// No description provided for @confessionScheduledMessage.
  ///
  /// In pt, this message translates to:
  /// **'Confissão agendada para {date}'**
  String confessionScheduledMessage(String date);

  /// No description provided for @confessionScheduledCard.
  ///
  /// In pt, this message translates to:
  /// **'Confissão Agendada'**
  String get confessionScheduledCard;

  /// No description provided for @confessionTodaySubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Hoje é dia de se confessar!'**
  String get confessionTodaySubtitle;

  /// No description provided for @novenaInProgressCard.
  ///
  /// In pt, this message translates to:
  /// **'Novena em Andamento'**
  String get novenaInProgressCard;

  /// No description provided for @novenaDayProgress.
  ///
  /// In pt, this message translates to:
  /// **'Dia {day} de {total}'**
  String novenaDayProgress(int day, int total);

  /// No description provided for @finishPrayerButton.
  ///
  /// In pt, this message translates to:
  /// **'Finalizar Oração'**
  String get finishPrayerButton;

  /// No description provided for @prayerRegisteredMessage.
  ///
  /// In pt, this message translates to:
  /// **'Oração \"{title}\" registrada!'**
  String prayerRegisteredMessage(String title);

  /// No description provided for @prayerLoggedMessage.
  ///
  /// In pt, this message translates to:
  /// **'{title} registrada em {date}!'**
  String prayerLoggedMessage(String title, String date);

  /// No description provided for @prayerAlreadyInPlanMessage.
  ///
  /// In pt, this message translates to:
  /// **'{title} já está no seu plano!'**
  String prayerAlreadyInPlanMessage(String title);

  /// No description provided for @prayerAddedToPlanMessage.
  ///
  /// In pt, this message translates to:
  /// **'{title} adicionada ao plano!'**
  String prayerAddedToPlanMessage(String title);

  /// No description provided for @heatmapPrayersLabel.
  ///
  /// In pt, this message translates to:
  /// **'orações'**
  String get heatmapPrayersLabel;

  /// No description provided for @heatmapRosaryLabel.
  ///
  /// In pt, this message translates to:
  /// **'Terço'**
  String get heatmapRosaryLabel;

  /// No description provided for @heatmapConfessionLabel.
  ///
  /// In pt, this message translates to:
  /// **'Confissão'**
  String get heatmapConfessionLabel;

  /// No description provided for @heatmapNovenaLabel.
  ///
  /// In pt, this message translates to:
  /// **'Novena'**
  String get heatmapNovenaLabel;

  /// No description provided for @threeHailMarysTitle.
  ///
  /// In pt, this message translates to:
  /// **'3 Ave-Marias'**
  String get threeHailMarysTitle;

  /// No description provided for @threeHailMarysContent.
  ///
  /// In pt, this message translates to:
  /// **'Maria, Mãe de Jesus e minha Mãe, defendei-me do Maligno em vida e na hora da morte, pelo Poder que vos concedeu o Pai Eterno. Ave Maria... Pela Sabedoria que vos concedeu o Filho. Ave Maria... Pelo Amor que vos concedeu o Espírito Santo. Ave Maria...'**
  String get threeHailMarysContent;

  /// No description provided for @examDailyLabel.
  ///
  /// In pt, this message translates to:
  /// **'Exame Diário'**
  String get examDailyLabel;

  /// No description provided for @confirm.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar'**
  String get confirm;

  /// No description provided for @mysteryTodayTitle.
  ///
  /// In pt, this message translates to:
  /// **'Mistério do Dia'**
  String get mysteryTodayTitle;

  /// No description provided for @mysteryJoyfulDaysLuminous.
  ///
  /// In pt, this message translates to:
  /// **'Segunda e Sábado'**
  String get mysteryJoyfulDaysLuminous;

  /// No description provided for @mysteryGloriousDaysLuminous.
  ///
  /// In pt, this message translates to:
  /// **'Quarta e Domingo'**
  String get mysteryGloriousDaysLuminous;

  /// No description provided for @feastMaryMotherOfGod.
  ///
  /// In pt, this message translates to:
  /// **'Santa Maria, Mãe de Deus'**
  String get feastMaryMotherOfGod;

  /// No description provided for @feastHolyNameJesus.
  ///
  /// In pt, this message translates to:
  /// **'Santíssimo Nome de Jesus'**
  String get feastHolyNameJesus;

  /// No description provided for @feastEpiphany.
  ///
  /// In pt, this message translates to:
  /// **'Epifania do Senhor'**
  String get feastEpiphany;

  /// No description provided for @feastConversionPaul.
  ///
  /// In pt, this message translates to:
  /// **'Conversão de São Paulo'**
  String get feastConversionPaul;

  /// No description provided for @feastTimothyTitus.
  ///
  /// In pt, this message translates to:
  /// **'São Timóteo e São Tito'**
  String get feastTimothyTitus;

  /// No description provided for @feastThomasAquinas.
  ///
  /// In pt, this message translates to:
  /// **'São Tomás de Aquino'**
  String get feastThomasAquinas;

  /// No description provided for @feastJohnBosco.
  ///
  /// In pt, this message translates to:
  /// **'São João Bosco'**
  String get feastJohnBosco;

  /// No description provided for @feastPresentationLord.
  ///
  /// In pt, this message translates to:
  /// **'Apresentação do Senhor'**
  String get feastPresentationLord;

  /// No description provided for @feastLadyLourdes.
  ///
  /// In pt, this message translates to:
  /// **'Nossa Senhora de Lourdes'**
  String get feastLadyLourdes;

  /// No description provided for @feastChairPeter.
  ///
  /// In pt, this message translates to:
  /// **'Cátedra de São Pedro'**
  String get feastChairPeter;

  /// No description provided for @feastJosephHusband.
  ///
  /// In pt, this message translates to:
  /// **'São José, Esposo de Maria'**
  String get feastJosephHusband;

  /// No description provided for @feastAnnunciation.
  ///
  /// In pt, this message translates to:
  /// **'Anunciação do Senhor'**
  String get feastAnnunciation;

  /// No description provided for @feastMarkEvangelist.
  ///
  /// In pt, this message translates to:
  /// **'São Marcos, Evangelista'**
  String get feastMarkEvangelist;

  /// No description provided for @feastJosephWorker.
  ///
  /// In pt, this message translates to:
  /// **'São José Operário'**
  String get feastJosephWorker;

  /// No description provided for @feastPhilipJames.
  ///
  /// In pt, this message translates to:
  /// **'São Filipe e São Tiago'**
  String get feastPhilipJames;

  /// No description provided for @feastLadyFatima.
  ///
  /// In pt, this message translates to:
  /// **'Nossa Senhora de Fátima'**
  String get feastLadyFatima;

  /// No description provided for @feastVisitation.
  ///
  /// In pt, this message translates to:
  /// **'Visitação de Nossa Senhora'**
  String get feastVisitation;

  /// No description provided for @feastJustin.
  ///
  /// In pt, this message translates to:
  /// **'São Justino'**
  String get feastJustin;

  /// No description provided for @feastAnthonyPadua.
  ///
  /// In pt, this message translates to:
  /// **'Santo Antônio de Pádua'**
  String get feastAnthonyPadua;

  /// No description provided for @feastBirthJohnBaptist.
  ///
  /// In pt, this message translates to:
  /// **'Nascimento de São João Batista'**
  String get feastBirthJohnBaptist;

  /// No description provided for @feastPeterPaul.
  ///
  /// In pt, this message translates to:
  /// **'São Pedro e São Paulo'**
  String get feastPeterPaul;

  /// No description provided for @feastThomasApostle.
  ///
  /// In pt, this message translates to:
  /// **'São Tomé, Apóstolo'**
  String get feastThomasApostle;

  /// No description provided for @feastBenedict.
  ///
  /// In pt, this message translates to:
  /// **'São Bento'**
  String get feastBenedict;

  /// No description provided for @feastMaryMagdalene.
  ///
  /// In pt, this message translates to:
  /// **'Santa Maria Madalena'**
  String get feastMaryMagdalene;

  /// No description provided for @feastJamesApostle.
  ///
  /// In pt, this message translates to:
  /// **'São Tiago Maior'**
  String get feastJamesApostle;

  /// No description provided for @feastJoachimAnne.
  ///
  /// In pt, this message translates to:
  /// **'São Joaquim e Santa Ana'**
  String get feastJoachimAnne;

  /// No description provided for @feastMarthaMaryLazarus.
  ///
  /// In pt, this message translates to:
  /// **'Santa Marta, Maria e Lázaro'**
  String get feastMarthaMaryLazarus;

  /// No description provided for @feastIgnatiusLoyola.
  ///
  /// In pt, this message translates to:
  /// **'Santo Inácio de Loyola'**
  String get feastIgnatiusLoyola;

  /// No description provided for @feastJohnVianney.
  ///
  /// In pt, this message translates to:
  /// **'São João Maria Vianney'**
  String get feastJohnVianney;

  /// No description provided for @feastTransfiguration.
  ///
  /// In pt, this message translates to:
  /// **'Transfiguração do Senhor'**
  String get feastTransfiguration;

  /// No description provided for @feastDominic.
  ///
  /// In pt, this message translates to:
  /// **'São Domingos'**
  String get feastDominic;

  /// No description provided for @feastLawrence.
  ///
  /// In pt, this message translates to:
  /// **'São Lourenço'**
  String get feastLawrence;

  /// No description provided for @feastClare.
  ///
  /// In pt, this message translates to:
  /// **'Santa Clara'**
  String get feastClare;

  /// No description provided for @feastMaximilianKolbe.
  ///
  /// In pt, this message translates to:
  /// **'São Maximiliano Kolbe'**
  String get feastMaximilianKolbe;

  /// No description provided for @feastAssumption.
  ///
  /// In pt, this message translates to:
  /// **'Assunção de Nossa Senhora'**
  String get feastAssumption;

  /// No description provided for @feastBartholomew.
  ///
  /// In pt, this message translates to:
  /// **'São Bartolomeu, Apóstolo'**
  String get feastBartholomew;

  /// No description provided for @feastMonica.
  ///
  /// In pt, this message translates to:
  /// **'Santa Mônica'**
  String get feastMonica;

  /// No description provided for @feastAugustine.
  ///
  /// In pt, this message translates to:
  /// **'Santo Agostinho'**
  String get feastAugustine;

  /// No description provided for @feastPassionJohnBaptist.
  ///
  /// In pt, this message translates to:
  /// **'Martírio de São João Batista'**
  String get feastPassionJohnBaptist;

  /// No description provided for @feastNativityMary.
  ///
  /// In pt, this message translates to:
  /// **'Natividade de Nossa Senhora'**
  String get feastNativityMary;

  /// No description provided for @feastExaltationCross.
  ///
  /// In pt, this message translates to:
  /// **'Exaltação da Santa Cruz'**
  String get feastExaltationCross;

  /// No description provided for @feastLadySorrows.
  ///
  /// In pt, this message translates to:
  /// **'Nossa Senhora das Dores'**
  String get feastLadySorrows;

  /// No description provided for @feastMatthewApostle.
  ///
  /// In pt, this message translates to:
  /// **'São Mateus, Apóstolo'**
  String get feastMatthewApostle;

  /// No description provided for @feastPadrePio.
  ///
  /// In pt, this message translates to:
  /// **'São Padre Pio'**
  String get feastPadrePio;

  /// No description provided for @feastVincentPaul.
  ///
  /// In pt, this message translates to:
  /// **'São Vicente de Paulo'**
  String get feastVincentPaul;

  /// No description provided for @feastArchangels.
  ///
  /// In pt, this message translates to:
  /// **'Arcanjos Miguel, Gabriel e Rafael'**
  String get feastArchangels;

  /// No description provided for @feastJerome.
  ///
  /// In pt, this message translates to:
  /// **'São Jerônimo'**
  String get feastJerome;

  /// No description provided for @feastThereseLisieux.
  ///
  /// In pt, this message translates to:
  /// **'Santa Teresinha do Menino Jesus'**
  String get feastThereseLisieux;

  /// No description provided for @feastGuardianAngels.
  ///
  /// In pt, this message translates to:
  /// **'Santos Anjos da Guarda'**
  String get feastGuardianAngels;

  /// No description provided for @feastFrancisAssisi.
  ///
  /// In pt, this message translates to:
  /// **'São Francisco de Assis'**
  String get feastFrancisAssisi;

  /// No description provided for @feastFaustina.
  ///
  /// In pt, this message translates to:
  /// **'Santa Faustina Kowalska'**
  String get feastFaustina;

  /// No description provided for @feastLadyRosary.
  ///
  /// In pt, this message translates to:
  /// **'Nossa Senhora do Rosário'**
  String get feastLadyRosary;

  /// No description provided for @feastLadyAparecida.
  ///
  /// In pt, this message translates to:
  /// **'Nossa Senhora Aparecida'**
  String get feastLadyAparecida;

  /// No description provided for @feastTeresaAvila.
  ///
  /// In pt, this message translates to:
  /// **'Santa Teresa de Ávila'**
  String get feastTeresaAvila;

  /// No description provided for @feastLukeEvangelist.
  ///
  /// In pt, this message translates to:
  /// **'São Lucas, Evangelista'**
  String get feastLukeEvangelist;

  /// No description provided for @feastJohnPaulII.
  ///
  /// In pt, this message translates to:
  /// **'São João Paulo II'**
  String get feastJohnPaulII;

  /// No description provided for @feastSimonJude.
  ///
  /// In pt, this message translates to:
  /// **'São Simão e São Judas Tadeu'**
  String get feastSimonJude;

  /// No description provided for @feastAllSaints.
  ///
  /// In pt, this message translates to:
  /// **'Todos os Santos'**
  String get feastAllSaints;

  /// No description provided for @feastAllSouls.
  ///
  /// In pt, this message translates to:
  /// **'Fiéis Defuntos'**
  String get feastAllSouls;

  /// No description provided for @feastLateranBasilica.
  ///
  /// In pt, this message translates to:
  /// **'Dedicação da Basílica de Latrão'**
  String get feastLateranBasilica;

  /// No description provided for @feastPresentationMary.
  ///
  /// In pt, this message translates to:
  /// **'Apresentação de Nossa Senhora'**
  String get feastPresentationMary;

  /// No description provided for @feastCecilia.
  ///
  /// In pt, this message translates to:
  /// **'Santa Cecília'**
  String get feastCecilia;

  /// No description provided for @feastAndrewApostle.
  ///
  /// In pt, this message translates to:
  /// **'Santo André, Apóstolo'**
  String get feastAndrewApostle;

  /// No description provided for @feastFrancisXavier.
  ///
  /// In pt, this message translates to:
  /// **'São Francisco Xavier'**
  String get feastFrancisXavier;

  /// No description provided for @feastNicholas.
  ///
  /// In pt, this message translates to:
  /// **'São Nicolau'**
  String get feastNicholas;

  /// No description provided for @feastImmaculateConception.
  ///
  /// In pt, this message translates to:
  /// **'Imaculada Conceição'**
  String get feastImmaculateConception;

  /// No description provided for @feastLadyGuadalupe.
  ///
  /// In pt, this message translates to:
  /// **'Nossa Senhora de Guadalupe'**
  String get feastLadyGuadalupe;

  /// No description provided for @feastLucy.
  ///
  /// In pt, this message translates to:
  /// **'Santa Luzia'**
  String get feastLucy;

  /// No description provided for @feastJohnCross.
  ///
  /// In pt, this message translates to:
  /// **'São João da Cruz'**
  String get feastJohnCross;

  /// No description provided for @feastChristmas.
  ///
  /// In pt, this message translates to:
  /// **'Natal do Senhor'**
  String get feastChristmas;

  /// No description provided for @feastStephen.
  ///
  /// In pt, this message translates to:
  /// **'Santo Estêvão'**
  String get feastStephen;

  /// No description provided for @feastJohnApostle.
  ///
  /// In pt, this message translates to:
  /// **'São João, Apóstolo'**
  String get feastJohnApostle;

  /// No description provided for @feastHolyInnocents.
  ///
  /// In pt, this message translates to:
  /// **'Santos Inocentes'**
  String get feastHolyInnocents;

  /// No description provided for @feastSylvester.
  ///
  /// In pt, this message translates to:
  /// **'São Silvestre'**
  String get feastSylvester;

  /// No description provided for @feastAshWednesday.
  ///
  /// In pt, this message translates to:
  /// **'Quarta-feira de Cinzas'**
  String get feastAshWednesday;

  /// No description provided for @feastPalmSunday.
  ///
  /// In pt, this message translates to:
  /// **'Domingo de Ramos'**
  String get feastPalmSunday;

  /// No description provided for @feastHolyThursday.
  ///
  /// In pt, this message translates to:
  /// **'Quinta-feira Santa'**
  String get feastHolyThursday;

  /// No description provided for @feastGoodFriday.
  ///
  /// In pt, this message translates to:
  /// **'Sexta-feira Santa'**
  String get feastGoodFriday;

  /// No description provided for @feastEaster.
  ///
  /// In pt, this message translates to:
  /// **'Domingo de Páscoa'**
  String get feastEaster;

  /// No description provided for @feastAscension.
  ///
  /// In pt, this message translates to:
  /// **'Ascensão do Senhor'**
  String get feastAscension;

  /// No description provided for @feastPentecost.
  ///
  /// In pt, this message translates to:
  /// **'Pentecostes'**
  String get feastPentecost;

  /// No description provided for @feastTrinitySunday.
  ///
  /// In pt, this message translates to:
  /// **'Santíssima Trindade'**
  String get feastTrinitySunday;

  /// No description provided for @feastCorpusChristi.
  ///
  /// In pt, this message translates to:
  /// **'Corpus Christi'**
  String get feastCorpusChristi;

  /// No description provided for @feastSacredHeart.
  ///
  /// In pt, this message translates to:
  /// **'Sagrado Coração de Jesus'**
  String get feastSacredHeart;

  /// No description provided for @seasonAdvent.
  ///
  /// In pt, this message translates to:
  /// **'Advento'**
  String get seasonAdvent;

  /// No description provided for @seasonChristmas.
  ///
  /// In pt, this message translates to:
  /// **'Natal'**
  String get seasonChristmas;

  /// No description provided for @seasonLent.
  ///
  /// In pt, this message translates to:
  /// **'Quaresma'**
  String get seasonLent;

  /// No description provided for @seasonEaster.
  ///
  /// In pt, this message translates to:
  /// **'Páscoa'**
  String get seasonEaster;

  /// No description provided for @seasonOrdinaryTime.
  ///
  /// In pt, this message translates to:
  /// **'Tempo Comum'**
  String get seasonOrdinaryTime;

  /// No description provided for @tabToday.
  ///
  /// In pt, this message translates to:
  /// **'Hoje'**
  String get tabToday;

  /// No description provided for @tabCalendar.
  ///
  /// In pt, this message translates to:
  /// **'Calendário'**
  String get tabCalendar;

  /// No description provided for @tabReminders.
  ///
  /// In pt, this message translates to:
  /// **'Lembretes'**
  String get tabReminders;

  /// No description provided for @gardenTitle.
  ///
  /// In pt, this message translates to:
  /// **'Jardim da Alma'**
  String get gardenTitle;

  /// No description provided for @gardenSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Cultive sua vida espiritual.'**
  String get gardenSubtitle;

  /// No description provided for @statsToday.
  ///
  /// In pt, this message translates to:
  /// **'Hoje'**
  String get statsToday;

  /// No description provided for @statsThisWeek.
  ///
  /// In pt, this message translates to:
  /// **'Esta Semana'**
  String get statsThisWeek;

  /// No description provided for @catPrayersSpecial.
  ///
  /// In pt, this message translates to:
  /// **'Especiais'**
  String get catPrayersSpecial;

  /// No description provided for @timeDuringDay.
  ///
  /// In pt, this message translates to:
  /// **'Durante o Dia'**
  String get timeDuringDay;

  /// No description provided for @rosaryHailMaryCount.
  ///
  /// In pt, this message translates to:
  /// **'Ave Maria {current}/{total}'**
  String rosaryHailMaryCount(int current, int total);

  /// No description provided for @novenaDayCounter.
  ///
  /// In pt, this message translates to:
  /// **'Dia {day}'**
  String novenaDayCounter(int day);

  /// No description provided for @novenaConfigTitle.
  ///
  /// In pt, this message translates to:
  /// **'Configurar Novena'**
  String get novenaConfigTitle;

  /// No description provided for @novenaConfigStartDate.
  ///
  /// In pt, this message translates to:
  /// **'Quando deseja iniciar?'**
  String get novenaConfigStartDate;

  /// No description provided for @novenaConfigReminder.
  ///
  /// In pt, this message translates to:
  /// **'Lembrete diário (Opcional)'**
  String get novenaConfigReminder;

  /// No description provided for @novenaConfigNoReminder.
  ///
  /// In pt, this message translates to:
  /// **'Sem lembrete'**
  String get novenaConfigNoReminder;

  /// No description provided for @novenaScheduledMessage.
  ///
  /// In pt, this message translates to:
  /// **'Novena agendada para iniciar em:'**
  String get novenaScheduledMessage;

  /// No description provided for @novenaReminderMessage.
  ///
  /// In pt, this message translates to:
  /// **'Lembrete às {time}'**
  String novenaReminderMessage(String time);

  /// No description provided for @historyDayOfObligation.
  ///
  /// In pt, this message translates to:
  /// **'Dia de Preceito'**
  String get historyDayOfObligation;

  /// No description provided for @historyAddPrayer.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar oração neste dia'**
  String get historyAddPrayer;

  /// No description provided for @historyConfessionDone.
  ///
  /// In pt, this message translates to:
  /// **'Confissão Realizada'**
  String get historyConfessionDone;

  /// No description provided for @historyNextConfession.
  ///
  /// In pt, this message translates to:
  /// **'Próxima Confissão'**
  String get historyNextConfession;

  /// No description provided for @historyNextConfessionSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Prepare-se para sua confissão.'**
  String get historyNextConfessionSubtitle;

  /// No description provided for @historyNovena.
  ///
  /// In pt, this message translates to:
  /// **'Novena'**
  String get historyNovena;

  /// No description provided for @historyPrayersForDay.
  ///
  /// In pt, this message translates to:
  /// **'Orações do dia: {count}'**
  String historyPrayersForDay(int count);

  /// No description provided for @historyRemovePrayerTitle.
  ///
  /// In pt, this message translates to:
  /// **'Remover oração?'**
  String get historyRemovePrayerTitle;

  /// No description provided for @historyRemovePrayerContent.
  ///
  /// In pt, this message translates to:
  /// **'Deseja remover \"{title}\" do histórico?'**
  String historyRemovePrayerContent(String title);

  /// No description provided for @historyConfessionHistoryTitle.
  ///
  /// In pt, this message translates to:
  /// **'HISTÓRICO DE CONFISSÕES'**
  String get historyConfessionHistoryTitle;

  /// No description provided for @historyNoConfessions.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma confissão registrada.'**
  String get historyNoConfessions;

  /// No description provided for @historyRemoveConfessionTitle.
  ///
  /// In pt, this message translates to:
  /// **'Remover confissão?'**
  String get historyRemoveConfessionTitle;

  /// No description provided for @historyRemoveConfessionContent.
  ///
  /// In pt, this message translates to:
  /// **'Esta ação não pode ser desfeita.'**
  String get historyRemoveConfessionContent;

  /// No description provided for @remindersAddButton.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar'**
  String get remindersAddButton;

  /// No description provided for @remindersEmptyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Você ainda não criou lembretes'**
  String get remindersEmptyTitle;

  /// No description provided for @remindersEmptySubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Toque em Adicionar para criar o primeiro: de uma oração, de uma novena ou personalizado.'**
  String get remindersEmptySubtitle;

  /// No description provided for @remindersGroupPrayers.
  ///
  /// In pt, this message translates to:
  /// **'ORAÇÕES'**
  String get remindersGroupPrayers;

  /// No description provided for @remindersGroupNovenas.
  ///
  /// In pt, this message translates to:
  /// **'NOVENAS'**
  String get remindersGroupNovenas;

  /// No description provided for @remindersGroupExaminations.
  ///
  /// In pt, this message translates to:
  /// **'EXAMES'**
  String get remindersGroupExaminations;

  /// No description provided for @remindersGroupRosaries.
  ///
  /// In pt, this message translates to:
  /// **'TERÇOS'**
  String get remindersGroupRosaries;

  /// No description provided for @remindersGroupConfession.
  ///
  /// In pt, this message translates to:
  /// **'CONFISSÃO'**
  String get remindersGroupConfession;

  /// No description provided for @remindersGroupOthers.
  ///
  /// In pt, this message translates to:
  /// **'OUTROS'**
  String get remindersGroupOthers;

  /// No description provided for @statsSummary.
  ///
  /// In pt, this message translates to:
  /// **'Resumo'**
  String get statsSummary;

  /// No description provided for @statsActive.
  ///
  /// In pt, this message translates to:
  /// **'{count} ativos'**
  String statsActive(int count);

  /// No description provided for @statsNext.
  ///
  /// In pt, this message translates to:
  /// **'Próximo: '**
  String get statsNext;

  /// No description provided for @statsDefaultTitle.
  ///
  /// In pt, this message translates to:
  /// **'Lembrete'**
  String get statsDefaultTitle;

  /// No description provided for @statsTodayTime.
  ///
  /// In pt, this message translates to:
  /// **'Hoje, {time}'**
  String statsTodayTime(String time);

  /// No description provided for @statsTomorrowTime.
  ///
  /// In pt, this message translates to:
  /// **'Amanhã, {time}'**
  String statsTomorrowTime(String time);

  /// No description provided for @reminderEditTitle.
  ///
  /// In pt, this message translates to:
  /// **'Editar Lembrete'**
  String get reminderEditTitle;

  /// No description provided for @reminderNewTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novo Lembrete'**
  String get reminderNewTitle;

  /// No description provided for @reminderTypePrayer.
  ///
  /// In pt, this message translates to:
  /// **'Oração'**
  String get reminderTypePrayer;

  /// No description provided for @reminderTypeNovena.
  ///
  /// In pt, this message translates to:
  /// **'Novena'**
  String get reminderTypeNovena;

  /// No description provided for @reminderTypeRosary.
  ///
  /// In pt, this message translates to:
  /// **'Terço'**
  String get reminderTypeRosary;

  /// No description provided for @reminderTypeExamination.
  ///
  /// In pt, this message translates to:
  /// **'Exame'**
  String get reminderTypeExamination;

  /// No description provided for @reminderTypeConfession.
  ///
  /// In pt, this message translates to:
  /// **'Confissão'**
  String get reminderTypeConfession;

  /// No description provided for @reminderTypePenance.
  ///
  /// In pt, this message translates to:
  /// **'Penitência'**
  String get reminderTypePenance;

  /// No description provided for @reminderTypeCustom.
  ///
  /// In pt, this message translates to:
  /// **'Personalizado'**
  String get reminderTypeCustom;

  /// No description provided for @reminderTitleLabel.
  ///
  /// In pt, this message translates to:
  /// **'Título'**
  String get reminderTitleLabel;

  /// No description provided for @reminderTitleHint.
  ///
  /// In pt, this message translates to:
  /// **'Digite um título'**
  String get reminderTitleHint;

  /// No description provided for @reminderTitleError.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, digite um título'**
  String get reminderTitleError;

  /// No description provided for @reminderRecurrenceLabel.
  ///
  /// In pt, this message translates to:
  /// **'Repetição'**
  String get reminderRecurrenceLabel;

  /// No description provided for @reminderRecurrenceOnce.
  ///
  /// In pt, this message translates to:
  /// **'Apenas uma vez'**
  String get reminderRecurrenceOnce;

  /// No description provided for @reminderRecurrenceDaily.
  ///
  /// In pt, this message translates to:
  /// **'Diariamente'**
  String get reminderRecurrenceDaily;

  /// No description provided for @reminderRecurrenceWeekly.
  ///
  /// In pt, this message translates to:
  /// **'Semanalmente'**
  String get reminderRecurrenceWeekly;

  /// No description provided for @reminderRecurrenceMonthly.
  ///
  /// In pt, this message translates to:
  /// **'Mensalmente'**
  String get reminderRecurrenceMonthly;

  /// No description provided for @reminderIntervalLabel.
  ///
  /// In pt, this message translates to:
  /// **'Intervalo'**
  String get reminderIntervalLabel;

  /// No description provided for @reminderIntervalDays.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{dia} other{dias}}'**
  String reminderIntervalDays(int count);

  /// No description provided for @reminderIntervalWeeks.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{semana} other{semanas}}'**
  String reminderIntervalWeeks(int count);

  /// No description provided for @reminderIntervalMonths.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{mês} other{meses}}'**
  String reminderIntervalMonths(int count);

  /// No description provided for @reminderWeekDaysLabel.
  ///
  /// In pt, this message translates to:
  /// **'Dias da Semana'**
  String get reminderWeekDaysLabel;

  /// No description provided for @reminderMonthDayLabel.
  ///
  /// In pt, this message translates to:
  /// **'Dia do Mês'**
  String get reminderMonthDayLabel;

  /// No description provided for @reminderMonthDayValue.
  ///
  /// In pt, this message translates to:
  /// **'Dia {day}'**
  String reminderMonthDayValue(int day);

  /// No description provided for @reminderCancelButton.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get reminderCancelButton;

  /// No description provided for @reminderCreateButton.
  ///
  /// In pt, this message translates to:
  /// **'Criar'**
  String get reminderCreateButton;

  /// No description provided for @reminderSaveButton.
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get reminderSaveButton;

  /// No description provided for @reminderDefaultTitlePrayer.
  ///
  /// In pt, this message translates to:
  /// **'Oração'**
  String get reminderDefaultTitlePrayer;

  /// No description provided for @reminderDefaultTitleNovena.
  ///
  /// In pt, this message translates to:
  /// **'Novena'**
  String get reminderDefaultTitleNovena;

  /// No description provided for @reminderDefaultTitleRosary.
  ///
  /// In pt, this message translates to:
  /// **'Santo Terço'**
  String get reminderDefaultTitleRosary;

  /// No description provided for @reminderDefaultTitleExamination.
  ///
  /// In pt, this message translates to:
  /// **'Exame de Consciência'**
  String get reminderDefaultTitleExamination;

  /// No description provided for @reminderDefaultTitleCustom.
  ///
  /// In pt, this message translates to:
  /// **'Lembrete'**
  String get reminderDefaultTitleCustom;

  /// No description provided for @monthDayLabel.
  ///
  /// In pt, this message translates to:
  /// **'Dia do Mês'**
  String get monthDayLabel;

  /// No description provided for @reminderRecurrenceCustom.
  ///
  /// In pt, this message translates to:
  /// **'Personalizado'**
  String get reminderRecurrenceCustom;

  /// No description provided for @reminderFrequencyDailyInterval.
  ///
  /// In pt, this message translates to:
  /// **'A cada {interval} dias'**
  String reminderFrequencyDailyInterval(int interval);

  /// No description provided for @reminderFrequencyWeeklyInterval.
  ///
  /// In pt, this message translates to:
  /// **'A cada {interval} semanas'**
  String reminderFrequencyWeeklyInterval(int interval);

  /// No description provided for @reminderFrequencyMonthly.
  ///
  /// In pt, this message translates to:
  /// **'Dia {day} de cada mês'**
  String reminderFrequencyMonthly(int day);

  /// No description provided for @reminderFrequencyMonthlyInterval.
  ///
  /// In pt, this message translates to:
  /// **'Dia {day} a cada {interval} meses'**
  String reminderFrequencyMonthlyInterval(int day, int interval);

  /// No description provided for @configLanguageTitle.
  ///
  /// In pt, this message translates to:
  /// **'Idioma (Language)'**
  String get configLanguageTitle;

  /// No description provided for @configLanguageDesc.
  ///
  /// In pt, this message translates to:
  /// **'Selecione o idioma do aplicativo (Select application language)'**
  String get configLanguageDesc;

  /// No description provided for @languagePortuguese.
  ///
  /// In pt, this message translates to:
  /// **'Português (Portuguese)'**
  String get languagePortuguese;

  /// No description provided for @languageEnglish.
  ///
  /// In pt, this message translates to:
  /// **'Inglês (English)'**
  String get languageEnglish;

  /// No description provided for @okAction.
  ///
  /// In pt, this message translates to:
  /// **'OK'**
  String get okAction;

  /// No description provided for @contentNotFound.
  ///
  /// In pt, this message translates to:
  /// **'Conteúdo não encontrado.'**
  String get contentNotFound;

  /// No description provided for @rosarySelectMystery.
  ///
  /// In pt, this message translates to:
  /// **'Selecione o Mistério'**
  String get rosarySelectMystery;

  /// No description provided for @rosaryDesc.
  ///
  /// In pt, this message translates to:
  /// **'Contemple os mistérios da vida de Cristo.'**
  String get rosaryDesc;

  /// No description provided for @rosaryTraditionalToggle.
  ///
  /// In pt, this message translates to:
  /// **'Santo Terço - Modo Tradicional'**
  String get rosaryTraditionalToggle;

  /// No description provided for @rosaryTodaysMystery.
  ///
  /// In pt, this message translates to:
  /// **'Mistério de Hoje'**
  String get rosaryTodaysMystery;

  /// No description provided for @rosaryFinish.
  ///
  /// In pt, this message translates to:
  /// **'Finalizar'**
  String get rosaryFinish;

  /// No description provided for @rosaryAutoMysterySubtitle.
  ///
  /// In pt, this message translates to:
  /// **'O mistério será selecionado automaticamente.'**
  String get rosaryAutoMysterySubtitle;

  /// No description provided for @rosarySelectSpecificMystery.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar Mistério Específico'**
  String get rosarySelectSpecificMystery;

  /// No description provided for @frequencyNone.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma'**
  String get frequencyNone;

  /// No description provided for @weeksUnit.
  ///
  /// In pt, this message translates to:
  /// **'semanas'**
  String get weeksUnit;

  /// No description provided for @monthUnit.
  ///
  /// In pt, this message translates to:
  /// **'mês'**
  String get monthUnit;

  /// No description provided for @confessionFrequencyLabel.
  ///
  /// In pt, this message translates to:
  /// **'Frequência (Repetição)'**
  String get confessionFrequencyLabel;

  /// No description provided for @confessionIntervalCustomTitle.
  ///
  /// In pt, this message translates to:
  /// **'Intervalo Personalizado (Dias)'**
  String get confessionIntervalCustomTitle;

  /// No description provided for @confessionIntervalCustomLabel.
  ///
  /// In pt, this message translates to:
  /// **'Dias'**
  String get confessionIntervalCustomLabel;

  /// No description provided for @confessionReminder2Weeks.
  ///
  /// In pt, this message translates to:
  /// **'2 Semanas'**
  String get confessionReminder2Weeks;

  /// No description provided for @confessionReminder3Weeks.
  ///
  /// In pt, this message translates to:
  /// **'3 Semanas'**
  String get confessionReminder3Weeks;

  /// No description provided for @confessionReminder1Month.
  ///
  /// In pt, this message translates to:
  /// **'1 Mês'**
  String get confessionReminder1Month;

  /// No description provided for @confessionReminder2Months.
  ///
  /// In pt, this message translates to:
  /// **'2 Meses'**
  String get confessionReminder2Months;

  /// No description provided for @confessionReminder3Months.
  ///
  /// In pt, this message translates to:
  /// **'3 Meses'**
  String get confessionReminder3Months;

  /// No description provided for @liturgicalCalendarTitle.
  ///
  /// In pt, this message translates to:
  /// **'Calendário Litúrgico'**
  String get liturgicalCalendarTitle;

  /// No description provided for @preceptDayLabel.
  ///
  /// In pt, this message translates to:
  /// **'Dia de Preceito'**
  String get preceptDayLabel;

  /// No description provided for @abstinenceDayLabel.
  ///
  /// In pt, this message translates to:
  /// **'Abstinência de Carne'**
  String get abstinenceDayLabel;

  /// No description provided for @fastingDayLabel.
  ///
  /// In pt, this message translates to:
  /// **'Dia de Jejum'**
  String get fastingDayLabel;

  /// No description provided for @notifyPreceptTitle.
  ///
  /// In pt, this message translates to:
  /// **'Notificar dias de Preceito'**
  String get notifyPreceptTitle;

  /// No description provided for @notifyPreceptSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Domingos e dias santos'**
  String get notifyPreceptSubtitle;

  /// No description provided for @notifyFastingTitle.
  ///
  /// In pt, this message translates to:
  /// **'Notificar dias de Jejum'**
  String get notifyFastingTitle;

  /// No description provided for @notifyFastingSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Quarta-feira de Cinzas e Sexta-feira Santa'**
  String get notifyFastingSubtitle;

  /// No description provided for @notifyAbstinenceTitle.
  ///
  /// In pt, this message translates to:
  /// **'Notificar dias de Abstinência'**
  String get notifyAbstinenceTitle;

  /// No description provided for @notifyAbstinenceSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Todas as sextas-feiras do ano'**
  String get notifyAbstinenceSubtitle;

  /// No description provided for @liturgicalReminderPrecept.
  ///
  /// In pt, this message translates to:
  /// **'Dias de Preceito'**
  String get liturgicalReminderPrecept;

  /// No description provided for @liturgicalReminderFasting.
  ///
  /// In pt, this message translates to:
  /// **'Dias de Jejum'**
  String get liturgicalReminderFasting;

  /// No description provided for @liturgicalReminderAbstinence.
  ///
  /// In pt, this message translates to:
  /// **'Dias de Abstinência'**
  String get liturgicalReminderAbstinence;

  /// No description provided for @notificationPreceptTitle.
  ///
  /// In pt, this message translates to:
  /// **'Dia de Preceito'**
  String get notificationPreceptTitle;

  /// No description provided for @notificationPreceptBody.
  ///
  /// In pt, this message translates to:
  /// **'Hoje é Domingo, dia do Senhor. Não se esqueça da Santa Missa!'**
  String get notificationPreceptBody;

  /// No description provided for @notificationFastingTitle.
  ///
  /// In pt, this message translates to:
  /// **'Dia de Jejum e Abstinência'**
  String get notificationFastingTitle;

  /// No description provided for @notificationFastingBody.
  ///
  /// In pt, this message translates to:
  /// **'Hoje é dia de Jejum e Abstinência de carne.'**
  String get notificationFastingBody;

  /// No description provided for @notificationAbstinenceTitle.
  ///
  /// In pt, this message translates to:
  /// **'Dia de Penitência'**
  String get notificationAbstinenceTitle;

  /// No description provided for @notificationAbstinenceBody.
  ///
  /// In pt, this message translates to:
  /// **'Hoje é Sexta-feira. Dia de abstinência de carne ou obra de piedade.'**
  String get notificationAbstinenceBody;

  /// No description provided for @drawerAbout.
  ///
  /// In pt, this message translates to:
  /// **'Sobre o Projeto'**
  String get drawerAbout;

  /// No description provided for @aboutPageTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sancta Devocionário Católico'**
  String get aboutPageTitle;

  /// No description provided for @donateSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Chave Pix copiada com sucesso!'**
  String get donateSuccess;

  /// No description provided for @drawerSettings.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get drawerSettings;

  /// No description provided for @readMore.
  ///
  /// In pt, this message translates to:
  /// **'Ler mais'**
  String get readMore;

  /// No description provided for @jornadaBannerTitle.
  ///
  /// In pt, this message translates to:
  /// **'Jornada de Confissão'**
  String get jornadaBannerTitle;

  /// No description provided for @jornadaBannerSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Prepare sua alma para o encontro com a Misericórdia'**
  String get jornadaBannerSubtitle;

  /// No description provided for @jornadaQuote1.
  ///
  /// In pt, this message translates to:
  /// **'O padre não é juiz, é pai. Ele está ali para acolher e perdoar em nome de Cristo.'**
  String get jornadaQuote1;

  /// No description provided for @jornadaQuote2.
  ///
  /// In pt, this message translates to:
  /// **'Deus já conhece todos os seus pecados e ainda assim te ama infinitamente.'**
  String get jornadaQuote2;

  /// No description provided for @jornadaQuote3.
  ///
  /// In pt, this message translates to:
  /// **'A confissão é um tribunal de misericórdia, onde quem se declara culpado é perdoado.'**
  String get jornadaQuote3;

  /// No description provided for @jornadaAction.
  ///
  /// In pt, this message translates to:
  /// **'Iniciar Jornada'**
  String get jornadaAction;

  /// No description provided for @novenaTitleNatal.
  ///
  /// In pt, this message translates to:
  /// **'Novena de Natal'**
  String get novenaTitleNatal;

  /// No description provided for @novenaTitleCarloAcutis.
  ///
  /// In pt, this message translates to:
  /// **'Novena a São Carlo Acutis'**
  String get novenaTitleCarloAcutis;

  /// No description provided for @novenaTitleTeresaLisieux.
  ///
  /// In pt, this message translates to:
  /// **'Novena a Santa Teresinha'**
  String get novenaTitleTeresaLisieux;

  /// No description provided for @novenaTitleSagradoCoracao.
  ///
  /// In pt, this message translates to:
  /// **'Novena ao Sagrado Coração de Jesus'**
  String get novenaTitleSagradoCoracao;

  /// No description provided for @novenaTitleConceicao.
  ///
  /// In pt, this message translates to:
  /// **'Novena à Imaculada Conceição'**
  String get novenaTitleConceicao;

  /// No description provided for @prayerLevel1Description.
  ///
  /// In pt, this message translates to:
  /// **'Iniciante: Oração da Manhã, Noite e 3 Ave-Marias'**
  String get prayerLevel1Description;

  /// No description provided for @prayerLevel2Description.
  ///
  /// In pt, this message translates to:
  /// **'Intermediário: + Santo Terço'**
  String get prayerLevel2Description;

  /// No description provided for @prayerLevel3Description.
  ///
  /// In pt, this message translates to:
  /// **'Avançado: + Angelus e Leitura Espiritual'**
  String get prayerLevel3Description;

  /// No description provided for @prayerLevel4Description.
  ///
  /// In pt, this message translates to:
  /// **'Contemplativo: + Exame de Consciência e Meditação'**
  String get prayerLevel4Description;

  /// No description provided for @prayerTimeDescriptionMorning.
  ///
  /// In pt, this message translates to:
  /// **'Manhã'**
  String get prayerTimeDescriptionMorning;

  /// No description provided for @prayerTimeDescriptionNoon.
  ///
  /// In pt, this message translates to:
  /// **'Meio-dia'**
  String get prayerTimeDescriptionNoon;

  /// No description provided for @prayerTimeDescriptionNight.
  ///
  /// In pt, this message translates to:
  /// **'Noite'**
  String get prayerTimeDescriptionNight;

  /// No description provided for @prayerTimeDescriptionAnytime.
  ///
  /// In pt, this message translates to:
  /// **'Durante o dia'**
  String get prayerTimeDescriptionAnytime;

  /// No description provided for @prayerTimeDescriptionDefault.
  ///
  /// In pt, this message translates to:
  /// **'Qualquer hora'**
  String get prayerTimeDescriptionDefault;

  /// No description provided for @activeNovenasTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novenas Ativas'**
  String get activeNovenasTitle;

  /// No description provided for @activeNovenasEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma novena ativa.'**
  String get activeNovenasEmpty;

  /// No description provided for @confessionTitle.
  ///
  /// In pt, this message translates to:
  /// **'Confissão'**
  String get confessionTitle;

  /// No description provided for @confessionNextLabel.
  ///
  /// In pt, this message translates to:
  /// **'Próxima Confissão'**
  String get confessionNextLabel;

  /// No description provided for @confessionNotScheduled.
  ///
  /// In pt, this message translates to:
  /// **'Não agendada'**
  String get confessionNotScheduled;

  /// No description provided for @confessionRegisterLabel.
  ///
  /// In pt, this message translates to:
  /// **'Registrar Confissão'**
  String get confessionRegisterLabel;

  /// No description provided for @confessionRegisterSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Marcar hoje como dia de confissão'**
  String get confessionRegisterSubtitle;

  /// No description provided for @addPrayerToPlanLabel.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar Oração ao Plano'**
  String get addPrayerToPlanLabel;

  /// No description provided for @loginBackLabel.
  ///
  /// In pt, this message translates to:
  /// **'Voltar para login'**
  String get loginBackLabel;

  /// No description provided for @penanceLabel.
  ///
  /// In pt, this message translates to:
  /// **'Penitência'**
  String get penanceLabel;

  /// No description provided for @penanceHint.
  ///
  /// In pt, this message translates to:
  /// **'Ex: Rezar 3 Ave-Marias'**
  String get penanceHint;

  /// No description provided for @penanceOptional.
  ///
  /// In pt, this message translates to:
  /// **'Penitência (opcional)'**
  String get penanceOptional;

  /// No description provided for @novenaSaoJoseTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novena a São José'**
  String get novenaSaoJoseTitle;

  /// No description provided for @novenaSaoJoseDesc.
  ///
  /// In pt, this message translates to:
  /// **'Para alcançar graças e a proteção de São José, pai nutrício de Jesus, esposo da Virgem Maria, chefe da Sagrada Família e padroeiro da Santa Igreja.'**
  String get novenaSaoJoseDesc;

  /// No description provided for @novenaSaoJoseOpening.
  ///
  /// In pt, this message translates to:
  /// **'Ó glorioso São José, pai nutrício de Jesus e castíssimo esposo de Maria, abri vosso coração paternal a nós que recorremos a vós com confiança. Pelo amor que tivestes ao Menino Deus, alcançai-nos as graças que humildemente vos pedimos. Amém.'**
  String get novenaSaoJoseOpening;

  /// No description provided for @novenaSaoJoseClosing.
  ///
  /// In pt, this message translates to:
  /// **'Glorioso São José, que fostes exaltado pelo Eterno Pai, obedecido pelo Verbo Encarnado, favorecido pelo Espírito Santo e amado pela Virgem Maria; louvo e bendigo a Santíssima Trindade pelos privilégios e méritos com que vos enriqueceu. Sois poderosíssimo e jamais se ouviu dizer que alguém tenha recorrido a vós e tenha sido por vós desamparado. Sois o consolador dos aflitos, o amparo dos míseros e o advogado dos pecadores. Acolhei, pois, com bondade paternal a quem vos invoca com filial confiança e alcançai-me as graças que vos peço nesta novena. Eu vos escolho por meu especial protetor. Sede, depois de Jesus e Maria, minha consolação nesta terra, meu refúgio nas desgraças, meu guia nas incertezas, meu conforto nas tribulações, meu pai solícito em todas as necessidades. Obtende-me, finalmente, como coroa dos vossos favores, uma boa e santa morte na graça de Nosso Senhor. Amém.'**
  String get novenaSaoJoseClosing;

  /// No description provided for @novenaSaoJosePrayers.
  ///
  /// In pt, this message translates to:
  /// **'Rezar 1 Pai-Nosso, 1 Ave-Maria e 1 Glória ao Pai.'**
  String get novenaSaoJosePrayers;

  /// No description provided for @novenaSaoJoseDay1Title.
  ///
  /// In pt, this message translates to:
  /// **'1º Dia - São José, Pai Nutrício de Jesus'**
  String get novenaSaoJoseDay1Title;

  /// No description provided for @novenaSaoJoseDay1Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Amabilíssimo São José, que tivestes a honra de alimentar, educar e abraçar o Messias, a quem tantos profetas e reis desejaram ver e não viram, obtende-me, com o perdão das minhas culpas, a graça da oração humilde e confiante que tudo alcança de Deus. Acolhei com bondade paternal os pedidos que vos faço nesta novena e apresentai-os a Jesus, que se dignou obedecer-vos na terra. Amém.\n\nV/. Rogai por nós, São José, pai nutrício de Jesus.\nR/. Para que sejamos dignos das promessas de Cristo.\n\nOremos. Ó Deus, que por uma inefável Providência Vos dignastes escolher o bem-aventurado São José para Esposo de vossa Mãe Santíssima, concedei-nos que aquele mesmo que na terra veneramos como protetor, mereçamos tê-lo no céu por nosso intercessor. Vós que viveis e reinais por todos os séculos dos séculos. Amém.'**
  String get novenaSaoJoseDay1Meditation;

  /// No description provided for @novenaSaoJoseDay2Title.
  ///
  /// In pt, this message translates to:
  /// **'2º Dia - São José, Esposo da Virgem Maria'**
  String get novenaSaoJoseDay2Title;

  /// No description provided for @novenaSaoJoseDay2Meditation.
  ///
  /// In pt, this message translates to:
  /// **'São José, castíssimo Esposo da Mãe de Deus e guarda fiel da sua virgindade, obtende-me, por Maria, a pureza do corpo e da alma e a vitória em todas as tentações e dificuldades. Recomendo-vos também os esposos cristãos, para que, unidos com sincero amor e fortalecidos pela graça, amparem-se mutuamente nos sofrimentos e tribulações da vida. Amém.\n\nV/. Rogai por nós, São José, esposo da Mãe de Deus.\nR/. Para que sejamos dignos das promessas de Cristo.\n\nOremos. Ó Deus, que por uma inefável Providência Vos dignastes escolher o bem-aventurado São José para Esposo de vossa Mãe Santíssima, concedei-nos que aquele mesmo que na terra veneramos como protetor, mereçamos tê-lo no céu por nosso intercessor. Vós que viveis e reinais por todos os séculos dos séculos. Amém.'**
  String get novenaSaoJoseDay2Meditation;

  /// No description provided for @novenaSaoJoseDay3Title.
  ///
  /// In pt, this message translates to:
  /// **'3º Dia - São José, Chefe da Sagrada Família'**
  String get novenaSaoJoseDay3Title;

  /// No description provided for @novenaSaoJoseDay3Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Glorioso São José, que gozastes durante tantos anos da presença e filial afeição de Jesus, a quem tivestes a dita de alimentar e vestir, juntamente com vossa Santíssima Esposa, eu vos suplico me alcanceis o dom inefável de sempre viver em união com Deus pela graça santificante. Obtende também para os pais cristãos a graça do fiel cumprimento de seus graves deveres de educadores e, aos filhos, o respeito e a obediência, segundo o exemplo do Menino Jesus. Amém.\n\nV/. Rogai por nós, São José, chefe da Sagrada Família.\nR/. Para que sejamos dignos das promessas de Cristo.\n\nOremos. Ó Deus, que por uma inefável Providência Vos dignastes escolher o bem-aventurado São José para Esposo de vossa Mãe Santíssima, concedei-nos que aquele mesmo que na terra veneramos como protetor, mereçamos tê-lo no céu por nosso intercessor. Vós que viveis e reinais por todos os séculos dos séculos. Amém.'**
  String get novenaSaoJoseDay3Meditation;

  /// No description provided for @novenaSaoJoseDay4Title.
  ///
  /// In pt, this message translates to:
  /// **'4º Dia - São José, Exemplo de Fidelidade'**
  String get novenaSaoJoseDay4Title;

  /// No description provided for @novenaSaoJoseDay4Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Fidelíssimo São José, que nos destes tão belo exemplo no fiel cumprimento de vossos deveres de protetor da Santíssima Virgem e de pai nutrício do Redentor, rogo-vos me obtenhais a graça de imitar o vosso exemplo na fidelidade a todos os deveres do meu estado de vida. Ajudai-me a ser fiel nas coisas pequenas, para sê-lo também nas grandes. Alcançai essa mesma graça para todos os que me são caros nesta vida, a fim de chegarmos a gozar no céu o prêmio prometido aos que forem fiéis até a morte. Amém.\n\nV/. Rogai por nós, São José, exemplo de fidelidade.\nR/. Para que sejamos dignos das promessas de Cristo.\n\nOremos. Ó Deus, que por uma inefável Providência Vos dignastes escolher o bem-aventurado São José para Esposo de vossa Mãe Santíssima, concedei-nos que aquele mesmo que na terra veneramos como protetor, mereçamos tê-lo no céu por nosso intercessor. Vós que viveis e reinais por todos os séculos dos séculos. Amém.'**
  String get novenaSaoJoseDay4Meditation;

  /// No description provided for @novenaSaoJoseDay5Title.
  ///
  /// In pt, this message translates to:
  /// **'5º Dia - São José, Espelho de Paciência'**
  String get novenaSaoJoseDay5Title;

  /// No description provided for @novenaSaoJoseDay5Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Bondoso São José, que suportastes com heroica paciência as provações e adversidades na viagem a Belém, na fuga para o Egito e durante a vida oculta em Nazaré e nos destes o exemplo de admirável conformidade com a vontade de Deus, obtende-me a virtude da paciência nas dificuldades de cada dia. Alcançai também invencível paciência a todos os que suportam pesadas cruzes, a fim de que se unam sempre mais a Jesus, divino modelo de mansidão e paciência. Amém.\n\nV/. Rogai por nós, São José, espelho de paciência.\nR/. Para que sejamos dignos das promessas de Cristo.\n\nOremos. Ó Deus, que por uma inefável Providência Vos dignastes escolher o bem-aventurado São José para Esposo de vossa Mãe Santíssima, concedei-nos que aquele mesmo que na terra veneramos como protetor, mereçamos tê-lo no céu por nosso intercessor. Vós que viveis e reinais por todos os séculos dos séculos. Amém.'**
  String get novenaSaoJoseDay5Meditation;

  /// No description provided for @novenaSaoJoseDay6Title.
  ///
  /// In pt, this message translates to:
  /// **'6º Dia - São José, Modelo dos Operários'**
  String get novenaSaoJoseDay6Title;

  /// No description provided for @novenaSaoJoseDay6Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Humilde São José, que vivendo em pobreza dignificastes a vossa profissão pelo trabalho constante e vos sentistes feliz em servir a Jesus e a Maria com o fruto de vossos suores, alcançai-me amor ao trabalho, que me foi imposto como dever de estado, procurando cumprir nisto sempre a vontade de Deus. Protegei os lares dos trabalhadores do Brasil contra as influências nefastas dos inimigos de Cristo e da Santa Igreja. Obtende-lhes a graça de santificarem o seu trabalho, pela reta intenção, em tudo conformados com os desígnios da Divina Providência. Amém.\n\nV/. Rogai por nós, São José, modelo dos operários.\nR/. Para que sejamos dignos das promessas de Cristo.\n\nOremos. Ó Deus, que por uma inefável Providência Vos dignastes escolher o bem-aventurado São José para Esposo de vossa Mãe Santíssima, concedei-nos que aquele mesmo que na terra veneramos como protetor, mereçamos tê-lo no céu por nosso intercessor. Vós que viveis e reinais por todos os séculos dos séculos. Amém.'**
  String get novenaSaoJoseDay6Meditation;

  /// No description provided for @novenaSaoJoseDay7Title.
  ///
  /// In pt, this message translates to:
  /// **'7º Dia - São José, Protetor da Santa Igreja'**
  String get novenaSaoJoseDay7Title;

  /// No description provided for @novenaSaoJoseDay7Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Glorioso Patriarca São José, Protetor e Padroeiro da Igreja Universal, obtende-me a graça de amar a Igreja como Mãe e de a honrar como verdadeiro discípulo de Cristo. Rogo-vos que veleis sobre o seu Corpo Místico, como outrora velastes sobre Jesus e Maria. Protegei o Santo Padre e os Bispos, os Sacerdotes e os Religiosos. Alcançai-lhes santidade de vida e eficácia no apostolado. Guardai a inocência da infância, a castidade da juventude, a honestidade do lar, a ordem e a paz da sociedade. Amém.\n\nV/. Rogai por nós, São José, protetor da Santa Igreja.\nR/. Para que sejamos dignos das promessas de Cristo.\n\nOremos. Ó Deus, que por uma inefável Providência Vos dignastes escolher o bem-aventurado São José para Esposo de vossa Mãe Santíssima, concedei-nos que aquele mesmo que na terra veneramos como protetor, mereçamos tê-lo no céu por nosso intercessor. Vós que viveis e reinais por todos os séculos dos séculos. Amém.'**
  String get novenaSaoJoseDay7Meditation;

  /// No description provided for @novenaSaoJoseDay8Title.
  ///
  /// In pt, this message translates to:
  /// **'8º Dia - São José, Consolo dos Enfermos'**
  String get novenaSaoJoseDay8Title;

  /// No description provided for @novenaSaoJoseDay8Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Compassivo São José, esperança dos doentes e necessitados, valei-me em todas as enfermidades e tribulações, alcançando-me plena conformidade com os admiráveis desígnios de Deus. Obtende-me também, para mim e para todos por quem rezo nesta novena, a cura das enfermidades espirituais, que são as paixões desordenadas, fraquezas, faltas e pecados, e protegei-nos contra as tentações do inimigo da nossa salvação. Amém.\n\nV/. Rogai por nós, São José, consolo dos enfermos.\nR/. Para que sejamos dignos das promessas de Cristo.\n\nOremos. Ó Deus, que por uma inefável Providência Vos dignastes escolher o bem-aventurado São José para Esposo de vossa Mãe Santíssima, concedei-nos que aquele mesmo que na terra veneramos como protetor, mereçamos tê-lo no céu por nosso intercessor. Vós que viveis e reinais por todos os séculos dos séculos. Amém.'**
  String get novenaSaoJoseDay8Meditation;

  /// No description provided for @novenaSaoJoseDay9Title.
  ///
  /// In pt, this message translates to:
  /// **'9º Dia - São José, Padroeiro dos Moribundos'**
  String get novenaSaoJoseDay9Title;

  /// No description provided for @novenaSaoJoseDay9Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Ditoso São José, que morrendo nos braços de Jesus e Maria, partistes deste mundo ornado de virtudes e enriquecido de méritos, assisti-me na hora suprema e decisiva da minha vida contra os ataques do poder infernal. Obtende-me a graça de morrer confortado com os santos Sacramentos, necessários para a minha salvação. Tende compaixão de todos os agonizantes, alcançando-lhes a graça da salvação por intermédio de Maria, vossa Santíssima Esposa. Amém.\n\nV/. Rogai por nós, São José, padroeiro dos moribundos.\nR/. Para que sejamos dignos das promessas de Cristo.\n\nOremos. Ó Deus, que por uma inefável Providência Vos dignastes escolher o bem-aventurado São José para Esposo de vossa Mãe Santíssima, concedei-nos que aquele mesmo que na terra veneramos como protetor, mereçamos tê-lo no céu por nosso intercessor. Vós que viveis e reinais por todos os séculos dos séculos. Amém.'**
  String get novenaSaoJoseDay9Meditation;

  /// No description provided for @novenaSaoJudasTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novena a São Judas Tadeu'**
  String get novenaSaoJudasTitle;

  /// No description provided for @novenaSaoJudasDesc.
  ///
  /// In pt, this message translates to:
  /// **'Aos corações aflitos e casos desesperados, recorremos ao glorioso São Judas.'**
  String get novenaSaoJudasDesc;

  /// No description provided for @novenaSaoJudasOpening.
  ///
  /// In pt, this message translates to:
  /// **'Oração: São Judas glorioso, apóstolo fiel e mártir de Jesus Cristo! O título de traidor foi a causa de serdes esquecido por muitos, mas a Igreja vos honra e vos invoca universalmente como Padroeiro nos casos manifestamente desesperados, nos negócios sem remédio. Intercedei por mim, que sou tão miserável; fazei uso daquele particular privilégio que vos foi concedido de trazer viável e imediato auxílio, onde o socorro desapareceu quase por completo. Assisti-me nesta grande necessidade, para que eu possa receber o consolo e o auxílio do céu em todas as minhas precisões, atribulações e sofrimentos, alcançando a graça que peço. (Faça o seu pedido)'**
  String get novenaSaoJudasOpening;

  /// No description provided for @novenaSaoJudasClosing.
  ///
  /// In pt, this message translates to:
  /// **'Oração final: São Judas Tadeu, rogai por nós e por todos que vos honram e invocam o vosso auxílio! Prometo, ó bendito São Judas, lembrar-me sempre deste grande favor e nunca deixar de vos honrar como meu especial e poderoso padroeiro, e fazer tudo o que estiver ao meu alcance para incentivar a devoção para convosco. Amém.'**
  String get novenaSaoJudasClosing;

  /// No description provided for @novenaSaoJudasPrayers.
  ///
  /// In pt, this message translates to:
  /// **'Rezar 3 Pai-Nossos, 3 Ave-Marias e 3 Glórias ao Pai.'**
  String get novenaSaoJudasPrayers;

  /// No description provided for @novenaSaoJudasDay1Title.
  ///
  /// In pt, this message translates to:
  /// **'1º Dia - Fidelidade incondicional'**
  String get novenaSaoJudasDay1Title;

  /// No description provided for @novenaSaoJudasDay1Meditation.
  ///
  /// In pt, this message translates to:
  /// **'São Judas, testemunha valente, peço-vos a graça de permanecer fiel na minha fé, não obstante os tempos sombrios, e a força para nunca perder a esperança nas promessas do Cristo.'**
  String get novenaSaoJudasDay1Meditation;

  /// No description provided for @novenaSaoJudasDay2Title.
  ///
  /// In pt, this message translates to:
  /// **'2º Dia - O amor à Cruz'**
  String get novenaSaoJudasDay2Title;

  /// No description provided for @novenaSaoJudasDay2Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Glorioso apóstolo, ajudai-me a abraçar a minha cruz de cada dia com a mesma alegria e prontidão com as quais destes a vossa vida pelo Evangelho.'**
  String get novenaSaoJudasDay2Meditation;

  /// No description provided for @novenaSaoJudasDay3Title.
  ///
  /// In pt, this message translates to:
  /// **'3º Dia - A pureza de intenções'**
  String get novenaSaoJudasDay3Title;

  /// No description provided for @novenaSaoJudasDay3Meditation.
  ///
  /// In pt, this message translates to:
  /// **'São Judas amado, purificai meus desejos mundanos para que eu busque antes de tudo agradar a Deus, amando o próximo como a mim mesmo.'**
  String get novenaSaoJudasDay3Meditation;

  /// No description provided for @novenaSaoJudasDay4Title.
  ///
  /// In pt, this message translates to:
  /// **'4º Dia - A paz nos desesperos'**
  String get novenaSaoJudasDay4Title;

  /// No description provided for @novenaSaoJudasDay4Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Ó Padroeiro dos aflitos, descei sobre meu coração perturbado a paz serena e a plena confiança na Divina Providência.'**
  String get novenaSaoJudasDay4Meditation;

  /// No description provided for @novenaSaoJudasDay5Title.
  ///
  /// In pt, this message translates to:
  /// **'5º Dia - A salvação das almas'**
  String get novenaSaoJudasDay5Title;

  /// No description provided for @novenaSaoJudasDay5Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Inspirado pelo vosso zelo, São Judas, rogo para que eu seja instrumento do Senhor para a salvação e a santificação da minha família.'**
  String get novenaSaoJudasDay5Meditation;

  /// No description provided for @novenaSaoJudasDay6Title.
  ///
  /// In pt, this message translates to:
  /// **'6º Dia - A virtude da paciência'**
  String get novenaSaoJudasDay6Title;

  /// No description provided for @novenaSaoJudasDay6Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Nas contrariedades do caminho, ó Santo valente, dai-me paciência de suportar tudo em expiação por minhas próprias faltas.'**
  String get novenaSaoJudasDay6Meditation;

  /// No description provided for @novenaSaoJudasDay7Title.
  ///
  /// In pt, this message translates to:
  /// **'7º Dia - A defesa da verdadeira fé'**
  String get novenaSaoJudasDay7Title;

  /// No description provided for @novenaSaoJudasDay7Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Vós, São Judas, que em vossa Epístola condenastes as seitas e heresias, alcançai-me a graça de defender vigorosamente a Doutrina Católica.'**
  String get novenaSaoJudasDay7Meditation;

  /// No description provided for @novenaSaoJudasDay8Title.
  ///
  /// In pt, this message translates to:
  /// **'8º Dia - O auxílio infalível'**
  String get novenaSaoJudasDay8Title;

  /// No description provided for @novenaSaoJudasDay8Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Nos problemas sem solução aparente, firmo a minha confiança em vossa intercessão. O Senhor jamais negará o vosso pedido, pois por Ele destes o sangue.'**
  String get novenaSaoJudasDay8Meditation;

  /// No description provided for @novenaSaoJudasDay9Title.
  ///
  /// In pt, this message translates to:
  /// **'9º Dia - A glória eterna'**
  String get novenaSaoJudasDay9Title;

  /// No description provided for @novenaSaoJudasDay9Meditation.
  ///
  /// In pt, this message translates to:
  /// **'São Judas vencedor, guiai meus passos no cume desta vida exilada, a fim de que, merecendo o perdão por vossa assistência, possa bendizer a Deus convosco eternamente.'**
  String get novenaSaoJudasDay9Meditation;

  /// No description provided for @novenaPentecostesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novena de Pentecostes'**
  String get novenaPentecostesTitle;

  /// No description provided for @novenaPentecostesDesc.
  ///
  /// In pt, this message translates to:
  /// **'A primeira novena da Igreja, pedindo os dons do Espírito Santo, como fizeram Maria e os Apóstolos no Cenáculo.'**
  String get novenaPentecostesDesc;

  /// No description provided for @novenaPentecostesOpening.
  ///
  /// In pt, this message translates to:
  /// **'Vinde, Espírito Santo! Enchei os corações dos Vossos fiéis e acendei neles o fogo do Vosso amor. Enviai o Vosso Espírito, e tudo será criado; e renovareis a face da terra. Ó Deus, que instruístes os corações dos Vossos fiéis com a luz do Espírito Santo, fazei que apreciemos retamente todas as coisas segundo o mesmo Espírito e gozemos sempre da Sua consolação. Por Cristo, Senhor nosso. Amém.'**
  String get novenaPentecostesOpening;

  /// No description provided for @novenaPentecostesClosing.
  ///
  /// In pt, this message translates to:
  /// **'Divino Espírito Santo, concede-me as Tuas graças e os Teus sete dons. Que a chama do Vosso Divino Amor purifique e santifique o meu coração, tornando-o um templo digno da Vossa habitação perpétua. Amém.'**
  String get novenaPentecostesClosing;

  /// No description provided for @novenaPentecostesPrayers.
  ///
  /// In pt, this message translates to:
  /// **'Rezar 1 Pai-Nosso, 1 Ave-Maria e o canto Veni Creator Spiritus (ou 1 Glória ao Pai).'**
  String get novenaPentecostesPrayers;

  /// No description provided for @novenaPentecostesDay1Title.
  ///
  /// In pt, this message translates to:
  /// **'1º Dia - Vem, Santo Espírito do Céu'**
  String get novenaPentecostesDay1Title;

  /// No description provided for @novenaPentecostesDay1Meditation.
  ///
  /// In pt, this message translates to:
  /// **'O Espírito Santo é a promessa do Pai e a luz da nossa alma. Peçamos que o Espírito da Verdade desça e acenda a nossa fé morna.'**
  String get novenaPentecostesDay1Meditation;

  /// No description provided for @novenaPentecostesDay2Title.
  ///
  /// In pt, this message translates to:
  /// **'2º Dia - O Dom do Temor de Deus'**
  String get novenaPentecostesDay2Title;

  /// No description provided for @novenaPentecostesDay2Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Espírito Santo, dai-me o sagrado temor de ofender a Deus, livrando-me do desrespeito e do apego ao pecado.'**
  String get novenaPentecostesDay2Meditation;

  /// No description provided for @novenaPentecostesDay3Title.
  ///
  /// In pt, this message translates to:
  /// **'3º Dia - O Dom da Piedade'**
  String get novenaPentecostesDay3Title;

  /// No description provided for @novenaPentecostesDay3Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Senhor, inundai-me de terna afeição por Vós, para que Vos chame de Pai e sirva alegremente os meus irmãos e irmãs.'**
  String get novenaPentecostesDay3Meditation;

  /// No description provided for @novenaPentecostesDay4Title.
  ///
  /// In pt, this message translates to:
  /// **'4º Dia - O Dom da Ciência'**
  String get novenaPentecostesDay4Title;

  /// No description provided for @novenaPentecostesDay4Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Divino Mestre, concedei-me a verdadeira sabedoria das coisas criadas, para que não me iluda com o mundo e busque o eterno.'**
  String get novenaPentecostesDay4Meditation;

  /// No description provided for @novenaPentecostesDay5Title.
  ///
  /// In pt, this message translates to:
  /// **'5º Dia - O Dom da Fortaleza'**
  String get novenaPentecostesDay5Title;

  /// No description provided for @novenaPentecostesDay5Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Espírito Consolador, fortificai meu espírito contra o medo e as tentações. Dai-me a força dos mártires para testemunhar Cristo.'**
  String get novenaPentecostesDay5Meditation;

  /// No description provided for @novenaPentecostesDay6Title.
  ///
  /// In pt, this message translates to:
  /// **'6º Dia - O Dom do Conselho'**
  String get novenaPentecostesDay6Title;

  /// No description provided for @novenaPentecostesDay6Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Iluminador das almas, guiai minhas decisões. Nas hesitações da vida, dai-me escolher somente aquilo que é da Vossa santíssima vontade.'**
  String get novenaPentecostesDay6Meditation;

  /// No description provided for @novenaPentecostesDay7Title.
  ///
  /// In pt, this message translates to:
  /// **'7º Dia - O Dom do Entendimento'**
  String get novenaPentecostesDay7Title;

  /// No description provided for @novenaPentecostesDay7Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Luz Divina, abri meu intelecto às verdades reveladas da fé, e afugentai para longe as cegueiras e ignorâncias da minha mente.'**
  String get novenaPentecostesDay7Meditation;

  /// No description provided for @novenaPentecostesDay8Title.
  ///
  /// In pt, this message translates to:
  /// **'8º Dia - O Dom da Sabedoria'**
  String get novenaPentecostesDay8Title;

  /// No description provided for @novenaPentecostesDay8Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Fogo de Amor Sagrado, que este dom me faça degustar a beleza de Deus, unindo-me cada vez mais profundamente na verdadeira comunhão com o Cristo.'**
  String get novenaPentecostesDay8Meditation;

  /// No description provided for @novenaPentecostesDay9Title.
  ///
  /// In pt, this message translates to:
  /// **'9º Dia - Os Frutos do Espírito'**
  String get novenaPentecostesDay9Title;

  /// No description provided for @novenaPentecostesDay9Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Ao lado da Virgem no Cenáculo, abro totalmente meu coração. Formai em mim a caridade, a alegria, a paz e todas as virtudes.'**
  String get novenaPentecostesDay9Meditation;

  /// No description provided for @novenaPerpetuoSocorroTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novena a N. S. do Perpétuo Socorro'**
  String get novenaPerpetuoSocorroTitle;

  /// No description provided for @novenaPerpetuoSocorroDesc.
  ///
  /// In pt, this message translates to:
  /// **'Em todas as aflições, a Mãe Imaculada nunca nega Seu perpétuo auxílio e misericórdia.'**
  String get novenaPerpetuoSocorroDesc;

  /// No description provided for @novenaPerpetuoSocorroOpening.
  ///
  /// In pt, this message translates to:
  /// **'Ó Santíssima Virgem Maria, que para inspirar-nos confiança destes a vós mesma o dulcíssimo nome de Mãe do Perpétuo Socorro! Confiando na vossa misericórdia, rogo-vos me socorrais em todas as minhas necessidades e em todas as minhas misérias desta vida corruptível. Especialmente peço, Mãe bendita, a graça de recorrer sempre a Vós; porque assim sei bem que não cairei jamais no abismo das condenações eternas.'**
  String get novenaPerpetuoSocorroOpening;

  /// No description provided for @novenaPerpetuoSocorroClosing.
  ///
  /// In pt, this message translates to:
  /// **'Lembrai-vos, ó piíssima Virgem Maria, que nunca se ouviu dizer que algum daqueles que têm recorrido à vossa proteção fosse por vós desamparado. Animado com esta confiança a vós também corro. Protegei-me e concedei o Perpétuo Socorro que urgentemente preciso. Amém.'**
  String get novenaPerpetuoSocorroClosing;

  /// No description provided for @novenaPerpetuoSocorroPrayers.
  ///
  /// In pt, this message translates to:
  /// **'Rezar 3 Ave-Marias, seguidas da jaculatória: \'Ó Maria, concebida sem pecado, rogai por nós que recorremos a vós.\''**
  String get novenaPerpetuoSocorroPrayers;

  /// No description provided for @novenaPerpetuoSocorroDay1Title.
  ///
  /// In pt, this message translates to:
  /// **'1º Dia - N. S. Rainha de Misericórdia'**
  String get novenaPerpetuoSocorroDay1Title;

  /// No description provided for @novenaPerpetuoSocorroDay1Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Maria tem seus olhos de misericórdia sempre postos sobre mim. Seus braços abençoados nunca se fecham aos meus apelos.'**
  String get novenaPerpetuoSocorroDay1Meditation;

  /// No description provided for @novenaPerpetuoSocorroDay2Title.
  ///
  /// In pt, this message translates to:
  /// **'2º Dia - O refúgio no desespero'**
  String get novenaPerpetuoSocorroDay2Title;

  /// No description provided for @novenaPerpetuoSocorroDay2Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Diante das tentações desesperadoras, Mãe Imaculada, mostrai-me o Menino Jesus que trazeis nos braços, meu refúgio e salvação.'**
  String get novenaPerpetuoSocorroDay2Meditation;

  /// No description provided for @novenaPerpetuoSocorroDay3Title.
  ///
  /// In pt, this message translates to:
  /// **'3º Dia - Socorro na doença e aflição'**
  String get novenaPerpetuoSocorroDay3Title;

  /// No description provided for @novenaPerpetuoSocorroDay3Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma aflição terrena passa despercebida pela Senhora. Peço-Vos alívio corporal ou força e resignação para cumprir a vontade divina.'**
  String get novenaPerpetuoSocorroDay3Meditation;

  /// No description provided for @novenaPerpetuoSocorroDay4Title.
  ///
  /// In pt, this message translates to:
  /// **'4º Dia - Estrela em meio à escuridão'**
  String get novenaPerpetuoSocorroDay4Title;

  /// No description provided for @novenaPerpetuoSocorroDay4Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Nas trevas que cobrem o mundo hoje, sede minha Estrela. Mãe amada, não deixei que as falsas modas me afastem da cruz.'**
  String get novenaPerpetuoSocorroDay4Meditation;

  /// No description provided for @novenaPerpetuoSocorroDay5Title.
  ///
  /// In pt, this message translates to:
  /// **'5º Dia - Proteção e auxílio das famílias'**
  String get novenaPerpetuoSocorroDay5Title;

  /// No description provided for @novenaPerpetuoSocorroDay5Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Ó Perpétuo Socorro, derramai abundantes bênçãos em minha casa. Mantendei-nos em união, amor e pureza de vida.'**
  String get novenaPerpetuoSocorroDay5Meditation;

  /// No description provided for @novenaPerpetuoSocorroDay6Title.
  ///
  /// In pt, this message translates to:
  /// **'6º Dia - Refúgio dos pecadores'**
  String get novenaPerpetuoSocorroDay6Title;

  /// No description provided for @novenaPerpetuoSocorroDay6Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Eu me reconheço indigno e fraco. Por isso Vos peço: alcançai-me as lágrimas da sincera e duradoura confissão de minhas culpas.'**
  String get novenaPerpetuoSocorroDay6Meditation;

  /// No description provided for @novenaPerpetuoSocorroDay7Title.
  ///
  /// In pt, this message translates to:
  /// **'7º Dia - Consolo nas horas minguadas'**
  String get novenaPerpetuoSocorroDay7Title;

  /// No description provided for @novenaPerpetuoSocorroDay7Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Pela dor pungente que tivestes ao pé da cruz, vinde consolar as angústias do meu coração e acalmar os que lutam e suam por mim.'**
  String get novenaPerpetuoSocorroDay7Meditation;

  /// No description provided for @novenaPerpetuoSocorroDay8Title.
  ///
  /// In pt, this message translates to:
  /// **'8º Dia - Fidelidade ao Rosário'**
  String get novenaPerpetuoSocorroDay8Title;

  /// No description provided for @novenaPerpetuoSocorroDay8Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Soberana Senhora, gravai no meu espírito a fidelidade e constância ao Santo Terço diário, corrente de graças e porta de salvação.'**
  String get novenaPerpetuoSocorroDay8Meditation;

  /// No description provided for @novenaPerpetuoSocorroDay9Title.
  ///
  /// In pt, this message translates to:
  /// **'9º Dia - A Hora da nossa morte'**
  String get novenaPerpetuoSocorroDay9Title;

  /// No description provided for @novenaPerpetuoSocorroDay9Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Ó Mãe clemente e piedosa! Na última e definitiva batalha da minha vida, socorrei-me. Recebei-me e levai minha alma na companhia dos anjos.'**
  String get novenaPerpetuoSocorroDay9Meditation;

  /// No description provided for @novenaSaoMiguelTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novena a São Miguel Arcanjo'**
  String get novenaSaoMiguelTitle;

  /// No description provided for @novenaSaoMiguelDesc.
  ///
  /// In pt, this message translates to:
  /// **'Príncipe das Milícias Celestes, intercessor e combatente poderoso para a vitória contra os ataques malignos.'**
  String get novenaSaoMiguelDesc;

  /// No description provided for @novenaSaoMiguelOpening.
  ///
  /// In pt, this message translates to:
  /// **'São Miguel Arcanjo, defendei-nos no combate; sede o nosso refúgio contra as maldades e as ciladas do demônio. Ordene-lhe Deus, instantemente o pedimos. E vós, príncipe da milícia celeste, pelo poder divino, precipitai no inferno a satanás e aos outros espíritos malignos que andam pelo mundo para perder as almas. Amém.'**
  String get novenaSaoMiguelOpening;

  /// No description provided for @novenaSaoMiguelClosing.
  ///
  /// In pt, this message translates to:
  /// **'Ó glorioso Príncipe da Milícia Celeste, São Miguel Arcanjo! Pelo Vosso clamor \'Quem como Deus?\', recebei os meus humildes pedidos e apresentai-os diante do trono do Altíssimo. Amém.'**
  String get novenaSaoMiguelClosing;

  /// No description provided for @novenaSaoMiguelPrayers.
  ///
  /// In pt, this message translates to:
  /// **'Rezar 1 Pai-Nosso, 3 Ave-Marias e o Glória ao Pai (preferencialmente após a oração a São Miguel).'**
  String get novenaSaoMiguelPrayers;

  /// No description provided for @novenaSaoMiguelDay1Title.
  ///
  /// In pt, this message translates to:
  /// **'1º Dia - Príncipe Fidelíssimo'**
  String get novenaSaoMiguelDay1Title;

  /// No description provided for @novenaSaoMiguelDay1Meditation.
  ///
  /// In pt, this message translates to:
  /// **'São Miguel, pelo Vosso zelo à glória de Deus, impulsionai-me a não ter respeito humano e a dar sempre a honra devida a Nosso Senhor.'**
  String get novenaSaoMiguelDay1Meditation;

  /// No description provided for @novenaSaoMiguelDay2Title.
  ///
  /// In pt, this message translates to:
  /// **'2º Dia - Destruidor do Orgulho'**
  String get novenaSaoMiguelDay2Title;

  /// No description provided for @novenaSaoMiguelDay2Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Arcanjo luminoso, que despedaçastes o orgulho satânico, extirpai em mim tudo que não é humildade genuína.'**
  String get novenaSaoMiguelDay2Meditation;

  /// No description provided for @novenaSaoMiguelDay3Title.
  ///
  /// In pt, this message translates to:
  /// **'3º Dia - Terror de Satanás'**
  String get novenaSaoMiguelDay3Title;

  /// No description provided for @novenaSaoMiguelDay3Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Ó terror do abismo, afugentai com Vossa espada empunhada toda insinuação demoníaca de impureza e desespero.'**
  String get novenaSaoMiguelDay3Meditation;

  /// No description provided for @novenaSaoMiguelDay4Title.
  ///
  /// In pt, this message translates to:
  /// **'4º Dia - Defensor da Igreja'**
  String get novenaSaoMiguelDay4Title;

  /// No description provided for @novenaSaoMiguelDay4Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Protegei a Santa Mãe Igreja, o Sumo Pontífice, clérigos e leigos de todos os inimigos visíveis e invisíveis que planejam destruí-la.'**
  String get novenaSaoMiguelDay4Meditation;

  /// No description provided for @novenaSaoMiguelDay5Title.
  ///
  /// In pt, this message translates to:
  /// **'5º Dia - Consolo das Almas'**
  String get novenaSaoMiguelDay5Title;

  /// No description provided for @novenaSaoMiguelDay5Meditation.
  ///
  /// In pt, this message translates to:
  /// **'São Miguel formidável, portador da balança da justiça divina, trazei consolação na hora extrema aos agonizantes e aflitos.'**
  String get novenaSaoMiguelDay5Meditation;

  /// No description provided for @novenaSaoMiguelDay6Title.
  ///
  /// In pt, this message translates to:
  /// **'6º Dia - Vencedor nos perigos espirituais'**
  String get novenaSaoMiguelDay6Title;

  /// No description provided for @novenaSaoMiguelDay6Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Socorrei-me nas lutas ocultas. Rompei com o Vosso grito guerreiro as amarras de vícios secretos e faltas habituais em minha vida.'**
  String get novenaSaoMiguelDay6Meditation;

  /// No description provided for @novenaSaoMiguelDay7Title.
  ///
  /// In pt, this message translates to:
  /// **'7º Dia - Padrão dos servos e militares de Cristo'**
  String get novenaSaoMiguelDay7Title;

  /// No description provided for @novenaSaoMiguelDay7Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Formai-me um verdadeiro discípulo valoroso da doutrina, não cedendo espaço e nem condescendência com as coisas enganosas do mundo.'**
  String get novenaSaoMiguelDay7Meditation;

  /// No description provided for @novenaSaoMiguelDay8Title.
  ///
  /// In pt, this message translates to:
  /// **'8º Dia - Escudo das famílias'**
  String get novenaSaoMiguelDay8Title;

  /// No description provided for @novenaSaoMiguelDay8Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Dignai-vos São Miguel colocar vossos anjos sob a porta de minha casa, defendendo minha família de discórdias e invejas.'**
  String get novenaSaoMiguelDay8Meditation;

  /// No description provided for @novenaSaoMiguelDay9Title.
  ///
  /// In pt, this message translates to:
  /// **'9º Dia - Apresentador das almas'**
  String get novenaSaoMiguelDay9Title;

  /// No description provided for @novenaSaoMiguelDay9Meditation.
  ///
  /// In pt, this message translates to:
  /// **'No dia do juízo, quando minha alma comparecer diante do rigor da balança divina, peço que compareçais por mim como fiador. Amém.'**
  String get novenaSaoMiguelDay9Meditation;

  /// No description provided for @novenaAlmasTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novena pelas Almas do Purgatório'**
  String get novenaAlmasTitle;

  /// No description provided for @novenaAlmasDesc.
  ///
  /// In pt, this message translates to:
  /// **'A mais nobre obra de caridade: interceder através do sacrifício para abreviar o sofrimento das almas padecentes.'**
  String get novenaAlmasDesc;

  /// No description provided for @novenaAlmasOpening.
  ///
  /// In pt, this message translates to:
  /// **'Senhor meu Jesus Cristo, Redentor nosso, que Vos dignastes derramar o Vosso preciosíssimo Sangue para remir o mundo e salvar as almas, eu Vos suplico humildemente, pelas dores de Vossa Santíssima Mãe e por Vossa Divina chagas, tenhais misericórdia das Almas do Purgatório, especialmente aquelas por quem sou mais obrigado a pedir.'**
  String get novenaAlmasOpening;

  /// No description provided for @novenaAlmasClosing.
  ///
  /// In pt, this message translates to:
  /// **'Dai-lhes, Senhor, o descanso eterno. E que a luz perpétua as ilumine. Descansem em paz. Amém. Doce Coração de Maria, sede a salvação das almas do purgatório.'**
  String get novenaAlmasClosing;

  /// No description provided for @novenaAlmasPrayers.
  ///
  /// In pt, this message translates to:
  /// **'Rezar 1 Pai-Nosso, 1 Ave-Maria e a oração \'Dai-lhes Senhor o descanso eterno\'.'**
  String get novenaAlmasPrayers;

  /// No description provided for @novenaAlmasDay1Title.
  ///
  /// In pt, this message translates to:
  /// **'1º Dia - A gravidade do pecado'**
  String get novenaAlmasDay1Title;

  /// No description provided for @novenaAlmasDay1Meditation.
  ///
  /// In pt, this message translates to:
  /// **'As almas sofrem tormentos incríveis porque o pecado ofende um Deus de bondade infinita. Senhor, livrai as almas esquecidas e fazei-me chorar meus próprios pecados.'**
  String get novenaAlmasDay1Meditation;

  /// No description provided for @novenaAlmasDay2Title.
  ///
  /// In pt, this message translates to:
  /// **'2º Dia - Os pais e familiares no Purgatório'**
  String get novenaAlmasDay2Title;

  /// No description provided for @novenaAlmasDay2Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Jesus amado, rogo por todas as almas de que minha família tem sangue ou dívida. Sede Vós sua libertação imediata e eterna purificação.'**
  String get novenaAlmasDay2Meditation;

  /// No description provided for @novenaAlmasDay3Title.
  ///
  /// In pt, this message translates to:
  /// **'3º Dia - Almas e devoções à Virgem'**
  String get novenaAlmasDay3Title;

  /// No description provided for @novenaAlmasDay3Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Descei, Senhora e Mãe Celeste, ao abismo dessas dores. Aliviai as devotas de Vosso rosário e escapulário com o orvalho dos Seus méritos.'**
  String get novenaAlmasDay3Meditation;

  /// No description provided for @novenaAlmasDay4Title.
  ///
  /// In pt, this message translates to:
  /// **'4º Dia - A alma mais esquecida'**
  String get novenaAlmasDay4Title;

  /// No description provided for @novenaAlmasDay4Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Ó Misericórdia de Deus, aplico esta intenção por aquela alma no purgatório que não tem absolutamente NINGUÉM no mundo inteiro que por ela reze.'**
  String get novenaAlmasDay4Meditation;

  /// No description provided for @novenaAlmasDay5Title.
  ///
  /// In pt, this message translates to:
  /// **'5º Dia - Sacerdotes e Religiosos'**
  String get novenaAlmasDay5Title;

  /// No description provided for @novenaAlmasDay5Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Lembrando da grande responsabilidade dos Santos Óleos, rogo em especial pelas almas sacerdotais que demoram a chegar até a Vossa visão celestial.'**
  String get novenaAlmasDay5Meditation;

  /// No description provided for @novenaAlmasDay6Title.
  ///
  /// In pt, this message translates to:
  /// **'6º Dia - A justiça de Deus'**
  String get novenaAlmasDay6Title;

  /// No description provided for @novenaAlmasDay6Meditation.
  ///
  /// In pt, this message translates to:
  /// **'A santidade de Deus é fogo devorador, exigindo pagamento pelo menor dos faltosos passos. Pelos méritos da Santa Cruz, pagai Vós o débito, Senhor Jesus.'**
  String get novenaAlmasDay6Meditation;

  /// No description provided for @novenaAlmasDay7Title.
  ///
  /// In pt, this message translates to:
  /// **'7º Dia - As que mais tempo lá estarão'**
  String get novenaAlmasDay7Title;

  /// No description provided for @novenaAlmasDay7Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Aquelas almas culpadas pelas piores penas purificativas contam com um infinito intercessor. Peço, ó Sangue de Cristo, apagai a conta infindável.'**
  String get novenaAlmasDay7Meditation;

  /// No description provided for @novenaAlmasDay8Title.
  ///
  /// In pt, this message translates to:
  /// **'8º Dia - As almas mais próximas do Céu'**
  String get novenaAlmasDay8Title;

  /// No description provided for @novenaAlmasDay8Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Clamo por aquelas almas que estão à porta, carecendo daquela última gota de prece para entrar. Que subam hoje à glória!'**
  String get novenaAlmasDay8Meditation;

  /// No description provided for @novenaAlmasDay9Title.
  ///
  /// In pt, this message translates to:
  /// **'9º Dia - O Santo Sacrifício da Missa'**
  String get novenaAlmasDay9Title;

  /// No description provided for @novenaAlmasDay9Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Senhor, Vós que num altar oferecestes tudo, uni amanhã os méritos da Santa Missa a essas almas todas, resgatando as legiões aos coros celestes. Amém.'**
  String get novenaAlmasDay9Meditation;

  /// No description provided for @fontSizeTitle.
  ///
  /// In pt, this message translates to:
  /// **'Tamanho do texto'**
  String get fontSizeTitle;

  /// No description provided for @fontSizeSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Aumente para facilitar a leitura das orações em todo o app.'**
  String get fontSizeSubtitle;

  /// No description provided for @fontSizeSample.
  ///
  /// In pt, this message translates to:
  /// **'Pai nosso, que estais nos céus, santificado seja o vosso nome.'**
  String get fontSizeSample;

  /// No description provided for @todayRosaryCardTitle.
  ///
  /// In pt, this message translates to:
  /// **'Rezar o terço de hoje'**
  String get todayRosaryCardTitle;

  /// No description provided for @todayRosaryCardSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Mistérios do dia'**
  String get todayRosaryCardSubtitle;

  /// No description provided for @onbWelcomeTitle.
  ///
  /// In pt, this message translates to:
  /// **'Bem-vindo ao Sancta Devocionário Católico'**
  String get onbWelcomeTitle;

  /// No description provided for @onbWelcomeBody.
  ///
  /// In pt, this message translates to:
  /// **'Um companheiro para a sua vida de oração e para a preparação da confissão.'**
  String get onbWelcomeBody;

  /// No description provided for @onbFeaturesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Tudo em um só lugar'**
  String get onbFeaturesTitle;

  /// No description provided for @onbFeatureGarden.
  ///
  /// In pt, this message translates to:
  /// **'Jardim: seu plano de orações do dia e o histórico'**
  String get onbFeatureGarden;

  /// No description provided for @onbFeaturePrayers.
  ///
  /// In pt, this message translates to:
  /// **'Orações tradicionais, com busca por nome'**
  String get onbFeaturePrayers;

  /// No description provided for @onbFeatureExam.
  ///
  /// In pt, this message translates to:
  /// **'Exame de consciência protegido por senha'**
  String get onbFeatureExam;

  /// No description provided for @onbNotifTitle.
  ///
  /// In pt, this message translates to:
  /// **'Lembretes no seu horário'**
  String get onbNotifTitle;

  /// No description provided for @onbNotifBody.
  ///
  /// In pt, this message translates to:
  /// **'Ative as notificações para receber lembretes de oração, novenas e confissão. Você pode mudar isso depois.'**
  String get onbNotifBody;

  /// No description provided for @onbEnableNotifications.
  ///
  /// In pt, this message translates to:
  /// **'Ativar lembretes'**
  String get onbEnableNotifications;

  /// No description provided for @onbNext.
  ///
  /// In pt, this message translates to:
  /// **'Continuar'**
  String get onbNext;

  /// No description provided for @onbSkip.
  ///
  /// In pt, this message translates to:
  /// **'Pular'**
  String get onbSkip;

  /// No description provided for @onbStart.
  ///
  /// In pt, this message translates to:
  /// **'Agora não'**
  String get onbStart;

  /// No description provided for @notifHealthTitle.
  ///
  /// In pt, this message translates to:
  /// **'Lembretes e notificações'**
  String get notifHealthTitle;

  /// No description provided for @notifHealthAllGood.
  ///
  /// In pt, this message translates to:
  /// **'Tudo certo: seus lembretes podem tocar no horário.'**
  String get notifHealthAllGood;

  /// No description provided for @notifHealthNotificationsOff.
  ///
  /// In pt, this message translates to:
  /// **'As notificações estão desativadas.'**
  String get notifHealthNotificationsOff;

  /// No description provided for @notifHealthExactAlarmOff.
  ///
  /// In pt, this message translates to:
  /// **'Alarmes exatos estão bloqueados; os lembretes podem atrasar.'**
  String get notifHealthExactAlarmOff;

  /// No description provided for @notifHealthFixAction.
  ///
  /// In pt, this message translates to:
  /// **'Corrigir'**
  String get notifHealthFixAction;

  /// No description provided for @notifHealthBatteryHint.
  ///
  /// In pt, this message translates to:
  /// **'Se os lembretes ainda falharem, nos ajustes do aparelho retire o app da economia de bateria.'**
  String get notifHealthBatteryHint;

  /// No description provided for @backupProtectTitle.
  ///
  /// In pt, this message translates to:
  /// **'Proteger o backup com senha?'**
  String get backupProtectTitle;

  /// No description provided for @backupProtectBody.
  ///
  /// In pt, this message translates to:
  /// **'O backup contém dados sensíveis, como o registro de pecados. Com uma senha, só quem a souber poderá abrir o arquivo. Guarde-a: sem ela o backup não pode ser recuperado.'**
  String get backupProtectBody;

  /// No description provided for @backupPasswordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Senha do backup'**
  String get backupPasswordLabel;

  /// No description provided for @backupPasswordConfirmLabel.
  ///
  /// In pt, this message translates to:
  /// **'Repita a senha'**
  String get backupPasswordConfirmLabel;

  /// No description provided for @backupPasswordMismatch.
  ///
  /// In pt, this message translates to:
  /// **'As senhas não conferem.'**
  String get backupPasswordMismatch;

  /// No description provided for @backupPasswordTooShort.
  ///
  /// In pt, this message translates to:
  /// **'Use pelo menos 6 caracteres.'**
  String get backupPasswordTooShort;

  /// No description provided for @backupProtectAction.
  ///
  /// In pt, this message translates to:
  /// **'Proteger e exportar'**
  String get backupProtectAction;

  /// No description provided for @backupNoProtectAction.
  ///
  /// In pt, this message translates to:
  /// **'Exportar sem senha'**
  String get backupNoProtectAction;

  /// No description provided for @backupEnterPasswordTitle.
  ///
  /// In pt, this message translates to:
  /// **'Backup protegido'**
  String get backupEnterPasswordTitle;

  /// No description provided for @backupEnterPasswordBody.
  ///
  /// In pt, this message translates to:
  /// **'Digite a senha usada ao exportar este backup.'**
  String get backupEnterPasswordBody;

  /// No description provided for @backupWrongPassword.
  ///
  /// In pt, this message translates to:
  /// **'Senha incorreta ou arquivo alterado.'**
  String get backupWrongPassword;

  /// No description provided for @backupOpenAction.
  ///
  /// In pt, this message translates to:
  /// **'Abrir'**
  String get backupOpenAction;

  /// No description provided for @backupExportError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível exportar o backup.'**
  String get backupExportError;

  /// No description provided for @backupImportError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível importar o backup.'**
  String get backupImportError;

  /// No description provided for @backupImportSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Backup restaurado com sucesso!'**
  String get backupImportSuccess;

  /// No description provided for @novenaPrayedTimes.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{Rezada 1 vez} other{Rezada {count} vezes}}'**
  String novenaPrayedTimes(int count);

  /// No description provided for @novenaCompletedOn.
  ///
  /// In pt, this message translates to:
  /// **'Concluída em {date}'**
  String novenaCompletedOn(String date);

  /// No description provided for @novenaStartAgain.
  ///
  /// In pt, this message translates to:
  /// **'Rezar novamente'**
  String get novenaStartAgain;

  /// No description provided for @novenaPrayedBefore.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{Você já rezou esta novena 1 vez} other{Você já rezou esta novena {count} vezes}}. Última conclusão: {date}.'**
  String novenaPrayedBefore(int count, String date);

  /// No description provided for @novenaMarkDayDone.
  ///
  /// In pt, this message translates to:
  /// **'Marcar o dia {day} como rezado'**
  String novenaMarkDayDone(int day);

  /// No description provided for @novenaDayDoneLabel.
  ///
  /// In pt, this message translates to:
  /// **'Dia {day} rezado'**
  String novenaDayDoneLabel(int day);

  /// No description provided for @examSelectedCount.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{1 marcado} other{{count} marcados}}'**
  String examSelectedCount(int count);

  /// No description provided for @examGuideTotal.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{1 item marcado no exame} other{{count} itens marcados no exame}}'**
  String examGuideTotal(int count);

  /// No description provided for @examGuideHint.
  ///
  /// In pt, this message translates to:
  /// **'Marque os pecados nas categorias para gerar o guia.'**
  String get examGuideHint;

  /// No description provided for @reportCopy.
  ///
  /// In pt, this message translates to:
  /// **'Copiar guia'**
  String get reportCopy;

  /// No description provided for @reportShare.
  ///
  /// In pt, this message translates to:
  /// **'Compartilhar guia'**
  String get reportShare;

  /// No description provided for @reportCopied.
  ///
  /// In pt, this message translates to:
  /// **'Guia copiado. Cole só em lugares privados.'**
  String get reportCopied;

  /// No description provided for @reportLastConfessionNone.
  ///
  /// In pt, this message translates to:
  /// **'Não tenho registro da minha última Confissão.'**
  String get reportLastConfessionNone;

  /// No description provided for @rosaryMysteryOf.
  ///
  /// In pt, this message translates to:
  /// **'Mistério {current} de {total}'**
  String rosaryMysteryOf(int current, int total);

  /// No description provided for @rosaryOpeningPhase.
  ///
  /// In pt, this message translates to:
  /// **'Orações iniciais'**
  String get rosaryOpeningPhase;

  /// No description provided for @rosaryClosingPhase.
  ///
  /// In pt, this message translates to:
  /// **'Encerramento'**
  String get rosaryClosingPhase;

  /// No description provided for @rosaryPrayNow.
  ///
  /// In pt, this message translates to:
  /// **'Rezar agora'**
  String get rosaryPrayNow;

  /// No description provided for @rosaryOtherMysteries.
  ///
  /// In pt, this message translates to:
  /// **'Outros mistérios'**
  String get rosaryOtherMysteries;

  /// No description provided for @rosaryHapticsToggle.
  ///
  /// In pt, this message translates to:
  /// **'Vibração no terço'**
  String get rosaryHapticsToggle;

  /// No description provided for @rosaryHapticsSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Uma leve vibração a cada oração'**
  String get rosaryHapticsSubtitle;

  /// No description provided for @prayerForMorning.
  ///
  /// In pt, this message translates to:
  /// **'Para esta manhã'**
  String get prayerForMorning;

  /// No description provided for @prayerForNoon.
  ///
  /// In pt, this message translates to:
  /// **'Para o meio-dia'**
  String get prayerForNoon;

  /// No description provided for @prayerForNight.
  ///
  /// In pt, this message translates to:
  /// **'Para esta noite'**
  String get prayerForNight;

  /// No description provided for @prayersSectionCategories.
  ///
  /// In pt, this message translates to:
  /// **'Categorias'**
  String get prayersSectionCategories;

  /// No description provided for @prayersCountLabel.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{Nenhuma oração} =1{1 oração} other{{count} orações}}'**
  String prayersCountLabel(int count);

  /// No description provided for @novenasInProgress.
  ///
  /// In pt, this message translates to:
  /// **'Em andamento'**
  String get novenasInProgress;

  /// No description provided for @novenasAll.
  ///
  /// In pt, this message translates to:
  /// **'Todas as novenas'**
  String get novenasAll;

  /// No description provided for @novenasIntro.
  ///
  /// In pt, this message translates to:
  /// **'Uma novena são nove dias seguidos de oração. Escolha uma abaixo para começar.'**
  String get novenasIntro;

  /// No description provided for @novenaContinue.
  ///
  /// In pt, this message translates to:
  /// **'Continuar'**
  String get novenaContinue;

  /// No description provided for @historyNovenaLabel.
  ///
  /// In pt, this message translates to:
  /// **'Novena: {title}'**
  String historyNovenaLabel(String title);

  /// No description provided for @planEmptyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Seu plano de oração está vazio.'**
  String get planEmptyTitle;

  /// No description provided for @planEmptySubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Adicione orações para começar a cultivar seu jardim.'**
  String get planEmptySubtitle;

  /// No description provided for @penanceMarkedDone.
  ///
  /// In pt, this message translates to:
  /// **'Penitência marcada como cumprida'**
  String get penanceMarkedDone;

  /// No description provided for @undoAction.
  ///
  /// In pt, this message translates to:
  /// **'Desfazer'**
  String get undoAction;

  /// No description provided for @confessionDateLabel.
  ///
  /// In pt, this message translates to:
  /// **'Data da Confissão'**
  String get confessionDateLabel;

  /// No description provided for @confessionRetroactiveHint.
  ///
  /// In pt, this message translates to:
  /// **'Agendado para hoje/amanhã (confissão retroativa)'**
  String get confessionRetroactiveHint;

  /// No description provided for @backupShareSubject.
  ///
  /// In pt, this message translates to:
  /// **'Backup Jardim da Alma'**
  String get backupShareSubject;

  /// No description provided for @prayerActContritionTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ato de Contrição'**
  String get prayerActContritionTitle;

  /// No description provided for @prayerActContritionContent.
  ///
  /// In pt, this message translates to:
  /// **'Senhor meu Jesus Cristo, Deus e homem verdadeiro, Criador e Redentor meu, por serdes Vós quem sois, sumamente bom e digno de ser amado sobre todas as coisas, e porque Vos amo e estimo, pesa-me, Senhor, de todo o coração, de Vos ter ofendido.\n\nProponho firmemente nunca mais pecar e afastar-me de todas as ocasiões próximas de pecado. Confesso-me, satisfarei a penitência e espero na Vossa bondade e misericórdia infinita que me perdoareis, pela Vossa Paixão e Morte, e me dareis a graça de me emendar e de perseverar no Vosso santo serviço até o fim da minha vida. Amém.'**
  String get prayerActContritionContent;

  /// No description provided for @prayerConfiteorTitle.
  ///
  /// In pt, this message translates to:
  /// **'Confiteor (Confesso a Deus)'**
  String get prayerConfiteorTitle;

  /// No description provided for @prayerConfiteorContent.
  ///
  /// In pt, this message translates to:
  /// **'Eu, pecador, confesso a Deus todo-poderoso, à bem-aventurada sempre Virgem Maria, ao bem-aventurado Miguel Arcanjo, ao bem-aventurado João Batista, aos santos Apóstolos Pedro e Paulo, a todos os Santos e a vós, Padre, que pequei muitas vezes, por pensamentos, palavras e obras; por minha culpa, minha culpa, minha máxima culpa.\n\nPortanto, rogo à bem-aventurada sempre Virgem Maria, ao bem-aventurado Miguel Arcanjo, ao bem-aventurado João Batista, aos santos Apóstolos Pedro e Paulo, a todos os Santos e a vós, Padre, que rogueis por mim a Deus nosso Senhor. Amém.'**
  String get prayerConfiteorContent;

  /// No description provided for @prayerConfiteorContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Confiteor Deo omnipotenti, beatae Mariae semper Virgini, beato Michaeli Archangelo, beato Ioanni Baptistae, sanctis Apostolis Petro et Paulo, omnibus Sanctis, et tibi, Pater: quia peccavi nimis cogitatione, verbo et opere: mea culpa, mea culpa, mea maxima culpa.\n\nIdeo precor beatam Mariam semper Virginem, beatum Michaelem Archangelum, beatum Ioannem Baptistam, sanctos Apostolos Petrum et Paulum, omnes Sanctos, et te, Pater, orare pro me ad Dominum Deum nostrum. Amen.'**
  String get prayerConfiteorContentLatin;

  /// No description provided for @prayerBeforeConfessionTitle.
  ///
  /// In pt, this message translates to:
  /// **'Antes da Confissão'**
  String get prayerBeforeConfessionTitle;

  /// No description provided for @prayerBeforeConfessionContent.
  ///
  /// In pt, this message translates to:
  /// **'Vinde, Espírito Santo, iluminai a minha consciência para que eu reconheça os meus pecados. Dai-me a graça de confessá-los com sinceridade, humildade e confiança na misericórdia de Deus.\n\nNossa Senhora, Mãe de misericórdia, rogai por mim. Amém.'**
  String get prayerBeforeConfessionContent;

  /// No description provided for @prayerAfterConfessionTitle.
  ///
  /// In pt, this message translates to:
  /// **'Depois da Confissão'**
  String get prayerAfterConfessionTitle;

  /// No description provided for @prayerAfterConfessionContent.
  ///
  /// In pt, this message translates to:
  /// **'Obrigado, Senhor, pelo perdão que me concedestes. Ajudai-me a cumprir a penitência, a evitar as ocasiões de pecado e a perseverar na Vossa graça.\n\nMaria, Refúgio dos pecadores, rogai por mim. Amém.'**
  String get prayerAfterConfessionContent;

  /// No description provided for @prayerBeforeCommunionTitle.
  ///
  /// In pt, this message translates to:
  /// **'Antes da Comunhão'**
  String get prayerBeforeCommunionTitle;

  /// No description provided for @prayerBeforeCommunionContent.
  ///
  /// In pt, this message translates to:
  /// **'Senhor Jesus, creio que estais verdadeiramente presente na Eucaristia, com o Vosso Corpo, Sangue, Alma e Divindade. Purificai o meu coração e preparai-me para Vos receber.\n\nSenhor, eu não sou digno de que entreis em minha morada, mas dizei uma palavra e serei salvo.'**
  String get prayerBeforeCommunionContent;

  /// No description provided for @prayerAfterCommunionTitle.
  ///
  /// In pt, this message translates to:
  /// **'Depois da Comunhão'**
  String get prayerAfterCommunionTitle;

  /// No description provided for @prayerAfterCommunionContent.
  ///
  /// In pt, this message translates to:
  /// **'Jesus, meu Senhor e meu Deus, agradeço-Vos por Vos dardes a mim neste Sacramento. Permanecei comigo, guardai-me do pecado e fazei de mim instrumento da Vossa paz.\n\nAlma de Cristo, santificai-me. Corpo de Cristo, salvai-me. Sangue de Cristo, inebriai-me. Amém.'**
  String get prayerAfterCommunionContent;

  /// No description provided for @prayerTheologicalActsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Atos de Fé, Esperança e Caridade'**
  String get prayerTheologicalActsTitle;

  /// No description provided for @prayerTheologicalActsContent.
  ///
  /// In pt, this message translates to:
  /// **'Ato de Fé\nMeu Deus, creio firmemente em tudo o que a Santa Igreja Católica propõe a crer, porque Vós o revelastes, Vós que sois a própria Verdade e não podeis enganar-Vos nem enganar-nos.\n\nAto de Esperança\nMeu Deus, espero da Vossa bondade, pelos méritos de Jesus Cristo, a vida eterna e as graças necessárias para a merecer pelas boas obras que devo e quero praticar.\n\nAto de Caridade\nMeu Deus, amo-Vos de todo o coração sobre todas as coisas, porque sois infinitamente bom e digno de ser amado; e, por amor de Vós, amo o meu próximo como a mim mesmo.'**
  String get prayerTheologicalActsContent;

  /// No description provided for @prayerTantumErgoTitle.
  ///
  /// In pt, this message translates to:
  /// **'Tantum Ergo'**
  String get prayerTantumErgoTitle;

  /// No description provided for @prayerTantumErgoContent.
  ///
  /// In pt, this message translates to:
  /// **'Veneremos, prostrados, tão grande Sacramento; e o antigo rito dê lugar ao novo culto; a fé supra o que faltam os sentidos.\n\nAo Pai e ao Filho, louvor e júbilo, salvação, honra, poder e bênção; e Àquele que procede de ambos, igual louvor. Amém.'**
  String get prayerTantumErgoContent;

  /// No description provided for @prayerTantumErgoContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Tantum ergo Sacramentum\nveneremur cernui:\net antiquum documentum\nnovo cedat ritui:\npraestet fides supplementum\nsensuum defectui.\n\nGenitori, Genitoque\nlaus et iubilatio,\nsalus, honor, virtus quoque\nsit et benedictio:\nprocedenti ab utroque\ncompar sit laudatio.\nAmen.'**
  String get prayerTantumErgoContentLatin;

  /// No description provided for @prayerPsalm50Title.
  ///
  /// In pt, this message translates to:
  /// **'Salmo 50 (Miserere)'**
  String get prayerPsalm50Title;

  /// No description provided for @prayerPsalm50Content.
  ///
  /// In pt, this message translates to:
  /// **'Tem piedade de mim, ó Deus, segundo a tua grande misericórdia. E segundo as muitas mostras da tua clemência, apaga a minha maldade. Lava-me mais e mais da minha iniquidade: e purifica-me do meu pecado.\n\nPorque a minha maldade eu a conheço: e o meu pecado diante de mim está sempre. Contra ti só pequei, e fiz o mal diante dos teus olhos: para que sejas justificado nas tuas palavras, e venças quando fores julgado.\n\nEis aqui sabes que eu fui concebido em iniquidades: e em pecados me concebeu minha mãe. E bem vejo que tu amaste a verdade: e me revelaste o segredo, e o escondido do teu saber.\n\nTu me borrifarás com o hissopo, e serei purificado: lavar-me-ás, e me tornarei mais branco que a neve. Ao meu ouvido darás gozo e alegria: e se regozijarão os meus ossos humilhados.\n\nAparta o teu rosto dos meus pecados: e apaga todas as minhas maldades. Cria em mim, ó Deus, um coração puro: e renova nas minhas entranhas um espírito reto. Não me arremesses da tua presença: e não tires de mim o teu Espírito Santo.\n\nDá-me a alegria da tua salvação: e conforta-me por meio do espírito principal. Ensinarei aos iníquos os teus caminhos: e os ímpios se converterão a ti.\n\nLivra-me dos sangues, ó Deus, Deus da minha salvação: e a minha língua exaltará a tua justiça. Senhor, abrirás os meus lábios: e a minha boca anunciará o teu louvor.\n\nPorque, se quisesses sacrifícios, tos dera: tu não te deleitarás em holocaustos. O sacrifício para Deus é um espírito atribulado: o coração quebrantado e humilhado, ó Deus, não o desprezarás.\n\nSenhor, trata benignamente a Sião segundo a tua boa vontade: para que sejam edificados os muros de Jerusalém. Então aceitarás o sacrifício de justiça, as oblações, e os holocaustos: então porão touros sobre o teu altar.'**
  String get prayerPsalm50Content;

  /// No description provided for @prayerPsalm50ContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Miserere mei, Deus, secundum magnam misericordiam tuam. Et secundum multitudinem miserationum tuarum, dele iniquitatem meam.\n\nAmplius lava me ab iniquitate mea, et a peccato meo munda me. Quoniam iniquitatem meam ego cognosco, et peccatum meum contra me est semper.\n\nTibi soli peccavi, et malum coram te feci: ut iustificeris in sermonibus tuis, et vincas cum iudicaris.\n\nEcce enim in iniquitatibus conceptus sum, et in peccatis concepit me mater mea. Ecce enim veritatem dilexisti: incerta et occulta sapientiae tuae manifestasti mihi.\n\nAsperges me hyssopo, et mundabor: lavabis me, et super nivem dealbabor. Auditui meo dabis gaudium et laetitiam: et exsultabunt ossa humiliata.\n\nAverte faciem tuam a peccatis meis, et omnes iniquitates meas dele. Cor mundum crea in me, Deus: et spiritum rectum innova in visceribus meis.\n\nNe proiicias me a facie tua: et spiritum sanctum tuum ne auferas a me. Redde mihi laetitiam salutaris tui: et spiritu principali confirma me.\n\nDocebo iniquos vias tuas: et impii ad te convertentur.\n\nLibera me de sanguinibus, Deus, Deus salutis meae: et exsultabit lingua mea iustitiam tuam. Domine, labia mea aperies: et os meum annuntiabit laudem tuam.\n\nQuoniam si voluisses sacrificium, dedissem utique: holocaustis non delectaberis. Sacrificium Deo spiritus contribulatus: cor contritum, et humiliatum, Deus, non despicies.\n\nBenigne fac, Domine, in bona voluntate tua Sion: ut aedificentur muri Ierusalem. Tunc acceptabis sacrificium iustitiae, oblationes, et holocausta: tunc imponent super altare tuum vitulos.'**
  String get prayerPsalm50ContentLatin;

  /// No description provided for @prayerPsalm129Title.
  ///
  /// In pt, this message translates to:
  /// **'Salmo 129 (De Profundis)'**
  String get prayerPsalm129Title;

  /// No description provided for @prayerPsalm129Content.
  ///
  /// In pt, this message translates to:
  /// **'Das profundezas clamei a vós, Senhor; Senhor, escutai a minha voz. Estejam os vossos ouvidos atentos à voz da minha súplica.\n\nSe observardes, Senhor, as iniquidades: Senhor, quem poderá subsistir? Porque em vós está a misericórdia; e por amor da vossa lei esperei em vós, Senhor.\n\nEsperou a minha alma na sua palavra; esperou a minha alma no Senhor. Desde a vigília matutina até à noite, espere Israel no Senhor. Porque no Senhor está a misericórdia: e nele há copiosa redenção. E ele mesmo remirá a Israel de todas as suas iniquidades.\n\nDai-lhes, Senhor, o eterno descanso, e brilhe para eles a luz perpétua. Amém.'**
  String get prayerPsalm129Content;

  /// No description provided for @prayerPsalm129ContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'De profundis clamavi ad te, Domine; Domine, exaudi vocem meam. Fiant aures tuae intendentes in vocem deprecationis meae.\n\nSi iniquitates observaveris, Domine, Domine, quis sustinebit? Quia apud te propitiatio est, et propter legem tuam sustinui te, Domine.\n\nSustinuit anima mea in verbo eius; speravit anima mea in Domino. A custodia matutina usque ad noctem speret Israel in Domino.\n\nQuia apud Dominum misericordia, et copiosa apud eum redemptio. Et ipse redimet Israel ex omnibus iniquitatibus eius.\n\nRequiem aeternam dona eis, Domine, et lux perpetua luceat eis. Amen.'**
  String get prayerPsalm129ContentLatin;

  /// No description provided for @prayerPsalm22Title.
  ///
  /// In pt, this message translates to:
  /// **'Salmo 22 (O Senhor é meu pastor)'**
  String get prayerPsalm22Title;

  /// No description provided for @prayerPsalm22Content.
  ///
  /// In pt, this message translates to:
  /// **'O Senhor me governa, e nada me faltará: em um lugar de pastos ali me colocou. Ele me conduziu junto a uma água de refeição: converteu a minha alma.\n\nLevou-me por veredas de justiça, por amor do seu nome. Pois ainda quando andar no meio da sombra da morte, não temerei males: porquanto tu estás comigo. A tua vara, e o teu báculo, eles me consolaram.\n\nPreparaste uma mesa diante de mim, à vista daqueles que me angustiavam. Ungiste com o óleo pingue a minha cabeça: e o meu cálix que embriaga quão precioso é!\n\nE a tua misericórdia irá após de mim todos os dias da minha vida: e a fim de que eu habite na casa do Senhor, por diuturnidade de dias.'**
  String get prayerPsalm22Content;

  /// No description provided for @prayerPsalm22ContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Dominus regit me, et nihil mihi deerit: in loco pascuae ibi me collocavit. Super aquam refectionis educavit me: animam meam convertit.\n\nDeduxit me super semitas iustitiae, propter nomen suum. Nam et si ambulavero in medio umbrae mortis, non timebo mala: quoniam tu mecum es. Virga tua, et baculus tuus: ipsa me consolata sunt.\n\nParasti in conspectu meo mensam, adversus eos qui tribulant me. Impinguasti in oleo caput meum: et calix meus inebrians quam praeclarus est!\n\nEt misericordia tua subsequetur me omnibus diebus vitae meae: et ut inhabitem in domo Domini, in longitudinem dierum.'**
  String get prayerPsalm22ContentLatin;

  /// No description provided for @prayerMagnificatTitle.
  ///
  /// In pt, this message translates to:
  /// **'Magnificat'**
  String get prayerMagnificatTitle;

  /// No description provided for @prayerMagnificatContent.
  ///
  /// In pt, this message translates to:
  /// **'A minha alma glorifica o Senhor, e o meu espírito se alegrou por extremo em Deus, meu Salvador, por ele ter posto os olhos na baixeza da sua escrava: porque eis aí de hoje em diante me chamarão bem-aventurada todas as gerações.\n\nPorque me fez grandes coisas o que é Poderoso: e santo o seu nome. E a sua misericórdia se estende de geração a geração sobre os que o temem.\n\nEle manifestou o poder do seu braço: dissipou os que no fundo do seu coração formavam altivos pensamentos. Depôs do trono os poderosos, e elevou os humildes. Encheu de bens os famintos: e despediu vazios os ricos.\n\nRecebeu a Israel seu servo, lembrado da sua misericórdia. Como tinha falado a nossos pais, a Abraão e à sua descendência para sempre.'**
  String get prayerMagnificatContent;

  /// No description provided for @prayerMagnificatContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Magnificat anima mea Dominum, et exsultavit spiritus meus in Deo salutari meo, quia respexit humilitatem ancillae suae; ecce enim ex hoc beatam me dicent omnes generationes.\n\nQuia fecit mihi magna qui potens est, et sanctum nomen eius, et misericordia eius in progenies et progenies timentibus eum.\n\nFecit potentiam in brachio suo, dispersit superbos mente cordis sui; deposuit potentes de sede et exaltavit humiles; esurientes implevit bonis et divites dimisit inanes.\n\nSuscepit Israel puerum suum, recordatus misericordiae suae, sicut locutus est ad patres nostros, Abraham et semini eius in saecula.'**
  String get prayerMagnificatContentLatin;

  /// No description provided for @prayerViaSacraTitle.
  ///
  /// In pt, this message translates to:
  /// **'Via-Sacra'**
  String get prayerViaSacraTitle;

  /// No description provided for @prayerViaSacraContent.
  ///
  /// In pt, this message translates to:
  /// **'Em cada estação, diz-se:\nV. Nós vos adoramos, Senhor Jesus Cristo, e vos bendizemos.\nR. Porque pela vossa santa Cruz remistes o mundo.\n\n1ª Estação – Jesus é condenado à morte\nJesus, inocente, aceita a sentença injusta por amor de mim.\n\n2ª Estação – Jesus carrega a cruz\nSenhor, ajudai-me a levar com amor as cruzes de cada dia.\n\n3ª Estação – Jesus cai pela primeira vez\nQuando eu cair no pecado, levantai-me, Senhor.\n\n4ª Estação – Jesus encontra sua Mãe\nMaria, Mãe das Dores, ensinai-me a permanecer junto à cruz.\n\n5ª Estação – Simão Cireneu ajuda Jesus a carregar a cruz\nQue eu saiba ajudar quem sofre ao meu lado.\n\n6ª Estação – Verônica enxuga o rosto de Jesus\nGravai em meu coração o Vosso santo rosto.\n\n7ª Estação – Jesus cai pela segunda vez\nNão permitais que o desânimo me vença.\n\n8ª Estação – Jesus consola as mulheres de Jerusalém\nDai-me a graça de chorar os meus pecados.\n\n9ª Estação – Jesus cai pela terceira vez\nDai-me perseverança até o fim.\n\n10ª Estação – Jesus é despojado de suas vestes\nDespojai-me do apego às coisas passageiras.\n\n11ª Estação – Jesus é pregado na cruz\nSenhor, pregai ao Vosso amor a minha vontade.\n\n12ª Estação – Jesus morre na cruz\nObrigado, Jesus, por Vos entregardes por mim.\n\n13ª Estação – Jesus é descido da cruz e entregue a sua Mãe\nMaria, acolhei-me também em vossos braços.\n\n14ª Estação – Jesus é colocado no sepulcro\nQue eu morra para o pecado e ressuscite convosco.\n\nAo final, reza-se um Pai-Nosso, uma Ave-Maria e um Glória pelas intenções do Santo Padre.'**
  String get prayerViaSacraContent;

  /// No description provided for @prayerDivineMercyChapletTitle.
  ///
  /// In pt, this message translates to:
  /// **'Terço da Divina Misericórdia'**
  String get prayerDivineMercyChapletTitle;

  /// No description provided for @prayerDivineMercyChapletContent.
  ///
  /// In pt, this message translates to:
  /// **'Faz-se o Sinal da Cruz e reza-se, opcionalmente:\nExpirastes, Jesus, mas jorrou uma fonte de vida para as almas e abriu-se um mar de misericórdia para o mundo inteiro. Ó fonte de vida, insondável misericórdia de Deus, envolvei o mundo inteiro e derramai-Vos sobre nós. Jesus, eu confio em Vós!\n\nInício: um Pai-Nosso, uma Ave-Maria e o Credo.\n\nNas contas grandes (uma vez em cada dezena):\nEterno Pai, eu Vos ofereço o Corpo e Sangue, Alma e Divindade de Vosso diletíssimo Filho, Nosso Senhor Jesus Cristo, em expiação dos nossos pecados e dos do mundo inteiro.\n\nNas contas pequenas (dez vezes em cada dezena):\nPela sua dolorosa Paixão, tende misericórdia de nós e do mundo inteiro.\n\nAo final (três vezes):\nSanto Deus, Santo Forte, Santo Imortal, tende piedade de nós e do mundo inteiro.\n\nReza-se de preferência às 15 horas, a hora da misericórdia.'**
  String get prayerDivineMercyChapletContent;

  /// No description provided for @prayerMemorareTitle.
  ///
  /// In pt, this message translates to:
  /// **'Lembrai-vos (Memorare)'**
  String get prayerMemorareTitle;

  /// No description provided for @prayerMemorareContent.
  ///
  /// In pt, this message translates to:
  /// **'Lembrai-vos, ó piíssima Virgem Maria, que nunca se ouviu dizer que algum daqueles que recorreram à vossa proteção, imploraram a vossa assistência e reclamaram o vosso socorro fosse por vós desamparado.\n\nAnimado eu, pois, de igual confiança, a vós, ó Virgem entre todas singular, como a Mãe recorro, de vós me valho e, gemendo sob o peso dos meus pecados, me prostro a vossos pés.\n\nNão rejeiteis as minhas súplicas, ó Mãe do Filho de Deus humanado, mas dignai-vos de as ouvir propícia e de me alcançar o que vos rogo. Amém.'**
  String get prayerMemorareContent;

  /// No description provided for @prayerMemorareContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Memorare, o piissima Virgo Maria, non esse auditum a saeculo, quemquam ad tua currentem praesidia, tua implorantem auxilia, tua petentem suffragia, esse derelictum.\n\nEgo tali animatus confidentia, ad te, Virgo Virginum, Mater, curro, ad te venio, coram te gemens peccator assisto.\n\nNoli, Mater Verbi, verba mea despicere; sed audi propitia et exaudi. Amen.'**
  String get prayerMemorareContentLatin;

  /// No description provided for @prayerStMichaelTitle.
  ///
  /// In pt, this message translates to:
  /// **'Oração a São Miguel Arcanjo'**
  String get prayerStMichaelTitle;

  /// No description provided for @prayerStMichaelContent.
  ///
  /// In pt, this message translates to:
  /// **'São Miguel Arcanjo, defendei-nos no combate; sede o nosso refúgio contra a maldade e as ciladas do demônio.\n\nOrdene-lhe Deus, instantemente o pedimos, e vós, príncipe da milícia celeste, pelo poder divino, precipitai no inferno a satanás e a todos os espíritos malignos que andam pelo mundo para perder as almas. Amém.'**
  String get prayerStMichaelContent;

  /// No description provided for @prayerStMichaelContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Sancte Michael Archangele, defende nos in proelio; contra nequitiam et insidias diaboli esto praesidium.\n\nImperet illi Deus, supplices deprecamur: tuque, Princeps militiae caelestis, Satanam aliosque spiritus malignos, qui ad perditionem animarum pervagantur in mundo, divina virtute in infernum detrude. Amen.'**
  String get prayerStMichaelContentLatin;

  /// No description provided for @prayerEternalRestTitle.
  ///
  /// In pt, this message translates to:
  /// **'Eterno Descanso (pelos defuntos)'**
  String get prayerEternalRestTitle;

  /// No description provided for @prayerEternalRestContent.
  ///
  /// In pt, this message translates to:
  /// **'Dai-lhes, Senhor, o eterno descanso, e brilhe para eles a luz perpétua.\n\nDescansem em paz. Amém.'**
  String get prayerEternalRestContent;

  /// No description provided for @prayerEternalRestContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Requiem aeternam dona eis, Domine, et lux perpetua luceat eis.\n\nRequiescant in pace. Amen.'**
  String get prayerEternalRestContentLatin;

  /// No description provided for @prayerGraceAfterMealsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Graças depois das refeições'**
  String get prayerGraceAfterMealsTitle;

  /// No description provided for @prayerGraceAfterMealsContent.
  ///
  /// In pt, this message translates to:
  /// **'Agradecemos-vos, Deus todo-poderoso, todos os vossos benefícios, vós que viveis e reinais pelos séculos dos séculos. Amém.\n\nDeus nos dê a sua paz e a vida eterna. Amém.\n\nE as almas dos fiéis defuntos, pela misericórdia de Deus, descansem em paz. Amém.'**
  String get prayerGraceAfterMealsContent;

  /// No description provided for @prayerGraceAfterMealsContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Agimus tibi gratias, omnipotens Deus, pro universis beneficiis tuis, qui vivis et regnas in saecula saeculorum. Amen.'**
  String get prayerGraceAfterMealsContentLatin;

  /// No description provided for @catPrayersSacraments.
  ///
  /// In pt, this message translates to:
  /// **'Sacramentos'**
  String get catPrayersSacraments;

  /// No description provided for @catPrayersPsalms.
  ///
  /// In pt, this message translates to:
  /// **'Salmos e Cânticos'**
  String get catPrayersPsalms;

  /// No description provided for @catPrayersDevotions.
  ///
  /// In pt, this message translates to:
  /// **'Devoções'**
  String get catPrayersDevotions;

  /// No description provided for @massCardTitle.
  ///
  /// In pt, this message translates to:
  /// **'Fui à missa'**
  String get massCardTitle;

  /// No description provided for @massCardSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Registre a missa de hoje e faça florescer uma flor dourada'**
  String get massCardSubtitle;

  /// No description provided for @massCardSubtitleSunday.
  ///
  /// In pt, this message translates to:
  /// **'Domingo, dia do Senhor. Registre a sua missa'**
  String get massCardSubtitleSunday;

  /// No description provided for @massCardDoneTitle.
  ///
  /// In pt, this message translates to:
  /// **'Missa de hoje registrada'**
  String get massCardDoneTitle;

  /// No description provided for @massCardDoneSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Uma flor dourada floresceu no seu jardim'**
  String get massCardDoneSubtitle;

  /// No description provided for @massMarkedSnack.
  ///
  /// In pt, this message translates to:
  /// **'Missa registrada. Deus abençoe o seu jardim!'**
  String get massMarkedSnack;

  /// No description provided for @massUnmarkedSnack.
  ///
  /// In pt, this message translates to:
  /// **'Missa desmarcada'**
  String get massUnmarkedSnack;

  /// No description provided for @heatmapMassLabel.
  ///
  /// In pt, this message translates to:
  /// **'Missa'**
  String get heatmapMassLabel;

  /// No description provided for @massMarkDay.
  ///
  /// In pt, this message translates to:
  /// **'Marcar missa neste dia'**
  String get massMarkDay;

  /// No description provided for @massUnmarkDay.
  ///
  /// In pt, this message translates to:
  /// **'Desmarcar missa'**
  String get massUnmarkDay;

  /// No description provided for @massMonthCount.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{1 missa neste mês} other{{count} missas neste mês}}'**
  String massMonthCount(int count);

  /// No description provided for @massSundayStreak.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{1 domingo} other{{count} domingos seguidos}}'**
  String massSundayStreak(int count);

  /// No description provided for @gardenGrowthHint.
  ///
  /// In pt, this message translates to:
  /// **'Sem oração, o gramado do dia fica seco e amarelado; a cada oração ele reverdece, e a missa ou a confissão o deixam totalmente verde. Cada oração planta uma florzinha. Toque em um dia para ver o que foi rezado.'**
  String get gardenGrowthHint;

  /// No description provided for @gardenSemantics.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{Jardim da Alma: nenhum dia com oração no último ano} =1{Jardim da Alma: 1 dia com oração no último ano} other{Jardim da Alma: {count} dias com oração no último ano}}'**
  String gardenSemantics(int count);

  /// No description provided for @novenaAparecidaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novena a Nossa Senhora Aparecida'**
  String get novenaAparecidaTitle;

  /// No description provided for @novenaAparecidaDesc.
  ///
  /// In pt, this message translates to:
  /// **'Padroeira do Brasil. Festa em 12 de outubro. Nove dias aos pés da Mãe que o povo encontrou nas águas do rio Paraíba.'**
  String get novenaAparecidaDesc;

  /// No description provided for @novenaAparecidaOpening.
  ///
  /// In pt, this message translates to:
  /// **'Ó Virgem Imaculada, Mãe de Deus e minha Mãe, Senhora Aparecida, Rainha e Padroeira do Brasil, eu me coloco sob o vosso manto. Acolhei os meus pedidos e os meus agradecimentos e levai-os ao vosso Filho, Jesus Cristo, meu Senhor e meu Salvador.'**
  String get novenaAparecidaOpening;

  /// No description provided for @novenaAparecidaClosing.
  ///
  /// In pt, this message translates to:
  /// **'Nossa Senhora Aparecida, Mãe do Redentor, abençoai o Brasil, as nossas famílias e a todos os que recorrem a vós. Mostrai-nos Jesus e conduzi-nos a Ele. Amém.'**
  String get novenaAparecidaClosing;

  /// No description provided for @novenaAparecidaPrayers.
  ///
  /// In pt, this message translates to:
  /// **'Rezar 1 Pai-Nosso, 3 Ave-Marias e a Salve Rainha.'**
  String get novenaAparecidaPrayers;

  /// No description provided for @novenaAparecidaDay1Title.
  ///
  /// In pt, this message translates to:
  /// **'1º Dia - A Mãe que nos acolhe'**
  String get novenaAparecidaDay1Title;

  /// No description provided for @novenaAparecidaDay1Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Mãe Aparecida, que vos deixastes encontrar pelos simples, ensinai-me a procurar Deus na humildade e a confiar no vosso amor de Mãe.'**
  String get novenaAparecidaDay1Meditation;

  /// No description provided for @novenaAparecidaDay2Title.
  ///
  /// In pt, this message translates to:
  /// **'2º Dia - A rede que se encheu'**
  String get novenaAparecidaDay2Title;

  /// No description provided for @novenaAparecidaDay2Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Como os pescadores que lançaram a rede e a encheram, ajudai-me a confiar na palavra de Jesus e a lançar a rede de novo, mesmo depois de noites sem fruto.'**
  String get novenaAparecidaDay2Meditation;

  /// No description provided for @novenaAparecidaDay3Title.
  ///
  /// In pt, this message translates to:
  /// **'3º Dia - Mãe de Deus'**
  String get novenaAparecidaDay3Title;

  /// No description provided for @novenaAparecidaDay3Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Santa Maria, Mãe de Deus, que dissestes sim ao anjo, dai-me um coração disponível para cumprir a vontade do Senhor em tudo.'**
  String get novenaAparecidaDay3Meditation;

  /// No description provided for @novenaAparecidaDay4Title.
  ///
  /// In pt, this message translates to:
  /// **'4º Dia - Mãe dos pobres e aflitos'**
  String get novenaAparecidaDay4Title;

  /// No description provided for @novenaAparecidaDay4Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Mãe Aparecida, olhai pelos que passam fome, pelos que não têm casa nem trabalho, e tornai-me atento às necessidades de quem está perto de mim.'**
  String get novenaAparecidaDay4Meditation;

  /// No description provided for @novenaAparecidaDay5Title.
  ///
  /// In pt, this message translates to:
  /// **'5º Dia - Mãe da Igreja'**
  String get novenaAparecidaDay5Title;

  /// No description provided for @novenaAparecidaDay5Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Protegei a Santa Igreja, o Papa, os bispos, os sacerdotes e todos os fiéis. Fazei-nos um só povo, unido em torno de Jesus.'**
  String get novenaAparecidaDay5Meditation;

  /// No description provided for @novenaAparecidaDay6Title.
  ///
  /// In pt, this message translates to:
  /// **'6º Dia - Mãe das famílias'**
  String get novenaAparecidaDay6Title;

  /// No description provided for @novenaAparecidaDay6Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Guardai as nossas famílias do egoísmo e da discórdia. Que em cada lar reinem a oração, o perdão e a paz de Nazaré.'**
  String get novenaAparecidaDay6Meditation;

  /// No description provided for @novenaAparecidaDay7Title.
  ///
  /// In pt, this message translates to:
  /// **'7º Dia - Refúgio dos pecadores'**
  String get novenaAparecidaDay7Title;

  /// No description provided for @novenaAparecidaDay7Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Mãe de misericórdia, levai-me ao confessionário e à conversão sincera. Livrai-me do pecado e fortalecei o meu desejo de recomeçar.'**
  String get novenaAparecidaDay7Meditation;

  /// No description provided for @novenaAparecidaDay8Title.
  ///
  /// In pt, this message translates to:
  /// **'8º Dia - Saúde dos enfermos'**
  String get novenaAparecidaDay8Title;

  /// No description provided for @novenaAparecidaDay8Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Cuidai dos doentes e dos que cuidam deles. Dai-lhes alívio e esperança, e a mim a graça de visitá-los e consolá-los.'**
  String get novenaAparecidaDay8Meditation;

  /// No description provided for @novenaAparecidaDay9Title.
  ///
  /// In pt, this message translates to:
  /// **'9º Dia - Padroeira do Brasil'**
  String get novenaAparecidaDay9Title;

  /// No description provided for @novenaAparecidaDay9Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Mãe e Rainha do Brasil, consagro-vos a minha vida e a minha pátria. Que o vosso povo viva a fé, a justiça e a fraternidade. Amém.'**
  String get novenaAparecidaDay9Meditation;

  /// No description provided for @novenaFatimaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novena a Nossa Senhora de Fátima'**
  String get novenaFatimaTitle;

  /// No description provided for @novenaFatimaDesc.
  ///
  /// In pt, this message translates to:
  /// **'Festa em 13 de maio. A mensagem de Fátima: oração, penitência, reparação e o Rosário todos os dias.'**
  String get novenaFatimaDesc;

  /// No description provided for @novenaFatimaOpening.
  ///
  /// In pt, this message translates to:
  /// **'Ó Virgem de Fátima, Mãe do Céu, que viestes ao mundo para pedir oração, penitência e conversão, acolhei esta novena que faço com confiança. Ensinai-me a rezar o terço todos os dias e a oferecer a Deus os meus sacrifícios pela salvação das almas.'**
  String get novenaFatimaOpening;

  /// No description provided for @novenaFatimaClosing.
  ///
  /// In pt, this message translates to:
  /// **'Ó meu Jesus, perdoai-nos, livrai-nos do fogo do inferno, levai as almas todas para o Céu, principalmente as que mais precisarem. Nossa Senhora do Rosário de Fátima, rogai por nós. Amém.'**
  String get novenaFatimaClosing;

  /// No description provided for @novenaFatimaPrayers.
  ///
  /// In pt, this message translates to:
  /// **'Rezar o terço (ou ao menos uma dezena do Rosário) e a oração: \"Ó meu Jesus, perdoai-nos\".'**
  String get novenaFatimaPrayers;

  /// No description provided for @novenaFatimaDay1Title.
  ///
  /// In pt, this message translates to:
  /// **'1º Dia - Rezar o terço todos os dias'**
  String get novenaFatimaDay1Title;

  /// No description provided for @novenaFatimaDay1Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Nossa Senhora pediu que rezássemos o terço diariamente. Dai-me a perseverança para ser fiel a este encontro com a Mãe e com o seu Filho.'**
  String get novenaFatimaDay1Meditation;

  /// No description provided for @novenaFatimaDay2Title.
  ///
  /// In pt, this message translates to:
  /// **'2º Dia - A penitência'**
  String get novenaFatimaDay2Title;

  /// No description provided for @novenaFatimaDay2Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Ensinai-me a aceitar com amor as pequenas cruzes do dia a dia e a oferecê-las a Deus em reparação dos pecados.'**
  String get novenaFatimaDay2Meditation;

  /// No description provided for @novenaFatimaDay3Title.
  ///
  /// In pt, this message translates to:
  /// **'3º Dia - A reparação'**
  String get novenaFatimaDay3Title;

  /// No description provided for @novenaFatimaDay3Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Ó Mãe, quero consolar o Coração de Jesus e o vosso, tão ofendidos. Aceitai a minha oração como reparação pelos pecados do mundo.'**
  String get novenaFatimaDay3Meditation;

  /// No description provided for @novenaFatimaDay4Title.
  ///
  /// In pt, this message translates to:
  /// **'4º Dia - A conversão dos pecadores'**
  String get novenaFatimaDay4Title;

  /// No description provided for @novenaFatimaDay4Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Rezai por mim e por todos os pecadores. Que ninguém se perca, e que cada um volte para os braços do Pai.'**
  String get novenaFatimaDay4Meditation;

  /// No description provided for @novenaFatimaDay5Title.
  ///
  /// In pt, this message translates to:
  /// **'5º Dia - A paz no mundo'**
  String get novenaFatimaDay5Title;

  /// No description provided for @novenaFatimaDay5Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Mãe da Paz, afastai as guerras e os ódios. Fazei de mim um instrumento de paz nos lugares onde vivo.'**
  String get novenaFatimaDay5Meditation;

  /// No description provided for @novenaFatimaDay6Title.
  ///
  /// In pt, this message translates to:
  /// **'6º Dia - O exemplo dos pastorinhos'**
  String get novenaFatimaDay6Title;

  /// No description provided for @novenaFatimaDay6Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Francisco, Jacinta e Lúcia, ensinai-me a simplicidade, a coragem e o espírito de sacrifício com que respondestes ao pedido da Senhora.'**
  String get novenaFatimaDay6Meditation;

  /// No description provided for @novenaFatimaDay7Title.
  ///
  /// In pt, this message translates to:
  /// **'7º Dia - O Imaculado Coração de Maria'**
  String get novenaFatimaDay7Title;

  /// No description provided for @novenaFatimaDay7Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Coração Imaculado de Maria, sede o meu refúgio e o caminho que me conduz a Deus. Em vós quero encontrar abrigo e força.'**
  String get novenaFatimaDay7Meditation;

  /// No description provided for @novenaFatimaDay8Title.
  ///
  /// In pt, this message translates to:
  /// **'8º Dia - A comunhão reparadora'**
  String get novenaFatimaDay8Title;

  /// No description provided for @novenaFatimaDay8Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Quero aproximar-me dos sacramentos com fé: confessar, comungar e rezar o terço nos primeiros sábados, como pedistes.'**
  String get novenaFatimaDay8Meditation;

  /// No description provided for @novenaFatimaDay9Title.
  ///
  /// In pt, this message translates to:
  /// **'9º Dia - A consagração'**
  String get novenaFatimaDay9Title;

  /// No description provided for @novenaFatimaDay9Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Mãe do Céu, consagro-vos a minha vida, a minha família e o mundo inteiro. Que o vosso Imaculado Coração triunfe. Amém.'**
  String get novenaFatimaDay9Meditation;

  /// No description provided for @novenaMisericordiaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novena da Divina Misericórdia'**
  String get novenaMisericordiaTitle;

  /// No description provided for @novenaMisericordiaDesc.
  ///
  /// In pt, this message translates to:
  /// **'Começa na Sexta-feira Santa e termina no sábado antes da Festa da Misericórdia. Cada dia, uma intenção pedida por Jesus a Santa Faustina.'**
  String get novenaMisericordiaDesc;

  /// No description provided for @novenaMisericordiaOpening.
  ///
  /// In pt, this message translates to:
  /// **'Jesus, eu confio em Vós! Fonte de misericórdia, trago a esta novena as almas que me pedis para levar ao vosso Coração. Que o sangue e a água que jorraram do vosso lado sejam o refúgio de toda a humanidade.'**
  String get novenaMisericordiaOpening;

  /// No description provided for @novenaMisericordiaClosing.
  ///
  /// In pt, this message translates to:
  /// **'Eterno Pai, olhai com misericórdia para as almas que Vos apresentei e, pelos méritos da dolorosa Paixão do vosso Filho, derramai sobre elas a vossa graça. Jesus, eu confio em Vós! Amém.'**
  String get novenaMisericordiaClosing;

  /// No description provided for @novenaMisericordiaPrayers.
  ///
  /// In pt, this message translates to:
  /// **'Rezar o Terço da Divina Misericórdia, em favor da intenção do dia.'**
  String get novenaMisericordiaPrayers;

  /// No description provided for @novenaMisericordiaDay1Title.
  ///
  /// In pt, this message translates to:
  /// **'1º Dia - Toda a humanidade, especialmente os pecadores'**
  String get novenaMisericordiaDay1Title;

  /// No description provided for @novenaMisericordiaDay1Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Jesus misericordioso, trago-Vos todos os homens, sobretudo os pecadores. Mergulhai-os no abismo da vossa misericórdia.'**
  String get novenaMisericordiaDay1Meditation;

  /// No description provided for @novenaMisericordiaDay2Title.
  ///
  /// In pt, this message translates to:
  /// **'2º Dia - Os sacerdotes e os religiosos'**
  String get novenaMisericordiaDay2Title;

  /// No description provided for @novenaMisericordiaDay2Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Trago-Vos os sacerdotes e as almas consagradas. Dai-lhes força para serem fiéis e para levarem a luz da vossa misericórdia aos outros.'**
  String get novenaMisericordiaDay2Meditation;

  /// No description provided for @novenaMisericordiaDay3Title.
  ///
  /// In pt, this message translates to:
  /// **'3º Dia - As almas piedosas e fiéis'**
  String get novenaMisericordiaDay3Title;

  /// No description provided for @novenaMisericordiaDay3Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Trago-Vos as almas devotas e fiéis. Fortalecei-as em suas provações e fazei-as crescer no vosso amor.'**
  String get novenaMisericordiaDay3Meditation;

  /// No description provided for @novenaMisericordiaDay4Title.
  ///
  /// In pt, this message translates to:
  /// **'4º Dia - Os que ainda não conhecem Jesus'**
  String get novenaMisericordiaDay4Title;

  /// No description provided for @novenaMisericordiaDay4Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Trago-Vos os que ainda não Vos conhecem. Que a luz do vosso Coração os ilumine e os atraia a Vós.'**
  String get novenaMisericordiaDay4Meditation;

  /// No description provided for @novenaMisericordiaDay5Title.
  ///
  /// In pt, this message translates to:
  /// **'5º Dia - Os que se afastaram da Igreja'**
  String get novenaMisericordiaDay5Title;

  /// No description provided for @novenaMisericordiaDay5Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Trago-Vos os que se separaram da unidade da Igreja. Reconduzi-os à comunhão, para que todos sejam um.'**
  String get novenaMisericordiaDay5Meditation;

  /// No description provided for @novenaMisericordiaDay6Title.
  ///
  /// In pt, this message translates to:
  /// **'6º Dia - Os mansos, os humildes e as crianças'**
  String get novenaMisericordiaDay6Title;

  /// No description provided for @novenaMisericordiaDay6Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Trago-Vos as almas mansas e humildes e as crianças. Que encontrem repouso no vosso Coração.'**
  String get novenaMisericordiaDay6Meditation;

  /// No description provided for @novenaMisericordiaDay7Title.
  ///
  /// In pt, this message translates to:
  /// **'7º Dia - Os que veneram a Misericórdia'**
  String get novenaMisericordiaDay7Title;

  /// No description provided for @novenaMisericordiaDay7Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Trago-Vos as almas que veneram e glorificam a vossa misericórdia. Que sejam apóstolos da confiança em Vós.'**
  String get novenaMisericordiaDay7Meditation;

  /// No description provided for @novenaMisericordiaDay8Title.
  ///
  /// In pt, this message translates to:
  /// **'8º Dia - As almas do Purgatório'**
  String get novenaMisericordiaDay8Title;

  /// No description provided for @novenaMisericordiaDay8Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Trago-Vos as almas do Purgatório. Que o sangue e a água do vosso lado as refresquem e as levem à alegria do Céu.'**
  String get novenaMisericordiaDay8Meditation;

  /// No description provided for @novenaMisericordiaDay9Title.
  ///
  /// In pt, this message translates to:
  /// **'9º Dia - As almas tépidas'**
  String get novenaMisericordiaDay9Title;

  /// No description provided for @novenaMisericordiaDay9Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Trago-Vos as almas tíbias e frias. Reacendei nelas o fogo do vosso amor e dai-lhes a graça de recomeçar. Amém.'**
  String get novenaMisericordiaDay9Meditation;

  /// No description provided for @novenaSantoAntonioTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novena a Santo Antônio'**
  String get novenaSantoAntonioTitle;

  /// No description provided for @novenaSantoAntonioDesc.
  ///
  /// In pt, this message translates to:
  /// **'Festa em 13 de junho. Doutor da Igreja, pregador do Evangelho e amigo dos pobres, invocado por quem busca o que perdeu.'**
  String get novenaSantoAntonioDesc;

  /// No description provided for @novenaSantoAntonioOpening.
  ///
  /// In pt, this message translates to:
  /// **'Glorioso Santo Antônio, doutor do Evangelho e amigo dos pobres, que Deus encheu de sabedoria e de bondade, escutai os meus pedidos. Ajudai-me a encontrar o que me falta e, sobretudo, a encontrar sempre Jesus.'**
  String get novenaSantoAntonioOpening;

  /// No description provided for @novenaSantoAntonioClosing.
  ///
  /// In pt, this message translates to:
  /// **'Santo Antônio, intercessor poderoso, apresentai a Deus as nossas necessidades. Fazei que, por vossa intercessão, encontremos o que perdemos e, acima de tudo, não percamos jamais a graça de Deus. Amém.'**
  String get novenaSantoAntonioClosing;

  /// No description provided for @novenaSantoAntonioPrayers.
  ///
  /// In pt, this message translates to:
  /// **'Rezar 1 Pai-Nosso, 1 Ave-Maria e 1 Glória ao Pai, e o Responso a Santo Antônio, se desejar.'**
  String get novenaSantoAntonioPrayers;

  /// No description provided for @novenaSantoAntonioDay1Title.
  ///
  /// In pt, this message translates to:
  /// **'1º Dia - Pregador do Evangelho'**
  String get novenaSantoAntonioDay1Title;

  /// No description provided for @novenaSantoAntonioDay1Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Santo Antônio, que anunciastes a Palavra com a vida e com os lábios, dai-me o desejo de conhecer e viver o Evangelho.'**
  String get novenaSantoAntonioDay1Meditation;

  /// No description provided for @novenaSantoAntonioDay2Title.
  ///
  /// In pt, this message translates to:
  /// **'2º Dia - Doutor da Igreja'**
  String get novenaSantoAntonioDay2Title;

  /// No description provided for @novenaSantoAntonioDay2Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Sábio mestre das Escrituras, ensinai-me a unir a fé e a inteligência e a defender a verdade com humildade e caridade.'**
  String get novenaSantoAntonioDay2Meditation;

  /// No description provided for @novenaSantoAntonioDay3Title.
  ///
  /// In pt, this message translates to:
  /// **'3º Dia - Amigo dos pobres'**
  String get novenaSantoAntonioDay3Title;

  /// No description provided for @novenaSantoAntonioDay3Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Vós que repartistes o que tínheis, abri o meu coração aos necessitados e livrai-me do apego ao dinheiro.'**
  String get novenaSantoAntonioDay3Meditation;

  /// No description provided for @novenaSantoAntonioDay4Title.
  ///
  /// In pt, this message translates to:
  /// **'4º Dia - Modelo de humildade'**
  String get novenaSantoAntonioDay4Title;

  /// No description provided for @novenaSantoAntonioDay4Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Santo Antônio, que escolhestes o último lugar, livrai-me do orgulho e da vaidade e ensinai-me a servir sem esperar reconhecimento.'**
  String get novenaSantoAntonioDay4Meditation;

  /// No description provided for @novenaSantoAntonioDay5Title.
  ///
  /// In pt, this message translates to:
  /// **'5º Dia - Taumaturgo'**
  String get novenaSantoAntonioDay5Title;

  /// No description provided for @novenaSantoAntonioDay5Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Santo dos milagres, que Deus operou prodígios por vosso intermédio, fortalecei a minha fé nas promessas do Senhor.'**
  String get novenaSantoAntonioDay5Meditation;

  /// No description provided for @novenaSantoAntonioDay6Title.
  ///
  /// In pt, this message translates to:
  /// **'6º Dia - Protetor do que se perdeu'**
  String get novenaSantoAntonioDay6Title;

  /// No description provided for @novenaSantoAntonioDay6Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Ajudai-me a encontrar as coisas perdidas, e também a paz, o rumo e a fé que eu possa ter perdido pelo caminho.'**
  String get novenaSantoAntonioDay6Meditation;

  /// No description provided for @novenaSantoAntonioDay7Title.
  ///
  /// In pt, this message translates to:
  /// **'7º Dia - Protetor das famílias'**
  String get novenaSantoAntonioDay7Title;

  /// No description provided for @novenaSantoAntonioDay7Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Abençoai os casais, os noivos e as famílias. Que vivam unidos no amor e na fidelidade a Deus.'**
  String get novenaSantoAntonioDay7Meditation;

  /// No description provided for @novenaSantoAntonioDay8Title.
  ///
  /// In pt, this message translates to:
  /// **'8º Dia - Devoto da Eucaristia'**
  String get novenaSantoAntonioDay8Title;

  /// No description provided for @novenaSantoAntonioDay8Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Santo Antônio, que adorastes Jesus no Santíssimo Sacramento, ensinai-me a amar a Eucaristia e a recebê-la com fé.'**
  String get novenaSantoAntonioDay8Meditation;

  /// No description provided for @novenaSantoAntonioDay9Title.
  ///
  /// In pt, this message translates to:
  /// **'9º Dia - Intercessor junto a Deus'**
  String get novenaSantoAntonioDay9Title;

  /// No description provided for @novenaSantoAntonioDay9Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Levai ao Senhor os meus pedidos e dai-me confiança no vosso auxílio. Que eu alcance a graça de que preciso e o Céu que espero. Amém.'**
  String get novenaSantoAntonioDay9Meditation;

  /// No description provided for @novenaSantaRitaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novena a Santa Rita de Cássia'**
  String get novenaSantaRitaTitle;

  /// No description provided for @novenaSantaRitaDesc.
  ///
  /// In pt, this message translates to:
  /// **'Festa em 22 de maio. Esposa, mãe, viúva e religiosa, invocada nas causas difíceis e desesperadas.'**
  String get novenaSantaRitaDesc;

  /// No description provided for @novenaSantaRitaOpening.
  ///
  /// In pt, this message translates to:
  /// **'Santa Rita, advogada das causas impossíveis, que levastes a vida inteira unida a Cristo crucificado, escutai o meu pedido. Alcançai-me de Deus a graça de que preciso, se for para a sua glória e para o bem da minha alma.'**
  String get novenaSantaRitaOpening;

  /// No description provided for @novenaSantaRitaClosing.
  ///
  /// In pt, this message translates to:
  /// **'Santa Rita de Cássia, mulher de oração e de perdão, rogai por nós. Alcançai-nos paciência nas cruzes, paz nas famílias e a graça de confiar em Deus quando tudo parece perdido. Amém.'**
  String get novenaSantaRitaClosing;

  /// No description provided for @novenaSantaRitaPrayers.
  ///
  /// In pt, this message translates to:
  /// **'Rezar 1 Pai-Nosso, 3 Ave-Marias e 1 Glória ao Pai.'**
  String get novenaSantaRitaPrayers;

  /// No description provided for @novenaSantaRitaDay1Title.
  ///
  /// In pt, this message translates to:
  /// **'1º Dia - Esposa paciente'**
  String get novenaSantaRitaDay1Title;

  /// No description provided for @novenaSantaRitaDay1Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Santa Rita, que suportastes com paciência um casamento difícil, dai-me paz e fortaleza nas provações da vida em família.'**
  String get novenaSantaRitaDay1Meditation;

  /// No description provided for @novenaSantaRitaDay2Title.
  ///
  /// In pt, this message translates to:
  /// **'2º Dia - Mãe dedicada'**
  String get novenaSantaRitaDay2Title;

  /// No description provided for @novenaSantaRitaDay2Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Rezai por todas as mães e pelos filhos. Que eu saiba educar na fé, com amor e firmeza.'**
  String get novenaSantaRitaDay2Meditation;

  /// No description provided for @novenaSantaRitaDay3Title.
  ///
  /// In pt, this message translates to:
  /// **'3º Dia - Mulher de perdão'**
  String get novenaSantaRitaDay3Title;

  /// No description provided for @novenaSantaRitaDay3Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Vós que perdoastes os assassinos de vosso marido, ensinai-me a perdoar de coração quem me feriu.'**
  String get novenaSantaRitaDay3Meditation;

  /// No description provided for @novenaSantaRitaDay4Title.
  ///
  /// In pt, this message translates to:
  /// **'4º Dia - Viúva confiante'**
  String get novenaSantaRitaDay4Title;

  /// No description provided for @novenaSantaRitaDay4Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Consolai os que choram a perda de alguém querido e os que vivem na solidão. Que encontrem em Deus a sua esperança.'**
  String get novenaSantaRitaDay4Meditation;

  /// No description provided for @novenaSantaRitaDay5Title.
  ///
  /// In pt, this message translates to:
  /// **'5º Dia - Religiosa obediente'**
  String get novenaSantaRitaDay5Title;

  /// No description provided for @novenaSantaRitaDay5Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Santa Rita, que vencestes as dificuldades para consagrar a vida a Deus, ajudai-me a perseverar no que o Senhor me pede.'**
  String get novenaSantaRitaDay5Meditation;

  /// No description provided for @novenaSantaRitaDay6Title.
  ///
  /// In pt, this message translates to:
  /// **'6º Dia - Amante da Paixão de Cristo'**
  String get novenaSantaRitaDay6Title;

  /// No description provided for @novenaSantaRitaDay6Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Vós que recebestes em vossa fronte um espinho do Senhor, fazei-me compreender o valor do sofrimento unido à cruz de Jesus.'**
  String get novenaSantaRitaDay6Meditation;

  /// No description provided for @novenaSantaRitaDay7Title.
  ///
  /// In pt, this message translates to:
  /// **'7º Dia - Pacificadora'**
  String get novenaSantaRitaDay7Title;

  /// No description provided for @novenaSantaRitaDay7Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Santa Rita, que reconciliastes inimigos, levai a paz às famílias divididas e aos corações endurecidos.'**
  String get novenaSantaRitaDay7Meditation;

  /// No description provided for @novenaSantaRitaDay8Title.
  ///
  /// In pt, this message translates to:
  /// **'8º Dia - Advogada das causas impossíveis'**
  String get novenaSantaRitaDay8Title;

  /// No description provided for @novenaSantaRitaDay8Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Intercedei por esta causa que parece sem saída. Alcançai-me a graça, ou a força para aceitar a vontade de Deus.'**
  String get novenaSantaRitaDay8Meditation;

  /// No description provided for @novenaSantaRitaDay9Title.
  ///
  /// In pt, this message translates to:
  /// **'9º Dia - Consolo dos doentes'**
  String get novenaSantaRitaDay9Title;

  /// No description provided for @novenaSantaRitaDay9Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Santa Rita, socorrei os enfermos e os que sofrem em corpo e alma. Que eu confie sempre na bondade do Senhor. Amém.'**
  String get novenaSantaRitaDay9Meditation;

  /// No description provided for @novenaCristoReiTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novena a Cristo Rei'**
  String get novenaCristoReiTitle;

  /// No description provided for @novenaCristoReiDesc.
  ///
  /// In pt, this message translates to:
  /// **'Solenidade de Nosso Senhor Jesus Cristo, Rei do Universo, no último domingo do Tempo Comum. Nove dias para pedir que Cristo reine em nossa vida.'**
  String get novenaCristoReiDesc;

  /// No description provided for @novenaCristoReiOpening.
  ///
  /// In pt, this message translates to:
  /// **'Senhor Jesus Cristo, Rei do Universo, eu me coloco diante de Vós para Vos reconhecer como meu Senhor e meu Rei. Vinde reinar em meu coração, em minha família e em toda a sociedade.'**
  String get novenaCristoReiOpening;

  /// No description provided for @novenaCristoReiClosing.
  ///
  /// In pt, this message translates to:
  /// **'Cristo Rei, Príncipe da Paz, venha a nós o vosso Reino de verdade, de justiça, de amor e de paz. Reinai em nossos corações, em nossos lares e em nossas nações, agora e para sempre. Amém.'**
  String get novenaCristoReiClosing;

  /// No description provided for @novenaCristoReiPrayers.
  ///
  /// In pt, this message translates to:
  /// **'Rezar 1 Pai-Nosso, 1 Ave-Maria e 1 Glória ao Pai, e a ladainha do Sagrado Coração, se desejar.'**
  String get novenaCristoReiPrayers;

  /// No description provided for @novenaCristoReiDay1Title.
  ///
  /// In pt, this message translates to:
  /// **'1º Dia - Rei do Universo'**
  String get novenaCristoReiDay1Title;

  /// No description provided for @novenaCristoReiDay1Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Senhor Jesus, por Vós todas as coisas foram criadas. Ensinai-me a reconhecer a vossa soberania sobre o mundo e sobre a minha vida.'**
  String get novenaCristoReiDay1Meditation;

  /// No description provided for @novenaCristoReiDay2Title.
  ///
  /// In pt, this message translates to:
  /// **'2º Dia - Rei da Verdade'**
  String get novenaCristoReiDay2Title;

  /// No description provided for @novenaCristoReiDay2Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Vós viestes dar testemunho da verdade. Dai-me a graça de viver na verdade e de nunca me envergonhar do Evangelho.'**
  String get novenaCristoReiDay2Meditation;

  /// No description provided for @novenaCristoReiDay3Title.
  ///
  /// In pt, this message translates to:
  /// **'3º Dia - Rei da Paz'**
  String get novenaCristoReiDay3Title;

  /// No description provided for @novenaCristoReiDay3Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Príncipe da Paz, desarmai o meu coração e as nações. Fazei de mim um construtor da paz que só Vós podeis dar.'**
  String get novenaCristoReiDay3Meditation;

  /// No description provided for @novenaCristoReiDay4Title.
  ///
  /// In pt, this message translates to:
  /// **'4º Dia - Rei de misericórdia'**
  String get novenaCristoReiDay4Title;

  /// No description provided for @novenaCristoReiDay4Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Rei que perdoa, acolhei-me quando caio. Que eu receba o vosso perdão e o leve aos meus irmãos.'**
  String get novenaCristoReiDay4Meditation;

  /// No description provided for @novenaCristoReiDay5Title.
  ///
  /// In pt, this message translates to:
  /// **'5º Dia - Rei dos corações'**
  String get novenaCristoReiDay5Title;

  /// No description provided for @novenaCristoReiDay5Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Reinai em meus pensamentos, desejos e afetos. Que nada em mim seja contrário à vossa vontade.'**
  String get novenaCristoReiDay5Meditation;

  /// No description provided for @novenaCristoReiDay6Title.
  ///
  /// In pt, this message translates to:
  /// **'6º Dia - Rei das famílias'**
  String get novenaCristoReiDay6Title;

  /// No description provided for @novenaCristoReiDay6Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Que o vosso reino de amor se estabeleça em nossos lares. Que a oração e o perdão sejam o alicerce de cada família.'**
  String get novenaCristoReiDay6Meditation;

  /// No description provided for @novenaCristoReiDay7Title.
  ///
  /// In pt, this message translates to:
  /// **'7º Dia - Rei das nações'**
  String get novenaCristoReiDay7Title;

  /// No description provided for @novenaCristoReiDay7Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Iluminai os governantes e os povos. Que as leis e as sociedades respeitem a dignidade da pessoa e o bem comum.'**
  String get novenaCristoReiDay7Meditation;

  /// No description provided for @novenaCristoReiDay8Title.
  ///
  /// In pt, this message translates to:
  /// **'8º Dia - Rei eucarístico'**
  String get novenaCristoReiDay8Title;

  /// No description provided for @novenaCristoReiDay8Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Vós reinais no altar e no Sacrário. Ensinai-me a adorar-Vos e a Vos receber com amor e reverência.'**
  String get novenaCristoReiDay8Meditation;

  /// No description provided for @novenaCristoReiDay9Title.
  ///
  /// In pt, this message translates to:
  /// **'9º Dia - Rei da glória'**
  String get novenaCristoReiDay9Title;

  /// No description provided for @novenaCristoReiDay9Meditation.
  ///
  /// In pt, this message translates to:
  /// **'Que eu um dia contemple a vossa glória e reine convosco no Céu. Venha a nós o vosso Reino. Amém.'**
  String get novenaCristoReiDay9Meditation;

  /// No description provided for @novenaSuggestLabel.
  ///
  /// In pt, this message translates to:
  /// **'Sugestão para esta época'**
  String get novenaSuggestLabel;

  /// No description provided for @novenaSuggestAction.
  ///
  /// In pt, this message translates to:
  /// **'Ver novena'**
  String get novenaSuggestAction;

  /// No description provided for @novenaSuggestToday.
  ///
  /// In pt, this message translates to:
  /// **'Hoje é o dia ideal para começar: a festa é em {date}.'**
  String novenaSuggestToday(String date);

  /// No description provided for @novenaSuggestSoon.
  ///
  /// In pt, this message translates to:
  /// **'Começa em {days, plural, =1{1 dia} other{{days} dias}}; a festa é em {date}.'**
  String novenaSuggestSoon(int days, String date);

  /// No description provided for @novenaSuggestLate.
  ///
  /// In pt, this message translates to:
  /// **'Ainda dá tempo: a festa é em {date}.'**
  String novenaSuggestLate(String date);

  /// No description provided for @prayerStFrancisPeaceTitle.
  ///
  /// In pt, this message translates to:
  /// **'Oração da Paz (São Francisco)'**
  String get prayerStFrancisPeaceTitle;

  /// No description provided for @prayerStFrancisPeaceContent.
  ///
  /// In pt, this message translates to:
  /// **'Senhor, fazei-me instrumento de vossa paz.\nOnde houver ódio, que eu leve o amor;\nOnde houver ofensa, que eu leve o perdão;\nOnde houver discórdia, que eu leve a união;\nOnde houver dúvida, que eu leve a fé;\nOnde houver erro, que eu leve a verdade;\nOnde houver desespero, que eu leve a esperança;\nOnde houver tristeza, que eu leve a alegria;\nOnde houver trevas, que eu leve a luz.\n\nÓ Mestre, fazei que eu procure mais\nConsolar, que ser consolado;\nCompreender, que ser compreendido;\nAmar, que ser amado.\nPois é dando que se recebe,\nÉ perdoando que se é perdoado,\nE é morrendo que se vive para a vida eterna.\n\nAmém.'**
  String get prayerStFrancisPeaceContent;

  /// No description provided for @prayerStFrancisPeaceContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Domine, fac me servum pacis tuae.\nUbi odium est, ibi caritatem afferam;\nubi iniuria, veniam;\nubi discordia, concordiam;\nubi dubium, fidem;\nubi error, veritatem;\nubi desperatio, spem;\nubi tristitia, laetitiam;\nubi tenebrae, lucem.\n\nO Magister, fac ut non quaeram\nconsolari, sed consolare;\nintellegi, sed intellegere;\namari, sed amare.\nQuia dando accipitur,\nignoscendo ignoscitur,\net moriendo ad vitam aeternam resurgitur.\n\nAmen.'**
  String get prayerStFrancisPeaceContentLatin;

  /// No description provided for @prayerStBenedictMedalTitle.
  ///
  /// In pt, this message translates to:
  /// **'Medalha de São Bento'**
  String get prayerStBenedictMedalTitle;

  /// No description provided for @prayerStBenedictMedalContent.
  ///
  /// In pt, this message translates to:
  /// **'A Cruz Sagrada seja a minha luz,\nNão seja o dragão meu guia.\nRetira-te, satanás!\nNunca me aconselhes coisas vãs.\nÉ mau o que tu me ofereces,\nBebe tu mesmo o teu veneno.\n\nEm nome do Pai, e do Filho e do Espírito Santo.\n\nAmém.'**
  String get prayerStBenedictMedalContent;

  /// No description provided for @prayerStBenedictMedalContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Crux sacra sit mihi lux,\nnon draco sit mihi dux.\nVade retro, Satana!\nNumquam suade mihi vana;\nsunt mala quae libas,\nipse venena bibas.\n\nIn nomine Patris, et Filii, et Spiritus Sancti.\n\nAmen.'**
  String get prayerStBenedictMedalContentLatin;

  /// No description provided for @prayerUniversalClementTitle.
  ///
  /// In pt, this message translates to:
  /// **'Oração Universal (Papa Clemente XI)'**
  String get prayerUniversalClementTitle;

  /// No description provided for @prayerUniversalClementContent.
  ///
  /// In pt, this message translates to:
  /// **'Creio, Senhor, mas fazei que eu creia com mais firmeza; espero, mas fazei que eu espere com mais segurança; amo-Vos, mas fazei que eu Vos ame com mais ardor; arrependo-me, mas fazei que eu me arrependa com mais veemência.\n\nAdoro-Vos como primeiro princípio; desejo-Vos como fim último; louvo-Vos como benfeitor perpétuo; invoco-Vos como defensor propício.\n\nDirigi-me com a vossa sabedoria, contei-me com a vossa justiça, consolai-me com a vossa clemência, protegei-me com o vosso poder.\n\nOfereço-Vos, Senhor, os meus pensamentos, para que sejam para Vós; as minhas palavras, para que sejam de Vós; as minhas obras, para que sejam segundo Vós; e os meus sofrimentos, para que sejam por Vós.\n\nQuero tudo o que quereis, quero porque quereis, quero do modo como quereis e enquanto o quiserdes.\n\nPeço-Vos, Senhor: iluminai o meu entendimento, inflamai a minha vontade, purificai o meu coração e santificai a minha alma.\n\nNão seja eu contaminado pela soberba, nem seduzido pela adulação, nem enganado pelo mundo, nem surpreendido por Satanás.\n\nConcedei-me a graça de purificar a memória, refrear a língua, guardar os olhos e reprimir os sentidos.\n\nChore eu as iniquidades passadas, repila as tentações futuras, corrija as inclinações viciosas e cultive as virtudes convenientes.\n\nConcedei-me, bom Deus, o amor de Vós, o desapego de mim mesmo, o zelo pelo próximo e o desprezo do mundo.\n\nEsforce-me por obedecer aos superiores, socorrer os inferiores, aconselhar os amigos e a ninguém invejar.\n\nLembre-me eu, ó Jesus, do vosso mandamento e exemplo, amando os inimigos, sofrendo as injúrias, fazendo bem aos que me perseguem e orando pelos que me caluniam.\n\nVença eu o prazer sensual pela austeridade, a avareza pela largueza, a ira pela mansidão e a tibieza pela piedade.\n\nTornai-me prudente nos conselhos, constante nos perigos, paciente nas adversidades e humilde nas prosperidades.\n\nFazei, Senhor, que eu seja atento na oração, sóbrio nas refeições, diligente nos deveres e firme nos propósitos.\n\nProcure eu ter santidade interior, modéstia exterior, trato exemplar e vida regrada.\n\nVele eu constantemente para domar a natureza, alimentar a graça, guardar a vossa lei e merecer a salvação.\n\nAlcance eu a santidade pela sincera confissão dos pecados, pela fervorosa comunhão do Corpo de Cristo, pelo contínuo recolhimento da mente e pela pura intenção do coração.\n\nAprenda eu de Vós, meu Deus, quão pequeno é o que é terreno, quão grande o que é divino, quão breve o que é temporal e quão durável o que é eterno. Amém.'**
  String get prayerUniversalClementContent;

  /// No description provided for @prayerUniversalClementContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Credo, Domine, sed credam firmius; spero, sed sperem securius; amo, sed amem ardentius; doleo, sed doleam vehementius.\n\nAdoro te ut primum principium; desidero ut finem ultimum; laudo ut benefactorem perpetuum; invoco ut defensorem propitium.\n\nTua me sapientia dirige, iustitia contine, clementia solare, potentia protege.\n\nOffero tibi, Domine, cogitanda, ut sint ad te; dicenda, ut sint de te; facienda, ut sint secundum te; ferenda, ut sint propter te.\n\nVolo quidquid vis, volo quia vis, volo quomodo vis, volo quamdiu vis.\n\nOro, Domine: intellectum illumines, voluntatem inflammes, cor emundes, animam sanctifices.\n\nA superbia non inficiar; adulatione non afficiar; a mundo non decipiar; a Satana non circumveniar.\n\nGratiam praesta memoriam purgandi, linguam frenandi, oculos cohibendi, sensus coercendi.\n\nDefleam praeteritas iniquitates, repellam futuras tentationes, corrigam vitiosas propensiones, excolam idoneas virtutes.\n\nTribue mihi, bone Deus, amorem tui, odium mei, zelum proximi, contemptum mundi.\n\nStudeam superioribus oboedire, inferioribus subvenire, amicis consulere, nemini invidere.\n\nMeminerim, o Iesu, mandati tui et exempli, inimicos diligendo, iniurias sufferendo, persequentibus benefaciendo, pro calumniantibus orando.\n\nVincam voluptatem austeritate, avaritiam largitate, iracundiam lenitate, tepiditatem pietate.\n\nRedde me prudentem in consiliis, constantem in periculis, patientem in adversis, humilem in prosperis.\n\nFac, Domine, ut sim in oratione attentus, in epulis sobrius, in munere sedulus, in proposito firmus.\n\nCurem habere sanctitatem interiorem, modestiam exteriorem, conversationem exemplarem, vitam regularem.\n\nNaturae invigilem domandae, gratiae fovendae, legi servandae, saluti promerendae.\n\nSanctimoniam assequar sincera peccatorum confessione, fervida Corporis Christi communione, continua mentis recollectione, pura cordis intentione.\n\nDiscam a te, Deus, quam tenue, quod terrenum; quam grande, quod divinum; quam breve, quod temporaneum; quam durabile, quod aeternum. Amen.'**
  String get prayerUniversalClementContentLatin;

  /// No description provided for @prayerStTeresaAvilaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Nada te perturbe (Santa Teresa d\'Ávila)'**
  String get prayerStTeresaAvilaTitle;

  /// No description provided for @prayerStTeresaAvilaContent.
  ///
  /// In pt, this message translates to:
  /// **'Nada te perturbe,\nNada te espante,\nTudo passa.\nDeus não muda.\nA paciência tudo alcança.\nQuem a Deus tem,\nNada lhe falta:\nSó Deus basta.\n\nAmém.'**
  String get prayerStTeresaAvilaContent;

  /// No description provided for @prayerStTeresaAvilaContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Nihil te perturbet,\nnihil te terreat,\nomnia transeunt.\nDeus non mutatur.\nPatientia omnia assequitur.\nQui Deum habet,\nnihil illi deest:\nsolus Deus sufficit.\n\nAmen.'**
  String get prayerStTeresaAvilaContentLatin;

  /// No description provided for @prayerStAugustineTitle.
  ///
  /// In pt, this message translates to:
  /// **'Tarde Te amei (Santo Agostinho)'**
  String get prayerStAugustineTitle;

  /// No description provided for @prayerStAugustineContent.
  ///
  /// In pt, this message translates to:
  /// **'Tarde Te amei, ó Beleza tão antiga e tão nova, tarde Te amei! Eis que habitavas dentro de mim e eu Te procurava fora! Eu, disforme, lançava-me sobre as belas formas das Tuas criaturas. Estavas comigo e eu não estava contigo. Retinham-me longe de Ti as coisas que não existiriam se não existissem em Ti.\n\nChamaste-me, clamaste por mim e rompeste a minha surdez. Brilhaste, resplandeceste e dissipaste a minha cegueira. Exalaste o Teu perfume: aspirei-o e suspiro por Ti. Provei-Te e agora tenho fome e sede de Ti. Tocaste-me e abrasei-me na Tua paz.\n\nAmém.'**
  String get prayerStAugustineContent;

  /// No description provided for @prayerStAugustineContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Sero te amavi, pulchritudo tam antiqua et tam nova, sero te amavi! Et ecce intus eras et ego foris, et ibi te quaerebam, et in ista formosa, quae fecisti, deformis irruebam. Mecum eras, et tecum non eram. Ea me tenebant longe a te, quae si in te non essent, non essent.\n\nVocasti et clamasti et rupisti surditatem meam; coruscasti, splenduisti et fugasti caecitatem meam; fragrasti, et duxi spiritum et anhelo tibi; gustavi et esurio et sitio; tetigisti me, et exarsi in pacem tuam.\n\nAmen.'**
  String get prayerStAugustineContentLatin;

  /// No description provided for @prayerStAnthonyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Oração a Santo Antônio'**
  String get prayerStAnthonyTitle;

  /// No description provided for @prayerStAnthonyContent.
  ///
  /// In pt, this message translates to:
  /// **'Ó Santo Antônio, o mais afável e bondoso dos santos, vosso amor a Deus e vossa caridade com o próximo vos tornaram digno, na terra, de operar milagres e prodígios. Animado por esta confiança, a vós recorro com filial devoção.\n\nÓ terno e milagroso Santo Antônio, cujo coração sempre transbordou de simpatia humana, apresentai a minha prece ao Menino Jesus, que tanto se alegrava em repousar em vossos braços. Uma só palavra vossa alcançará a graça de que tanto necessito.\n\nCompadecei-vos de mim e alcançai-me esta graça, para que o meu coração eternamente vos louve e agradeça, e sobretudo alcance a fidelidade aos mandamentos de Deus até o fim da minha vida.\n\nV. Rogai por nós, bem-aventurado Santo Antônio.\nR. Para que sejamos dignos das promessas de Cristo.\n\nAmém.'**
  String get prayerStAnthonyContent;

  /// No description provided for @prayerStAnthonyContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'O beate Antoni, sanctorum mitissime, cuius caritas in Deum ac proximum te miraculis clarum fecit in terris. Eadem fiducia recreati, ad te supplices confugimus ut gratiam quam fidenter expetimus impetrare digneris.\n\nO dulcissime Sancte Antoni, cuius pectus misericordia redundabat, affer precem nostram ad aures Divini Infantis Iesu, qui in ulnis tuis requiescere gaudebat. Sufficit enim verbum tuum ut nostra exaudiatur petitio.\n\nMiserere nostri et hanc gratiam impetra, ut gratias tibi semper agamus, et praesertim mandatis Dei usque ad vitae finem fideles maneamus.\n\nV. Ora pro nobis, beate Antoni.\nR. Ut digni efficiamur promissionibus Christi.\n\nAmen.'**
  String get prayerStAnthonyContentLatin;

  /// No description provided for @prayerStRitaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Oração a Santa Rita de Cássia'**
  String get prayerStRitaTitle;

  /// No description provided for @prayerStRitaContent.
  ///
  /// In pt, this message translates to:
  /// **'Ó poderosa e gloriosa Santa Rita de Cássia, eis a vossos pés uma alma desamparada que, necessitando de auxílio, a vós recorre com a doce esperança de ser atendida por vós, que tendes o incomparável título de Santa dos Casos Impossíveis e Desesperados.\n\nÓ cara Santa, tomai interesse pela minha causa, intercedei junto de Deus para que me conceda a graça de que tanto necessito. Não permitais que eu tenha de me afastar dos vossos pés sem ser atendido.\n\nSe houver em mim algum obstáculo que me impeça de alcançar a graça que imploro, ajudai-me a afastá-lo. Olhai para os meus sofrimentos e abençoai o meu coração desolado com a vossa eficaz intercessão. Confiando no vosso poder junto ao Sagrado Coração de Jesus, eu vos suplico que me alcanceis esta graça.\n\nV. Rogai por nós, Santa Rita, advogada dos impossíveis.\nR. Para que sejamos dignos das promessas de Cristo.\n\nAmém.'**
  String get prayerStRitaContent;

  /// No description provided for @prayerStRitaContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'O potens et gloriosa Sancta Rita, ecce ad pedes tuos afflicta anima, quae ad te confugit spe plena exaudiendi a te, quae Patrona Causarum Impossibilium et Desperatarum merito appellaris.\n\nO dilecta Sancta, suscipe causam meam, intercede pro me apud Deum ut gratiam qua vehementer indigeo consequi merear. Noli me a pedibus tuis vacuum dimittere.\n\nSi quid in me est quod divinae gratiae obstet, adiuva me ut illud expellam. Respice tribulationes meas et consolare cor meum maerens. Fidens potentia tua apud Sacratissimum Cor Iesu, auxilium tuum imploro.\n\nV. Ora pro nobis, Sancta Rita, patrona impossibilium.\nR. Ut digni efficiamur promissionibus Christi.\n\nAmen.'**
  String get prayerStRitaContentLatin;

  /// No description provided for @prayerLitanyHumilityTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ladainha da Humildade'**
  String get prayerLitanyHumilityTitle;

  /// No description provided for @prayerLitanyHumilityContent.
  ///
  /// In pt, this message translates to:
  /// **'Ó Jesus, manso e humilde de coração, ouvi-me.\n\nDo desejo de ser estimado, livrai-me, Jesus.\nDo desejo de ser amado, livrai-me, Jesus.\nDo desejo de ser louvado, livrai-me, Jesus.\nDo desejo de ser honrado, livrai-me, Jesus.\nDo desejo de ser preferido aos outros, livrai-me, Jesus.\nDo desejo de ser consultado, livrai-me, Jesus.\nDo desejo de ser aprovado, livrai-me, Jesus.\n\nDo temor de ser humilhado, livrai-me, Jesus.\nDo temor de ser desprezado, livrai-me, Jesus.\nDo temor de ser repreendido, livrai-me, Jesus.\nDo temor de ser caluniado, livrai-me, Jesus.\nDo temor de ser esquecido, livrai-me, Jesus.\nDo temor de ser ridicularizado, livrai-me, Jesus.\nDo temor de ser injuriado, livrai-me, Jesus.\nDo temor de ser suspeito, livrai-me, Jesus.\n\nQue os outros sejam mais amados do que eu, Jesus, dai-me a graça de o desejar.\nQue os outros sejam mais estimados do que eu, Jesus, dai-me a graça de o desejar.\nQue os outros cresçam na opinião do mundo e que eu diminua, Jesus, dai-me a graça de o desejar.\nQue os outros sejam escolhidos e eu posto de lado, Jesus, dai-me a graça de o desejar.\nQue os outros sejam louvados e eu esquecido, Jesus, dai-me a graça de o desejar.\nQue os outros sejam preferidos a mim em tudo, Jesus, dai-me a graça de o desejar.\nQue os outros se tornem mais santos do que eu, contanto que eu me torne tão santo quanto puder, Jesus, dai-me a graça de o desejar.\n\nAmém.'**
  String get prayerLitanyHumilityContent;

  /// No description provided for @prayerLitanyHumilityContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Iesu, mitis et humilis corde, exaudi me.\n\nA desiderio aestimandi, libera me, Iesu.\nA desiderio amandi, libera me, Iesu.\nA desiderio laudandi, libera me, Iesu.\nA desiderio honorandi, libera me, Iesu.\nA desiderio praeferendi aliis, libera me, Iesu.\nA desiderio consulendi, libera me, Iesu.\nA desiderio approbandi, libera me, Iesu.\n\nA timore humiliandi, libera me, Iesu.\nA timore contemnendi, libera me, Iesu.\nA timore reprehendendi, libera me, Iesu.\nA timore calumniandi, libera me, Iesu.\nA timore oblivioni tradendi, libera me, Iesu.\nA timore irridendi, libera me, Iesu.\nA timore iniuria afficiendi, libera me, Iesu.\nA timore suspecti habendi, libera me, Iesu.\n\nUt alii magis amentur quam ego, Iesu, da mihi gratiam hoc exoptandi.\nUt alii magis aestimentur quam ego, Iesu, da mihi gratiam hoc exoptandi.\nUt alii crescant in existimatione saeculi et ego minuar, Iesu, da mihi gratiam hoc exoptandi.\nUt alii eligantur et ego praeterear, Iesu, da mihi gratiam hoc exoptandi.\nUt alii laudentur et ego negligar, Iesu, da mihi gratiam hoc exoptandi.\nUt alii mihi in omnibus praeferantur, Iesu, da mihi gratiam hoc exoptandi.\nUt alii sanctiores evadant quam ego, dummodo ego tam sanctus fiam quam debeo, Iesu, da mihi gratiam hoc exoptandi.\n\nAmen.'**
  String get prayerLitanyHumilityContentLatin;

  /// No description provided for @prayerLitanyPreciousBloodTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ladainha do Preciosíssimo Sangue'**
  String get prayerLitanyPreciousBloodTitle;

  /// No description provided for @prayerLitanyPreciousBloodContent.
  ///
  /// In pt, this message translates to:
  /// **'Senhor, tende piedade de nós.\nCristo, tende piedade de nós.\nSenhor, tende piedade de nós.\n\nJesus Cristo, ouvi-nos.\nJesus Cristo, atendei-nos.\n\nDeus Pai dos céus, tende piedade de nós.\nDeus Filho, Redentor do mundo, tende piedade de nós.\nDeus Espírito Santo, tende piedade de nós.\nSantíssima Trindade, que sois um só Deus, tende piedade de nós.\n\nSangue de Cristo, Filho Único do Pai Eterno, salvai-nos.\nSangue de Cristo, Verbo de Deus encarnado, salvai-nos.\nSangue de Cristo, do Novo e Eterno Testamento, salvai-nos.\nSangue de Cristo, a correr pela terra na agonia, salvai-nos.\nSangue de Cristo, a verter na flagelação, salvai-nos.\nSangue de Cristo, a emanar na coroação de espinhos, salvai-nos.\nSangue de Cristo, derramado na Cruz, salvai-nos.\nSangue de Cristo, preço da nossa salvação, salvai-nos.\nSangue de Cristo, sem o qual não há remissão, salvai-nos.\nSangue de Cristo, bebida e purificação das almas na Eucaristia, salvai-nos.\nSangue de Cristo, torrente de misericórdia, salvai-nos.\nSangue de Cristo, vencedor dos demônios, salvai-nos.\nSangue de Cristo, fortaleza dos mártires, salvai-nos.\nSangue de Cristo, virtude dos confessores, salvai-nos.\nSangue de Cristo, que dais origem às virgens, salvai-nos.\nSangue de Cristo, sustentáculo dos que estão em perigo, salvai-nos.\nSangue de Cristo, alívio dos que sofrem, salvai-nos.\nSangue de Cristo, consolo nas lágrimas, salvai-nos.\nSangue de Cristo, esperança dos penitentes, salvai-nos.\nSangue de Cristo, conforto dos moribundos, salvai-nos.\nSangue de Cristo, paz e doçura dos corações, salvai-nos.\nSangue de Cristo, penhor de vida eterna, salvai-nos.\nSangue de Cristo, que libertais as almas do Purgatório, salvai-nos.\nSangue de Cristo, digno de toda a honra e glória, salvai-nos.\n\nCordeiro de Deus, que tirais os pecados do mundo, perdoai-nos, Senhor.\nCordeiro de Deus, que tirais os pecados do mundo, ouvi-nos, Senhor.\nCordeiro de Deus, que tirais os pecados do mundo, tende piedade de nós.\n\nV. Vós nos remistes, Senhor, no vosso Sangue.\nR. E fizestes de nós um reino para o nosso Deus.\n\nOremos: Deus todo-poderoso e eterno, que constituístes o vosso Filho Unigênito Redentor do mundo e quisestes ser aplacado com o Seu Sangue, concedei-nos a graça de venerar o preço da nossa salvação e de sermos por ele defendidos na terra contra todos os males, para que alcancemos a alegria dos seus frutos eternos no céu. Por Cristo, Nosso Senhor. Amém.'**
  String get prayerLitanyPreciousBloodContent;

  /// No description provided for @prayerLitanyPreciousBloodContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Kyrie, eleison.\nChriste, eleison.\nKyrie, eleison.\n\nChriste, audi nos.\nChriste, exaudi nos.\n\nPater de caelis, Deus, miserere nobis.\nFili, Redemptor mundi, Deus, miserere nobis.\nSpiritus Sancte, Deus, miserere nobis.\nSancta Trinitas, unus Deus, miserere nobis.\n\nSanguis Christi, Unigeniti Patris Aeterni, salva nos.\nSanguis Christi, Verbi Dei incarnati, salva nos.\nSanguis Christi, Novi et Aeterni Testamenti, salva nos.\nSanguis Christi, in agonia decurrens in terram, salva nos.\nSanguis Christi, in flagellatione effusus, salva nos.\nSanguis Christi, in coronatione spinarum emanans, salva nos.\nSanguis Christi, in Cruce effusus, salva nos.\nSanguis Christi, pretium nostrae salutis, salva nos.\nSanguis Christi, sine quo non fit remissio, salva nos.\nSanguis Christi, in Eucharistia potus et lavacrum animarum, salva nos.\nSanguis Christi, flumen misericordiae, salva nos.\nSanguis Christi, victor daemonum, salva nos.\nSanguis Christi, fortitudo martyrum, salva nos.\nSanguis Christi, virtus confessorum, salva nos.\nSanguis Christi, germinans virgines, salva nos.\nSanguis Christi, robur periclitantium, salva nos.\nSanguis Christi, levamen laborantium, salva nos.\nSanguis Christi, in fletu solatium, salva nos.\nSanguis Christi, spes paenitentium, salva nos.\nSanguis Christi, solamen morientium, salva nos.\nSanguis Christi, pax et dulcedo cordium, salva nos.\nSanguis Christi, pignus vitae aeternae, salva nos.\nSanguis Christi, animas liberans de lacu Purgatorii, salva nos.\nSanguis Christi, omni honore et gloria dignissimus, salva nos.\n\nAgnus Dei, qui tollis peccata mundi, parce nobis, Domine.\nAgnus Dei, qui tollis peccata mundi, exaudi nos, Domine.\nAgnus Dei, qui tollis peccata mundi, miserere nobis.\n\nV. Redemisti nos, Domine, in sanguine tuo.\nR. Et fecisti nos Deo nostro regnum.\n\nOremus: Omnipotens sempiterne Deus, qui unigenitum Filium tuum mundi Redemptorem constituisti, ac eius sanguine placari voluisti: concede, quaesumus, salutis nostrae pretium ita venerari, atque a praesentis vitae malis eius virtute defendi in terris, ut fructu perpetuo laetemur in caelis. Per eundem Christum Dominum nostrum. Amen.'**
  String get prayerLitanyPreciousBloodContentLatin;

  /// No description provided for @prayerLitanyBlessedSacramentTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ladainha do Santíssimo Sacramento'**
  String get prayerLitanyBlessedSacramentTitle;

  /// No description provided for @prayerLitanyBlessedSacramentContent.
  ///
  /// In pt, this message translates to:
  /// **'Senhor, tende piedade de nós.\nCristo, tende piedade de nós.\nSenhor, tende piedade de nós.\n\nJesus Cristo, ouvi-nos.\nJesus Cristo, atendei-nos.\n\nDeus Pai dos céus, tende piedade de nós.\nDeus Filho, Redentor do mundo, tende piedade de nós.\nDeus Espírito Santo, tende piedade de nós.\nSantíssima Trindade, que sois um só Deus, tende piedade de nós.\n\nPão vivo que desceu do céu, tende piedade de nós.\nDeus escondido e Salvador, tende piedade de nós.\nTrigo dos eleitos, tende piedade de nós.\nVinho que faz germinar virgens, tende piedade de nós.\nPão substancioso e delícia dos reis, tende piedade de nós.\nSacrifício perpétuo, tende piedade de nós.\nOblação pura, tende piedade de nós.\nCordeiro sem mancha, tende piedade de nós.\nMesa puríssima, tende piedade de nós.\nAlimento dos anjos, tende piedade de nós.\nManá escondido, tende piedade de nós.\nMemorial das maravilhas de Deus, tende piedade de nós.\nPão supersubstancial, tende piedade de nós.\nVerbo feito carne, habitando entre nós, tende piedade de nós.\nHóstia santa, tende piedade de nós.\nCálice de bênção, tende piedade de nós.\nMistério da fé, tende piedade de nós.\nSublime e venerável Sacramento, tende piedade de nós.\nSacrifício santíssimo sobre todos os sacrifícios, tende piedade de nós.\nVerdadeiro propiciatório pelos vivos e pelos mortos, tende piedade de nós.\nRemédio celestial contra todos os males, tende piedade de nós.\nMilagre admirável sobre todos os milagres, tende piedade de nós.\nSagrada memória da Paixão do Senhor, tende piedade de nós.\nDom que excede toda a plenitude, tende piedade de nós.\nPenhor da glória futura, tende piedade de nós.\n\nSede-nos propício, perdoai-nos, Senhor.\nSede-nos propício, ouvi-nos, Senhor.\n\nDe receber indignamente o vosso Corpo e o vosso Sangue, livrai-nos, Senhor.\nDa concupiscência da carne, livrai-nos, Senhor.\nDa soberba da vida, livrai-nos, Senhor.\nDe toda ocasião de pecar, livrai-nos, Senhor.\nPelo vosso ardente desejo de comer esta Páscoa com os discípulos, livrai-nos, Senhor.\nPela vossa profunda humildade ao lavar os pés dos discípulos, livrai-nos, Senhor.\nPelo vosso infinito amor ao instituir este Santíssimo Sacramento, livrai-nos, Senhor.\n\nNós que somos pecadores, nós vos rogamos, ouvi-nos.\nPara que vos digneis aumentar em nós a fé, o respeito e a devoção a este admirável Sacramento, nós vos rogamos, ouvi-nos.\nPara que vos digneis conduzir-nos à comunhão frequente com sincera pureza e piedade, nós vos rogamos, ouvi-nos.\nPara que vos digneis preservar-nos de toda heresia, sacrilégio e tibieza espiritual, nós vos rogamos, ouvi-nos.\n\nCordeiro de Deus, que tirais os pecados do mundo, perdoai-nos, Senhor.\nCordeiro de Deus, que tirais os pecados do mundo, ouvi-nos, Senhor.\nCordeiro de Deus, que tirais os pecados do mundo, tende piedade de nós.\n\nV. Vós lhes destes o pão do céu.\nR. Que contém em si todo o sabor.\n\nOremos: Deus, que neste admirável sacramento nos deixastes o memorial da vossa paixão, concedei-nos a graça de venerar de tal modo os sagrados mistérios do vosso Corpo e do vosso Sangue, que sintamos continuamente em nós os frutos da vossa redenção. Vós que viveis e reinais para todo o sempre. Amém.'**
  String get prayerLitanyBlessedSacramentContent;

  /// No description provided for @prayerLitanyBlessedSacramentContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Kyrie, eleison.\nChriste, eleison.\nKyrie, eleison.\n\nChriste, audi nos.\nChriste, exaudi nos.\n\nPater de caelis, Deus, miserere nobis.\nFili, Redemptor mundi, Deus, miserere nobis.\nSpiritus Sancte, Deus, miserere nobis.\nSancta Trinitas, unus Deus, miserere nobis.\n\nPanis vivus, qui de caelo descendisti, miserere nobis.\nDeus absconditus et Salvator, miserere nobis.\nFrumentum electorum, miserere nobis.\nVinum germinans virgines, miserere nobis.\nPanis pinguis et daps regalis, miserere nobis.\nIuge sacrificium, miserere nobis.\nOblatio munda, miserere nobis.\nAgnus absque macula, miserere nobis.\nMensa purissima, miserere nobis.\nAngelorum esca, miserere nobis.\nManna absconditum, miserere nobis.\nMemoriale mirabilium Dei, miserere nobis.\nPanis supersubstantialis, miserere nobis.\nVerbum caro factum, habitans in nobis, miserere nobis.\nHostia sancta, miserere nobis.\nCalix benedictionis, miserere nobis.\nMysterium fidei, miserere nobis.\nPraecelsum et venerabile Sacramentum, miserere nobis.\nSacrificium omnium sanctissimum, miserere nobis.\nVere propitiatorium pro vivis et defunctis, miserere nobis.\nCaeleste antidotum, quo a peccatis praeservamur, miserere nobis.\nMiraculum praestantissimum, miserere nobis.\nMemoria sacratissima Passionis Dominicae, miserere nobis.\nPignus futurae gloriae, miserere nobis.\n\nPropitius esto, parce nobis, Domine.\nPropitius esto, exaudi nos, Domine.\n\nAb indigna Corporis et Sanguinis tui sumptione, libera nos, Domine.\nA concupiscentia carnis, libera nos, Domine.\nA superbia vitae, libera nos, Domine.\nAb omni peccandi occasione, libera nos, Domine.\nPer desiderium quo hoc Pascha cum discipulis manducare cupiisti, libera nos, Domine.\nPer immensam caritatem qua hoc Sacramentum instituisti, libera nos, Domine.\n\nPeccatores, te rogamus, audi nos.\nUt fidem, reverentiam et devotionem erga hoc admirabile Sacramentum in nobis augere digneris, te rogamus, audi nos.\nUt ad frequentem et dignam sanctae Eucharistiae sumptionem nos perducere digneris, te rogamus, audi nos.\nUt ab omni haeresi, sacrilegio et cordis tepore nos praeservare digneris, te rogamus, audi nos.\n\nAgnus Dei, qui tollis peccata mundi, parce nobis, Domine.\nAgnus Dei, qui tollis peccata mundi, exaudi nos, Domine.\nAgnus Dei, qui tollis peccata mundi, miserere nobis.\n\nV. Panem de caelo praestitisti eis.\nR. Omne delectamentum in se habentem.\n\nOremus: Deus, qui nobis sub sacramento mirabili passionis tuae memoriam reliquisti: tribue, quaesumus, ita nos Corporis et Sanguinis tui sacra mysteria venerari, ut redemptionis tuae fructum in nobis iugiter sentiamus. Qui vivis et regnas in saecula saeculorum. Amen.'**
  String get prayerLitanyBlessedSacramentContentLatin;

  /// No description provided for @prayerLitanyHolyAngelsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ladainha dos Santos Anjos'**
  String get prayerLitanyHolyAngelsTitle;

  /// No description provided for @prayerLitanyHolyAngelsContent.
  ///
  /// In pt, this message translates to:
  /// **'Senhor, tende piedade de nós.\nCristo, tende piedade de nós.\nSenhor, tende piedade de nós.\n\nJesus Cristo, ouvi-nos.\nJesus Cristo, atendei-nos.\n\nDeus Pai dos céus, tende piedade de nós.\nDeus Filho, Redentor do mundo, tende piedade de nós.\nDeus Espírito Santo, tende piedade de nós.\nSantíssima Trindade, que sois um só Deus, tende piedade de nós.\n\nSanta Maria, Rainha dos Anjos, rogai por nós.\nSão Miguel Arcanjo, rogai por nós.\nSão Gabriel Arcanjo, rogai por nós.\nSão Rafael Arcanjo, rogai por nós.\nSantos Anjos e Arcanjos, rogai por nós.\nSantos Serafins, querubins e tronos, rogai por nós.\nSantas dominações, potestades e virtudes, rogai por nós.\nSantos principados, anjos e arcanjos, rogai por nós.\nSantos Anjos da Guarda, rogai por nós.\nSantos Anjos, nossos defensores no combate espiritual, rogai por nós.\nSantos Anjos, mensageiros da vontade divina, rogai por nós.\nSantos Anjos, que contemplais a face do Pai celeste, rogai por nós.\nSantos Anjos, consoladores nas aflições, rogai por nós.\nSantos Anjos, companheiros nas nossas peregrinações, rogai por nós.\nSantos Anjos, sustentáculos na hora da tentação, rogai por nós.\nSantos Anjos, que apresentais as nossas preces a Deus, rogai por nós.\nSantos Anjos, nosso conforto na agonia da morte, rogai por nós.\nSantos Anjos, que conduzis as almas dos justos ao Paraíso, rogai por nós.\n\nCordeiro de Deus, que tirais os pecados do mundo, perdoai-nos, Senhor.\nCordeiro de Deus, que tirais os pecados do mundo, ouvi-nos, Senhor.\nCordeiro de Deus, que tirais os pecados do mundo, tende piedade de nós.\n\nV. Deus deu ordens aos Seus Anjos a teu respeito.\nR. Para que te guardem em todos os teus caminhos.\n\nOremos: Deus todo-poderoso e eterno, que por vossa inefável providência vos dignais enviar os vossos Santos Anjos para nossa guarda, concedei aos vossos servos suplicantes sermos sempre defendidos pela sua proteção na terra e gozarmos da sua eterna companhia nos céus. Por Cristo, Nosso Senhor. Amém.'**
  String get prayerLitanyHolyAngelsContent;

  /// No description provided for @prayerLitanyHolyAngelsContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Kyrie, eleison.\nChriste, eleison.\nKyrie, eleison.\n\nChriste, audi nos.\nChriste, exaudi nos.\n\nPater de caelis, Deus, miserere nobis.\nFili, Redemptor mundi, Deus, miserere nobis.\nSpiritus Sancte, Deus, miserere nobis.\nSancta Trinitas, unus Deus, miserere nobis.\n\nSancta Maria, Regina Angelorum, ora pro nobis.\nSancte Michael Archangele, ora pro nobis.\nSancte Gabriel Archangele, ora pro nobis.\nSancte Raphael Archangele, ora pro nobis.\nSancti Angeli et Archangeli, orate pro nobis.\nSancti Seraphim, Cherubim et Throni, orate pro nobis.\nSanctae Dominationes, Potestates et Virtutes, orate pro nobis.\nSancti Principatus, orate pro nobis.\nSancti Angeli Custodes nostri, orate pro nobis.\nSancti Angeli, defensores nostri in certamine spiritali, orate pro nobis.\nSancti Angeli, nuntii divinae voluntatis, orate pro nobis.\nSancti Angeli, qui faciem Patris assidue contemplamini, orate pro nobis.\nSancti Angeli, consolatores in afflictionibus, orate pro nobis.\nSancti Angeli, fideles comites peregrinationis nostrae, orate pro nobis.\nSancti Angeli, robur nostrum in tempore tentationis, orate pro nobis.\nSancti Angeli, qui orationes nostras Deo offertis, orate pro nobis.\nSancti Angeli, solatores nostri in agone mortis, orate pro nobis.\nSancti Angeli, ductores animarum in Paradisum, orate pro nobis.\n\nAgnus Dei, qui tollis peccata mundi, parce nobis, Domine.\nAgnus Dei, qui tollis peccata mundi, exaudi nos, Domine.\nAgnus Dei, qui tollis peccata mundi, miserere nobis.\n\nV. Angelis suis Deus mandavit de te.\nR. Ut custodiant te in omnibus viis tuis.\n\nOremus: Deus, qui ineffabili providentia sanctos Angelos tuos ad nostram custodiam mittere dignaris: largire supplicibus tuis, et eorum semper protectione defendi, et aeterna societate gaudere. Per Christum Dominum nostrum. Amen.'**
  String get prayerLitanyHolyAngelsContentLatin;

  /// No description provided for @prayerLitanyGoodDeathTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ladainha da Boa Morte'**
  String get prayerLitanyGoodDeathTitle;

  /// No description provided for @prayerLitanyGoodDeathContent.
  ///
  /// In pt, this message translates to:
  /// **'Senhor Jesus, Deus de bondade e Pai de misericórdia, apresento-me diante de Vós com o coração humilhado e contrito, e vos recomendo a minha última hora e aquilo que depois dela me espera.\n\nQuando os meus pés imóveis me avisarem que a minha carreira neste mundo está prestes a terminar, misericordioso Jesus, tende piedade de mim.\nQuando as minhas mãos trêmulas já não puderem segurar o Crucifixo e eu o deixar cair sobre o meu leito de dor, misericordioso Jesus, tende piedade de mim.\nQuando os meus olhos embaciados e escurecidos pela proximidade da morte se fixarem em Vós pela última vez, misericordioso Jesus, tende piedade de mim.\nQuando os meus lábios frios e trêmulos pronunciarem pela última vez o vosso adorável Nome, misericordioso Jesus, tende piedade de mim.\nQuando os meus ouvidos, fechados às vozes dos homens, escutarem a vossa sentença divina irrevogável, misericordioso Jesus, tende piedade de mim.\nQuando a minha alma, agitada pelas angústias da morte, lutar contra os assaltos do demônio, misericordioso Jesus, tende piedade de mim.\nQuando o meu coração bater com fraqueza e travar os últimos combates da agonia, misericordioso Jesus, tende piedade de mim.\nQuando a minha alma se separar do meu corpo, deixando-o pálido, frio e sem vida, recebei o meu espírito em vossas mãos divinas, misericordioso Jesus, tende piedade de mim.\n\nOremos: Ó Deus, que nos condenastes à morte, mas nos ocultastes o momento e a hora dela, fazei que, passando em santidade e justiça todos os dias da nossa vida, mereçamos sair deste mundo em vosso santo amor. Por Jesus Cristo, Nosso Senhor. Amém.'**
  String get prayerLitanyGoodDeathContent;

  /// No description provided for @prayerLitanyGoodDeathContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Domine Iesu, Deus bonitatis et Pater misericordiarum, contrito et humiliato corde ad Te accedo; Tibi ultimam meam horam et quidquid me post eam manet commendo.\n\nCum pedes mei immobiles me commonefacient cursum meum in hoc saeculo finiri, misericors Iesu, miserere mei.\nCum manus meae trementes Crucifixum tenere non poterunt, misericors Iesu, miserere mei.\nCum oculi mei caligantes in Te ultimum aspectum figent, misericors Iesu, miserere mei.\nCum labia mea frigida et trementia ultimum nomen Tuum invocabunt, misericors Iesu, miserere mei.\nCum aures meae vocibus hominum clausae Te solum iudicem audient, misericors Iesu, miserere mei.\nCum anima mea in agone mortis contra insidias diaboli decertabit, misericors Iesu, miserere mei.\nCum cor meum languidum ultimos motus efficiet, misericors Iesu, miserere mei.\nCum anima mea e corpore evolabit, suscipe spiritum meum in manus tuas, misericors Iesu, miserere mei.\n\nOremus: Deus, qui nos mori statuisti, sed horam mortis nostrae occultasti: concede ut in iustitia et sanctitate omnes dies vitae nostrae transeuntes, in caritate tua ex hoc saeculo migrare mereamur. Per Christum Dominum nostrum. Amen.'**
  String get prayerLitanyGoodDeathContentLatin;

  /// No description provided for @prayerConsecTotusTuusTitle.
  ///
  /// In pt, this message translates to:
  /// **'Totus Tuus (consagração a Maria)'**
  String get prayerConsecTotusTuusTitle;

  /// No description provided for @prayerConsecTotusTuusContent.
  ///
  /// In pt, this message translates to:
  /// **'Totus Tuus ego sum, et omnia mea tua sunt.\n\nSou todo vosso, ó Maria, e tudo quanto tenho é vosso. Eu vos tomo hoje, ó minha Mãe, por meu tudo. Emprestai-me o vosso Coração para que eu possa amar a Deus com a mesma pureza e fervor com que Vós o amastes.\n\nRecebei-me, Virgem Imaculada, sob a vossa maternal proteção. Guardai os meus sentidos, purificai a minha alma e santificai todas as minhas ações, para que eu viva unicamente para Jesus, por Vós e convosco.\n\nTotus Tuus ego sum, et omnia mea tua sunt. Amém.'**
  String get prayerConsecTotusTuusContent;

  /// No description provided for @prayerConsecTotusTuusContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Totus Tuus ego sum, et omnia mea tua sunt.\n\nAccipio te in mea omnia, o Maria, Mater mea dulcissima. Praebe mihi cor tuum, ut Deum eodem amore et puritate qua tu amasti diligere valeam.\n\nSuscipe me, Virgo Immaculata, sub materno praesidio tuo. Custodi sensus meos, munda animam meam, et omnes actiones meas sanctifica, ut soli Iesu per te et tecum vivam.\n\nTotus Tuus ego sum, et omnia mea tua sunt. Amen.'**
  String get prayerConsecTotusTuusContentLatin;

  /// No description provided for @prayerConsecMontfortTitle.
  ///
  /// In pt, this message translates to:
  /// **'Consagração a Jesus por Maria (São Luís de Montfort)'**
  String get prayerConsecMontfortTitle;

  /// No description provided for @prayerConsecMontfortContent.
  ///
  /// In pt, this message translates to:
  /// **'Ó Sabedoria Eterna e Encarnada! Ó amabilíssimo e adorável Jesus, verdadeiro Deus e verdadeiro homem, Filho Único do Pai Eterno e de Maria, sempre Virgem! Adoro-Vos profundamente no seio e nas glórias de vosso Pai, durante a eternidade, e no seio virginal de Maria, vossa Mãe digníssima, no tempo da vossa Encarnação.\n\nAgradeço-Vos ter-Vos aniquilado a Vós mesmo, tomando a forma de escravo, para livrar-me da cruel escravidão do demônio. Louvo-Vos e glorifico-Vos por ter-Vos submetido a Maria, vossa santa Mãe, em todas as coisas, a fim de tornar-me, por Ela, vosso fiel escravo. Mas, ai de mim! Ingrato e infiel que sou, não guardei os votos e as promessas que tão solenemente Vos fiz no meu Batismo. Não cumpri as minhas obrigações; não mereço ser chamado vosso filho nem vosso escravo; e, como nada há em mim que não mereça as vossas repulsas e a vossa cólera, não ouso mais aproximar-me por mim mesmo da vossa santíssima e augusta Majestade.\n\nPor isso, recorro à intercessão e à misericórdia de vossa Mãe Santíssima, que me destes por medianeira junto de Vós; e é por intermédio d\'Ela que espero obter de Vós a contrição e o perdão dos meus pecados, a aquisição e a conservação da Sabedoria.\n\nAve, pois, ó Maria Imaculada, sacrário vivo da Divindade, onde a Sabedoria Eterna escondida quer ser adorada pelos anjos e pelos homens! Ave, ó Rainha do céu e da terra, a cujo império tudo está sujeito, abaixo de Deus! Ave, ó refúgio seguro dos pecadores, cuja misericórdia a ninguém falta! Atendei aos desejos que tenho da divina Sabedoria, e recebei, para isso, os votos e as ofertas que a minha baixeza vos apresenta.\n\nEu, pecador infiel, renovo e ratifico hoje, em vossas mãos, os votos do meu Batismo: renuncio para sempre a satanás, às suas pompas e às suas obras, e dou-me inteiramente a Jesus Cristo, a Sabedoria Encarnada, para levar a minha cruz após Ele todos os dias da minha vida, e para Lhe ser mais fiel do que tenho sido até aqui.\n\nEscolho-vos hoje, em presença de toda a corte celeste, por minha Mãe e minha Senhora. Entrego-vos e consagro-vos, na qualidade de escravo, o meu corpo e a minha alma, os meus bens interiores e exteriores, e o próprio valor das minhas boas ações passadas, presentes e futuras, deixando-vos pleno e inteiro direito de dispor de mim e de tudo o que me pertence, sem exceção, segundo o vosso beneplácito, para a maior glória de Deus, no tempo e na eternidade.\n\nRecebei, ó Virgem benigna, esta pequena oferenda da minha escravidão, em honra e união daquela submissão que a Sabedoria Eterna quis ter à vossa maternidade; em homenagem ao poder que tendes ambos sobre este vermezinho e miserável pecador; e em ação de graças pelos privilégios com que a Santíssima Trindade vos favoreceu. Protesto que quero doravante, como vosso verdadeiro escravo, procurar a vossa honra e obedecer-vos em todas as coisas.\n\nÓ Mãe admirável, apresentai-me ao vosso querido Filho na qualidade de escravo perpétuo, para que, tendo-me resgatado por Vós, por Vós me receba!\n\nÓ Mãe de misericórdia, concedei-me a graça de obter a verdadeira Sabedoria de Deus, e de colocar-me, para isso, no número daqueles a quem amais, ensinais, guiais, sustentais e protegeis como filhos e escravos vossos!\n\nÓ Virgem fiel! Tornai-me em todas as coisas um tão perfeito discípulo, imitador e escravo da Sabedoria Encarnada, Jesus Cristo, vosso Filho, que eu chegue, por vossa intercessão e a vosso exemplo, à plenitude da Sua idade sobre a terra e da Sua glória nos céus. Amém.'**
  String get prayerConsecMontfortContent;

  /// No description provided for @prayerConsecMontfortContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'O Aeterna et Incarnata Sapientia! O dulcissime et adorabilis Iesu, verus Deus et verus homo, Fili unigenite Patris Aeterni et Mariae semper Virginis! Te profundissime adoro in sinu et splendoribus Patris tui in aeternitate, atque in sinu virginali Mariae, sanctissimae Matris tuae, in tempore Incarnationis tuae.\n\nGratias tibi ago quod teipsum exinanisti, formam servi accipiens, ut me a crudeli diaboli servitute liberares. Te laudo et glorifico quod Mariae, Matri tuae sanctissimae, in omnibus subditus esse voluisti, ut me per ipsam fidelem servum tuum efficeres. Sed heu! ingratus et infidelis, promissa meo Baptismate tam solemniter facta non servavi; ideo confugio ad misericordiam et intercessionem sanctissimae Matris tuae, quam mihi mediatricem dedisti.\n\nAve igitur, o Maria Immaculata, vivum Divinitatis tabernaculum! Ave, Regina caeli et terrae! Ave, refugium peccatorum! Ego infidelis peccator renovo et ratifico hodie in manibus tuis vota mei Baptismi: renuntio in perpetuum satanae, pompis et operibus eius, et me totum trado Iesu Christo, Sapientiae Incarnatae, ad crucem meam post eum ferendam omnibus diebus vitae meae.\n\nEligo te hodie, coram omni curia caelesti, in Matrem et Dominam meam. Trado et consecro tibi, in statu servi, corpus et animam meam, bona mea interiora et exteriora, atque ipsum pretium bonorum meorum actuum praeteritorum, praesentium et futurorum, relinquens tibi plenum et integrum ius de me disponendi secundum beneplacitum tuum, ad maiorem Dei gloriam in tempore et in aeternitate.\n\nAccipe, o Virgo benigna, hanc meae servitutis oblationem, et praesenta me dilecto Filio tuo tamquam servum sempiternum, ut qui me per te redemit, per te me recipiat. Amen.'**
  String get prayerConsecMontfortContentLatin;

  /// No description provided for @prayerConsecSacredHeartTitle.
  ///
  /// In pt, this message translates to:
  /// **'Consagração ao Sagrado Coração de Jesus'**
  String get prayerConsecSacredHeartTitle;

  /// No description provided for @prayerConsecSacredHeartContent.
  ///
  /// In pt, this message translates to:
  /// **'Eu dou e consagro ao Sagrado Coração de Nosso Senhor Jesus Cristo a minha pessoa e a minha vida, as minhas ações, penas e sofrimentos, para não querer mais servir-me de nenhuma parte do meu ser senão para O honrar, amar e glorificar.\n\nÉ esta a minha determinação irrevogável: ser todo d\'Ele e fazer tudo por Seu amor, renunciando de todo o meu coração a tudo quanto Lhe possa desagradar.\n\nEu vos tomo, pois, ó Sagrado Coração, por único objeto do meu amor, protetor da minha vida, segurança da minha salvação, remédio da minha fragilidade e inconstância, reparador de todos os defeitos da minha vida e asilo seguro na hora da minha morte.\n\nSede, pois, ó Coração de bondade, a minha justificação para com Deus vosso Pai, e afastai de mim os castigos da Sua justa cólera. Ó Coração de amor, ponho em Vós toda a minha confiança, pois tudo temo da minha fraqueza e malícia, mas tudo espero da vossa bondade!\n\nDestruí em mim tudo o que Vos possa desagradar ou resistir. Imprimi o vosso puro amor tão profundamente no meu coração, que nunca mais Vos possa esquecer nem de Vós me separar.\n\nSuplico-Vos, pela vossa bondade, que o meu nome seja gravado em Vós, porque quero fazer consistir toda a minha felicidade e a minha glória em viver e morrer na qualidade de vosso fiel servo.\n\nAmém.'**
  String get prayerConsecSacredHeartContent;

  /// No description provided for @prayerConsecSacredHeartContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Ego me totum trado et consecro Sacratissimo Cordi Domini nostri Iesu Christi: personam et vitam meam, actiones, aerumnas et dolores meos, ut nulla amplius entis mei parte uti velim, nisi ad Ipsum honorandum, amandum et glorificandum.\n\nHaec est voluntas mea irrevocabilis: totum Eius esse, et omnia pro Eius amore facere, renuntiando ex toto corde meo omnibus quae Ipsi displicere possunt.\n\nTe igitur eligo, o Cor Sacratissimum, in unicum meae dilectionis obiectum, vitae meae custodem, salutis meae securitatem, meae infirmitatis et inconstantiae remedium, omnium vitae meae culparum expiationem, atque certum in hora mortis refugium.\n\nEsto igitur, o Cor bonitatis, mea iustificatio apud Deum Patrem tuum, et averte a me iustae Ipsius irae flagella. O Cor dilectionis, in Te totam fiduciam meam pono; omnia enim timeo a mea fragilitate, sed omnia spero a tua bonitate!\n\nDele in me quidquid Tibi displicere vel resistere potest; infige amorem tuum tam alte cordi meo, ut numquam Tui oblivisci neque a Te separari valeam.\n\nAmen.'**
  String get prayerConsecSacredHeartContentLatin;

  /// No description provided for @prayerConsecStJosephTitle.
  ///
  /// In pt, this message translates to:
  /// **'Consagração a São José'**
  String get prayerConsecStJosephTitle;

  /// No description provided for @prayerConsecStJosephContent.
  ///
  /// In pt, this message translates to:
  /// **'Ó glorioso São José, a vós recorremos em nossa tribulação e, depois de ter implorado o auxílio de vossa santíssima Esposa, cheios de confiança solicitamos também o vosso patrocínio.\n\nPor aquele laço sagrado de caridade que vos uniu à Virgem Imaculada, Mãe de Deus, e pelo amor paternal que tivestes ao Menino Jesus, ardentemente vos suplicamos que lanceis um olhar benigno para a herança que Jesus Cristo adquiriu com o Seu Sangue, e nos socorrais com o vosso auxílio e poder nas nossas necessidades.\n\nProtegei, ó guarda providentíssimo da Sagrada Família, a raça eleita de Jesus Cristo. Afastai de nós, ó pai amantíssimo, toda mancha de erro e corrupção. Do alto do céu sede-nos propício, ó nosso fortíssimo sustentáculo, na luta contra o poder das trevas.\n\nE assim como outrora livrastes da morte a vida ameaçada do Menino Jesus, defendei agora a Santa Igreja de Deus contra as ciladas dos inimigos e contra toda adversidade. Amparai a cada um de nós com o vosso perpétuo patrocínio, a fim de que, a vosso exemplo e sustentados pelo vosso auxílio, possamos viver santamente, piedosamente morrer e alcançar a eterna bem-aventurança no céu.\n\nAmém.'**
  String get prayerConsecStJosephContent;

  /// No description provided for @prayerConsecStJosephContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Ad te, beate Ioseph, in tribulatione nostra confugimus, atque, implorato Sponsae tuae sanctissimae auxilio, patrocinium quoque tuum fidenter exposcimus.\n\nPer eam, quaesumus, quae te cum immaculata Virgine Dei Genetrice coniunxit, caritatis necessitudinem, perque paternum, quo Puerum Iesum amplexus es, amorem, supplices deprecamur, ut ad hereditatem, quam Iesus Christus acquisivit Sanguine suo, benignus respicias, ac necessitatibus nostris tua virtute et ope succurras.\n\nTuere, o Custos providentissime divinae Familiae, Iesu Christi sobolem electam; prohibe a nobis, amantissime pater, omnem errorum ac corruptelarum luem; propitius nobis, sospitator noster fortissime, in hoc cum potestate tenebrarum certamine e caelo adesto.\n\nEt sicut olim Puerum Iesum e summo eripuisti vitae discrimine, ita nunc sanctam Dei Ecclesiam ab hostilibus insidiis atque omni adversitate defende: nosque singulos perpetuo tege patrocinio, ut ad tui exemplar et ope suffulti, sancte vivere, pie emori, sempiternamque in caelis beatitudinem assequi valeamus.\n\nAmen.'**
  String get prayerConsecStJosephContentLatin;

  /// No description provided for @catPrayersConsecrations.
  ///
  /// In pt, this message translates to:
  /// **'Consagrações'**
  String get catPrayersConsecrations;

  /// No description provided for @drawerIntentions.
  ///
  /// In pt, this message translates to:
  /// **'Intenções de oração'**
  String get drawerIntentions;

  /// No description provided for @drawerMassGuide.
  ///
  /// In pt, this message translates to:
  /// **'Guia da Missa'**
  String get drawerMassGuide;

  /// No description provided for @drawerAdoration.
  ///
  /// In pt, this message translates to:
  /// **'Adoração Eucarística'**
  String get drawerAdoration;

  /// No description provided for @intentionsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Intenções de oração'**
  String get intentionsTitle;

  /// No description provided for @intentionsSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Anote por quem e pelo quê você reza.'**
  String get intentionsSubtitle;

  /// No description provided for @intentionsEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma intenção ainda. Toque em \"Nova intenção\" para anotar a primeira.'**
  String get intentionsEmpty;

  /// No description provided for @intentionsAdd.
  ///
  /// In pt, this message translates to:
  /// **'Nova intenção'**
  String get intentionsAdd;

  /// No description provided for @intentionsEditTitle.
  ///
  /// In pt, this message translates to:
  /// **'Editar intenção'**
  String get intentionsEditTitle;

  /// No description provided for @intentionsHint.
  ///
  /// In pt, this message translates to:
  /// **'Ex.: pela saúde de um familiar'**
  String get intentionsHint;

  /// No description provided for @intentionsOpenSection.
  ///
  /// In pt, this message translates to:
  /// **'Em oração'**
  String get intentionsOpenSection;

  /// No description provided for @intentionsAnsweredSection.
  ///
  /// In pt, this message translates to:
  /// **'Graças recebidas'**
  String get intentionsAnsweredSection;

  /// No description provided for @intentionsMarkAnswered.
  ///
  /// In pt, this message translates to:
  /// **'Marcar como graça recebida'**
  String get intentionsMarkAnswered;

  /// No description provided for @intentionsMarkOpen.
  ///
  /// In pt, this message translates to:
  /// **'Voltar para \"em oração\"'**
  String get intentionsMarkOpen;

  /// No description provided for @intentionsEdit.
  ///
  /// In pt, this message translates to:
  /// **'Editar'**
  String get intentionsEdit;

  /// No description provided for @intentionsDelete.
  ///
  /// In pt, this message translates to:
  /// **'Apagar'**
  String get intentionsDelete;

  /// No description provided for @intentionsDeleted.
  ///
  /// In pt, this message translates to:
  /// **'Intenção apagada'**
  String get intentionsDeleted;

  /// No description provided for @massGuideTitle.
  ///
  /// In pt, this message translates to:
  /// **'Guia da Missa'**
  String get massGuideTitle;

  /// No description provided for @massGuideSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Acompanhe cada parte da celebração.'**
  String get massGuideSubtitle;

  /// No description provided for @massGuideTipsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Antes de ir'**
  String get massGuideTipsTitle;

  /// No description provided for @massGuideTipsBody.
  ///
  /// In pt, this message translates to:
  /// **'Chegamos alguns minutos antes, silenciamos o celular e fazemos o Sinal da Cruz com água benta ao entrar na igreja. Ao chegar ao banco, fazemos a genuflexão (dobrando o joelho direito até o chão) em direção ao sacrário, onde está Jesus na Eucaristia, e nos recolhemos em oração silenciosa.\n\nPara comungar, precisamos estar em estado de graça: se houver consciência de pecado grave, procuramos antes a Confissão. Guardamos o jejum eucarístico de uma hora antes da Comunhão (água e remédios não quebram o jejum). A Missa aos domingos e nas festas de guarda é de preceito.'**
  String get massGuideTipsBody;

  /// No description provided for @massGuidePart1Title.
  ///
  /// In pt, this message translates to:
  /// **'1. Ritos iniciais'**
  String get massGuidePart1Title;

  /// No description provided for @massGuidePart1Body.
  ///
  /// In pt, this message translates to:
  /// **'Postura: Em pé durante todos os ritos iniciais.\n\nProcissão e canto de entrada: enquanto o sacerdote se aproxima e beija o altar, acolhemos o início da celebração.\n\nSinal da Cruz e saudação: fazemos o Sinal da Cruz com o sacerdote e respondemos:\n» O Senhor esteja convosco.\n» — Ele está no meio de nós.\n\nAto Penitencial: breve silêncio para reconhecer nossas faltas e pedir perdão a Deus. Quando se reza a confissão geral, batemos levemente no peito ao reconhecer a nossa culpa. Seguem-se as invocações de misericórdia:\n» Senhor, tende piedade de nós. / Cristo, tende piedade de nós.\n\nHino de Louvor (Glória): cantado ou rezado aos domingos (fora do Advento e da Quaresma), solenidades e festas, louvando a Santíssima Trindade.\n\nOração do dia (Coleta): ao convite \"Oremos\", fazemos um breve silêncio para apresentar a Deus nossas intenções pessoais. Ao final da oração do sacerdote, todos confirmam respondendo: Amém.'**
  String get massGuidePart1Body;

  /// No description provided for @massGuidePart2Title.
  ///
  /// In pt, this message translates to:
  /// **'2. Liturgia da Palavra'**
  String get massGuidePart2Title;

  /// No description provided for @massGuidePart2Body.
  ///
  /// In pt, this message translates to:
  /// **'Postura: Sentados nas leituras, no Salmo e na homilia; em pé na Aclamação, no Evangelho, no Credo e na Oração dos Fiéis.\n\nLeituras e Salmo Responsorial: escutamos a primeira leitura, respondemos ao Salmo e, aos domingos e solenidades, ouvimos a segunda leitura. Ao final de cada leitura:\n» Palavra do Senhor.\n» — Graças a Deus.\n\nAclamação e Evangelho: ficamos em pé para aclamar o Evangelho. Ao anúncio \"Proclamação do Evangelho...\", respondemos \"Glória a vós, Senhor\" fazendo o tríplice sinal da cruz com o polegar: na testa (para compreender), nos lábios (para anunciar) e no peito (para guardar no coração). Ao final:\n» Palavra da Salvação.\n» — Glória a vós, Senhor.\n\nHomilia: sentados, acolhemos a explicação da Palavra de Deus para a nossa vida.\n\nProfissão de Fé (Credo): aos domingos e solenidades, de pé, professamos a fé da Igreja. Ao mencionar a Encarnação de Cristo, fazemos uma inclinação profunda (e nos ajoelhamos nas solenidades da Anunciação e do Natal).\n\nOração dos Fiéis: ainda em pé, apresentamos as preces pela Igreja, pelo mundo e pelos necessitados, respondendo a cada intenção (por exemplo: \"Senhor, escutai a nossa prece\").'**
  String get massGuidePart2Body;

  /// No description provided for @massGuidePart3Title.
  ///
  /// In pt, this message translates to:
  /// **'3. Preparação das oferendas'**
  String get massGuidePart3Title;

  /// No description provided for @massGuidePart3Body.
  ///
  /// In pt, this message translates to:
  /// **'Postura: Sentados enquanto o altar é preparado e as oferendas são levadas; em pé no convite \"Orai, irmãos e irmãs\".\n\nApresentação do pão e do vinho: os dons do pão e do vinho são colocados sobre o altar, acompanhados pelo canto ou em silêncio. É o momento de unir ao altar o nosso trabalho, alegrias, provações e intenções.\n\nLavar das mãos: o sacerdote lava as mãos em sinal de purificação interior antes do Sacrifício Eucarístico.\n\nConvite à oração e Oração sobre as Oferendas: todos se colocam em pé quando o sacerdote convida a rezar:\n» Orai, irmãos e irmãs...\n» — Receba o Senhor por tuas mãos este sacrifício, para glória do seu nome, para nosso bem e de toda a sua santa Igreja.\n\nAo concluir a Oração sobre as Oferendas, todos respondem: Amém.'**
  String get massGuidePart3Body;

  /// No description provided for @massGuidePart4Title.
  ///
  /// In pt, this message translates to:
  /// **'4. Oração Eucarística e Consagração'**
  String get massGuidePart4Title;

  /// No description provided for @massGuidePart4Body.
  ///
  /// In pt, this message translates to:
  /// **'Postura: Em pé no diálogo do Prefácio e no canto do Santo; de joelhos a partir da invocação do Espírito Santo sobre as oferendas até a aclamação após a Consagração (ou durante toda a Oração Eucarística, conforme o costume local).\n\nDiálogo do Prefácio: abre a grande ação de graças:\n» O Senhor esteja convosco. — Ele está no meio de nós.\n» Corações ao alto. — O nosso coração está em Deus.\n» Demos graças ao Senhor, nosso Deus. — É nosso dever e nossa salvação.\n\nHino do Santo: unimo-nos aos anjos e santos proclamando \"Santo, Santo, Santo...\".\n\nConsagração e Elevação: ajoelhamo-nos em profundo silêncio. O sacerdote invoca o Espírito Santo e pronuncia as palavras de Jesus na Última Ceia; o pão e o vinho tornam-se verdadeiramente o Corpo e o Sangue de Cristo. Quando o sacerdote eleva a Hóstia Consagrada e o Cálice, olhamos com fé e adoramos em silêncio (podemos rezar interiormente: \"Meu Senhor e meu Deus!\").\n\nAclamação, intercessões e Grande Amém: após o convite \"Mistério da fé!\", aclamamos a morte e a ressurreição de Cristo. A Igreja intercede pelo Papa, pelos bispos, pelos vivos e pelos falecidos. Na elevação final (\"Por Cristo, com Cristo e em Cristo...\"), todos confirmam com o Grande Amém.'**
  String get massGuidePart4Body;

  /// No description provided for @massGuidePart5Title.
  ///
  /// In pt, this message translates to:
  /// **'5. Rito da Comunhão'**
  String get massGuidePart5Title;

  /// No description provided for @massGuidePart5Body.
  ///
  /// In pt, this message translates to:
  /// **'Postura: Em pé para o Pai-Nosso, o Rito da Paz e o Cordeiro de Deus; de joelhos (ou em pé com recolhimento, conforme o costume local) antes da Comunhão; ajoelhados ou sentados em ação de graças após comungar; em pé na Oração depois da Comunhão.\n\nPai-Nosso e Rito da Paz: rezamos juntos a Oração do Senhor. Em seguida, o sacerdote deseja a paz de Cristo:\n» A paz do Senhor esteja sempre convosco.\n» — O amor de Cristo nos uniu.\nQuando convidados, fazemos um gesto sóbrio de paz a quem está próximo.\n\nFração do Pão e Cordeiro de Deus: enquanto o sacerdote parte a Hóstia, cantamos ou rezamos o \"Cordeiro de Deus\", pedindo misericórdia e paz.\n\nPreparação imediata: quando o sacerdote apresenta a Hóstia consagrada (\"Eis o Cordeiro de Deus...\"), respondemos:\n» Senhor, eu não sou digno de que entreis em minha morada, mas dizei uma palavra e serei salvo.\n\nSagrada Comunhão: ao nos aproximarmos, fazemos um gesto de reverência (inclinação de cabeça ou genuflexão) antes de comungar. Quando o ministro diz \"O Corpo de Cristo\", respondemos com fé: Amém. Quem não puder comungar pode permanecer recolhido e fazer a Comunhão Espiritual.\n\nAção de graças: de volta ao banco, guardamos momentos de silêncio para agradecer a Jesus presente em nossa alma. Em seguida, em pé, acompanhamos a Oração depois da Comunhão, concluindo com: Amém.'**
  String get massGuidePart5Body;

  /// No description provided for @massGuidePart6Title.
  ///
  /// In pt, this message translates to:
  /// **'6. Ritos finais'**
  String get massGuidePart6Title;

  /// No description provided for @massGuidePart6Body.
  ///
  /// In pt, this message translates to:
  /// **'Postura: Sentados durante os avisos paroquiais (quando houver); em pé para a bênção final e a despedida.\n\nSaudação e Bênção Final: o sacerdote saúda novamente o povo (\"O Senhor esteja convosco\" — \"Ele está no meio de nós\") e concede a bênção em nome da Santíssima Trindade. Fazemos o Sinal da Cruz ao receber a bênção e respondemos: Amém.\n\nDespedida: somos enviados a viver o Evangelho no dia a dia:\n» Ide em paz, e o Senhor vos acompanhe.\n» — Graças a Deus.\n\nSaída: aguardamos o sacerdote venerar o altar e se retirar. Antes de deixar a igreja, fazemos um breve momento de ação de graças e uma genuflexão ao passar diante do sacrário.'**
  String get massGuidePart6Body;

  /// No description provided for @adorationTitle.
  ///
  /// In pt, this message translates to:
  /// **'Adoração Eucarística'**
  String get adorationTitle;

  /// No description provided for @adorationSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Uma hora diante de Jesus no Santíssimo Sacramento.'**
  String get adorationSubtitle;

  /// No description provided for @adorationStep1Title.
  ///
  /// In pt, this message translates to:
  /// **'1. Ao entrar'**
  String get adorationStep1Title;

  /// No description provided for @adorationStep1Body.
  ///
  /// In pt, this message translates to:
  /// **'Faça o sinal da cruz, genuflita diante do Santíssimo (exposto ou no sacrário) e procure um lugar tranquilo.'**
  String get adorationStep1Body;

  /// No description provided for @adorationStep2Title.
  ///
  /// In pt, this message translates to:
  /// **'2. Faça silêncio'**
  String get adorationStep2Title;

  /// No description provided for @adorationStep2Body.
  ///
  /// In pt, this message translates to:
  /// **'Fique diante de Jesus sem pressa. Você não precisa dizer muito: olhe para Ele e deixe que Ele olhe para você.'**
  String get adorationStep2Body;

  /// No description provided for @adorationStep3Title.
  ///
  /// In pt, this message translates to:
  /// **'3. Ore'**
  String get adorationStep3Title;

  /// No description provided for @adorationStep3Body.
  ///
  /// In pt, this message translates to:
  /// **'Algumas orações que podem ajudar:'**
  String get adorationStep3Body;

  /// No description provided for @adorationStep4Title.
  ///
  /// In pt, this message translates to:
  /// **'4. Fale com Jesus'**
  String get adorationStep4Title;

  /// No description provided for @adorationStep4Body.
  ///
  /// In pt, this message translates to:
  /// **'Agradeça, peça perdão e apresente as suas intenções e as de quem você ama. Se quiser, leia o Evangelho do dia.'**
  String get adorationStep4Body;

  /// No description provided for @adorationStep5Title.
  ///
  /// In pt, this message translates to:
  /// **'5. Ao sair'**
  String get adorationStep5Title;

  /// No description provided for @adorationStep5Body.
  ///
  /// In pt, this message translates to:
  /// **'Agradeça, faça o sinal da cruz, genuflita e leve a paz recebida para o seu dia.'**
  String get adorationStep5Body;

  /// No description provided for @examSectionPrepare.
  ///
  /// In pt, this message translates to:
  /// **'Preparar-se'**
  String get examSectionPrepare;

  /// No description provided for @examSectionExamine.
  ///
  /// In pt, this message translates to:
  /// **'Examinar a consciência'**
  String get examSectionExamine;

  /// No description provided for @examSectionConfess.
  ///
  /// In pt, this message translates to:
  /// **'Confessar'**
  String get examSectionConfess;

  /// No description provided for @nextConfessionToday.
  ///
  /// In pt, this message translates to:
  /// **'É hoje'**
  String get nextConfessionToday;

  /// No description provided for @examClearMarks.
  ///
  /// In pt, this message translates to:
  /// **'Limpar'**
  String get examClearMarks;

  /// No description provided for @examClearTitle.
  ///
  /// In pt, this message translates to:
  /// **'Limpar as marcações?'**
  String get examClearTitle;

  /// No description provided for @examClearConfirm.
  ///
  /// In pt, this message translates to:
  /// **'Limpar'**
  String get examClearConfirm;

  /// No description provided for @examCleared.
  ///
  /// In pt, this message translates to:
  /// **'Marcações limpas'**
  String get examCleared;

  /// No description provided for @nextConfessionInDays.
  ///
  /// In pt, this message translates to:
  /// **'{days, plural, =1{Amanhã} other{Em {days} dias}}'**
  String nextConfessionInDays(int days);

  /// No description provided for @nextConfessionOverdue.
  ///
  /// In pt, this message translates to:
  /// **'{days, plural, =1{Atrasada 1 dia} other{Atrasada {days} dias}}'**
  String nextConfessionOverdue(int days);

  /// No description provided for @examClearBody.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{O item marcado no exame será desmarcado.} other{Os {count} itens marcados no exame serão desmarcados.}} Isso não pode ser desfeito.'**
  String examClearBody(int count);

  /// No description provided for @massGuideFormTitle.
  ///
  /// In pt, this message translates to:
  /// **'Forma da Missa'**
  String get massGuideFormTitle;

  /// No description provided for @massGuideFormOrdinary.
  ///
  /// In pt, this message translates to:
  /// **'Missa ordinária (português)'**
  String get massGuideFormOrdinary;

  /// No description provided for @massGuideFormOrdinaryDesc.
  ///
  /// In pt, this message translates to:
  /// **'A Missa de hoje, celebrada na língua do povo.'**
  String get massGuideFormOrdinaryDesc;

  /// No description provided for @massGuideFormTraditional.
  ///
  /// In pt, this message translates to:
  /// **'Missa tradicional (latim)'**
  String get massGuideFormTraditional;

  /// No description provided for @massGuideFormTraditionalDesc.
  ///
  /// In pt, this message translates to:
  /// **'A Missa celebrada com o Missal Romano de 1962, em latim.'**
  String get massGuideFormTraditionalDesc;

  /// No description provided for @massGuideTradSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Acompanhe a Missa tradicional em latim.'**
  String get massGuideTradSubtitle;

  /// No description provided for @massGuideTradTipsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Antes de ir'**
  String get massGuideTradTipsTitle;

  /// No description provided for @massGuideTradTipsBody.
  ///
  /// In pt, this message translates to:
  /// **'A Missa tradicional é celebrada com o Missal Romano de 1962. Procure saber, na sua diocese, onde ela é celebrada. Leve um missal bilíngue (latim e português) para acompanhar. É costume o silêncio no templo, as mulheres cobrirem a cabeça com um véu e receber a Comunhão de joelhos e na língua. Boa parte das orações é dita em voz baixa pelo sacerdote: a participação é sobretudo interior. As normas de jejum e estado de graça para comungar são as mesmas.'**
  String get massGuideTradTipsBody;

  /// No description provided for @massGuideTradPart1Title.
  ///
  /// In pt, this message translates to:
  /// **'1. Ao pé do altar'**
  String get massGuideTradPart1Title;

  /// No description provided for @massGuideTradPart1Body.
  ///
  /// In pt, this message translates to:
  /// **'O sacerdote e os ministros se preparam com o sinal da cruz e o Salmo 42. Em seguida, o Confiteor (confissão dos pecados) e o pedido de perdão.\n\n» In nomine Patris, et Filii, et Spiritus Sancti. Amen.\n» Introibo ad altare Dei.\n» Ad Deum qui laetificat juventutem meam.\nSubirei ao altar de Deus. — A Deus, que alegra a minha juventude.'**
  String get massGuideTradPart1Body;

  /// No description provided for @massGuideTradPart2Title.
  ///
  /// In pt, this message translates to:
  /// **'2. Intróito, Kyrie e Glória'**
  String get massGuideTradPart2Title;

  /// No description provided for @massGuideTradPart2Body.
  ///
  /// In pt, this message translates to:
  /// **'O Intróito é o canto de entrada. Segue o Kyrie, súplica de misericórdia, e, nos domingos fora do Advento e da Quaresma, o Glória. A Coleta é a oração do dia.\n\n» Kyrie, eleison. Christe, eleison. Kyrie, eleison.\nSenhor, tende piedade. Cristo, tende piedade. Senhor, tende piedade.\n\n» Dominus vobiscum.\n» Et cum spiritu tuo.\nO Senhor esteja convosco. — E com o teu espírito.\n\n» Oremus. (…) — Amen.'**
  String get massGuideTradPart2Body;

  /// No description provided for @massGuideTradPart3Title.
  ///
  /// In pt, this message translates to:
  /// **'3. Epístola, Gradual e Evangelho'**
  String get massGuideTradPart3Title;

  /// No description provided for @massGuideTradPart3Body.
  ///
  /// In pt, this message translates to:
  /// **'Lê-se a Epístola, canta-se o Gradual (e o Aleluia) e proclama-se o Evangelho, ouvido de pé. Costuma-se fazer três pequenos sinais da cruz na testa, nos lábios e no peito.\n\n» Deo gratias.\nGraças a Deus. (depois da Epístola)\n\n» Dominus vobiscum. — Et cum spiritu tuo.\n» Sequentia sancti Evangelii secundum N.\n» Gloria tibi, Domine.\nLeitura do santo Evangelho segundo N. — Glória a vós, Senhor.\n\n» Laus tibi, Christe.\nLouvor a vós, Cristo. (depois do Evangelho)'**
  String get massGuideTradPart3Body;

  /// No description provided for @massGuideTradPart4Title.
  ///
  /// In pt, this message translates to:
  /// **'4. Sermão, Credo e Ofertório'**
  String get massGuideTradPart4Title;

  /// No description provided for @massGuideTradPart4Body.
  ///
  /// In pt, this message translates to:
  /// **'Depois do sermão, nos domingos e festas, reza-se o Credo (genuflexão em \"et incarnatus est\"). No Ofertório, o sacerdote oferece o pão e o vinho.\n\n» Credo in unum Deum, Patrem omnipotentem…\nCreio em um só Deus, Pai todo-poderoso…\n\n» Orate, fratres: ut meum ac vestrum sacrificium acceptabile fiat apud Deum Patrem omnipotentem.\n» Suscipiat Dominus sacrificium de manibus tuis ad laudem et gloriam nominis sui, ad utilitatem quoque nostram, totiusque Ecclesiae suae sanctae.\nOrai, irmãos, para que o meu e o vosso sacrifício seja aceito por Deus Pai todo-poderoso. — Receba o Senhor o sacrifício por tuas mãos, para louvor e glória do seu nome, para nosso bem e de toda a sua santa Igreja.'**
  String get massGuideTradPart4Body;

  /// No description provided for @massGuideTradPart5Title.
  ///
  /// In pt, this message translates to:
  /// **'5. Prefácio, Sanctus e Cânon'**
  String get massGuideTradPart5Title;

  /// No description provided for @massGuideTradPart5Body.
  ///
  /// In pt, this message translates to:
  /// **'O Prefácio abre a grande oração de ação de graças. Após o Sanctus, o sacerdote reza o Cânon em silêncio. Na consagração, ajoelhados, adoramos Jesus presente na Hóstia e no Cálice, ao toque da campainha.\n\n» Sursum corda.\n» Habemus ad Dominum.\n» Gratias agamus Domino Deo nostro.\n» Dignum et justum est.\nCorações ao alto. — Os temos no Senhor. — Demos graças ao Senhor nosso Deus. — É digno e justo.\n\n» Sanctus, Sanctus, Sanctus Dominus Deus Sabaoth. Pleni sunt caeli et terra gloria tua. Hosanna in excelsis. Benedictus qui venit in nomine Domini. Hosanna in excelsis.\nSanto, Santo, Santo, Senhor Deus dos exércitos. Os céus e a terra estão cheios da vossa glória. Hosana nas alturas. Bendito o que vem em nome do Senhor. Hosana nas alturas.'**
  String get massGuideTradPart5Body;

  /// No description provided for @massGuideTradPart6Title.
  ///
  /// In pt, this message translates to:
  /// **'6. Pai-Nosso, Agnus Dei e Comunhão'**
  String get massGuideTradPart6Title;

  /// No description provided for @massGuideTradPart6Body.
  ///
  /// In pt, this message translates to:
  /// **'O sacerdote canta o Pai-Nosso, o povo responde ao final. Segue o Agnus Dei. Antes da Comunhão, repete-se três vezes a oração de humildade. Recebe-se a Comunhão de joelhos, na balaustrada.\n\n» Et ne nos inducas in tentationem.\n» Sed libera nos a malo.\nE não nos deixeis cair em tentação. — Mas livrai-nos do mal.\n\n» Agnus Dei, qui tollis peccata mundi: miserere nobis. (duas vezes)\n» Agnus Dei, qui tollis peccata mundi: dona nobis pacem.\nCordeiro de Deus, que tirais os pecados do mundo, tende piedade de nós. (duas vezes) — Cordeiro de Deus, que tirais os pecados do mundo, dai-nos a paz.\n\n» Domine, non sum dignus ut intres sub tectum meum: sed tantum dic verbo, et sanabitur anima mea. (três vezes)\nSenhor, eu não sou digno de que entreis em minha morada, mas dizei uma palavra e serei salvo.'**
  String get massGuideTradPart6Body;

  /// No description provided for @massGuideTradPart7Title.
  ///
  /// In pt, this message translates to:
  /// **'7. Ritos finais e Último Evangelho'**
  String get massGuideTradPart7Title;

  /// No description provided for @massGuideTradPart7Body.
  ///
  /// In pt, this message translates to:
  /// **'Depois da oração final, o sacerdote despede o povo e dá a bênção. A Missa termina com a leitura do Prólogo de São João, o Último Evangelho.\n\n» Ite, missa est.\n» Deo gratias.\nPodeis ir, é a despedida. — Graças a Deus.\n\n» Benedicat vos omnipotens Deus, Pater, et Filius, et Spiritus Sanctus.\n» Amen.\nAbençoe-vos Deus todo-poderoso, Pai, Filho e Espírito Santo. — Amém.\n\n» Et Verbum caro factum est, et habitavit in nobis.\nE o Verbo se fez carne e habitou entre nós. (genuflexão)'**
  String get massGuideTradPart7Body;

  /// No description provided for @searchPrayersHint.
  ///
  /// In pt, this message translates to:
  /// **'Buscar oração…'**
  String get searchPrayersHint;

  /// No description provided for @searchNovenasHint.
  ///
  /// In pt, this message translates to:
  /// **'Buscar novena…'**
  String get searchNovenasHint;

  /// No description provided for @searchExamHint.
  ///
  /// In pt, this message translates to:
  /// **'Buscar pecado ou tema…'**
  String get searchExamHint;

  /// No description provided for @searchNoPrayers.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma oração encontrada.\nTente outra palavra ou só o começo do nome.'**
  String get searchNoPrayers;

  /// No description provided for @searchNoNovenas.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma novena encontrada.\nTente outra palavra ou o nome do santo.'**
  String get searchNoNovenas;

  /// No description provided for @searchNoSins.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum item encontrado.\nTente outra palavra, um sinônimo ou só o começo dela.'**
  String get searchNoSins;

  /// No description provided for @searchApproximate.
  ///
  /// In pt, this message translates to:
  /// **'Resultados aproximados'**
  String get searchApproximate;

  /// No description provided for @searchClear.
  ///
  /// In pt, this message translates to:
  /// **'Limpar busca'**
  String get searchClear;

  /// No description provided for @rosaryFullComplete.
  ///
  /// In pt, this message translates to:
  /// **'Rosário completo!'**
  String get rosaryFullComplete;

  /// No description provided for @rosaryFullDetail.
  ///
  /// In pt, this message translates to:
  /// **'Hoje você rezou {chaplets} terços: {decades} dezenas.'**
  String rosaryFullDetail(int chaplets, int decades);

  /// No description provided for @rosaryProgress.
  ///
  /// In pt, this message translates to:
  /// **'{done} de {total} terços de hoje para completar o Rosário'**
  String rosaryProgress(int done, int total);

  /// No description provided for @prayerMealsContentLatin.
  ///
  /// In pt, this message translates to:
  /// **'Benedic, Domine, nos et haec tua dona, quae de tua largitate sumus sumpturi. Per Christum Dominum nostrum. Amen.'**
  String get prayerMealsContentLatin;

  /// No description provided for @todaySectionPending.
  ///
  /// In pt, this message translates to:
  /// **'Para hoje'**
  String get todaySectionPending;

  /// No description provided for @todaySectionDone.
  ///
  /// In pt, this message translates to:
  /// **'Feito hoje'**
  String get todaySectionDone;

  /// No description provided for @todayKindPrayer.
  ///
  /// In pt, this message translates to:
  /// **'Oração'**
  String get todayKindPrayer;

  /// No description provided for @todayKindRosary.
  ///
  /// In pt, this message translates to:
  /// **'Terço'**
  String get todayKindRosary;

  /// No description provided for @todayKindNovena.
  ///
  /// In pt, this message translates to:
  /// **'Novena'**
  String get todayKindNovena;

  /// No description provided for @todayKindMass.
  ///
  /// In pt, this message translates to:
  /// **'Missa'**
  String get todayKindMass;

  /// No description provided for @todayKindConfession.
  ///
  /// In pt, this message translates to:
  /// **'Confissão'**
  String get todayKindConfession;

  /// No description provided for @todayKindPenance.
  ///
  /// In pt, this message translates to:
  /// **'Penitência'**
  String get todayKindPenance;

  /// No description provided for @todayDoneEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nada registrado ainda. O que você rezar e fizer hoje aparece aqui.'**
  String get todayDoneEmpty;

  /// No description provided for @todayAllDone.
  ///
  /// In pt, this message translates to:
  /// **'Tudo feito por hoje. Deus abençoe o seu dia!'**
  String get todayAllDone;

  /// No description provided for @addSheetSubtitleToday.
  ///
  /// In pt, this message translates to:
  /// **'Para hoje'**
  String get addSheetSubtitleToday;

  /// No description provided for @addSheetSubtitleFuture.
  ///
  /// In pt, this message translates to:
  /// **'Para {date}'**
  String addSheetSubtitleFuture(String date);

  /// No description provided for @addSheetSubtitlePast.
  ///
  /// In pt, this message translates to:
  /// **'Registrar como rezada em {date}'**
  String addSheetSubtitlePast(String date);

  /// No description provided for @addSheetReminderTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novo lembrete de oração'**
  String get addSheetReminderTitle;

  /// No description provided for @addSheetReminderSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Escolha a oração ou novena que quer lembrar'**
  String get addSheetReminderSubtitle;

  /// No description provided for @addSheetSearchHint.
  ///
  /// In pt, this message translates to:
  /// **'Buscar oração ou novena…'**
  String get addSheetSearchHint;

  /// No description provided for @addNowTitle.
  ///
  /// In pt, this message translates to:
  /// **'Rezei agora'**
  String get addNowTitle;

  /// No description provided for @addNowDesc.
  ///
  /// In pt, this message translates to:
  /// **'Registra em Hoje, sem criar lembrete.'**
  String get addNowDesc;

  /// No description provided for @addPlanTitle.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar ao meu plano'**
  String get addPlanTitle;

  /// No description provided for @addPlanDesc.
  ///
  /// In pt, this message translates to:
  /// **'Entra na lista de orações do dia, com horário e lembrete opcionais.'**
  String get addPlanDesc;

  /// No description provided for @reminderChooserTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novo lembrete'**
  String get reminderChooserTitle;

  /// No description provided for @reminderChooserPrayerTitle.
  ///
  /// In pt, this message translates to:
  /// **'Lembrete de uma oração'**
  String get reminderChooserPrayerTitle;

  /// No description provided for @reminderChooserPrayerDesc.
  ///
  /// In pt, this message translates to:
  /// **'Escolha uma oração ou novena, o horário e a frequência.'**
  String get reminderChooserPrayerDesc;

  /// No description provided for @reminderChooserCustomTitle.
  ///
  /// In pt, this message translates to:
  /// **'Lembrete personalizado'**
  String get reminderChooserCustomTitle;

  /// No description provided for @reminderChooserCustomDesc.
  ///
  /// In pt, this message translates to:
  /// **'Escreva o seu próprio lembrete.'**
  String get reminderChooserCustomDesc;

  /// No description provided for @calendarTodayButton.
  ///
  /// In pt, this message translates to:
  /// **'Hoje'**
  String get calendarTodayButton;

  /// No description provided for @calendarLegendFeast.
  ///
  /// In pt, this message translates to:
  /// **'Festa'**
  String get calendarLegendFeast;

  /// No description provided for @calendarLegendPrayer.
  ///
  /// In pt, this message translates to:
  /// **'Oração'**
  String get calendarLegendPrayer;

  /// No description provided for @calendarRecordTitle.
  ///
  /// In pt, this message translates to:
  /// **'Registro do dia'**
  String get calendarRecordTitle;

  /// No description provided for @calendarNothingRecorded.
  ///
  /// In pt, this message translates to:
  /// **'Nada registrado neste dia. Use os botões acima para adicionar.'**
  String get calendarNothingRecorded;

  /// No description provided for @calendarFutureHint.
  ///
  /// In pt, this message translates to:
  /// **'Dia futuro: adicione uma oração para planejá-lo.'**
  String get calendarFutureHint;

  /// No description provided for @calendarActionPrayer.
  ///
  /// In pt, this message translates to:
  /// **'Oração'**
  String get calendarActionPrayer;

  /// No description provided for @calendarActionMass.
  ///
  /// In pt, this message translates to:
  /// **'Missa'**
  String get calendarActionMass;

  /// No description provided for @calendarActionConfession.
  ///
  /// In pt, this message translates to:
  /// **'Confissão'**
  String get calendarActionConfession;

  /// No description provided for @calendarSummaryTitle.
  ///
  /// In pt, this message translates to:
  /// **'Resumo do mês'**
  String get calendarSummaryTitle;

  /// No description provided for @calendarUpcomingTitle.
  ///
  /// In pt, this message translates to:
  /// **'Próximos dias'**
  String get calendarUpcomingTitle;

  /// No description provided for @calendarUpcomingEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma festa ou evento nas próximas semanas.'**
  String get calendarUpcomingEmpty;

  /// No description provided for @calendarSummaryPrayerDays.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{0 dias com oração} =1{1 dia com oração} other{{count} dias com oração}}'**
  String calendarSummaryPrayerDays(int count);

  /// No description provided for @calendarSummaryRosary.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{0 dias de terço} =1{1 dia de terço} other{{count} dias de terço}}'**
  String calendarSummaryRosary(int count);

  /// No description provided for @calendarSummaryMass.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{0 missas} =1{1 missa} other{{count} missas}}'**
  String calendarSummaryMass(int count);

  /// No description provided for @calendarSummaryConfession.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{0 confissões} =1{1 confissão} other{{count} confissões}}'**
  String calendarSummaryConfession(int count);

  /// No description provided for @calendarInDays.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{Amanhã} other{Em {count} dias}}'**
  String calendarInDays(int count);

  /// No description provided for @remindersYourTitle.
  ///
  /// In pt, this message translates to:
  /// **'Seus lembretes'**
  String get remindersYourTitle;

  /// No description provided for @remindersChurchTitle.
  ///
  /// In pt, this message translates to:
  /// **'Avisos da Igreja'**
  String get remindersChurchTitle;

  /// No description provided for @remindersChurchSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Domingos e dias santos, jejum e abstinência, no horário que você escolher.'**
  String get remindersChurchSubtitle;

  /// No description provided for @confessionCycleNone.
  ///
  /// In pt, this message translates to:
  /// **'Sem repetição: o lembrete toca uma vez, para a data planejada'**
  String get confessionCycleNone;

  /// No description provided for @cyclePeriodMonth.
  ///
  /// In pt, this message translates to:
  /// **'mês'**
  String get cyclePeriodMonth;

  /// No description provided for @confessionCycleText.
  ///
  /// In pt, this message translates to:
  /// **'A cada {period}, depois de cada confissão marcada como realizada'**
  String confessionCycleText(String period);

  /// No description provided for @confessionReminderPlanned.
  ///
  /// In pt, this message translates to:
  /// **'Confissão planejada: {date}'**
  String confessionReminderPlanned(String date);

  /// No description provided for @cyclePeriodWeeks.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{semana} other{{count} semanas}}'**
  String cyclePeriodWeeks(int count);

  /// No description provided for @cyclePeriodDays.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{dia} other{{count} dias}}'**
  String cyclePeriodDays(int count);

  /// No description provided for @prayerActionsTitle.
  ///
  /// In pt, this message translates to:
  /// **'O que fazer com esta oração?'**
  String get prayerActionsTitle;

  /// No description provided for @prayerActionOpen.
  ///
  /// In pt, this message translates to:
  /// **'Abrir oração'**
  String get prayerActionOpen;

  /// No description provided for @prayerActionOpenDesc.
  ///
  /// In pt, this message translates to:
  /// **'Ler e rezar agora'**
  String get prayerActionOpenDesc;

  /// No description provided for @prayerActionRemove.
  ///
  /// In pt, this message translates to:
  /// **'Excluir do plano'**
  String get prayerActionRemove;

  /// No description provided for @prayerActionRemoveDesc.
  ///
  /// In pt, this message translates to:
  /// **'Tira esta oração da lista de hoje'**
  String get prayerActionRemoveDesc;

  /// No description provided for @prayerActionEdit.
  ///
  /// In pt, this message translates to:
  /// **'Momento e lembrete'**
  String get prayerActionEdit;

  /// No description provided for @prayerActionEditDesc.
  ///
  /// In pt, this message translates to:
  /// **'Quando rezar e se o app deve avisar'**
  String get prayerActionEditDesc;

  /// No description provided for @prayerMoreOptions.
  ///
  /// In pt, this message translates to:
  /// **'Mais opções'**
  String get prayerMoreOptions;

  /// No description provided for @prayerEditSheetTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ajustar oração'**
  String get prayerEditSheetTitle;

  /// No description provided for @prayerEditMomentLabel.
  ///
  /// In pt, this message translates to:
  /// **'Quando você costuma rezar'**
  String get prayerEditMomentLabel;

  /// No description provided for @prayerEditReminderLabel.
  ///
  /// In pt, this message translates to:
  /// **'Lembrete'**
  String get prayerEditReminderLabel;

  /// No description provided for @prayerEditReminderOn.
  ///
  /// In pt, this message translates to:
  /// **'O app vai avisar você'**
  String get prayerEditReminderOn;

  /// No description provided for @prayerEditReminderOff.
  ///
  /// In pt, this message translates to:
  /// **'Sem lembrete'**
  String get prayerEditReminderOff;

  /// No description provided for @prayerEditTimeLabel.
  ///
  /// In pt, this message translates to:
  /// **'Horário do aviso'**
  String get prayerEditTimeLabel;

  /// No description provided for @prayerEditRepeatLabel.
  ///
  /// In pt, this message translates to:
  /// **'Repetir'**
  String get prayerEditRepeatLabel;

  /// No description provided for @prayersSectionGuides.
  ///
  /// In pt, this message translates to:
  /// **'Guias e devoções'**
  String get prayersSectionGuides;

  /// No description provided for @guideMassDesc.
  ///
  /// In pt, this message translates to:
  /// **'Acompanhe cada parte da Missa'**
  String get guideMassDesc;

  /// No description provided for @guideAdorationDesc.
  ///
  /// In pt, this message translates to:
  /// **'Um roteiro para a visita ao Santíssimo'**
  String get guideAdorationDesc;

  /// No description provided for @guideIntentionsDesc.
  ///
  /// In pt, this message translates to:
  /// **'Seus pedidos e as graças recebidas'**
  String get guideIntentionsDesc;

  /// No description provided for @supportTitle.
  ///
  /// In pt, this message translates to:
  /// **'Apoie o projeto'**
  String get supportTitle;

  /// No description provided for @supportSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Gratuito para todos, sempre'**
  String get supportSubtitle;

  /// No description provided for @supportStory.
  ///
  /// In pt, this message translates to:
  /// **'Somos Thalita e Diego, e vamos nos casar em breve. Este aplicativo é gratuito e continuará sendo; ele nasceu também desse sonho, o nosso casamento. Se ele ajuda você na vida de oração, considere uma doação de qualquer valor para as despesas da cerimônia, ou reze por nós. As duas coisas são um presente enorme.'**
  String get supportStory;

  /// No description provided for @supportSectionPrayer.
  ///
  /// In pt, this message translates to:
  /// **'Com oração'**
  String get supportSectionPrayer;

  /// No description provided for @supportSectionDonate.
  ///
  /// In pt, this message translates to:
  /// **'Com uma doação'**
  String get supportSectionDonate;

  /// No description provided for @supportPrayerTitle.
  ///
  /// In pt, this message translates to:
  /// **'Reze pelos noivos'**
  String get supportPrayerTitle;

  /// No description provided for @supportPrayerDesc.
  ///
  /// In pt, this message translates to:
  /// **'Uma Ave-Maria pelo casamento de Thalita e Diego e pela nossa futura família'**
  String get supportPrayerDesc;

  /// No description provided for @supportPrayerButton.
  ///
  /// In pt, this message translates to:
  /// **'Vou rezar por vocês'**
  String get supportPrayerButton;

  /// No description provided for @supportPrayerThanks.
  ///
  /// In pt, this message translates to:
  /// **'Muito obrigado! Que Nossa Senhora interceda por você também.'**
  String get supportPrayerThanks;

  /// No description provided for @supportPixTitle.
  ///
  /// In pt, this message translates to:
  /// **'PIX'**
  String get supportPixTitle;

  /// No description provided for @supportPixDesc.
  ///
  /// In pt, this message translates to:
  /// **'Aponte a câmera do app do banco para o QR Code, ou copie o código'**
  String get supportPixDesc;

  /// No description provided for @supportPixCopyPaste.
  ///
  /// In pt, this message translates to:
  /// **'Copiar PIX copia e cola'**
  String get supportPixCopyPaste;

  /// No description provided for @supportPixCopied.
  ///
  /// In pt, this message translates to:
  /// **'Código PIX copiado. Cole no app do seu banco.'**
  String get supportPixCopied;

  /// No description provided for @supportPixKey.
  ///
  /// In pt, this message translates to:
  /// **'Chave PIX'**
  String get supportPixKey;

  /// No description provided for @supportCardTitle.
  ///
  /// In pt, this message translates to:
  /// **'Cartão de crédito'**
  String get supportCardTitle;

  /// No description provided for @supportCardDesc.
  ///
  /// In pt, this message translates to:
  /// **'Doação internacional, por uma página segura'**
  String get supportCardDesc;

  /// No description provided for @supportCryptoTitle.
  ///
  /// In pt, this message translates to:
  /// **'Criptomoedas'**
  String get supportCryptoTitle;

  /// No description provided for @supportCryptoDesc.
  ///
  /// In pt, this message translates to:
  /// **'Confira a rede antes de enviar'**
  String get supportCryptoDesc;

  /// No description provided for @supportAddressCopied.
  ///
  /// In pt, this message translates to:
  /// **'Endereço copiado'**
  String get supportAddressCopied;

  /// No description provided for @supportLinkCopied.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível abrir. O link foi copiado.'**
  String get supportLinkCopied;

  /// No description provided for @supportShowQr.
  ///
  /// In pt, this message translates to:
  /// **'Mostrar QR Code'**
  String get supportShowQr;

  /// No description provided for @supportHideQr.
  ///
  /// In pt, this message translates to:
  /// **'Esconder QR Code'**
  String get supportHideQr;

  /// No description provided for @supportFootnote.
  ///
  /// In pt, this message translates to:
  /// **'Doações são voluntárias e não liberam nada a mais: o app inteiro é gratuito.'**
  String get supportFootnote;

  /// No description provided for @aboutSupportButton.
  ///
  /// In pt, this message translates to:
  /// **'Apoie o projeto'**
  String get aboutSupportButton;

  /// No description provided for @nudgeTitle.
  ///
  /// In pt, this message translates to:
  /// **'Um pedido dos noivos'**
  String get nudgeTitle;

  /// No description provided for @nudgeBody.
  ///
  /// In pt, this message translates to:
  /// **'Este app é gratuito e nasceu para ajudar nas despesas do nosso casamento. Se ele faz bem à sua vida de oração, considere uma doação, ou reze uma Ave-Maria por nós. Thalita e Diego'**
  String get nudgeBody;

  /// No description provided for @nudgeSupport.
  ///
  /// In pt, this message translates to:
  /// **'Apoiar'**
  String get nudgeSupport;

  /// No description provided for @nudgeNotNow.
  ///
  /// In pt, this message translates to:
  /// **'Agora não'**
  String get nudgeNotNow;

  /// No description provided for @nudgeAlreadySupported.
  ///
  /// In pt, this message translates to:
  /// **'Já apoiei'**
  String get nudgeAlreadySupported;

  /// No description provided for @nudgeThanksSupported.
  ///
  /// In pt, this message translates to:
  /// **'Muito obrigado pelo seu apoio! Deus lhe pague.'**
  String get nudgeThanksSupported;

  /// No description provided for @supportHeroTitle.
  ///
  /// In pt, this message translates to:
  /// **'Um app gratuito, um sonho a dois'**
  String get supportHeroTitle;

  /// No description provided for @supportQuote.
  ///
  /// In pt, this message translates to:
  /// **'“Portanto, o que Deus uniu, o homem não separe.” (Mt 19,6)'**
  String get supportQuote;

  /// No description provided for @supportBadgeFree.
  ///
  /// In pt, this message translates to:
  /// **'100% gratuito'**
  String get supportBadgeFree;

  /// No description provided for @supportBadgeNoAds.
  ///
  /// In pt, this message translates to:
  /// **'Sem anúncios'**
  String get supportBadgeNoAds;

  /// No description provided for @supportBadgePrivate.
  ///
  /// In pt, this message translates to:
  /// **'Dados só no seu celular'**
  String get supportBadgePrivate;

  /// No description provided for @supportChooseMethod.
  ///
  /// In pt, this message translates to:
  /// **'Como você quer ajudar?'**
  String get supportChooseMethod;

  /// No description provided for @supportMethodPix.
  ///
  /// In pt, this message translates to:
  /// **'PIX'**
  String get supportMethodPix;

  /// No description provided for @supportMethodCard.
  ///
  /// In pt, this message translates to:
  /// **'Cartão'**
  String get supportMethodCard;

  /// No description provided for @supportMethodCrypto.
  ///
  /// In pt, this message translates to:
  /// **'Cripto'**
  String get supportMethodCrypto;

  /// No description provided for @supportPixAmountLabel.
  ///
  /// In pt, this message translates to:
  /// **'Escolha um valor (ou deixe em aberto)'**
  String get supportPixAmountLabel;

  /// No description provided for @supportPixAmountFree.
  ///
  /// In pt, this message translates to:
  /// **'Outro valor'**
  String get supportPixAmountFree;

  /// No description provided for @supportPrayerAlt.
  ///
  /// In pt, this message translates to:
  /// **'Prefere ajudar com oração?'**
  String get supportPrayerAlt;

  /// No description provided for @supportCryptoLinkButton.
  ///
  /// In pt, this message translates to:
  /// **'Doar com cripto'**
  String get supportCryptoLinkButton;

  /// No description provided for @drawerTour.
  ///
  /// In pt, this message translates to:
  /// **'Guia do app'**
  String get drawerTour;

  /// No description provided for @drawerTourDesc.
  ///
  /// In pt, this message translates to:
  /// **'Passo a passo de onde fica cada coisa'**
  String get drawerTourDesc;

  /// No description provided for @tourSkip.
  ///
  /// In pt, this message translates to:
  /// **'Pular'**
  String get tourSkip;

  /// No description provided for @tourBack.
  ///
  /// In pt, this message translates to:
  /// **'Voltar'**
  String get tourBack;

  /// No description provided for @tourNext.
  ///
  /// In pt, this message translates to:
  /// **'Próximo'**
  String get tourNext;

  /// No description provided for @tourFinish.
  ///
  /// In pt, this message translates to:
  /// **'Começar'**
  String get tourFinish;

  /// No description provided for @tourWelcomeTitle.
  ///
  /// In pt, this message translates to:
  /// **'Bem-vindo! Vamos conhecer o app?'**
  String get tourWelcomeTitle;

  /// No description provided for @tourWelcomeBody.
  ///
  /// In pt, this message translates to:
  /// **'Em poucos passos você vai ver onde fica cada coisa: o plano do dia, as orações, as novenas, o terço e o exame de consciência. Toque em Próximo (ou em qualquer lugar da tela) para seguir.'**
  String get tourWelcomeBody;

  /// No description provided for @tourNavGardenTitle.
  ///
  /// In pt, this message translates to:
  /// **'Jardim: a sua página do dia'**
  String get tourNavGardenTitle;

  /// No description provided for @tourNavGardenBody.
  ///
  /// In pt, this message translates to:
  /// **'Este botão, na barra de baixo, sempre traz você de volta para cá. É aqui que fica o seu plano de oração do dia.'**
  String get tourNavGardenBody;

  /// No description provided for @tourGardenTitle.
  ///
  /// In pt, this message translates to:
  /// **'Jardim da Alma'**
  String get tourGardenTitle;

  /// No description provided for @tourGardenBody.
  ///
  /// In pt, this message translates to:
  /// **'Cada quadradinho é um dia. Ele vai ficando mais verde conforme você reza, e fica todo verde nos dias de Missa ou Confissão. É o retrato da sua constância.'**
  String get tourGardenBody;

  /// No description provided for @tourTodayTitle.
  ///
  /// In pt, this message translates to:
  /// **'Hoje'**
  String get tourTodayTitle;

  /// No description provided for @tourTodayBody.
  ///
  /// In pt, this message translates to:
  /// **'Aqui ficam as orações do seu plano para hoje, separadas por manhã, meio-dia e noite. Toque no quadradinho ao lado de uma oração para marcar como rezada. Toque no nome para abri-la, e no botão de três pontinhos, à direita, para mudar o horário, criar um lembrete ou tirar do plano.'**
  String get tourTodayBody;

  /// No description provided for @tourAddTitle.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar ao plano'**
  String get tourAddTitle;

  /// No description provided for @tourAddBody.
  ///
  /// In pt, this message translates to:
  /// **'Use o botão + para colocar no seu plano uma oração, uma novena ou o terço. Você escolhe o momento do dia e, se quiser, um lembrete.'**
  String get tourAddBody;

  /// No description provided for @tourCalendarTitle.
  ///
  /// In pt, this message translates to:
  /// **'Calendário'**
  String get tourCalendarTitle;

  /// No description provided for @tourCalendarBody.
  ///
  /// In pt, this message translates to:
  /// **'Veja o que você rezou em cada dia, as Missas, confissões e novenas, além do tempo litúrgico. Toque em um dia para ver os detalhes.'**
  String get tourCalendarBody;

  /// No description provided for @tourRemindersTitle.
  ///
  /// In pt, this message translates to:
  /// **'Lembretes'**
  String get tourRemindersTitle;

  /// No description provided for @tourRemindersBody.
  ///
  /// In pt, this message translates to:
  /// **'Todos os avisos do app em um só lugar: orações, novenas, confissão e os dias de preceito da Igreja. Você pode pausar, editar ou criar um lembrete seu.'**
  String get tourRemindersBody;

  /// No description provided for @tourMenuTitle.
  ///
  /// In pt, this message translates to:
  /// **'Menu'**
  String get tourMenuTitle;

  /// No description provided for @tourMenuBody.
  ///
  /// In pt, this message translates to:
  /// **'Aqui ficam Sobre o Projeto, este Guia do app (para rever quando quiser) e as Configurações, como idioma, tamanho do texto e backup.'**
  String get tourMenuBody;

  /// No description provided for @tourPrayersTitle.
  ///
  /// In pt, this message translates to:
  /// **'Orações'**
  String get tourPrayersTitle;

  /// No description provided for @tourPrayersBody.
  ///
  /// In pt, this message translates to:
  /// **'Todas as orações do app, organizadas por categoria. No topo aparece a oração indicada para este momento do dia e o santo do dia.'**
  String get tourPrayersBody;

  /// No description provided for @tourSearchTitle.
  ///
  /// In pt, this message translates to:
  /// **'Buscar uma oração'**
  String get tourSearchTitle;

  /// No description provided for @tourSearchBody.
  ///
  /// In pt, this message translates to:
  /// **'Digite parte do nome ou do texto. A busca entende palavras sem acento e até pequenos erros de digitação.'**
  String get tourSearchBody;

  /// No description provided for @tourGuidesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Guias e devoções'**
  String get tourGuidesTitle;

  /// No description provided for @tourGuidesBody.
  ///
  /// In pt, this message translates to:
  /// **'Guia da Missa (tradicional ou atual), roteiro de Adoração ao Santíssimo e as suas intenções de oração.'**
  String get tourGuidesBody;

  /// No description provided for @tourNovenasTitle.
  ///
  /// In pt, this message translates to:
  /// **'Novenas'**
  String get tourNovenasTitle;

  /// No description provided for @tourNovenasBody.
  ///
  /// In pt, this message translates to:
  /// **'Uma novena é uma oração de nove dias seguidos. Aqui ficam as novenas tradicionais, como a de Natal, as do Sagrado Coração e da Imaculada Conceição, e a de santos como São José. Você acompanha cada dia sem perder a conta.'**
  String get tourNovenasBody;

  /// No description provided for @tourRosaryTitle.
  ///
  /// In pt, this message translates to:
  /// **'Santo Terço'**
  String get tourRosaryTitle;

  /// No description provided for @tourRosaryBody.
  ///
  /// In pt, this message translates to:
  /// **'O terço guiado: o app mostra cada oração na hora certa, para você rezar sem se perder nas contas. Funciona em qualquer lugar, sem internet.'**
  String get tourRosaryBody;

  /// No description provided for @tourExamTitle.
  ///
  /// In pt, this message translates to:
  /// **'Exame de consciência'**
  String get tourExamTitle;

  /// No description provided for @tourExamBody.
  ///
  /// In pt, this message translates to:
  /// **'O coração do app para a confissão. Examine a consciência com calma, marque o que lembrar e leve um resumo para o confessionário. Tudo fica só no seu celular e pode ser protegido por senha.'**
  String get tourExamBody;

  /// No description provided for @tourEndTitle.
  ///
  /// In pt, this message translates to:
  /// **'Pronto!'**
  String get tourEndTitle;

  /// No description provided for @tourEndBody.
  ///
  /// In pt, this message translates to:
  /// **'Você pode rever este guia quando quiser, no menu (as três linhas no canto de cima) › Guia do app. Que este app ajude você a rezar todos os dias. Deus abençoe!'**
  String get tourEndBody;

  /// No description provided for @onbFeatureRosary.
  ///
  /// In pt, this message translates to:
  /// **'Santo Terço conta por conta e novenas com lembrete diário'**
  String get onbFeatureRosary;

  /// No description provided for @onbFeatureGuides.
  ///
  /// In pt, this message translates to:
  /// **'Guias da Missa, da Adoração e suas intenções de oração'**
  String get onbFeatureGuides;

  /// No description provided for @onbPrivacyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sua oração é só sua'**
  String get onbPrivacyTitle;

  /// No description provided for @onbPrivacyBody.
  ///
  /// In pt, this message translates to:
  /// **'Tudo o que você registra fica guardado apenas neste celular.'**
  String get onbPrivacyBody;

  /// No description provided for @onbPrivacyNoAccount.
  ///
  /// In pt, this message translates to:
  /// **'Sem conta e sem login'**
  String get onbPrivacyNoAccount;

  /// No description provided for @onbPrivacyNoAds.
  ///
  /// In pt, this message translates to:
  /// **'Sem anúncios e sem rastreamento'**
  String get onbPrivacyNoAds;

  /// No description provided for @onbPrivacyBackup.
  ///
  /// In pt, this message translates to:
  /// **'O backup é você quem faz, quando quiser'**
  String get onbPrivacyBackup;

  /// No description provided for @onbProjectTitle.
  ///
  /// In pt, this message translates to:
  /// **'Gratuito, feito com amor'**
  String get onbProjectTitle;

  /// No description provided for @onbProjectBody.
  ///
  /// In pt, this message translates to:
  /// **'O Sancta é gratuito e sem anúncios. Foi feito por Thalita e Diego, um casal que está se preparando para o matrimônio. Rezar por nós já é um grande presente; quem quiser ajudar encontra como em Sobre o Projeto, no menu.'**
  String get onbProjectBody;

  /// No description provided for @onbProjectBodyStore.
  ///
  /// In pt, this message translates to:
  /// **'O Sancta é gratuito e sem anúncios. Foi feito por Thalita e Diego, um casal que está se preparando para o matrimônio. Se puder, reze por nós!'**
  String get onbProjectBodyStore;

  /// No description provided for @onbReadyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Tudo pronto!'**
  String get onbReadyTitle;

  /// No description provided for @onbReadyBody.
  ///
  /// In pt, this message translates to:
  /// **'Quer um passeio rápido pela tela? O guia mostra onde fica cada coisa. Você pode revê-lo quando quiser em Menu › Guia do app.'**
  String get onbReadyBody;

  /// No description provided for @onbTourStart.
  ///
  /// In pt, this message translates to:
  /// **'Ver o guia'**
  String get onbTourStart;

  /// No description provided for @onbTourSkip.
  ///
  /// In pt, this message translates to:
  /// **'Começar sem o guia'**
  String get onbTourSkip;

  /// No description provided for @gardenDemoHint.
  ///
  /// In pt, this message translates to:
  /// **'Exemplo: assim fica o jardim depois de um ano de oração e perseverança. O seu começa hoje!'**
  String get gardenDemoHint;

  /// No description provided for @afterTourTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sobre este app'**
  String get afterTourTitle;

  /// No description provided for @afterTourBody.
  ///
  /// In pt, this message translates to:
  /// **'O Sancta foi criado por Thalita e Diego para ajudar a pagar as despesas do nosso casamento, mas também para que os católicos rezem bem e vivam a fé a cada dia. Ele é gratuito e sem anúncios. Se ele te ajuda e você quiser colaborar, toque no botão abaixo; e uma oração por nós já é um grande presente.'**
  String get afterTourBody;

  /// No description provided for @afterTourBodyStore.
  ///
  /// In pt, this message translates to:
  /// **'O Sancta foi criado por Thalita e Diego para que os católicos rezem bem e vivam a fé a cada dia, e também para ajudar nas despesas do nosso casamento. Ele é gratuito e sem anúncios. Uma oração por nós já é um grande presente.'**
  String get afterTourBodyStore;

  /// No description provided for @afterTourButton.
  ///
  /// In pt, this message translates to:
  /// **'Conhecer o projeto'**
  String get afterTourButton;

  /// No description provided for @afterTourLater.
  ///
  /// In pt, this message translates to:
  /// **'Agora não'**
  String get afterTourLater;

  /// No description provided for @tourNovenaSearchTitle.
  ///
  /// In pt, this message translates to:
  /// **'Encontre a sua novena'**
  String get tourNovenaSearchTitle;

  /// No description provided for @tourNovenaSearchBody.
  ///
  /// In pt, this message translates to:
  /// **'Digite o nome do santo ou da devoção. A busca aceita erros de digitação e acentos. Quando há uma festa chegando, o app sugere a novena certa no topo da lista.'**
  String get tourNovenaSearchBody;

  /// No description provided for @tourNovenaStartTitle.
  ///
  /// In pt, this message translates to:
  /// **'Iniciar e acompanhar'**
  String get tourNovenaStartTitle;

  /// No description provided for @tourNovenaStartBody.
  ///
  /// In pt, this message translates to:
  /// **'Toque numa novena para ler a oração de cada dia. Em Iniciar Novena você escolhe o primeiro dia e o horário do lembrete. Daí em diante a oração do dia aparece na aba Hoje, o progresso fica salvo e uma vela acende no seu Jardim.'**
  String get tourNovenaStartBody;

  /// No description provided for @tourRosaryProgressTitle.
  ///
  /// In pt, this message translates to:
  /// **'Seu Rosário de hoje'**
  String get tourRosaryProgressTitle;

  /// No description provided for @tourRosaryProgressBody.
  ///
  /// In pt, this message translates to:
  /// **'Cada bolinha é um terço rezado hoje. Quatro terços (com os mistérios luminosos) ou três (no Modo Tradicional, que você escolhe em Configurações) completam um Rosário inteiro, e o app comemora quando você chega lá.'**
  String get tourRosaryProgressBody;

  /// No description provided for @tourRosaryTodayTitle.
  ///
  /// In pt, this message translates to:
  /// **'Mistérios do dia'**
  String get tourRosaryTodayTitle;

  /// No description provided for @tourRosaryTodayBody.
  ///
  /// In pt, this message translates to:
  /// **'O app já escolhe os mistérios do dia da semana. Toque no cartão para rezar: as orações vão passando conta por conta, com Próxima e Anterior. A tela fica acesa, o celular vibra a cada Ave-Maria, mais longo depois da 10ª Ave-Maria, e ao terminar uma chuva de pétalas e uma rosa no Jardim.'**
  String get tourRosaryTodayBody;

  /// No description provided for @tourExamHeaderTitle.
  ///
  /// In pt, this message translates to:
  /// **'Suas confissões'**
  String get tourExamHeaderTitle;

  /// No description provided for @tourExamHeaderBody.
  ///
  /// In pt, this message translates to:
  /// **'Aqui você registra a última confissão e planeja a próxima. O app avisa quando está chegando a hora e mostra há quanto tempo você não se confessa.'**
  String get tourExamHeaderBody;

  /// No description provided for @tourExamJornadaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Jornada de Confissão'**
  String get tourExamJornadaTitle;

  /// No description provided for @tourExamJornadaBody.
  ///
  /// In pt, this message translates to:
  /// **'Um caminho passo a passo para quem quer se preparar bem: oração, exame, arrependimento e propósito, até o dia de se confessar. Ótimo para quem está voltando à confissão depois de muito tempo.'**
  String get tourExamJornadaBody;

  /// No description provided for @tourExamSectionsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Examine por categorias'**
  String get tourExamSectionsTitle;

  /// No description provided for @tourExamSectionsBody.
  ///
  /// In pt, this message translates to:
  /// **'Percorra as categorias, como os Mandamentos e os pecados capitais, e toque em + em cada item de que se lembrar (se repetiu, toque de novo). Use a busca para achar um pecado pelo nome.'**
  String get tourExamSectionsBody;

  /// No description provided for @tourExamGuideTitle.
  ///
  /// In pt, this message translates to:
  /// **'Gerar o guia'**
  String get tourExamGuideTitle;

  /// No description provided for @tourExamGuideBody.
  ///
  /// In pt, this message translates to:
  /// **'Quando terminar, toque em Gerar guia: o app monta um resumo organizado do que você marcou, para levar à confissão. Ao confirmar a confissão, as marcações são apagadas e o Jardim ganha um lírio.'**
  String get tourExamGuideBody;

  /// No description provided for @backupRestoring.
  ///
  /// In pt, this message translates to:
  /// **'Restaurando seu backup… Isso pode levar alguns segundos.'**
  String get backupRestoring;

  /// No description provided for @drawerGrowth.
  ///
  /// In pt, this message translates to:
  /// **'Minha Evolução'**
  String get drawerGrowth;

  /// No description provided for @drawerGrowthDesc.
  ///
  /// In pt, this message translates to:
  /// **'Sequências, perseverança e metas de oração'**
  String get drawerGrowthDesc;

  /// No description provided for @growthCardTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sua evolução'**
  String get growthCardTitle;

  /// No description provided for @growthCardCounter.
  ///
  /// In pt, this message translates to:
  /// **'{achieved} de {total} metas'**
  String growthCardCounter(int achieved, int total);

  /// No description provided for @growthNextGoalLabel.
  ///
  /// In pt, this message translates to:
  /// **'Próxima meta: {title}'**
  String growthNextGoalLabel(String title);

  /// No description provided for @growthAllDoneLabel.
  ///
  /// In pt, this message translates to:
  /// **'Todas as metas atuais foram alcançadas! Continue perseverando.'**
  String get growthAllDoneLabel;

  /// No description provided for @growthChipPrayer.
  ///
  /// In pt, this message translates to:
  /// **'Oração: {days}d'**
  String growthChipPrayer(int days);

  /// No description provided for @growthChipRosary.
  ///
  /// In pt, this message translates to:
  /// **'Terço: {days}d'**
  String growthChipRosary(int days);

  /// No description provided for @growthChipMass.
  ///
  /// In pt, this message translates to:
  /// **'Missa: {weeks} dom.'**
  String growthChipMass(int weeks);

  /// No description provided for @growthPageTitle.
  ///
  /// In pt, this message translates to:
  /// **'Evolução e Perseverança'**
  String get growthPageTitle;

  /// No description provided for @growthPageSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Acompanhe sua constância na oração e as metas alcançadas.'**
  String get growthPageSubtitle;

  /// No description provided for @growthSummaryTitle.
  ///
  /// In pt, this message translates to:
  /// **'Caminho de perseverança'**
  String get growthSummaryTitle;

  /// No description provided for @growthSummaryProgress.
  ///
  /// In pt, this message translates to:
  /// **'{achieved} de {total} metas alcançadas'**
  String growthSummaryProgress(int achieved, int total);

  /// No description provided for @growthSummaryQuote.
  ///
  /// In pt, this message translates to:
  /// **'\"Quem perseverar até o fim, esse será salvo.\" (Mt 24, 13)'**
  String get growthSummaryQuote;

  /// No description provided for @growthSectionStreaks.
  ///
  /// In pt, this message translates to:
  /// **'SEQUÊNCIAS ATUAIS'**
  String get growthSectionStreaks;

  /// No description provided for @growthStreakPrayerLabel.
  ///
  /// In pt, this message translates to:
  /// **'Dias seguidos rezando'**
  String get growthStreakPrayerLabel;

  /// No description provided for @growthStreakRosaryLabel.
  ///
  /// In pt, this message translates to:
  /// **'Dias seguidos de Terço'**
  String get growthStreakRosaryLabel;

  /// No description provided for @growthStreakMassLabel.
  ///
  /// In pt, this message translates to:
  /// **'Domingos seguidos na Missa'**
  String get growthStreakMassLabel;

  /// No description provided for @growthStreakBest.
  ///
  /// In pt, this message translates to:
  /// **'Recorde: {count}'**
  String growthStreakBest(int count);

  /// No description provided for @growthTotalRosariesLabel.
  ///
  /// In pt, this message translates to:
  /// **'Total: {count} terços'**
  String growthTotalRosariesLabel(int count);

  /// No description provided for @growthPreceptMonthsLabel.
  ///
  /// In pt, this message translates to:
  /// **'Meses fiéis ao preceito: {count}'**
  String growthPreceptMonthsLabel(int count);

  /// No description provided for @growthStreakDevotionLabel.
  ///
  /// In pt, this message translates to:
  /// **'Novenas e Confissões'**
  String get growthStreakDevotionLabel;

  /// No description provided for @growthDevotionBreakdown.
  ///
  /// In pt, this message translates to:
  /// **'{novenas} novenas · {confessions} confissões'**
  String growthDevotionBreakdown(int novenas, int confessions);

  /// No description provided for @growthSectionNext.
  ///
  /// In pt, this message translates to:
  /// **'PRÓXIMA META'**
  String get growthSectionNext;

  /// No description provided for @growthCatPrayer.
  ///
  /// In pt, this message translates to:
  /// **'CONSTÂNCIA NA ORAÇÃO'**
  String get growthCatPrayer;

  /// No description provided for @growthCatRosary.
  ///
  /// In pt, this message translates to:
  /// **'SANTO TERÇO'**
  String get growthCatRosary;

  /// No description provided for @growthCatMass.
  ///
  /// In pt, this message translates to:
  /// **'SANTA MISSA'**
  String get growthCatMass;

  /// No description provided for @growthCatDevotion.
  ///
  /// In pt, this message translates to:
  /// **'NOVENAS E SACRAMENTOS'**
  String get growthCatDevotion;

  /// No description provided for @growthAchievedBadge.
  ///
  /// In pt, this message translates to:
  /// **'Alcançada'**
  String get growthAchievedBadge;

  /// No description provided for @growthProgressRatio.
  ///
  /// In pt, this message translates to:
  /// **'{current} / {target}'**
  String growthProgressRatio(int current, int target);

  /// No description provided for @growthPopupTitleSingle.
  ///
  /// In pt, this message translates to:
  /// **'Nova meta alcançada!'**
  String get growthPopupTitleSingle;

  /// No description provided for @growthPopupTitleMulti.
  ///
  /// In pt, this message translates to:
  /// **'Novas metas alcançadas!'**
  String get growthPopupTitleMulti;

  /// No description provided for @growthPopupEncouragement.
  ///
  /// In pt, this message translates to:
  /// **'Deo gratias! Cada passo fiel aproxima sua alma de Deus. Continue firme na oração diária.'**
  String get growthPopupEncouragement;

  /// No description provided for @growthPopupViewAll.
  ///
  /// In pt, this message translates to:
  /// **'Ver evolução'**
  String get growthPopupViewAll;

  /// No description provided for @growthPopupContinue.
  ///
  /// In pt, this message translates to:
  /// **'Continuar'**
  String get growthPopupContinue;

  /// No description provided for @milestonePrayerStreak3Title.
  ///
  /// In pt, this message translates to:
  /// **'3 dias seguidos rezando'**
  String get milestonePrayerStreak3Title;

  /// No description provided for @milestonePrayerStreak3Desc.
  ///
  /// In pt, this message translates to:
  /// **'Primeiros passos na constância diária com Deus.'**
  String get milestonePrayerStreak3Desc;

  /// No description provided for @milestonePrayerStreak7Title.
  ///
  /// In pt, this message translates to:
  /// **'7 dias seguidos rezando'**
  String get milestonePrayerStreak7Title;

  /// No description provided for @milestonePrayerStreak7Desc.
  ///
  /// In pt, this message translates to:
  /// **'Uma semana inteira dedicada à vida de oração.'**
  String get milestonePrayerStreak7Desc;

  /// No description provided for @milestonePrayerStreak21Title.
  ///
  /// In pt, this message translates to:
  /// **'21 dias seguidos rezando'**
  String get milestonePrayerStreak21Title;

  /// No description provided for @milestonePrayerStreak21Desc.
  ///
  /// In pt, this message translates to:
  /// **'O hábito da oração começa a criar raízes firmes.'**
  String get milestonePrayerStreak21Desc;

  /// No description provided for @milestonePrayerStreak40Title.
  ///
  /// In pt, this message translates to:
  /// **'40 dias seguidos rezando'**
  String get milestonePrayerStreak40Title;

  /// No description provided for @milestonePrayerStreak40Desc.
  ///
  /// In pt, this message translates to:
  /// **'Uma Quaresma inteira de fidelidade na oração.'**
  String get milestonePrayerStreak40Desc;

  /// No description provided for @milestonePrayerStreak90Title.
  ///
  /// In pt, this message translates to:
  /// **'90 dias seguidos rezando'**
  String get milestonePrayerStreak90Title;

  /// No description provided for @milestonePrayerStreak90Desc.
  ///
  /// In pt, this message translates to:
  /// **'Três meses de perseverança constante diante do Senhor.'**
  String get milestonePrayerStreak90Desc;

  /// No description provided for @milestonePrayerStreak365Title.
  ///
  /// In pt, this message translates to:
  /// **'365 dias seguidos rezando'**
  String get milestonePrayerStreak365Title;

  /// No description provided for @milestonePrayerStreak365Desc.
  ///
  /// In pt, this message translates to:
  /// **'Um ano inteiro de oração fiel sem interromper a caminhada.'**
  String get milestonePrayerStreak365Desc;

  /// No description provided for @milestoneRosaryTotal1Title.
  ///
  /// In pt, this message translates to:
  /// **'Primeiro Santo Terço'**
  String get milestoneRosaryTotal1Title;

  /// No description provided for @milestoneRosaryTotal1Desc.
  ///
  /// In pt, this message translates to:
  /// **'Concluir e registrar o seu primeiro Terço no aplicativo.'**
  String get milestoneRosaryTotal1Desc;

  /// No description provided for @milestoneRosaryStreak7Title.
  ///
  /// In pt, this message translates to:
  /// **'7 dias seguidos de Terço'**
  String get milestoneRosaryStreak7Title;

  /// No description provided for @milestoneRosaryStreak7Desc.
  ///
  /// In pt, this message translates to:
  /// **'Uma semana inteira meditando os mistérios com Nossa Senhora.'**
  String get milestoneRosaryStreak7Desc;

  /// No description provided for @milestoneRosaryStreak30Title.
  ///
  /// In pt, this message translates to:
  /// **'30 dias seguidos de Terço'**
  String get milestoneRosaryStreak30Title;

  /// No description provided for @milestoneRosaryStreak30Desc.
  ///
  /// In pt, this message translates to:
  /// **'Um mês mariano rezando o Santo Terço todos os dias.'**
  String get milestoneRosaryStreak30Desc;

  /// No description provided for @milestoneRosaryStreak54Title.
  ///
  /// In pt, this message translates to:
  /// **'54 dias seguidos de Terço'**
  String get milestoneRosaryStreak54Title;

  /// No description provided for @milestoneRosaryStreak54Desc.
  ///
  /// In pt, this message translates to:
  /// **'Perseverança equivalente à tradicional Novena da Pompeia.'**
  String get milestoneRosaryStreak54Desc;

  /// No description provided for @milestoneRosaryTotal100Title.
  ///
  /// In pt, this message translates to:
  /// **'100 Terços rezados'**
  String get milestoneRosaryTotal100Title;

  /// No description provided for @milestoneRosaryTotal100Desc.
  ///
  /// In pt, this message translates to:
  /// **'Cem terços acumulados em honra à Virgem Santíssima.'**
  String get milestoneRosaryTotal100Desc;

  /// No description provided for @milestoneMassTotal1Title.
  ///
  /// In pt, this message translates to:
  /// **'Primeira Missa registrada'**
  String get milestoneMassTotal1Title;

  /// No description provided for @milestoneMassTotal1Desc.
  ///
  /// In pt, this message translates to:
  /// **'A primeira flor dourada plantada no seu Jardim da Alma.'**
  String get milestoneMassTotal1Desc;

  /// No description provided for @milestoneMassSunday4Title.
  ///
  /// In pt, this message translates to:
  /// **'4 domingos seguidos na Missa'**
  String get milestoneMassSunday4Title;

  /// No description provided for @milestoneMassSunday4Desc.
  ///
  /// In pt, this message translates to:
  /// **'Um mês inteiro sem faltar ao Dia do Senhor.'**
  String get milestoneMassSunday4Desc;

  /// No description provided for @milestoneMassPerfectMonth1Title.
  ///
  /// In pt, this message translates to:
  /// **'Mês fiel aos dias de preceito'**
  String get milestoneMassPerfectMonth1Title;

  /// No description provided for @milestoneMassPerfectMonth1Desc.
  ///
  /// In pt, this message translates to:
  /// **'Participar da Missa em todos os domingos e festas de guarda de um mês.'**
  String get milestoneMassPerfectMonth1Desc;

  /// No description provided for @milestoneMassSunday12Title.
  ///
  /// In pt, this message translates to:
  /// **'12 domingos seguidos na Missa'**
  String get milestoneMassSunday12Title;

  /// No description provided for @milestoneMassSunday12Desc.
  ///
  /// In pt, this message translates to:
  /// **'Um trimestre inteiro de fidelidade à Santa Missa dominical.'**
  String get milestoneMassSunday12Desc;

  /// No description provided for @milestoneMassSunday52Title.
  ///
  /// In pt, this message translates to:
  /// **'52 domingos seguidos na Missa'**
  String get milestoneMassSunday52Title;

  /// No description provided for @milestoneMassSunday52Desc.
  ///
  /// In pt, this message translates to:
  /// **'Um ano inteiro sem faltar à Santa Missa aos domingos.'**
  String get milestoneMassSunday52Desc;

  /// No description provided for @milestoneNovena1Title.
  ///
  /// In pt, this message translates to:
  /// **'Primeira Novena concluída'**
  String get milestoneNovena1Title;

  /// No description provided for @milestoneNovena1Desc.
  ///
  /// In pt, this message translates to:
  /// **'Perseverar pelos nove dias completos de uma novena.'**
  String get milestoneNovena1Desc;

  /// No description provided for @milestoneNovena3Title.
  ///
  /// In pt, this message translates to:
  /// **'3 Novenas concluídas'**
  String get milestoneNovena3Title;

  /// No description provided for @milestoneNovena3Desc.
  ///
  /// In pt, this message translates to:
  /// **'Três novenas completas oferecidas com fé e constância.'**
  String get milestoneNovena3Desc;

  /// No description provided for @milestoneConfession1Title.
  ///
  /// In pt, this message translates to:
  /// **'Primeira Confissão registrada'**
  String get milestoneConfession1Title;

  /// No description provided for @milestoneConfession1Desc.
  ///
  /// In pt, this message translates to:
  /// **'Buscar o sacramento da Reconciliação e renovar a graça.'**
  String get milestoneConfession1Desc;

  /// No description provided for @milestoneConfession4Title.
  ///
  /// In pt, this message translates to:
  /// **'4 Confissões registradas'**
  String get milestoneConfession4Title;

  /// No description provided for @milestoneConfession4Desc.
  ///
  /// In pt, this message translates to:
  /// **'Cuidar da alma com regularidade no sacramento da Penitência.'**
  String get milestoneConfession4Desc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
