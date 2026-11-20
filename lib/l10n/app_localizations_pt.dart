// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Sancta Devocionário Católico';

  @override
  String get loginButton => 'ACESSAR';

  @override
  String get createPasswordButton => 'CRIAR SENHA';

  @override
  String get forgotPasswordButton => 'Esqueci minha senha';

  @override
  String get recoverAccessButton => 'RECUPERAR ACESSO E APAGAR DADOS';

  @override
  String get passwordLabel => 'Digite sua senha';

  @override
  String get createPasswordLabel => 'Crie uma senha';

  @override
  String get confirmPasswordLabel => 'Confirme a senha';

  @override
  String get passwordErrorEmpty => 'Por favor, digite sua senha.';

  @override
  String get passwordErrorIncorrect => 'Senha incorreta. Tente novamente.';

  @override
  String get passwordErrorShort => 'A senha deve ter pelo menos 4 caracteres.';

  @override
  String get passwordErrorMismatch => 'As senhas não coincidem.';

  @override
  String get recoverAccessTitle => 'Recuperar Acesso';

  @override
  String get recoverAccessWarning =>
      'ATENÇÃO: os itens marcados no exame, o histórico de confissões e as datas serão APAGADOS deste aparelho, e a senha será removida. Suas orações e novenas não são afetadas. Esta ação não pode ser desfeita. Deseja continuar?';

  @override
  String get recoverAccessCancel => 'Cancelar';

  @override
  String get recoverAccessConfirm => 'Recuperar';

  @override
  String get lastConfessionLabel => 'Última Confissão:';

  @override
  String get notRegistered => 'Não registrada';

  @override
  String get planLabel => 'Planejar';

  @override
  String get timeAgoToday => 'hoje';

  @override
  String timeAgoDays(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias',
      one: '1 dia',
    );
    return '$_temp0';
  }

  @override
  String timeAgoWeeks(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count semanas',
      one: '1 semana',
    );
    return '$_temp0';
  }

  @override
  String timeAgoMonths(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meses',
      one: '1 mês',
    );
    return '$_temp0';
  }

  @override
  String timeAgoYears(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count anos',
      one: '1 ano',
    );
    return '$_temp0';
  }

  @override
  String get timeAgoConnector => ' e ';

  @override
  String get generateGuideButton => 'GERAR GUIA PARA CONFISSÃO';

  @override
  String get nextConfessionLabel => 'Próxima confissão:';

  @override
  String daysAgo(Object days) {
    return '$days dias atrás';
  }

  @override
  String get today => 'Hoje';

  @override
  String get yesterday => 'Ontem';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get reportTitle => 'Guia para Confissão';

  @override
  String get reportEmpty =>
      'Nenhum pecado foi selecionado.\n\nPor favor, examine sua consciência nas categorias antes de gerar o guia.';

  @override
  String get reportShareButton => 'COMPARTILHAR';

  @override
  String get reportCloseButton => 'FECHAR';

  @override
  String get confessButton => 'CONFESSAR-SE';

  @override
  String get confessDialogTitle => 'Confirmar Confissão';

  @override
  String get confessDialogContent =>
      'Deseja marcar sua confissão como realizada hoje? Isso limpará o exame atual.';

  @override
  String get confessDialogCancel => 'Cancelar';

  @override
  String get confessDialogConfirm => 'Confirmar';

  @override
  String get preparatoryPrayerTitle => 'Oração Preparatória';

  @override
  String get preparatoryPrayerSubtitle => 'Antes do Exame';

  @override
  String get preparatoryPrayerContent =>
      'Senhor, iluminai-me para que eu possa ver os meus pecados, e dai-me a graça de me arrepender verdadeiramente deles e de me confessar com sinceridade. Amém.';

  @override
  String get catOracaoTitle => 'Oração Preparatória';

  @override
  String get catOracaoDesc => 'Recomendado';

  @override
  String get catOracaoSub => 'Recomendado';

  @override
  String get catMetodoTitle => 'Método de Confissão';

  @override
  String get catMetodoDesc => 'Como se confessar';

  @override
  String get catMetodoSub => 'Como se confessar';

  @override
  String get catExameDiarioTitle => 'Exame Diário';

  @override
  String get catExameDiarioDesc => 'Revisão do dia (Inaciano)';

  @override
  String get catExameDiarioSub => 'Revisão do dia';

  @override
  String get devotionalTitle => 'Orações';

  @override
  String get prayersTitle => 'Novenas';

  @override
  String get rosaryTitle => 'Santo Terço';

  @override
  String get examinationTitle => 'Exame de Consciência';

  @override
  String get examinationMenuTitle => 'Exame';

  @override
  String get moreTitle => 'Jardim';

  @override
  String get confessionCardTitle => 'Confissão';

  @override
  String get confessionMarkComplete => 'Confirmar Confissão';

  @override
  String get confessionConfirmTitle => 'Confirmar Confissão?';

  @override
  String get confessionConfirmMessage =>
      'Ao confirmar, o exame de consciência será limpo e a data será registrada.';

  @override
  String get confessionConfirmed => 'Confissão registrada!';

  @override
  String get rosaryComplete => 'Terço completo';

  @override
  String get rosaryCompleteNotification =>
      'Parabéns! Você completou um Rosário hoje!';

  @override
  String get catAntesItem7 =>
      'Recebi outro Sacramento em estado de pecado mortal.';

  @override
  String get catMandamentosTitle => '10 Mandamentos';

  @override
  String get catMandamentosDesc => 'Lei de Deus';

  @override
  String get catMandamentosSub => 'Lei de Deus';

  @override
  String get catMandamentosSub1 =>
      'I Mandamento: Amar a Deus sobre todas as coisas';

  @override
  String get catMandamentos1Item1 =>
      'Fui negligente na oração, tive distrações voluntárias ou fiquei mais de um mês sem rezar.';

  @override
  String get catMandamentos1Item2 =>
      'Fui ingrato para com Deus ou tive preguiça espiritual.';

  @override
  String get catMandamentos1Item3 =>
      'Tentei a Deus, expondo-me a perigo para a alma, vida ou saúde sem causa grave.';

  @override
  String get catMandamentos1Item4 =>
      'Não fiz genuflexão para o Santíssimo ou tive comportamento inadequado na Igreja.';

  @override
  String get catMandamentos1Item5 =>
      'Tive apego excessivo a coisas ou criaturas (animais, ídolos, dinheiro, prazer ou poder).';

  @override
  String get catMandamentos1Item6 =>
      'Cometi idolatria, superstição ou atribuí importância indevida a sonhos e destino.';

  @override
  String get catMandamentos1Item7 =>
      'Consultei horóscopos, astrologia, leitura de mãos ou pratiquei espiritismo e adivinhação.';

  @override
  String get catMandamentos1Item8 =>
      'Pratiquei magia, bruxaria, usei amuletos ou joguei com quadros Ouija.';

  @override
  String get catMandamentos1Item9 =>
      'Cometi sacrilégio ao receber a Eucaristia em pecado mortal ou tratei indignamente coisas santas.';

  @override
  String get catMandamentos1Item10 =>
      'Duvidei da fé, ignorei as verdades cristãs ou aderi a grupos maçônicos e sociedades proibidas.';

  @override
  String get catMandamentosSub2 =>
      'II Mandamento: Não tomar seu santo nome em vão';

  @override
  String get catMandamentos2Item1 =>
      'Fiz uso profano ou desrespeitoso do Nome de Deus, de Jesus, da Virgem Maria ou dos santos.';

  @override
  String get catMandamentos2Item2 =>
      'Blasfemei contra Deus, a Igreja ou os santos por palavras, gestos ou músicas.';

  @override
  String get catMandamentos2Item3 =>
      'Cometi perjúrio (prometer algo sob juramento sem intenção de cumprir).';

  @override
  String get catMandamentos2Item4 =>
      'Fiz juramentos falsos ou desnecessários chamando a Deus por testemunha de uma mentira.';

  @override
  String get catMandamentos2Item5 =>
      'Amaldiçoei a mim mesmo ou a outros com real intenção.';

  @override
  String get catMandamentos2Item6 =>
      'Quebrei votos ou promessas feitas a Deus ou murmurei contra a Providência Divina.';

  @override
  String get catMandamentosSub3 => 'III Mandamento: Guardar domingos e festas';

  @override
  String get catMandamentos3Item1 =>
      'Omiti a oração, o culto divino ou realizei trabalho servil desnecessário no Domingo.';

  @override
  String get catMandamentos3Item2 =>
      'Fiz comércio desnecessário (comprar ou vender) nos Domingos e Dias de Guarda.';

  @override
  String get catMandamentos3Item3 =>
      'Profanei estes dias com companhias impiedosas, jogos de azar ou excessos com bebida.';

  @override
  String get catMandamentos3Item4 =>
      'Faltei à Missa ou cheguei gravemente atrasado sem razão suficiente.';

  @override
  String get catMandamentosSub4 => 'IV Mandamento: Honrar pai e mãe';

  @override
  String get catMandamentos4Item1 =>
      'Desobedeci, ofendi ou fui ingrato com meus pais, provocando-os à raiva.';

  @override
  String get catMandamentos4Item2 =>
      'Não ajudei meus pais em suas necessidades ou desejei-lhes algum mal.';

  @override
  String get catMandamentos4Item3 =>
      'Fui duro ou cruel com meus filhos ou adiei o batismo deles por mais de um mês.';

  @override
  String get catMandamentos4Item4 =>
      'Negligenciei a instrução religiosa dos filhos ou permiti que crescessem no pecado.';

  @override
  String get catMandamentos4Item5 =>
      'Tratei o cônjuge sem caridade, neguei o débito conjugal sem causa justa ou tive ciúmes despropositados.';

  @override
  String get catMandamentos4Item6 =>
      'Desobedeci a superiores espirituais (Papa, bispos) ou votei em partidos comunistas/socialistas.';

  @override
  String get catMandamentos4Item7 =>
      'Como empregado, perdi tempo no trabalho (internet) ou gastei propriedade do empregador.';

  @override
  String get catMandamentosSub5 => 'V Mandamento: Não matar';

  @override
  String get catMandamentos5Item1 =>
      'Causei morte, lesão física, briguei ou tive desejos de vingança.';

  @override
  String get catMandamentos5Item2 =>
      'Realizei, ajudei ou aconselhei um aborto (ciente da excomunhão se consumado).';

  @override
  String get catMandamentos5Item3 =>
      'Tive pensamentos de suicídio, pratiquei eutanásia ou mutilação do corpo (castração).';

  @override
  String get catMandamentos5Item4 =>
      'Cometi excessos no comer ou beber (gula e embriaguez) ou usei drogas.';

  @override
  String get catMandamentos5Item5 =>
      'Pratiquei vasectomia ou ligadura (pecado mortal que exige tentativa de reversão se possível).';

  @override
  String get catMandamentos5Item6 =>
      'Realizei inseminação artificial, fertilização in vitro ou pesquisas científicas imorais.';

  @override
  String get catMandamentos5Item7 =>
      'Tomei contraceptivos (pílulas, profiláticos) ou utilizei métodos naturais com mentalidade contraceptiva.';

  @override
  String get catMandamentos5Item8 =>
      'Dei mau exemplo, escandalizei o próximo ou induzi outros ao pecado.';

  @override
  String get catMandamentosSub6 =>
      'VI Mandamento: Não pecar contra a castidade';

  @override
  String get catMandamentos6Item1 =>
      'Pratiquei impureza ou imodéstia nas palavras, olhares e ações (sozinho ou acompanhado).';

  @override
  String get catMandamentos6Item2 =>
      'Contei piadas sujas, usei roupas imodestas (decotes, roupas transparentes ou apertadas).';

  @override
  String get catMandamentos6Item3 =>
      'Assisti a filmes, pornografia ou li livros e revistas indecentes.';

  @override
  String get catMandamentos6Item4 =>
      'Pratiquei masturbação, fornicação (sexo antes do casamento) ou adultério.';

  @override
  String get catMandamentos6Item5 =>
      'Aderi a práticas homossexuais (sodomia) ou outras contrárias à natureza.';

  @override
  String get catMandamentos6Item6 =>
      'Pratiquei o ato conjugal de modo inapto à procriação.';

  @override
  String get catMandamentos6Item7 =>
      'Participei de danças imodestas ou namorei sem a intenção de casar ou sem precauções.';

  @override
  String get catMandamentosSub7 => 'VII Mandamento: Não furtar';

  @override
  String get catMandamentos7Item1 =>
      'Cometi roubo, pequenos furtos no trabalho ou tomei dinheiro da família sem permissão.';

  @override
  String get catMandamentos7Item2 =>
      'Trapaceei, cometi plágio ou violei direitos autorais sem causa séria.';

  @override
  String get catMandamentos7Item3 =>
      'Mantive objetos emprestados ou perdidos sem tentativa de restituir.';

  @override
  String get catMandamentos7Item4 =>
      'Soneguei impostos justos, aceitei suborno ou fui desonesto nos negócios.';

  @override
  String get catMandamentos7Item5 =>
      'Não paguei dívidas no tempo correto ou paguei salários injustos aos empregados.';

  @override
  String get catMandamentos7Item6 =>
      'Gastei dinheiro excessivamente em jogos e apostas, privando a família do necessário.';

  @override
  String get catMandamentosSub8 =>
      'VIII Mandamento: Não levantar falso testemunho';

  @override
  String get catMandamentos8Item1 =>
      'Menti, usei de palavrões, grosserias, hipocrisia ou exagero.';

  @override
  String get catMandamentos8Item2 =>
      'Cometi detração (revelar faltas reais escondidas) ou calúnia (falsos defeitos).';

  @override
  String get catMandamentos8Item3 =>
      'Fiz fofocas, murmurações ou julguei precipitadamente o próximo.';

  @override
  String get catMandamentos8Item4 =>
      'Revelei segredos sem causa justa ou recusei restituir o bom nome manchado.';

  @override
  String get catMandamentos8Item5 =>
      'Fui irônico ou sarcástico com o objetivo de ferir o próximo.';

  @override
  String get catMandamentosSub9 =>
      'IX Mandamento: Não desejar a mulher do próximo';

  @override
  String get catMandamentos9Item1 =>
      'Deleitei-me deliberadamente em pensamentos ou desejos impuros.';

  @override
  String get catMandamentos9Item2 =>
      'Consenti em paixões ou pensamentos imorais quando vieram à mente.';

  @override
  String get catMandamentos9Item3 => 'Desejei a esposa ou marido de outrem.';

  @override
  String get catMandamentosSub10 =>
      'X Mandamento: Não cobiçar as coisas alheias';

  @override
  String get catMandamentos10Item1 =>
      'Tive inveja dos bens, sucessos ou talentos alheios.';

  @override
  String get catMandamentos10Item2 =>
      'Tive ganância e desejo sem limites de possuir bens materiais (avareza).';

  @override
  String get catMandamentos10Item3 =>
      'Desejei enriquecer a qualquer preço ou desejei cometer injustiça para obter bens.';

  @override
  String get catMandamentos10Item4 =>
      'Alegrei-me com a miséria alheia ou com o prejuízo do próximo.';

  @override
  String get catIgrejaTitle => 'Preceitos da Igreja';

  @override
  String get catIgrejaDesc => 'Lei da Igreja';

  @override
  String get catIgrejaSub => 'Lei da Igreja';

  @override
  String get catIgrejaSub1 => 'Preceitos da Santa Igreja';

  @override
  String get catIgrejaItem1 =>
      'Não assisti à Missa inteira nos Domingos e Dias de Guarda (Natal, Circuncisão, Epifania, etc.).';

  @override
  String get catIgrejaItem2 =>
      'Não jejuei na Quarta-feira de Cinzas e Sexta-feira Santa (se entre 18 e 60 anos).';

  @override
  String get catIgrejaItem3 =>
      'Não guardei a abstinência de carne nas sextas-feiras ou não a comutei por outra penitência.';

  @override
  String get catIgrejaItem4 =>
      'Deixei de confessar os pecados mortais ao menos uma vez por ano.';

  @override
  String get catIgrejaItem5 =>
      'Não recebi a Santa Comunhão durante o período da Páscoa.';

  @override
  String get catIgrejaItem6 =>
      'Não contribuí para o sustento da Igreja conforme minhas possibilidades.';

  @override
  String get catIgrejaItem7 =>
      'Casei-me ou ajudei alguém a casar sem permissão da Igreja ou diante de ministro acatólico.';

  @override
  String get devotionalSubtitle => 'Orações';

  @override
  String get devotionalComingSoon => 'Orações, Terço e Devoções em breve.';

  @override
  String get comingSoon => 'Em breve';

  @override
  String get jornadaTitle => 'Jornada de Confissão';

  @override
  String get jornadaHeaderTitle => 'Caminho de Reconciliação';

  @override
  String get jornadaHeaderSubtitle =>
      'Sua jornada espiritual de confissão e santidade';

  @override
  String get jornadaEmpty => 'Nenhuma confissão registrada ainda.';

  @override
  String get jornadaHistoryTitle => 'Histórico de Confissões';

  @override
  String jornadaHistorySubtitle(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count confissões registradas',
      one: '1 confissão registrada',
      zero: 'Nenhuma confissão registrada',
    );
    return '$_temp0';
  }

  @override
  String get deleteConfessionTitle => 'Excluir Confissão';

  @override
  String deleteConfessionContent(Object date) {
    return 'Tem certeza que deseja excluir a confissão de $date?';
  }

  @override
  String get deleteConfessionCancel => 'Cancelar';

  @override
  String get deleteConfessionConfirm => 'Excluir';

  @override
  String get whyConfessTitle => 'Por que se Confessar?';

  @override
  String get whyConfessContent =>
      'A Confissão é um Sacramento instituído por Jesus Cristo para nos reconciliar com Deus e com a Igreja. É um encontro pessoal com a misericórdia divina.\n\n**Importância Espiritual:**\nA Confissão restaura a graça santificante perdida pelo pecado mortal e aumenta a graça em nossa alma. Fortalece nossa vontade contra futuras tentações e nos dá paz de consciência.\n\n**Importância Temporal:**\nConfessar nossos erros nos libera do peso da culpa, melhora nossos relacionamentos e nos ajuda a viver uma vida mais autêntica e plena. A humildade necessária para confessar nos torna pessoas melhores.';

  @override
  String get psychBenefitsTitle => 'Benefícios Psicológicos';

  @override
  String get psychBenefitsContent =>
      'Estudos científicos demonstram diversos benefícios psicológicos da confissão:\n\n**Redução do Estresse:**\nGuardar segredos e sentimentos de culpa aumenta os níveis de cortisol. Confessar alivia esse peso emocional.\n\n**Melhoria na Saúde Mental:**\nA prática regular de examinar a consciência e confessar promove autoconhecimento e crescimento pessoal.\n\n**Superação de Vícios:**\nAdmitir nossos erros é o primeiro passo para a mudança. A confissão cria responsabilização e motivação para melhorar.\n\n**Relações Mais Saudáveis:**\nA honestidade consigo mesmo facilita relações mais autênticas e profundas com os outros.';

  @override
  String get saintsWordsTitle => 'Palavras dos Santos';

  @override
  String get saintsWordsContent =>
      '\"Aquele que se confessa em lágrimas recebe o perdão em alegria.\"\n— São João Maria Vianney (Cura d\'Ars)\n\n\"A confissão é um ato de honestidade e coragem — um ato de confiar a si mesmo, além das palavras, ao Senhor misericordioso.\"\n— Papa São João Paulo II\n\n\"Pela confissão, o homem olha a verdade de seus pecados no rosto e assume a responsabilidade por eles; por isso, abre-se novamente a Deus.\"\n— Papa Bento XVI\n\n\"Oh! Como é grande a bondade de nosso Senhor! Na realidade, Ele esquece os nossos pecados depois da confissão.\"\n— Santa Faustina Kowalska\n\n\"A confissão não é para ser julgado, mas para ser perdoado.\"\n— São Padre Pio de Pietrelcina';

  @override
  String get tipsTitle => 'Dicas para Ansiosos e Tímidos';

  @override
  String get tipsContent =>
      'Se você sente ansiedade ou vergonha ao confessar:\n\n1. **Prepare-se com antecedência:** Escreva seus pecados em um papel. Você pode levar esse papel ao confessionário.\n\n2. **Lembre-se: O padre não é juiz:** Ele está ali para perdoar e aconselhar, não para julgar você.\n\n3. **O padre já ouviu de tudo:** Provavelmente seu pecado não é único ou excepcional. Nada vai chocá-lo.\n\n4. **Comece pelos pecados \"mais fáceis\":** Isso pode ajudar a ganhar coragem para os mais difíceis.\n\n5. **Foque em Deus, não no padre:** Você está confessando a Jesus Cristo, através do sacerdote.\n\n6. **Confie na misericórdia:** Deus já conhece todos os seus pecados e ainda assim te ama infinitamente.\n\n7. **Vá com frequência:** Quanto mais você se confessa, mais fácil fica. A prática traz conforto.';

  @override
  String get secrecyTitle => 'O Sigilo Sacramental';

  @override
  String get secrecyContent =>
      'O Segredo da Confissão é ABSOLUTO e INVIOLÁVEL.\n\nO padre está proibido, sob pena de excomunhão automática, de revelar QUALQUER coisa que ouviu em confissão. Isso inclui:\n\n• Não pode contar a ninguém, nem mesmo a outro padre.\n• Não pode usar a informação de nenhuma forma.\n• Não pode dar indícios de que sabe algo.\n• Nem mesmo sob tortura ou ameaça de morte pode quebrar o sigilo.\n\n**Casos Históricos:**\nVários sacerdotes mártires preferiram morrer a quebrar o sigilo sacramental, como São João Nepomuceno, que foi martirizado em 1393 por se recusar a revelar a confissão da rainha.\n\n**Sua confissão é segura.** Nem Deus permitiria que o sigilo fosse quebrado, protegendo esse Sacramento precioso.';

  @override
  String get priestAttitudeTitle => 'A Atitude do Sacerdote';

  @override
  String get priestAttitudeContent =>
      'O padre manterá a mesma atitude acolhedora, não importa o pecado.\n\n**Por quê?**\n• O padre age \"in Persona Christi\" — representando Cristo.\n• Cristo acolheu a todos: prostitutas, ladrões, assassinos.\n• O padre é treinado para não demonstrar choque ou julgamento.\n• Ele sabe que todos somos pecadores em busca de misericórdia.\n\n**O que o padre pensa:**\nEm vez de julgar, o padre pensa:\n• \"Como posso ajudar esta pessoa?\"\n• \"Que conselho posso dar para evitar futuras quedas?\"\n• \"Louvo a Deus pela coragem desta alma em buscar reconciliação.\"\n\n**Sua experiência:**\nIndependente do que você confessar, você será recebido com:\n• Respeito e dignidade.\n• Compaixão e misericórdia.\n• Orientação e encorajamento.\n• A absolvição em nome de Jesus Cristo.\n\n**Lembre-se:** O padre está ali como instrumento da misericórdia de Deus, não como juiz. Sua função é perdoar e ajudar, não condenar.';

  @override
  String get searchHint => 'Buscar pecados...';

  @override
  String get noSinsFound => 'Nenhum pecado encontrado';

  @override
  String get noSinsFoundSearch =>
      'Nenhum pecado encontrado\nTente outros termos de busca';

  @override
  String get saveAndReturnButton => 'SALVAR E VOLTAR';

  @override
  String get configTitle => 'Configurações';

  @override
  String get changePasswordTitle => 'Alterar Senha';

  @override
  String get changePasswordDesc => 'Altere a senha de acesso ao aplicativo';

  @override
  String get changePasswordButton => 'Alterar Senha';

  @override
  String get currentPasswordLabel => 'Senha Atual';

  @override
  String get newPasswordLabel => 'Nova Senha';

  @override
  String get confirmNewPasswordLabel => 'Confirmar Nova Senha';

  @override
  String get changePasswordAction => 'Alterar';

  @override
  String get passwordSuccessMessage => 'Senha alterada com sucesso!';

  @override
  String get recoverAccessDesc =>
      'Caso tenha esquecido a senha, você pode recuperar o acesso. ATENÇÃO: Todos os dados do exame atual serão perdidos.';

  @override
  String get recoverAccessAction => 'Recuperar Acesso';

  @override
  String get clearExamTitle => 'Limpar Exame Atual';

  @override
  String get clearExamDesc =>
      'Apaga todos os dados do exame atual e inicia um novo';

  @override
  String get clearExamButton => 'Limpar Exame';

  @override
  String get clearExamDialogTitle => 'Limpar Exame Atual';

  @override
  String get clearExamDialogContent =>
      'Tem certeza que deseja limpar todos os dados do exame atual? Esta ação não pode ser desfeita.';

  @override
  String get clearExamAction => 'Limpar';

  @override
  String get clearExamSuccess => 'Exame limpo com sucesso!';

  @override
  String get fillAllFields => 'Por favor, preencha todos os campos.';

  @override
  String get currentPasswordIncorrect => 'Senha atual incorreta.';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get removeButton => 'Remover';

  @override
  String get planningTitle => 'Planejar Confissão';

  @override
  String get planningQuestion => 'Quando você pretende se confessar?';

  @override
  String get planningSaveSuccess => 'Data da próxima confissão salva!';

  @override
  String planningSelectedDate(Object date) {
    return 'Data selecionada: $date';
  }

  @override
  String get planLevelTitle => 'Nível Espiritual';

  @override
  String planLevelSubtitle(Object level, Object title) {
    return 'Passo $level: $title';
  }

  @override
  String get planLevel1Title => 'Iniciante';

  @override
  String get planLevel1Desc => 'Oração da Manhã, da Noite e 3 Ave-Marias';

  @override
  String get planLevel2Title => 'Crescimento';

  @override
  String get planLevel2Desc => 'Adiciona o Santo Terço diário';

  @override
  String get planLevel3Title => 'Fervor';

  @override
  String get planLevel3Desc => 'Adiciona o Angelus e Leitura Espiritual';

  @override
  String get planLevel4Title => 'União';

  @override
  String get planLevel4Desc => 'Adiciona Exame de Consciência e Meditação';

  @override
  String get timeMorning => 'Manhã';

  @override
  String get timeAfternoon => 'Tarde';

  @override
  String get timeNight => 'Noite';

  @override
  String get timeAnytime => 'Qualquer Hora';

  @override
  String get timeNoon => 'Meio-dia';

  @override
  String get otherPrayersSection => 'Outras Orações';

  @override
  String get rosarySection => 'ROSÁRIO';

  @override
  String get saintOfTheDay => 'SANTO DO DIA';

  @override
  String get removeRosaryTitle => 'Remover terço?';

  @override
  String removeRosaryContent(String title) {
    return 'Deseja remover \"$title\" do histórico?';
  }

  @override
  String get timePeriodLabel => 'Período do dia';

  @override
  String get enableReminderLabel => 'Ativar lembrete';

  @override
  String get selectTimeLabel => 'Selecionar horário';

  @override
  String get planSetupTitle => 'Configurar Plano';

  @override
  String get planSetupDesc =>
      'Escolha um nível para começar. Você pode mudar depois.';

  @override
  String get planSetupButton => 'Atualizar Plano';

  @override
  String get quickPrayerTab => 'Oração Rápida';

  @override
  String get quickPrayerDesc => 'Registrar uma oração já realizada';

  @override
  String get quickPrayerLogButton => 'Registrar';

  @override
  String quickPrayerLogged(String title) {
    return 'Oração $title registrada!';
  }

  @override
  String get configNotificationsTitle => 'Notificações';

  @override
  String get configNotificationsDesc =>
      'Gerenciar permissões de notificação para lembretes de oração.';

  @override
  String get configNotificationsButton => 'Solicitar Permissão';

  @override
  String get configNotificationsGranted => 'Permissões concedidas!';

  @override
  String get configNotificationsDenied =>
      'Permissões negadas. Verifique as configurações do aparelho.';

  @override
  String get reportWarningTitle => 'ATENÇÃO: Recomendações Importantes';

  @override
  String get reportWarningContent =>
      '• Por respeito ao Sacramento e ao sacerdote, recomenda-se copiar este guia para um papel e não ler diretamente do celular.\n\n• Para evitar distrações, desligue o seu celular (ou coloque em modo avião) durante a confissão.';

  @override
  String get reportGuideTitle => 'GUIA PARA CONFISSÃO';

  @override
  String get reportKneelInstruction => 'Ao se ajoelhar, diga ao sacerdote:';

  @override
  String get reportBlessMe => '\"Abençoai-me, Padre, porque pequei.\"';

  @override
  String reportLastConfession(Object time) {
    return 'Minha última Confissão foi há $time.';
  }

  @override
  String get reportMySins => 'MEUS PECADOS SÃO:';

  @override
  String get reportFinishInstruction =>
      'Ao terminar de listar os pecados, diga:';

  @override
  String get reportFinalPrayer =>
      '\"Acuso-me destes pecados, de todos os que não me lembro e dos de minha vida passada. Deles peço perdão a Deus, e a vós, Padre, a penitência e a absolvição.\"';

  @override
  String get reportActOfContritionTitle =>
      'Ato de Contrição (Rezar após o sacerdote dar a penitência):';

  @override
  String get reportActOfContrition =>
      'Senhor meu Jesus Cristo, Deus e homem verdadeiro, Criador e Redentor meu, por serdes vós quem sois, sumamente bom e digno de ser amado sobre todas as coisas, e porque vos amo e vos estimo, pesa-me, Senhor, de todo o meu coração, de vos ter ofendido; e proponho firmemente, ajudado com os auxílios de vossa divina graça, emendar-me e nunca mais tornar a vos ofender; espero alcançar de vossa infinita misericórdia o perdão de minhas culpas. Amém.';

  @override
  String get reportConfessButton => 'CONFESSAR-SE';

  @override
  String get reportConfessSuccess => 'Confissão registrada com sucesso!';

  @override
  String reportSinCount(String sin, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vezes',
      one: '1 vez',
    );
    return '• $sin ($_temp0)';
  }

  @override
  String get backButton => 'VOLTAR';

  @override
  String get nextButton => 'Próximo';

  @override
  String get finishButton => 'Concluir';

  @override
  String get dailyExamTitle => 'Exame Diário';

  @override
  String get dailyExamStep1Title => 'Ação de Graças';

  @override
  String get dailyExamStep1Desc =>
      'Coloque-se na presença de Deus. Agradeça por todos os benefícios recebidos hoje: a vida, a saúde, a família, a fé, e até pelas dificuldades que te fizeram crescer.';

  @override
  String get dailyExamStep1Prayer =>
      'Senhor, eu Vos dou graças por vossa imensa glória e por todos os benefícios que me concedestes hoje.';

  @override
  String get dailyExamStep2Title => 'Pedido de Luz';

  @override
  String get dailyExamStep2Desc =>
      'Peça ao Espírito Santo a graça de conhecer os seus pecados e de rejeitá-los. Peça luz para ver o seu dia como Deus o vê.';

  @override
  String get dailyExamStep2Prayer =>
      'Vinde, Espírito Santo, enchei os corações dos vossos fiéis e acendei neles o fogo do Vosso Amor.';

  @override
  String get dailyExamStep3Title => 'Exame do Dia';

  @override
  String get dailyExamStep3Desc =>
      'Percorra as horas do seu dia, desde o levantar até agora. Examine seus pensamentos, palavras, obras e omissões. Onde você falhou no amor a Deus e ao próximo?';

  @override
  String get dailyExamStep3Prayer =>
      'Sondai-me, ó Deus, e conhecei o meu coração; provai-me e conhecei os meus pensamentos.';

  @override
  String get dailyExamStep4Title => 'Contrição';

  @override
  String get dailyExamStep4Desc =>
      'Peça perdão a Deus pelas faltas cometidas. Sinta dor por ter ofendido a um Deus tão bom. Confie na Sua misericórdia infinita.';

  @override
  String get dailyExamStep4Prayer =>
      'Meu Deus, porque sois tão bom, tenho muita pena de Vos ter ofendido. Ajudai-me a não pecar mais.';

  @override
  String get dailyExamStep5Title => 'Propósito';

  @override
  String get dailyExamStep5Desc =>
      'Faça um firme propósito de se corrigir amanhã. Pense em uma virtude específica para praticar ou um vício para evitar.';

  @override
  String get dailyExamStep5Prayer =>
      'Com a Vossa graça, Senhor, proponho firmemente evitar o pecado e fazer a Vossa vontade. Amém.';

  @override
  String get dailyExamPrayerLabel => 'ORAÇÃO';

  @override
  String get confessionMethodTitle => 'Método de Confissão';

  @override
  String get confessionMethodStep1 =>
      'Ao chegar ao confessionário, o penitente diz:';

  @override
  String get confessionMethodStep2 =>
      'O Sacerdote abençoa. O penitente continua:';

  @override
  String get confessionMethodStep3 => 'Em seguida, o penitente diz:';

  @override
  String get confessionMethodStep3Content =>
      '\"Minha última Confissão foi há...\" (dizer a data aproximada).';

  @override
  String get confessionMethodStep4 =>
      'Em seguida, o penitente se acusa de seus pecados. (Use o guia gerado pelo App).\nDepois da confissão dos pecados, o penitente diz:';

  @override
  String get confessionMethodStep5 =>
      'O Sacerdote dá os conselhos e a penitência. Após as palavras do Padre, o penitente recita o ato de contrição:';

  @override
  String get confessionMethodOr => '... ou ...';

  @override
  String get confessionMethodAltPrayer =>
      '\"Meu Deus, porque sois infinitamente bom e amável, tenho muita pena por vos ter ofendido. Com a vossa graça, é o meu firme propósito não mais voltar a vos ofender. Amém.\"';

  @override
  String get confessionMethodStep6 =>
      'O Sacerdote então recita a fórmula da absolvição.';

  @override
  String get catAntesTitle => 'Antes da Confissão';

  @override
  String get catAntesSub => 'Erros ao se confessar';

  @override
  String get catAntesDesc => 'Pecados contra o Sacramento';

  @override
  String get catAntesSub1 => 'Pecados contra a Confissão';

  @override
  String get catAntesItem1 => 'Não examinei minha consciência com cuidado.';

  @override
  String get catAntesItem2 =>
      'Ocultei deliberadamente um pecado mortal na confissão.';

  @override
  String get catAntesItem3 => 'Confessei sem arrependimento verdadeiro.';

  @override
  String get catAntesItem4 => 'Confessei sem firme propósito de correção.';

  @override
  String get catAntesItem5 => 'Confessei sem intenção de cumprir a penitência.';

  @override
  String get catAntesItem6 =>
      'Recebi a Santa Comunhão em estado de pecado mortal após uma má confissão.';

  @override
  String get catJornadaTitle => 'Jornada de Confissão';

  @override
  String get catJornadaDesc => 'Histórico de confissões';

  @override
  String get catJornadaSub => 'Histórico de confissões';

  @override
  String get examinationSubtitle =>
      'Faça seu exame de consciência com base nas categorias abaixo.';

  @override
  String get dataStorageInfo =>
      'Seus dados são armazenados apenas no seu dispositivo.';

  @override
  String get preparatoryPrayerSource => '(Manual da Paróquia, 1942, p. 87)';

  @override
  String get catPrayersMain => 'Orações Principais';

  @override
  String get catPrayersDaily => 'Orações Diárias';

  @override
  String get catPrayersSaints => 'Devoções aos Santos';

  @override
  String get prayerPaterNosterTitle => 'Pai Nosso';

  @override
  String get prayerPaterNosterContent =>
      'Pai Nosso, que estais no Céu, santificado seja o vosso Nome; venha a nós o vosso Reino; seja feita a vossa vontade, assim na terra como no Céu. O pão nosso de cada dia nos dai hoje; perdoai-nos as nossas ofensas, assim como nós perdoamos a quem nos tem ofendido; e não nos deixeis cair em tentação, mas livrai-nos do mal. Amém.';

  @override
  String get prayerPaterNosterContentLatin =>
      'Pater noster, qui es in caelis, sanctificetur nomen tuum. Adveniat regnum tuum. Fiat voluntas tua, sicut in caelo et in terra. Panem nostrum quotidianum da nobis hodie, et dimitte nobis debita nostra sicut et nos dimittimus debitoribus nostris. Et ne nos inducas in tentationem, sed libera nos a malo. Amen.';

  @override
  String get prayerAnimaChristiTitle => 'Alma de Cristo';

  @override
  String get prayerAnimaChristiContent =>
      'Alma de Cristo, santificai-me.\nCorpo de Cristo, salvai-me.\nSangue de Cristo, inebriai-me.\nÁgua do lado de Cristo, lavai-me.\nPaixão de Cristo, confortai-me.\nÓ bom Jesus, ouvi-me.\nDentro de vossas chagas, escondei-me.\nNão permitais que me separe de vós.\nDo espírito maligno, defendei-me.\nNa hora da minha morte, chamai-me\nE mandai-me ir para vós,\nPara que com vossos Santos vos louve\nPor todos os séculos dos séculos. Amém.';

  @override
  String get prayerAnimaChristiContentLatin =>
      'Anima Christi, sanctifica me.\nCorpus Christi, salva me.\nSanguis Christi, inebria me.\nAqua lateris Christi, lava me.\nPassio Christi, conforta me.\nO bone Iesu, exaudi me.\nIntra tua vulnera absconde me.\nNe permittas me separari a te.\nAb hoste maligno defende me.\nIn hora mortis meae voca me.\nEt iube me venire ad te,\nUt cum Sanctis tuis laudem te,\nIn saecula saeculorum. Amen.';

  @override
  String get prayerSpiritualCommunionTitle => 'Comunhão Espiritual';

  @override
  String get prayerSpiritualCommunionContent =>
      'Creio, meu Jesus, que estais presente no Santíssimo Sacramento.\nAmo-Vos sobre todas as coisas e desejo receber-Vos em minha alma.\nMas como agora não posso receber-Vos sacramentalmente, vinde ao menos espiritualmente ao meu coração.\nE, como se já tivésseis vindo, uno-me inteiramente a Vós; não permitais que eu jamais me separe de Vós. Amém.';

  @override
  String get prayerSpiritualCommunionContentLatin =>
      'Credo, mi Iesu, te in Sanctissimo Sacramento praesentem esse.\nAmo te super omnia et desidero te in anima mea recipere.\nCum iam non possim te sacramentaliter sumere, veni saltem spiritualiter in cor meum.\nEt, tamquam iam veneris, unio me totum tibi; ne permitte me unquam a te separari. Amen.';

  @override
  String get prayerSelfOfferingTitle => 'Oferecimento de Si Mesmo';

  @override
  String get prayerSelfOfferingContent =>
      'Tomai, Senhor, e recebei toda a minha liberdade, a minha memória, o meu entendimento e toda a minha vontade, tudo o que tenho e possuo; Vós me destes; a Vós, Senhor, o restituo. Tudo é vosso, disponde de tudo, à vossa inteira vontade. Dai-me apenas o vosso amor e a vossa graça, que isso me basta. Amém.';

  @override
  String get prayerSelfOfferingContentLatin =>
      'Suscipe, Domine, universam meam libertatem. Accipe memoriam, intellectum, atque voluntatem omnem. Quidquid habeo vel possideo mihi largitus es; id tibi totum restituo, ac tuae prorsus voluntati trado gubernandum. Amorem tui solum cum gratia tua mihi dones, et dives sum satis, nec aliud quidquam ultra posco. Amen.';

  @override
  String get prayerAveMariaTitle => 'Ave Maria';

  @override
  String get prayerAveMariaContent =>
      'Ave Maria, cheia de graça, o Senhor é convosco; bendita sois vós entre as mulheres e bendito é o fruto do vosso ventre, Jesus. Santa Maria, Mãe de Deus, rogai por nós, pecadores, agora e na hora da nossa morte. Amém.';

  @override
  String get prayerAveMariaContentLatin =>
      'Ave Maria, gratia plena, Dominus tecum. Benedicta tu in mulieribus, et benedictus fructus ventris tui, Iesus. Sancta Maria, Mater Dei, ora pro nobis peccatoribus, nunc, et in hora mortis nostrae. Amen.';

  @override
  String get prayerCredoTitle => 'Credo';

  @override
  String get prayerCredoContent =>
      'Creio em Deus Pai Todo-Poderoso, Criador do céu e da terra; e em Jesus Cristo, um só seu Filho, Nosso Senhor; o qual foi concebido do Espírito Santo; nasceu de Maria Virgem, padeceu sob o poder de Pôncio Pilatos, foi crucificado, morto e sepultado; desceu aos infernos; ao terceiro dia ressurgiu dos mortos; subiu aos céus, está sentado à mão direita de Deus Pai todo-poderoso, donde há de vir a julgar os vivos e os mortos; creio no Espírito Santo, na Santa Igreja Católica, na comunhão dos Santos, na remissão dos pecados, na ressurreição da carne, na vida eterna. Amém.';

  @override
  String get prayerCredoContentLatin =>
      'Credo in Deum Patrem omnipotentem, Creatorem caeli et terrae. Et in Iesum Christum, Filium eius unicum, Dominum nostrum, qui conceptus est de Spiritu Sancto, natus ex Maria Virgine, passus sub Pontio Pilato, crucifixus, mortuus, et sepultus, descendit ad inferos, tertia die resurrexit a mortuis, ascendit ad caelos, sedet ad dexteram Dei Patris omnipotentis, inde venturus est iudicare vivos et mortuos. Credo in Spiritum Sanctum, sanctam Ecclesiam catholicam, sanctorum communionem, remissionem peccatorum, carnis resurrectionem, vitam aeternam. Amen.';

  @override
  String get prayerVeniCreatorTitle => 'Vinde Espírito Santo';

  @override
  String get prayerVeniCreatorContent =>
      'Vinde Espírito Santo, enchei os corações dos vossos fiéis e acendei neles o fogo do Vosso Amor. Enviai o Vosso Espírito e tudo será criado e renovareis a face da terra.\n\nOremos: Ó Deus, que instruístes os corações dos vossos fiéis, com a luz do Espírito Santo, fazei que apreciemos retamente todas as coisas segundo o mesmo Espírito e gozemos sempre da Sua consolação. Por Cristo Senhor Nosso. Amém.';

  @override
  String get prayerVeniCreatorContentLatin =>
      'Veni, Sancte Spiritus, reple tuorum corda fidelium, et tui amoris in eis ignem accende. Emitte Spiritum tuum et creabuntur. Et renovabis faciem terrae.\n\nOremus: Deus, qui corda fidelium Sancti Spiritus illustratione docuisti: da nobis in eodem Spiritu recta sapere, et de eius semper consolatione gaudere. Per Christum Dominum nostrum. Amen.';

  @override
  String get prayerBeforeWorkTitle => 'Antes do Trabalho';

  @override
  String get prayerBeforeWorkContent =>
      'Ofereço-Vos, ó meu Deus, o trabalho que vou iniciar; dignai-Vos abençoá-lo. Eu Vos ofereço a minha vontade, a minha inteligência, a minha memória, a minha imaginação e o meu corpo. Aceitai, Senhor, os meus pensamentos, as minhas palavras e as minhas obras. Tudo o que eu fizer, quero que seja por Vosso amor e para a Vossa glória. Ajudai-me, Senhor, a cumprir o meu dever com perfeição e alegria. Amém.';

  @override
  String get prayerMorningTitle => 'Oração da Manhã';

  @override
  String get prayerMorningContent =>
      'Pai Nosso...\n\nAve Maria...\n\nCredo...\n\nOferecimento do Dia:\nEu Vos adoro, meu Deus, e Vos amo de todo o coração. Dou-Vos graças por me terdes criado, feito cristão e conservado nesta noite. Ofereço-Vos todas as ações deste dia, fazei que sejam todas segundo a Vossa vontade e para a maior glória Vossa. Preservai-me do pecado e de todo o mal. A Vossa graça seja sempre comigo e com todos os que me são caros.\n\nRecebei, Senhor, minha liberdade inteira. Recebei minha memória, minha inteligência e toda a minha vontade. Tudo o que tenho ou possuo, de Vós me veio; tudo Vos devolvo e entrego sem reservas, para que a Vossa vontade tudo governe. Dai-me somente o Vosso amor e a Vossa graça, e nada mais Vos peço, pois já serei bastante rico.\n\nConsagração a Nossa Senhora:\nÓ minha Senhora e minha Mãe, eu me ofereço todo a vós e, em prova de minha devoção para convosco, vos consagro neste dia os meus olhos, os meus ouvidos, a minha boca, o meu coração e inteiramente todo o meu ser. E porque assim sou vosso, ó incomparável Mãe, guardai-me e defendei-me como coisa e propriedade vossa. \nAmém.';

  @override
  String get prayerNightTitle => 'Oração da Noite';

  @override
  String get prayerNightContent =>
      'Pai Nosso... \n\nAve Maria... \n\nCredo... \n\nAção de Graças: \nEu Vos adoro, meu Deus, e Vos amo de todo o coração. Dou-Vos graças por me terdes criado, feito cristão e conservado neste dia. Perdoai-me as faltas que hoje cometi e se fiz algum bem aceitai-o. Guardai-me durante o repouso e livrai-me de todos os perigos. A Vossa graça seja sempre comigo e com todos os que me são caros. Amém. \n\nFaça um breve exame de consciência. \n\nAto de Contrição: \nMeu Jesus, meu bom Jesus, que por mim morrestes na Cruz, perdoai os meus pecados, já não quero mais pecar. Amém. \n\nAto de Fé:\nEu creio firmemente que há um só Deus em três pessoas realmente distintas: Pai, Filho e Espírito Santo, que dá o céu aos bons e o inferno aos maus para sempre. Creio que o Filho de Deus se fez homem, padeceu e morreu na cruz para nos salvar, e que ao terceiro dia ressuscitou. Creio tudo mais que crê e ensina a Santa Igreja Católica, Apostólica, Romana, porque Deus, verdade infalível, lho revelou. E nesta crença quero viver e morrer.\n\nAto de Esperança:\nEu espero, meu Deus, com firme confiança, que pelos merecimentos de meu Senhor Jesus Cristo me dareis a salvação eterna e as graças necessárias para consegui-la, porque Vós, sumamente bom e poderoso, o haveis prometido a quem observar fielmente os Vossos mandamentos, como eu proponho fazer com o Vosso auxílio.\n\nAto de Caridade:\nEu Vos amo, meu Deus, de todo o meu coração e sobre todas as coisas, porque sois infinitamente bom e amável, e antes quero perder tudo do que Vos ofender. Por amor de Vós, amo meu próximo como a mim mesmo.';

  @override
  String get prayerStudiesTitle => 'Antes dos Estudos';

  @override
  String get prayerStudiesContent =>
      'Criador inefável, Vós que sois a verdadeira fonte da luz e da sabedoria, dignai-vos infundir o raio da vossa claridade sobre as trevas da minha inteligência, afastando de mim a dupla escuridão em que nasci: o pecado e a ignorância.\n\nVós, que tornais eloquente a língua das crianças, modelai a minha língua e derramai nos meus lábios a graça da vossa bênção. Dai-me agudeza para entender, capacidade para reter, método e facilidade para aprender, sutileza para interpretar e graça abundante para falar.\n\nDai-me acerto ao começar, direção ao progredir e perfeição ao concluir. Amém.\n(Santo Tomás de Aquino)';

  @override
  String get prayerMealsTitle => 'Antes das Refeições';

  @override
  String get prayerMealsContent =>
      'Abençoai-nos, Senhor, e estes dons que, da vossa bondade, vamos receber. Por Cristo, Senhor nosso. Amém.';

  @override
  String get prayerAngelusTitle => 'O Angelus';

  @override
  String get prayerAngelusContent =>
      '℣. O Anjo do Senhor anunciou a Maria.\n℟. E ela concebeu do Espírito Santo.\n\nAve Maria...\n\n℣. Eis aqui a escrava do Senhor.\n℟. Faça-se em mim segundo a vossa palavra.\n\nAve Maria...\n\n℣. E o Verbo se fez carne.\n℟. E habitou entre nós.\n\nAve Maria...\n\n℣. Rogai por nós, Santa Mãe de Deus.\n℟. Para que sejamos dignos das promessas de Cristo.\n\nOremos:\nInfundi, Senhor, a vossa graça em nossas almas, para que nós, que pela anunciação do Anjo conhecemos a encarnação de Cristo, vosso Filho, cheguemos, por sua paixão e cruz, à glória da ressurreição. Pelo mesmo Cristo, Senhor nosso. Amém.';

  @override
  String get prayerReginaCaeliTitle => 'Rainha do Céu (Regina Caeli)';

  @override
  String get prayerReginaCaeliContent =>
      '℣. Rainha do Céu, alegrai-vos, aleluia.\n℟. Porque Aquele que merecestes trazer em vosso seio, aleluia.\n℣. Ressuscitou como disse, aleluia.\n℟. Rogai a Deus por nós, aleluia.\n\n℣. Exultai e alegrai-vos, ó Virgem Maria, aleluia.\n℟. Porque o Senhor ressuscitou verdadeiramente, aleluia.\n\nOremos:\nÓ Deus, que vos dignastes alegrar o mundo com a Ressurreição do vosso Filho, Nosso Senhor Jesus Cristo, concedei-nos, vos suplicamos, que por sua Mãe, a Virgem Maria, alcancemos os gozos da vida eterna. Pelo mesmo Cristo, Senhor Nosso. Amém.';

  @override
  String get prayerGuardianAngelTitle => 'Santo Anjo da Guarda';

  @override
  String get prayerGuardianAngelContent =>
      'Santo Anjo do Senhor, meu zeloso guardador, se a ti me confiou a piedade divina, sempre me rege, me guarda, me governa e me ilumina. Amém.';

  @override
  String get prayerGuardianAngelContentLatin =>
      'Angele Dei, qui custos es mei, me, tibi commissum pietate superna, illumina, custodi, rege et guberna. Amen.';

  @override
  String get prayerStJosephTitle => 'São José';

  @override
  String get prayerStJosephContent =>
      'A vós, São José, recorremos em nossa tribulação e, depois de ter implorado o auxílio de vossa santíssima Esposa, cheios de confiança solicitamos também o vosso patrocínio.\n\nPor esse laço sagrado de caridade que vos uniu à Imaculada Virgem Mãe de Deus, e pelo amor paternal que tivestes ao Menino Jesus, ardentemente suplicamos que lanceis um olhar benigno sobre a herança que Jesus Cristo conquistou com seu Sangue, e nos socorrais em nossas necessidades com o vosso auxílio e poder.\n\nProtegei, ó Guarda providente da divina Família, a raça eleita de Jesus Cristo. Afastai para longe de nós, ó Pai amantíssimo, a peste do erro e do vício. Assisti-nos do alto do céu, ó nosso fortíssimo sustentáculo, na luta contra o poder das trevas.\n\nE assim como outrora salvastes da morte a vida ameaçada do Menino Jesus, assim também defendei agora a Santa Igreja de Deus das ciladas de seus inimigos e de toda a adversidade. Amparai a cada um de nós com o vosso constante patrocínio, a fim de que, a vosso exemplo e sustentados com o vosso auxílio, possamos viver virtuosamente, morrer piedosamente, e obter no céu a eterna bem-aventurança. Amém.';

  @override
  String get prayerStThereseTitle => 'Santa Teresinha';

  @override
  String get prayerStThereseContent =>
      'Ó Santa Teresinha do Menino Jesus, modelo de humildade, de confiança e de amor! Do alto dos céus, despejai sobre nós estas rosas que levais em vossos braços: a rosa da humildade, para que vençamos nosso orgulho e aceitemos o jugo do Evangelho; a rosa da confiança, para que nos abandonemos à vontade de Deus; a rosa do amor, para que, abrindo nossas almas sem medida à graça, realizemos o único fim para o qual Deus nos criou: Amá-Lo e fazê-Lo amar.\n\nVós que dissestes: \"Passarei o meu céu fazendo o bem na terra\", ajudai-me em minha aflição e socorrei-me nesta necessidade. Amém.';

  @override
  String get prayerGuadalupeTitle => 'N. Sra. de Guadalupe';

  @override
  String get prayerGuadalupeContent =>
      'Ó Nossa Senhora de Guadalupe, Rosa Mística, intercedei pela Santa Igreja, protegei o Sumo Pontífice e ajudai a todos os que vos invocam nas suas necessidades.\n\nVós que sois a sempre Virgem Maria e Mãe do Verdadeiro Deus, alcançai-nos de Vosso Santíssimo Filho a graça de conservar a fé, uma doce esperança no meio das amarguras da vida, uma caridade ardente e o precioso dom da perseverança final. Amém.\n(Papa São Pio X)';

  @override
  String get prayerCarloAcutisTitle => 'São Carlo Acutis';

  @override
  String get prayerCarloAcutisContent =>
      'Senhor Deus, que cumulastes de graças o coração do jovem São Carlo Acutis, despertando nele um amor ardente pela Santíssima Eucaristia e uma terna devoção filial à Virgem Maria, concedei-nos a graça de imitar o seu exemplo.\n\nPor sua intercessão, ensinai-nos a buscar primeiro o vosso Reino, a frequentar com pureza de alma os sacramentos da Confissão e da Comunhão, e a usar os meios deste mundo apenas para a vossa maior glória e para o bem dos pobres e necessitados.\n\nSão Carlo Acutis, rogai por nós, para que vivamos sempre unidos a Jesus e alcancemos a vida eterna. Amém.';

  @override
  String get temptationFightTitle => 'Luta contra as Tentações';

  @override
  String get temptationFightDesc => 'Orações e auxílio em momento de tentação';

  @override
  String get temptationStep1Title => 'Reconheça a Tentação';

  @override
  String get temptationStep1Desc =>
      'A tentação é um perigo real para a alma. Reconheça-a imediatamente e não dialogue com ela. O demônio é astuto e usa a hesitação para nos vencer.';

  @override
  String get temptationStep1Prayer =>
      '\"Vigiai e orai, para que não entreis em tentação.\" (Mt 26,41)';

  @override
  String get temptationStep2Title => 'Jaculatórias de Socorro';

  @override
  String get temptationStep2Desc =>
      'Orações curtas e poderosas para momentos de tentação. Repita-as com fervor até sentir a tentação diminuir.';

  @override
  String get temptationStep2Prayer =>
      '• Jesus e Maria, eu vos amo, salvai almas.\n• Meu Jesus, misericórdia!\n• Jesus, manso e humilde de coração, fazei o nosso coração semelhante ao Vosso.\n• Refúgio dos Pecadores, rogai por nós.';

  @override
  String get temptationStep3Title => 'São Miguel Arcanjo';

  @override
  String get temptationStep3Desc =>
      'O Príncipe da Milícia Celeste é nosso defensor contra as ciladas do demônio. Invoque-o com confiança!';

  @override
  String get temptationStep3Prayer =>
      'São Miguel Arcanjo, defendei-nos no combate; sede nosso refúgio contra a maldade e as ciladas do demônio. Ordene-lhe Deus, instantemente o pedimos, e Vós, Príncipe da Milícia Celeste, pela virtude divina, precipitai no inferno a Satanás e aos outros espíritos malignos que andam pelo mundo para a perdição das almas. Amém.';

  @override
  String get temptationStep4Title => 'Lembrai-Vos';

  @override
  String get temptationStep4Desc =>
      'A Virgem Maria nunca abandona quem a Ela recorre. Confie em sua intercessão maternal.';

  @override
  String get temptationStep4Prayer =>
      'Lembrai-Vos, ó piíssima Virgem Maria, que nunca se ouviu dizer que algum daqueles que têm recorrido à Vossa proteção, implorado a Vossa assistência e reclamado o Vosso socorro, fosse por Vós desamparado. Animado eu com igual confiança, a Vós recorro, ó Virgem das Virgens, minha Mãe. De Vós me valho, a Vós venho, e gemendo sob o peso de meus pecados, me prostro a Vossos pés. Não desprezeis as minhas súplicas, ó Mãe do Verbo de Deus humanado, mas dignai-Vos de as ouvir propícia, e de me alcançar o que Vos rogo. Amém.';

  @override
  String get temptationStep5Title => 'A Fuga é Vitória';

  @override
  String get temptationStep5Desc =>
      'Na tentação da impureza, a vitória consiste na fuga. Não lute corpo a corpo com a tentação – fuja dela! Os santos venceram fugindo, não enfrentando.';

  @override
  String get temptationStep5Prayer =>
      '\"Fugi da fornicação.\" (1 Cor 6,18)\n\n\"Aquele que se expõe voluntariamente ao perigo, nele perecerá.\" (Eclo 3,27)';

  @override
  String get temptationStep6Title => 'Mude o Ambiente';

  @override
  String get temptationStep6Desc =>
      'Dicas práticas para fugir da tentação:\n\n• Mude de pensamento: ocupe a mente com algo neutro\n• Mude de lugar: saia do ambiente de tentação\n• Faça uma tarefa: trabalho manual, exercício, leitura\n• Busque companhia: não fique sozinho\n• Desligue dispositivos: afaste-se da ocasião próxima';

  @override
  String get temptationStep6Prayer =>
      'Senhor, dai-me a sabedoria para fugir das ocasiões de pecado e a força para me afastar do perigo.';

  @override
  String get temptationStep7Title => 'Rompa o Cerco';

  @override
  String get temptationStep7Desc =>
      'Jaculatórias para quando o desânimo ataca. Não desista! Deus permite a tentação para nos fortalecer, não para nos derrubar.';

  @override
  String get temptationStep7Prayer =>
      '• Senhor, eu creio! Ajudai a minha incredulidade.\n• Mãe Santíssima, não me deixeis!\n• Coração Sagrado de Jesus, em Vós confio!\n• São José, guardião da pureza, rogai por nós!';

  @override
  String get temptationStep8Title => 'Propósito e Consagração';

  @override
  String get temptationStep8Desc =>
      'Renove seu propósito de fidelidade a Deus. Consagre-se à proteção de Nossa Senhora.';

  @override
  String get temptationStep8Prayer =>
      'Ó minha Senhora e minha Mãe, eu me ofereço todo a vós e, em prova de minha devoção para convosco, vos consagro neste dia os meus olhos, os meus ouvidos, a minha boca, o meu coração e inteiramente todo o meu ser. E porque assim sou vosso, ó incomparável Mãe, guardai-me e defendei-me como coisa e propriedade vossa. Amém.';

  @override
  String get joyful1Title => '1º Mistério: A Anunciação do Anjo a Maria';

  @override
  String get joyful1Short =>
      'Pedimos, por este mistério e pela intercessão de Maria, uma profunda humildade de coração.';

  @override
  String get joyful1Full =>
      'Nós vos oferecemos, Senhor Jesus, esta primeira dezena, em honra de vossa Encarnação no seio de Maria; e vos pedimos, por este mistério e por sua intercessão, uma profunda humildade de coração. Amém.';

  @override
  String get joyful2Title => '2º Mistério: A Visitação de Maria a Isabel';

  @override
  String get joyful2Short =>
      'Pedimos, por este mistério e pela intercessão de Maria, a perfeita caridade para com o próximo.';

  @override
  String get joyful2Full =>
      'Nós vos oferecemos, Senhor Jesus, esta segunda dezena, em honra da Visitação de vossa Santíssima Mãe à sua prima Santa Isabel e da santificação de São João Batista; e vos pedimos, por este mistério e pela intercessão de vossa Mãe Santíssima, uma perfeita caridade para com o nosso próximo. Amém.';

  @override
  String get joyful3Title => '3º Mistério: O Nascimento de Jesus';

  @override
  String get joyful3Short =>
      'Pedimos, por este mistério e pela intercessão de Maria, o desapego dos bens materiais e o amor à pobreza.';

  @override
  String get joyful3Full =>
      'Nós vos oferecemos, Senhor Jesus, esta terceira dezena, em honra de vosso Nascimento no estábulo de Belém; e vos pedimos, por este mistério e pela intercessão de vossa Santíssima Mãe, o desapego dos bens da terra, o desapego de nós mesmos e o amor à pobreza e aos pobres. Amém.';

  @override
  String get joyful4Title => '4º Mistério: A Apresentação de Jesus no Templo';

  @override
  String get joyful4Short =>
      'Pedimos, por este mistério e pela intercessão de Maria, uma grande pureza e perfeita obediência.';

  @override
  String get joyful4Full =>
      'Nós vos oferecemos, Senhor Jesus, esta quarta dezena, em honra de vossa Apresentação no Templo e da Purificação de Maria; e vos pedimos, por este mistério e por sua intercessão, uma grande pureza de corpo e de espírito e uma perfeita obediência à santa vontade de Deus. Amém.';

  @override
  String get joyful5Title =>
      '5º Mistério: A Perda e o Encontro de Jesus no Templo';

  @override
  String get joyful5Short =>
      'Pedimos, por este mistério e pela intercessão de Maria, a verdadeira sabedoria e conversão de vida.';

  @override
  String get joyful5Full =>
      'Nós vos oferecemos, Senhor Jesus, esta quinta dezena, em honra de vosso Encontro no Templo por Maria; e vos pedimos, por este mistério e por sua intercessão, a verdadeira sabedoria, a conversão de nossa vida e a de todos os pecadores. Amém.';

  @override
  String get sorrowful1Title =>
      '1º Mistério: A Agonia de Jesus no Jardim das Oliveiras';

  @override
  String get sorrowful1Short =>
      'Pedimos, por este mistério e pela intercessão de Maria, a contrição de nossos pecados e a conformidade com a vontade de Deus.';

  @override
  String get sorrowful1Full =>
      'Nós vos oferecemos, Senhor Jesus, esta primeira dezena dos mistérios dolorosos, em honra de vossa agonia mortal no Jardim das Oliveiras; e vos pedimos, por este mistério e pela intercessão de vossa Mãe Santíssima, a contrição de nossos pecados e uma perfeita conformidade com a vossa santa vontade. Amém.';

  @override
  String get sorrowful2Title => '2º Mistério: A Flagelação de Jesus';

  @override
  String get sorrowful2Short =>
      'Pedimos, por este mistério e pela intercessão de Maria, a mortificação de nossos sentidos e a perfeita castidade.';

  @override
  String get sorrowful2Full =>
      'Nós vos oferecemos, Senhor Jesus, esta segunda dezena dos mistérios dolorosos, em honra de vossa cruel Flagelação; e vos pedimos, por este mistério e pela intercessão de vossa Mãe Santíssima, a mortificação de nossos sentidos e a perfeita castidade. Amém.';

  @override
  String get sorrowful3Title => '3º Mistério: A Coroação de Espinhos';

  @override
  String get sorrowful3Short =>
      'Pedimos, por este mistério e pela intercessão de Maria, o desprezo do mundo e o desapego das vaidades.';

  @override
  String get sorrowful3Full =>
      'Nós vos oferecemos, Senhor Jesus, esta terceira dezena dos mistérios dolorosos, em honra de vossa Coroação de espinhos; e vos pedimos, por este mistério e pela intercessão de vossa Mãe Santíssima, o desprezo do mundo e o desapego das honras e vaidades. Amém.';

  @override
  String get sorrowful4Title => '4º Mistério: Jesus Carrega a Cruz';

  @override
  String get sorrowful4Short =>
      'Pedimos, por este mistério e pela intercessão de Maria, uma grande paciência para carregar a nossa cruz.';

  @override
  String get sorrowful4Full =>
      'Nós vos oferecemos, Senhor Jesus, esta quarta dezena dos mistérios dolorosos, em honra do carregamento de vossa pesada Cruz; e vos pedimos, por este mistério e pela intercessão de vossa Mãe Santíssima, uma grande paciência para carregar a nossa cruz a vosso exemplo por toda a nossa vida. Amém.';

  @override
  String get sorrowful5Title => '5º Mistério: A Crucifixão e Morte de Jesus';

  @override
  String get sorrowful5Short =>
      'Pedimos, por este mistério e pela intercessão de Maria, a conversão dos pecadores e a perseverança final.';

  @override
  String get sorrowful5Full =>
      'Nós vos oferecemos, Senhor Jesus, esta quinta dezena dos mistérios dolorosos, em honra de vossa Crucifixão e morte dolorosa no Calvário; e vos pedimos, por este mistério e pela intercessão de vossa Mãe Santíssima, a conversão dos pecadores, a nossa perseverança final e o alívio das almas do Purgatório. Amém.';

  @override
  String get glorious1Title => '1º Mistério: A Ressurreição de Jesus';

  @override
  String get glorious1Short =>
      'Pedimos, por este mistério e pela intercessão de Maria, uma fé viva.';

  @override
  String get glorious1Full =>
      'Nós vos oferecemos, Senhor Jesus, esta primeira dezena dos mistérios gloriosos, em honra de vossa gloriosa Ressurreição; e vos pedimos, por este mistério e pela intercessão de vossa Mãe Santíssima, uma fé viva. Amém.';

  @override
  String get glorious2Title => '2º Mistério: A Ascensão de Jesus ao Céu';

  @override
  String get glorious2Short =>
      'Pedimos, por este mistério e pela intercessão de Maria, um firme desejo do Céu e grande confiança em Deus.';

  @override
  String get glorious2Full =>
      'Nós vos oferecemos, Senhor Jesus, esta segunda dezena dos mistérios gloriosos, em honra de vossa gloriosa Ascensão ao Céu; e vos pedimos, por este mistério e pela intercessão de vossa Mãe Santíssima, um firme desejo do Céu e uma grande confiança em Vós. Amém.';

  @override
  String get glorious3Title =>
      '3º Mistério: A Descida do Espírito Santo sobre os Apóstolos';

  @override
  String get glorious3Short =>
      'Pedimos, por este mistério e pela intercessão de Maria, a descida do Espírito Santo e a caridade divina.';

  @override
  String get glorious3Full =>
      'Nós vos oferecemos, Senhor Jesus, esta terceira dezena dos mistérios gloriosos, em honra do mistério de Pentecostes; e vos pedimos, por este mistério e pela intercessão de vossa Mãe Santíssima, a descida do Espírito Santo em nossas almas e o dom da verdadeira caridade divina. Amém.';

  @override
  String get glorious4Title =>
      '4º Mistério: A Assunção de Nossa Senhora ao Céu';

  @override
  String get glorious4Short =>
      'Pedimos, por este mistério e pela intercessão de Maria, uma perfeita união com ela e uma terna devoção a tão boa Mãe.';

  @override
  String get glorious4Full =>
      'Nós vos oferecemos, Senhor Jesus, esta quarta dezena dos mistérios gloriosos, em honra da gloriosa Assunção de vossa Santíssima Mãe ao Céu; e vos pedimos, por este mistério e por sua intercessão, uma perfeita união com ela e uma terna devoção a tão boa Mãe. Amém.';

  @override
  String get glorious5Title =>
      '5º Mistério: A Coroação de Nossa Senhora como Rainha do Céu e da Terra';

  @override
  String get glorious5Short =>
      'Pedimos, por este mistério e pela intercessão de Maria, a perseverança na graça e a coroa da glória eterna.';

  @override
  String get glorious5Full =>
      'Nós vos oferecemos, Senhor Jesus, esta quinta dezena dos mistérios gloriosos, em honra da Coroação de vossa Santíssima Mãe no Céu; e vos pedimos, por este mistério e por sua intercessão, a perseverança na graça e a coroa da glória eterna. Amém.';

  @override
  String get luminous1Title => '1º Mistério: O Batismo de Jesus no Jordão';

  @override
  String get luminous1Short =>
      'Jesus é batizado por João no Rio Jordão. O céu se abre, o Espírito Santo desce como pomba, e o Pai declara: \"Este é meu Filho amado\".';

  @override
  String get luminous1Full =>
      'Então veio Jesus da Galileia ter com João ao Jordão, para ser batizado por ele. Mas João opunha-se-lhe, dizendo: \"Eu sou o que devo ser batizado por ti, e vens tu a mim?\" Jesus, porém, respondendo, disse-lhe: \"Deixa por agora; porque assim nos convém cumprir toda a justiça\". Então ele o consentiu. E sendo Jesus batizado, saiu logo da água; e eis que se lhe abriram os céus, e viu o Espírito de Deus que descia como uma pomba, e vinha sobre ele. E eis que uma voz dos céus dizia: \"Este é o meu Filho amado, em quem tenho posto toda a minha complacência\". Neste mistério, contemplamos a humildade de Jesus, que não precisava de batismo, mas quis santificar as águas e dar-nos o exemplo. É também a epifania da Santíssima Trindade: o Pai que fala, o Filho que é batizado, o Espírito Santo que desce.';

  @override
  String get luminous2Title => '2º Mistério: As Bodas de Caná';

  @override
  String get luminous2Short =>
      'Nas bodas de Caná, Jesus realiza seu primeiro milagre, transformando água em vinho, por intercessão de sua Mãe Maria.';

  @override
  String get luminous2Full =>
      'E, ao terceiro dia, fizeram-se umas bodas em Caná da Galileia; e estava ali a mãe de Jesus. E foram também convidados Jesus e os seus discípulos para as bodas. E, faltando o vinho, a mãe de Jesus lhe disse: \"Não têm vinho\". Disse-lhe Jesus: \"Mulher, que tenho eu contigo? Ainda não é chegada a minha hora\". Disse sua mãe aos serventes: \"Fazei tudo quanto ele vos disser\". E estavam ali postas seis talhas de pedra, segundo a purificação dos judeus, que tinham cada uma duas ou três medidas. Disse-lhes Jesus: \"Enchei as talhas de água\". E encheram-nas até acima. E disse-lhes: \"Tirai agora, e levai ao que tem o encargo da mesa\". E levaram-lho. E, logo que o chefe da mesa provou a água feita vinho (não sabendo donde vinha, se bem que os serventes que tinham tirado a água o sabiam), chamou o esposo, e disse-lhe: \"Todo o homem põe primeiro o vinho bom, e, quando já têm bebido bem, então o inferior; mas tu guardaste até agora o vinho bom\". Este princípio dos milagres o fez Jesus em Caná da Galileia; e manifestou a sua glória, e os seus discípulos creram nele.';

  @override
  String get luminous3Title => '3º Mistério: O Anúncio do Reino de Deus';

  @override
  String get luminous3Short =>
      'Jesus percorre a Galileia pregando o Evangelho e chamando à conversão: \"O Reino de Deus está próximo: arrependei-vos e crede no Evangelho\".';

  @override
  String get luminous3Full =>
      'E, depois que João foi entregue à prisão, veio Jesus para a Galileia, pregando o evangelho do Reino de Deus, e dizendo: \"O tempo está cumprido, e o Reino de Deus está próximo: arrependei-vos, e crede no evangelho\". E percorria Jesus toda a Galileia, ensinando nas suas sinagogas e pregando o evangelho do reino, e curando todas as enfermidades e moléstias entre o povo. E a sua fama correu por toda a Síria, e traziam-lhe todos os que padeciam de vários males e dores, os endemoninhados, lunáticos e paralíticos, e ele os curava. E seguia-o uma grande multidão da Galileia, de Decápolis, de Jerusalém, da Judeia e de além do Jordão. E Jesus, vendo a multidão, subiu a um monte; e, assentando-se, os seus discípulos chegaram-se a ele. E, abrindo a sua boca, os ensinava, dizendo: \"Bem-aventurados os pobres de espírito, porque deles é o reino dos céus. Bem-aventurados os que choram, porque eles serão consolados\".';

  @override
  String get luminous4Title => '4º Mistério: A Transfiguração de Jesus';

  @override
  String get luminous4Short =>
      'No Monte Tabor, Jesus se transfigura diante de Pedro, Tiago e João. Seu rosto brilha como o sol e suas vestes tornam-se brancas como a luz.';

  @override
  String get luminous4Full =>
      'E, seis dias depois, Jesus tomou consigo a Pedro, a Tiago e a João, e os levou sós, em particular, a um alto monte; e transfigurou-se diante deles. E os seus vestidos tornaram-se resplandecentes, em extremo brancos, como a neve, como nenhum lavadeiro sobre a terra os poderia branquear. E apareceu-lhes Elias, com Moisés, e falavam com Jesus. E Pedro, tomando a palavra, disse a Jesus: \"Rabi, bom é que nós estejamos aqui, e façamos três cabanas, uma para ti, outra para Moisés, e outra para Elias\". Pois não sabia o que dizia, porque estavam atemorizados. E formou-se uma nuvem que os cobriu com a sua sombra, e saiu da nuvem uma voz que dizia: \"Este é o meu Filho amado; a ele ouvi\". E, tendo olhado em roda, ninguém mais viram, senão só Jesus, com eles. E, ao descerem do monte, ordenou-lhes que a ninguém contassem o que tinham visto, senão depois que o Filho do homem tivesse ressuscitado dentre os mortos.';

  @override
  String get luminous5Title => '5º Mistério: A Instituição da Eucaristia';

  @override
  String get luminous5Short =>
      'Na Última Ceia, Jesus institui a Eucaristia, dando-nos seu Corpo e Sangue: \"Isto é o meu Corpo. Fazei isto em memória de mim\".';

  @override
  String get luminous5Full =>
      'No primeiro dia dos pães asmos, quando sacrificavam a Páscoa, perguntaram-lhe seus discípulos: \"Onde queres que vamos preparar para que comas a Páscoa?\" E, comendo eles, tomou Jesus pão, e, abençoando-o, o partiu, e deu-lho, e disse: \"Tomai, isto é o meu corpo\". E, tomando o cálice e dando graças, deu-lho; e todos beberam dele. E disse-lhes: \"Isto é o meu sangue, o sangue da nova aliança, que por muitos é derramado. Em verdade vos digo que não beberei mais do fruto da vide, até àquele dia em que o beber novo, no Reino de Deus\". Antes do dia da festa da Páscoa, sabendo Jesus que era chegada a sua hora de passar deste mundo para o Pai, como tivesse amado os seus que estavam no mundo, amou-os até o fim. Este é o maior dom: Jesus permanece conosco na Eucaristia até o fim dos tempos.';

  @override
  String get prayerGloriaTitle => 'Glória';

  @override
  String get prayerGloriaContent =>
      'Glória ao Pai, ao Filho e ao Espírito Santo. Como era no princípio, agora e sempre, por todos os séculos dos séculos. Amém.';

  @override
  String get prayerGloriaContentLatin =>
      'Gloria Patri, et Filio, et Spiritui Sancto. Sicut erat in principio, et nunc, et semper, et in saecula saeculorum. Amen.';

  @override
  String get prayerSalveTitle => 'Salve Rainha';

  @override
  String get prayerSalveContent =>
      'Infinitas graças vos damos, Soberana Rainha, pelos benefícios que todos os dias recebemos de vossas mãos liberais. Dignai-vos, agora e para sempre, tomar-nos debaixo do vosso poderoso amparo e, para mais vos obrigar, vos saudamos com uma Salve-Rainha. \n\nSalve, Rainha, Mãe de misericórdia, vida, doçura e esperança nossa, salve! A vós bradamos, os degredados filhos de Eva. A vós suspiramos, gemendo e chorando neste vale de lágrimas. Eia, pois, Advogada nossa, esses vossos olhos misericordiosos a nós volvei. E depois deste desterro, mostrai-nos Jesus, bendito fruto do vosso ventre. Ó clemente, ó piedosa, ó doce sempre Virgem Maria. Rogai por nós, Santa Mãe de Deus, para que sejamos dignos das promessas de Cristo. Amém.';

  @override
  String get prayerSalveContentLatin =>
      'Infinitas gratias tibi agimus, suprema Regina, pro beneficiis quae quotidie ex manibus tuis liberalibus accipimus. Dignare nunc et in aeternum nos sub potenti tuo patrocinio suscipere, et tibi gratias agentes, te Salve Regina salutamus.\n\nSalve, Regina, mater misericordiae, vita, dulcedo, et spes nostra, salve. Ad te clamamus, exsules filii Hevae. Ad te suspiramus, gementes et flentes in hac lacrimarum valle. Eia, ergo, advocata nostra, illos tuos misericordes oculos ad nos converte. Et Iesum, benedictum fructum ventris tui, nobis post hoc exsilium ostende. O clemens, O pia, O dulcis Virgo Maria.\n\n℣. Ora pro nobis, sancta Dei Genetrix.\n℟. Ut digni efficiamur promissionibus Christi. Amen.';

  @override
  String get prayerFatimaTitle => 'Oração de Fátima';

  @override
  String get prayerFatimaContent =>
      'Ó meu Jesus, perdoai-nos, livrai-nos do fogo do inferno, levai as almas todas para o Céu, principalmente as que mais precisarem.';

  @override
  String get prayerMariaImaculadaTitle =>
      'Oratio ad Beatam Virginem Mariam (Oração da Noite)';

  @override
  String get prayerMariaImaculadaContent =>
      'Ó Maria concebida sem pecado, livrai-nos nesta noite de todo pecado mortal, venial e de toda imperfeição. Amém.';

  @override
  String get prayerMariaImaculadaContentLatin =>
      'O Maria, sine labe concepta, libera nos hac nocte ab omni peccato mortali, veniali et ab omni imperfectione. Amen.';

  @override
  String get prayerMariaImaculadaMorningTitle =>
      'Oratio ad Beatam Virginem Mariam (Oração da Manhã)';

  @override
  String get prayerMariaImaculadaMorningContent =>
      'Ó Maria concebida sem pecado, livrai-nos neste dia de todo pecado mortal, venial e de toda imperfeição. Amém.';

  @override
  String get prayerMariaImaculadaMorningContentLatin =>
      'O Maria, sine labe concepta, libera nos hoc die ab omni peccato mortali, veniali et ab omni imperfectione. Amen.';

  @override
  String get prayerSignCrossTitle => 'Sinal da Cruz';

  @override
  String get prayerSignCrossContent =>
      'Em nome do Pai, e do Filho, e do Espírito Santo. Amém.';

  @override
  String get prayerSignCrossContentLatin =>
      'In nomine Patris, et Filii, et Spiritus Sancti. Amen.';

  @override
  String get prayerOfferingTitle => 'Oferecimento do Terço';

  @override
  String get prayerOfferingContent =>
      'Divino Jesus, eu Vos ofereço este terço que vou rezar, contemplando os mistérios de nossa Redenção. Concedei-me, por intercessão de Maria, Vossa Mãe Santíssima, a quem me dirijo, as virtudes que me são necessárias para bem rezá-lo e a graça de ganhar as indulgências desta santa devoção.';

  @override
  String get rosaryBeadOurFather => 'Pai Nosso';

  @override
  String get rosaryBeadHailMary => 'Ave Maria';

  @override
  String get rosaryBeadGlory => 'Glória';

  @override
  String get rosaryBeadFatima => 'Oração de Fátima';

  @override
  String get rosaryBeadCreed => 'Credo';

  @override
  String get rosaryBeadSignCross => 'Sinal da Cruz';

  @override
  String get rosaryBeadSalveRegina => 'Salve Rainha';

  @override
  String get rosaryBeadOffering => 'Oferecimento';

  @override
  String get mysteryJoyfulTitle => 'Mistérios Gozosos';

  @override
  String get mysteryJoyfulDays => 'Segunda e Quinta-feira';

  @override
  String get mysterySorrowfulTitle => 'Mistérios Dolorosos';

  @override
  String get mysterySorrowfulDays => 'Terça e Sexta-feira';

  @override
  String get mysteryGloriousTitle => 'Mistérios Gloriosos';

  @override
  String get mysteryGloriousDays => 'Quarta, Sábado e Domingo';

  @override
  String get mysteryLuminousTitle => 'Mistérios Luminosos';

  @override
  String get mysteryLuminousDays => 'Quinta-feira';

  @override
  String get temptationPrayerLabel => 'ORAÇÃO';

  @override
  String get rosaryNextBead => 'Próxima';

  @override
  String get rosaryPrevBead => 'Anterior';

  @override
  String get rosaryHailMaryFaith => 'Ave Maria (pela Fé)';

  @override
  String get rosaryHailMaryHope => 'Ave Maria (pela Esperança)';

  @override
  String get rosaryHailMaryCharity => 'Ave Maria (pela Caridade)';

  @override
  String get rosaryMeditationTitle => 'Meditação';

  @override
  String get rosaryMeditationResume => 'Fruto do Mistério';

  @override
  String get rosaryMeditationComplete => 'Oferecimento do Mistério';

  @override
  String get catJaculatoriasTitle => 'Jaculatórias';

  @override
  String get catJaculatoriasDesc => 'Orações curtas e fervorosas';

  @override
  String get jaculatoriaSacredHeartTitle => 'Sagrado Coração de Jesus';

  @override
  String get jaculatoriaSacredHeartContent =>
      'Sagrado Coração de Jesus, eu confio em Vós!';

  @override
  String get jaculatoriaMeekHeartTitle => 'Coração Manso e Humilde';

  @override
  String get jaculatoriaMeekHeartContent =>
      'Jesus, manso e humilde de coração, fazei o nosso coração semelhante ao vosso.';

  @override
  String get jaculatoriaMarySalvationTitle => 'Doce Coração de Maria';

  @override
  String get jaculatoriaMarySalvationContent =>
      'Doce Coração de Maria, sede a nossa salvação.';

  @override
  String get jaculatoriaHolyFamilyTitle => 'Sagrada Família';

  @override
  String get jaculatoriaHolyFamilyContent =>
      'Jesus, Maria e José, a nossa família vossa é.';

  @override
  String get jaculatoriaImmaculateConceptionTitle => 'Imaculada Conceição';

  @override
  String get jaculatoriaImmaculateConceptionContent =>
      'Ó Maria, concebida sem pecado, rogai por nós que recorremos a Vós.';

  @override
  String get jaculatoriaMercyTitle => 'Misericórdia';

  @override
  String get jaculatoriaMercyContent => 'Meu Jesus, misericórdia!';

  @override
  String get catLitaniesTitle => 'Ladainhas';

  @override
  String get litanyLorettoTitle => 'Ladainha de Nossa Senhora (Lauretana)';

  @override
  String get litanyLorettoContent =>
      'Senhor, tende piedade de nós.\nCristo, tende piedade de nós.\nSenhor, tende piedade de nós.\n\nCristo, ouvi-nos.\nCristo, atendei-nos.\n\nDeus Pai do Céu, tende piedade de nós.\nDeus Filho, Redentor do mundo, tende piedade de nós.\nDeus Espírito Santo, tende piedade de nós.\nSantíssima Trindade, que sois um só Deus, tende piedade de nós.\n\nSanta Maria, rogai por nós.\nSanta Mãe de Deus, rogai por nós.\nSanta Virgem das Virgens, rogai por nós.\nMãe de Cristo, rogai por nós.\nMãe da Igreja, rogai por nós.\nMãe da Divina Graça, rogai por nós.\nMãe puríssima, rogai por nós.\nMãe castíssima, rogai por nós.\nMãe sempre Virgem, rogai por nós.\nMãe imaculada, rogai por nós.\nMãe amável, rogai por nós.\nMãe admirável, rogai por nós.\nMãe do bom conselho, rogai por nós.\nMãe do Criador, rogai por nós.\nMãe do Salvador, rogai por nós.\nMãe de misericórdia, rogai por nós.\nVirgem prudentíssima, rogai por nós.\nVirgem venerável, rogai por nós.\nVirgem louvável, rogai por nós.\nVirgem poderosa, rogai por nós.\nVirgem clemente, rogai por nós.\nVirgem fiel, rogai por nós.\nEspelho de justiça, rogai por nós.\nSede da sabedoria, rogai por nós.\nCausa de nossa alegria, rogai por nós.\nVaso espiritual, rogai por nós.\nVaso honorífico, rogai por nós.\nVaso insigne de devoção, rogai por nós.\nRosa mística, rogai por nós.\nTorre de Davi, rogai por nós.\nTorre de marfim, rogai por nós.\nCasa de ouro, rogai por nós.\nArca da aliança, rogai por nós.\nPorta do céu, rogai por nós.\nEstrela da manhã, rogai por nós.\nSaúde dos enfermos, rogai por nós.\nRefúgio dos pecadores, rogai por nós.\nConsoladora dos aflitos, rogai por nós.\nAuxílio dos cristãos, rogai por nós.\nRainha dos Anjos, rogai por nós.\nRainha dos Patriarcas, rogai por nós.\nRainha dos Profetas, rogai por nós.\nRainha dos Apóstolos, rogai por nós.\nRainha dos Mártires, rogai por nós.\nRainha dos Confessores, rogai por nós.\nRainha das Virgens, rogai por nós.\nRainha de todos os Santos, rogai por nós.\nRainha concebida sem pecado original, rogai por nós.\nRainha assunta ao Céu, rogai por nós.\nRainha do Santíssimo Rosário, rogai por nós.\nRainha da família, rogai por nós.\nRainha da paz, rogai por nós.\n\nCordeiro de Deus, que tirais o pecado do mundo, perdoai-nos, Senhor.\nCordeiro de Deus, que tirais o pecado do mundo, ouvi-nos, Senhor.\nCordeiro de Deus, que tirais o pecado do mundo, tende piedade de nós.\n\n℣. Rogai por nós, Santa Mãe de Deus.\n℟. Para que sejamos dignos das promessas de Cristo.\n\nOremos:\nConcedei-nos, Senhor Deus, a nós vossos servos, gozar de contínua saúde de alma e de corpo; e, pela gloriosa intercessão da bem-aventurada sempre Virgem Maria, livrai-nos das tristezas da vida presente e dai-nos a alegria da vida eterna. Por Cristo, Nosso Senhor. Amém.';

  @override
  String get litanySacredHeartTitle => 'Ladainha do Sagrado Coração de Jesus';

  @override
  String get litanySacredHeartContent =>
      'Senhor, tende piedade de nós.\nCristo, tende piedade de nós.\nSenhor, tende piedade de nós.\n\nCristo, ouvi-nos.\nCristo, atendei-nos.\n\nDeus Pai do Céu, tende piedade de nós.\nDeus Filho, Redentor do mundo, tende piedade de nós.\nDeus Espírito Santo, tende piedade de nós.\nSantíssima Trindade, que sois um só Deus, tende piedade de nós.\n\nCoração de Jesus, Filho do Eterno Pai, tende piedade de nós.\nCoração de Jesus, formado pelo Espírito Santo no seio da Virgem Mãe, tende piedade de nós.\nCoração de Jesus, unido substancialmente ao Verbo de Deus, tende piedade de nós.\nCoração de Jesus, de majestade infinita, tende piedade de nós.\nCoração de Jesus, templo santo de Deus, tende piedade de nós.\nCoração de Jesus, tabernáculo do Altíssimo, tende piedade de nós.\nCoração de Jesus, casa de Deus e porta do Céu, tende piedade de nós.\nCoração de Jesus, fornalha ardente de caridade, tende piedade de nós.\nCoração de Jesus, santuário da justiça e do amor, tende piedade de nós.\nCoração de Jesus, cheio de bondade e de amor, tende piedade de nós.\nCoração de Jesus, abismo de todas as virtudes, tende piedade de nós.\nCoração de Jesus, digníssimo de todo o louvor, tende piedade de nós.\nCoração de Jesus, Rei e centro de todos os corações, tende piedade de nós.\nCoração de Jesus, em quem estão todos os tesouros da sabedoria e da ciência, tende piedade de nós.\nCoração de Jesus, em quem habita toda a plenitude da divindade, tende piedade de nós.\nCoração de Jesus, em quem o Pai põe todas as suas complacências, tende piedade de nós.\nCoração de Jesus, de cuja plenitude todos nós recebemos, tende piedade de nós.\nCoração de Jesus, desejo das colinas eternas, tende piedade de nós.\nCoração de Jesus, paciente e cheio de misericórdia, tende piedade de nós.\nCoração de Jesus, rico para todos os que Vos invocam, tende piedade de nós.\nCoração de Jesus, fonte de vida e de santidade, tende piedade de nós.\nCoração de Jesus, propiciação pelos nossos pecados, tende piedade de nós.\nCoração de Jesus, saturado de opróbrios, tende piedade de nós.\nCoração de Jesus, despedaçado por causa de nossos pecados, tende piedade de nós.\nCoração de Jesus, feito obediente até à morte, tende piedade de nós.\nCoração de Jesus, traspassado pela lança, tende piedade de nós.\nCoração de Jesus, fonte de toda consolação, tende piedade de nós.\nCoração de Jesus, nossa vida e ressurreição, tende piedade de nós.\nCoração de Jesus, nossa paz e reconciliação, tende piedade de nós.\nCoração de Jesus, vítima pelos pecadores, tende piedade de nós.\nCoração de Jesus, salvação dos que em Vós esperam, tende piedade de nós.\nCoração de Jesus, esperança dos que em Vós morrem, tende piedade de nós.\nCoração de Jesus, delícias de todos os Santos, tende piedade de nós.\n\nCordeiro de Deus, que tirais o pecado do mundo, perdoai-nos, Senhor.\nCordeiro de Deus, que tirais o pecado do mundo, ouvi-nos, Senhor.\nCordeiro de Deus, que tirais o pecado do mundo, tende piedade de nós.\n\n℣. Jesus manso e humilde de Coração.\n℟. Fazei o nosso coração semelhante ao Vosso.\n\nOremos:\nDeus onipotente e eterno, olhai para o Coração do vosso diletíssimo Filho, para os louvores e satisfações que em nome dos pecadores Vos tributa e, a quantos imploram a vossa misericórdia, concedei benigno o perdão, em nome do mesmo Jesus Cristo vosso Filho, que convosco vive e reina, na unidade do Espírito Santo. Amém.';

  @override
  String get litanyAllSaintsTitle => 'Ladainha de Todos os Santos';

  @override
  String get litanyAllSaintsContent =>
      'Senhor, tende piedade de nós.\nCristo, tende piedade de nós.\nSenhor, tende piedade de nós.\n\nCristo, ouvi-nos.\nCristo, atendei-nos.\n\nDeus Pai do Céu, tende piedade de nós.\nDeus Filho, Redentor do mundo, tende piedade de nós.\nDeus Espírito Santo, tende piedade de nós.\nSantíssima Trindade, que sois um só Deus, tende piedade de nós.\n\nSanta Maria, rogai por nós.\nSanta Mãe de Deus, rogai por nós.\nSanta Virgem das virgens, rogai por nós.\nSão Miguel, rogai por nós.\nSão Gabriel, rogai por nós.\nSão Rafael, rogai por nós.\nTodos os santos Anjos e Arcanjos, rogai por nós.\nTodas as santas ordens celestes, rogai por nós.\nSão João Batista, rogai por nós.\nSão José, rogai por nós.\nTodos os santos Patriarcas e Profetas, rogai por nós.\nSão Pedro, rogai por nós.\nSão Paulo, rogai por nós.\nSanto André, rogai por nós.\nSão Tiago, rogai por nós.\nSão João, rogai por nós.\nSão Tomé, rogai por nós.\nSão Tiago, rogai por nós.\nSão Filipe, rogai por nós.\nSão Bartolomeu, rogai por nós.\nSão Mateus, rogai por nós.\nSão Simão, rogai por nós.\nSão Tadeu, rogai por nós.\nSão Matias, rogai por nós.\nSão Barnabé, rogai por nós.\nSão Lucas, rogai por nós.\nSão Marcos, rogai por nós.\nTodos os santos Apóstolos e Evangelistas, rogai por nós.\nTodos os santos Discípulos do Senhor, rogai por nós.\nTodos os santos Inocentes, rogai por nós.\nSanto Estêvão, rogai por nós.\nSão Lourenço, rogai por nós.\nSão Vicente, rogai por nós.\nSantos Fabiano e Sebastião, rogai por nós.\nSantos João e Paulo, rogai por nós.\nSantos Cosme e Damião, rogai por nós.\nSantos Gervásio e Protásio, rogai por nós.\nTodos os santos Mártires, rogai por nós.\nSão Silvestre, rogai por nós.\nSão Gregório, rogai por nós.\nSanto Ambrósio, rogai por nós.\nSanto Agostinho, rogai por nós.\nSão Jerônimo, rogai por nós.\nSão Martinho, rogai por nós.\nSão Nicolau, rogai por nós.\nTodos os santos Bispos e Confessores, rogai por nós.\nTodos os santos Doutores, rogai por nós.\nSanto Antônio, rogai por nós.\nSão Bento, rogai por nós.\nSão Bernardo, rogai por nós.\nSão Domingos, rogai por nós.\nSão Francisco, rogai por nós.\nTodos os santos Sacerdotes e Levitas, rogai por nós.\nTodos os santos Monges e Eremitas, rogai por nós.\nSanta Maria Madalena, rogai por nós.\nSanta Ágata, rogai por nós.\nSanta Luzia, rogai por nós.\nSanta Inês, rogai por nós.\nSanta Cecília, rogai por nós.\nSanta Catarina, rogai por nós.\nSanta Anastácia, rogai por nós.\nTodas as santas Virgens e Viúvas, rogai por nós.\nTodos os Santos e Santas de Deus, intercedei por nós.\n\nSede-nos propício, perdoai-nos, Senhor.\nSede-nos propício, ouvi-nos, Senhor.\nDe todo o mal, livrai-nos, Senhor.\nDe todo o pecado, livrai-nos, Senhor.\nDa vossa ira, livrai-nos, Senhor.\nDa morte súbita e imprevista, livrai-nos, Senhor.\nDas insídias do demônio, livrai-nos, Senhor.\nDa ira, do ódio e de toda má vontade, livrai-nos, Senhor.\nDo espírito de impureza, livrai-nos, Senhor.\nDo raio e da tempestade, livrai-nos, Senhor.\nDo flagelo da terra, livrai-nos, Senhor.\nDa peste, da fome e da guerra, livrai-nos, Senhor.\nDa morte eterna, livrai-nos, Senhor.\n\nPelo mistério da vossa santa Encarnação, livrai-nos, Senhor.\nPela vossa vinda, livrai-nos, Senhor.\nPelo vosso Nascimento, livrai-nos, Senhor.\nPelo vosso Batismo e santo Jejum, livrai-nos, Senhor.\nPela vossa Cruz e Paixão, livrai-nos, Senhor.\nPela vossa Morte e Sepultura, livrai-nos, Senhor.\nPela vossa santa Ressurreição, livrai-nos, Senhor.\nPela vossa admirável Ascensão, livrai-nos, Senhor.\nPela vinda do Espírito Santo Consolador, livrai-nos, Senhor.\nNo dia do Juízo, livrai-nos, Senhor.\n\nNós, pecadores, nós Vos rogamos, ouvi-nos.\nQue nos perdoeis, nós Vos rogamos, ouvi-nos.\nQue nos conduzais à verdadeira penitência, nós Vos rogamos, ouvi-nos.\nQue Vos digneis governar e conservar a vossa santa Igreja, nós Vos rogamos, ouvi-nos.\nQue Vos digneis conservar na santa religião o Sumo Pontífice e todas as ordens eclesiásticas, nós Vos rogamos, ouvi-nos.\nQue Vos digneis humilhar os inimigos da santa Igreja, nós Vos rogamos, ouvi-nos.\nQue Vos digneis dar a paz e a verdadeira concórdia aos reis e príncipes cristãos, nós Vos rogamos, ouvi-nos.\nQue Vos digneis conceder a paz e a união a todo o povo cristão, nós Vos rogamos, ouvi-nos.\nQue Vos digneis chamar à unidade da Igreja todos os que andam transviados e conduzir todos os infiéis à luz do Evangelho, nós Vos rogamos, ouvi-nos.\nQue nos digneis confirmar e conservar no vosso santo serviço, nós Vos rogamos, ouvi-nos.\nQue elevais o nosso espírito ao desejo das coisas celestiais, nós Vos rogamos, ouvi-nos.\nQue retribuais a todos os nossos benfeitores os bens eternos, nós Vos rogamos, ouvi-nos.\nQue livreis as nossas almas, as de nossos irmãos, parentes e benfeitores, da eterna condenação, nós Vos rogamos, ouvi-nos.\nQue Vos digneis dar e conservar os frutos da terra, nós Vos rogamos, ouvi-nos.\nQue Vos digneis dar o eterno descanso a todos os fiéis defuntos, nós Vos rogamos, ouvi-nos.\nQue Vos digneis ouvir-nos, nós Vos rogamos, ouvi-nos.\nFilho de Deus, nós Vos rogamos, ouvi-nos.\n\nCordeiro de Deus, que tirais o pecado do mundo, perdoai-nos, Senhor.\nCordeiro de Deus, que tirais o pecado do mundo, ouvi-nos, Senhor.\nCordeiro de Deus, que tirais o pecado do mundo, tende piedade de nós.\n\nCristo, ouvi-nos.\nCristo, atendei-nos.\n\nSenhor, tende piedade de nós.\nCristo, tende piedade de nós.\nSenhor, tende piedade de nós.';

  @override
  String get litanyStJosephTitle => 'Ladainha de São José';

  @override
  String get litanyStJosephContent =>
      'Senhor, tende piedade de nós.\nCristo, tende piedade de nós.\nSenhor, tende piedade de nós.\n\nCristo, ouvi-nos.\nCristo, atendei-nos.\n\nDeus Pai do Céu, tende piedade de nós.\nDeus Filho, Redentor do mundo, tende piedade de nós.\nDeus Espírito Santo, tende piedade de nós.\nSantíssima Trindade, que sois um só Deus, tende piedade de nós.\n\nSanta Maria, rogai por nós.\nSão José, rogai por nós.\nIlustre descendente de Davi, rogai por nós.\nLuz dos Patriarcas, rogai por nós.\nEsposo da Mãe de Deus, rogai por nós.\nCustódio da Virgem, rogai por nós.\nPai nutrício do Filho de Deus, rogai por nós.\nSolícito defensor de Cristo, rogai por nós.\nChefe da sagrada Família, rogai por nós.\nJosé justíssimo, rogai por nós.\nJosé castíssimo, rogai por nós.\nJosé prudentíssimo, rogai por nós.\nJosé fortíssimo, rogai por nós.\nJosé obedientíssimo, rogai por nós.\nJosé fidelíssimo, rogai por nós.\nEspelho de paciência, rogai por nós.\nAmante da pobreza, rogai por nós.\nModelo dos operários, rogai por nós.\nEsplendor da vida doméstica, rogai por nós.\nGuarda das Virgens, rogai por nós.\nAmparo das famílias, rogai por nós.\nConsolo dos infelizes, rogai por nós.\nEsperança dos doentes, rogai por nós.\nPadroeiro dos moribundos, rogai por nós.\nTerror dos demônios, rogai por nós.\nProtetor da Santa Igreja, rogai por nós.\n\nCordeiro de Deus, que tirais o pecado do mundo, perdoai-nos, Senhor.\nCordeiro de Deus, que tirais o pecado do mundo, ouvi-nos, Senhor.\nCordeiro de Deus, que tirais o pecado do mundo, tende piedade de nós.\n\n℣. Constituiu-o senhor da sua casa.\n℟. E príncipe de todas as suas possessões.\n\nOremos:\nÓ Deus, que em vossa inefável providência vos dignastes escolher o bem-aventurado José para Esposo de vossa Mãe Santíssima, fazei, Vos rogamos, que tenhamos como intercessor no Céu aquele a quem, na Terra, veneramos como protetor. Vós, que viveis e reinais pelos séculos dos séculos. Amém.';

  @override
  String get litanyHolyNameTitle => 'Ladainha do Santíssimo Nome de Jesus';

  @override
  String get litanyHolyNameContent =>
      'Senhor, tende piedade de nós.\nCristo, tende piedade de nós.\nSenhor, tende piedade de nós.\n\nJesus, ouvi-nos.\nJesus, atendei-nos.\n\nDeus Pai do Céu, tende piedade de nós.\nDeus Filho, Redentor do mundo, tende piedade de nós.\nDeus Espírito Santo, tende piedade de nós.\nSantíssima Trindade, que sois um só Deus, tende piedade de nós.\n\nJesus, Filho do Deus vivo, tende piedade de nós.\nJesus, esplendor do Pai, tende piedade de nós.\nJesus, candor da luz eterna, tende piedade de nós.\nJesus, Rei da glória, tende piedade de nós.\nJesus, Sol de justiça, tende piedade de nós.\nJesus, Filho da Virgem Maria, tende piedade de nós.\nJesus, amável, tende piedade de nós.\nJesus, admirável, tende piedade de nós.\nJesus, Deus forte, tende piedade de nós.\nJesus, Pai do século futuro, tende piedade de nós.\nJesus, Anjo do grande conselho, tende piedade de nós.\nJesus, poderosíssimo, tende piedade de nós.\nJesus, pacientíssimo, tende piedade de nós.\nJesus, obedientíssimo, tende piedade de nós.\nJesus, manso e humilde de coração, tende piedade de nós.\nJesus, amante da castidade, tende piedade de nós.\nJesus, amante de todos nós, tende piedade de nós.\nJesus, Deus da paz, tende piedade de nós.\nJesus, autor da vida, tende piedade de nós.\nJesus, modelo das virtudes, tende piedade de nós.\nJesus, zeloso das almas, tende piedade de nós.\nJesus, nosso Deus, tende piedade de nós.\nJesus, nosso Refúgio, tende piedade de nós.\nJesus, Pai dos pobres, tende piedade de nós.\nJesus, tesouro dos fiéis, tende piedade de nós.\nJesus, bom Pastor, tende piedade de nós.\nJesus, luz verdadeira, tende piedade de nós.\nJesus, sabedoria eterna, tende piedade de nós.\nJesus, bondade infinita, tende piedade de nós.\nJesus, nosso Caminho e nossa Vida, tende piedade de nós.\nJesus, alegria dos Anjos, tende piedade de nós.\nJesus, Rei dos Patriarcas, tende piedade de nós.\nJesus, Mestre dos Apóstolos, tende piedade de nós.\nJesus, Doutor dos Evangelistas, tende piedade de nós.\nJesus, fortaleza dos Mártires, tende piedade de nós.\nJesus, luz dos Confessores, tende piedade de nós.\nJesus, pureza das Virgens, tende piedade de nós.\nJesus, coroa de todos os Santos, tende piedade de nós.\n\nSede-nos propício, perdoai-nos, Jesus.\nSede-nos propício, ouvi-nos, Jesus.\n\nDe todo o mal, livrai-nos, Jesus.\nDe todo o pecado, livrai-nos, Jesus.\nDa vossa ira, livrai-nos, Jesus.\nDas insídias do demônio, livrai-nos, Jesus.\nDo espírito de impureza, livrai-nos, Jesus.\nDa morte eterna, livrai-nos, Jesus.\nDo desprezo das vossas inspirações, livrai-nos, Jesus.\nPelo mistério da vossa santa Encarnação, livrai-nos, Jesus.\nPelo vosso Nascimento, livrai-nos, Jesus.\nPela vossa infância, livrai-nos, Jesus.\nPela vossa vida santíssima, livrai-nos, Jesus.\nPelos vossos trabalhos, livrai-nos, Jesus.\nPela vossa Agonia e Paixão, livrai-nos, Jesus.\nPela vossa Cruz e abandono, livrai-nos, Jesus.\nPelos vossos sofrimentos, livrai-nos, Jesus.\nPela vossa Morte e sepultura, livrai-nos, Jesus.\nPela vossa Ressurreição, livrai-nos, Jesus.\nPela vossa Ascensão, livrai-nos, Jesus.\nPela vossa instituição da Santíssima Eucaristia, livrai-nos, Jesus.\nPelas vossas alegrias, livrai-nos, Jesus.\nPela vossa glória, livrai-nos, Jesus.\n\nCordeiro de Deus, que tirais o pecado do mundo, perdoai-nos, Jesus.\nCordeiro de Deus, que tirais o pecado do mundo, ouvi-nos, Jesus.\nCordeiro de Deus, que tirais o pecado do mundo, tende piedade de nós, Jesus.\n\nJesus, ouvi-nos.\nJesus, atendei-nos.\n\nOremos:\nSenhor Jesus Cristo, que dissestes: Pedi e recebereis, buscai e encontrareis, batei e abrir-se-vos-á; concedei-nos, Vos pedimos, o afeto do vosso diviníssimo amor, para que Vos amemos de todo o coração, com palavras e obras, e nunca cessemos de Vos louvar. Fazei, Senhor, que tenhamos permanentemente o temor e o amor do vosso santo Nome, porque nunca deixais de governar aqueles a quem firmais solidamente no vosso amor. Vós, que viveis e reinais pelos séculos dos séculos. Amém.';

  @override
  String get litanySevenSorrowsTitle => 'Coroa de Nossa Senhora das Dores';

  @override
  String get litanySevenSorrowsContent =>
      'Deus, vinde em meu auxílio.\nSenhor, apressai-Vos em me socorrer.\n\nPai Nosso... 3 Ave Marias... Glória\n\nEstrofe: Na morte de Jesus, fazei que, em vossas dores, meu coração vos acompanhe, ó Mãe dos pecadores.\n\n— As Sete Dores de Maria —\n\n1ª DOR: A apresentação de Jesus no Templo e a profecia de Simeão\n\nContemplamos a dor de Nossa Senhora quando o santo velho Simeão lhe profetizou que uma espada de dor transpassaria a sua alma.\n\nReza-se: 7 Ave-Marias.\nEstrofe: Na morte de Jesus, fazei que, em vossas dores, meu coração vos acompanhe, ó Mãe dos pecadores.\n\n2ª DOR: A fuga para o Egito\n\nContemplamos a dor de Nossa Senhora quando teve que fugir para o Egito com o Menino Jesus e São José, para salvar a vida de seu Filho da perseguição de Herodes.\n\nReza-se: 7 Ave-Marias.\nEstrofe: Na morte de Jesus, fazei que, em vossas dores, meu coração vos acompanhe, ó Mãe dos pecadores.\n\n3ª DOR: A perda do menino Jesus no Templo\n\nContemplamos a dor de Nossa Senhora quando perdeu o Menino Jesus em Jerusalém por três dias, procurando-O com profunda aflição.\n\nReza-se: 7 Ave-Marias.\nEstrofe: Na morte de Jesus, fazei que, em vossas dores, meu coração vos acompanhe, ó Mãe dos pecadores.\n\n4ª DOR: O encontro com Jesus no caminho do calvário\n\nContemplamos a dor de Nossa Senhora ao encontrar o seu Divino Filho carregando a pesada cruz e ensanguentado a caminho do Calvário.\n\nReza-se: 7 Ave-Marias.\nEstrofe: Na morte de Jesus, fazei que, em vossas dores, meu coração vos acompanhe, ó Mãe dos pecadores.\n\n5ª DOR: Maria fica de pé junto à Cruz de Jesus\n\nContemplamos a dor de Nossa Senhora ao ver o seu Filho cravado na Cruz, permanecendo heroicamente de pé enquanto Ele expirava e morria por nossa salvação.\n\nReza-se: 7 Ave-Marias.\nEstrofe: Na morte de Jesus, fazei que, em vossas dores, meu coração vos acompanhe, ó Mãe dos pecadores.\n\n6ª DOR: O coração de Jesus é transpassado pela lança\n\nContemplamos a dor de Nossa Senhora quando a lança cruel transpassou o coração inanimado de seu Filho, abrindo uma profunda chaga em sua própria alma.\n\nReza-se: 7 Ave-Marias.\nEstrofe: Na morte de Jesus, fazei que, em vossas dores, meu coração vos acompanhe, ó Mãe dos pecadores.\n\n7ª DOR: Maria deposita Jesus no sepulcro\n\nContemplamos a dor e a profunda solidão de Nossa Senhora ao depositar o corpo sem vida de Jesus no sepulcro, despedindo-se Dele com imensa desolação.\n\nReza-se: 7 Ave-Marias.\nEstrofe: Na morte de Jesus, fazei que, em vossas dores, meu coração vos acompanhe, ó Mãe dos pecadores.\n\n— Oração Final —\n\n℣. Rogai por nós, Virgem Dolorosíssima.\n℟. Para que sejamos dignos das promessas de Cristo.\n\nOremos:\nDeus, em cuja Paixão, segundo a profecia de Simeão, uma espada de dor traspassou a dulcíssima alma da gloriosa Virgem e Mãe Maria, concedei-nos, propícios, que celebrando devotamente as suas dores, consigamos o feliz efeito da vossa Paixão. Por Cristo, Senhor nosso. Amém.';

  @override
  String get novenaTitle => 'Novenas';

  @override
  String get catNovenasTitle => 'Novenas';

  @override
  String get novenaSubtitle => 'Oração durante 9 dias';

  @override
  String get novenaStartButton => 'Iniciar Novena';

  @override
  String get novenaContinueButton => 'Continuar';

  @override
  String novenaDay(int day) {
    return 'Dia $day/9';
  }

  @override
  String get novenaDayLabel => 'Dia';

  @override
  String novenaScheduled(String date) {
    return 'Agendada: $date';
  }

  @override
  String get novenaCompleted => 'Concluída';

  @override
  String get novenaNotStarted => 'Não iniciada';

  @override
  String get novenaCancelTitle => 'Cancelar Novena';

  @override
  String get novenaCancelContent =>
      'Deseja cancelar esta novena? O progresso será perdido.';

  @override
  String get novenaCancelConfirm => 'Cancelar Novena';

  @override
  String get novenaCancelDismiss => 'Manter';

  @override
  String get novenaRestartTitle => 'Reiniciar Novena';

  @override
  String get quickPrayer => 'Oração rápida';

  @override
  String get backupTitle => 'Backup e Restauração';

  @override
  String get backupExportTitle => 'Exportar Dados';

  @override
  String get backupExportSubtitle => 'Salvar backup do jardim e orações';

  @override
  String get backupImportTitle => 'Importar Dados';

  @override
  String get backupImportSubtitle => 'Restaurar backup de arquivo';

  @override
  String get backupImportDialogTitle => 'Importar Backup';

  @override
  String get backupImportDialogContent =>
      'Atenção: Importar dados irá substituir os dados atuais. Deseja continuar?';

  @override
  String get backupImportConfirm => 'Importar';

  @override
  String get frequencyCustom => 'Personalizado';

  @override
  String get confessionReminderDaysCustomTitle => 'Frequência Personalizada';

  @override
  String get confessionReminderDaysCustomLabel => 'Dias';

  @override
  String get daysUnit => 'dias';

  @override
  String get saveButton => 'Salvar';

  @override
  String get dateLabel => 'Data';

  @override
  String get novenaRestartContent => 'Deseja recomeçar esta novena do dia 1?';

  @override
  String get novenaRestartConfirm => 'Recomeçar';

  @override
  String get novenaStartedMessage => 'Novena iniciada! Bom tempo de oração.';

  @override
  String get novenaPrayerInstruction =>
      '5 Pai-Nossos, 5 Ave-Marias e 5 Glórias ao Pai, em honra dos 15 anos de vida do servo de Deus nesta Terra.';

  @override
  String get novenaCompletedTitle => 'Novena Concluída!';

  @override
  String get novenaCompletedMessage => 'Você completou os 9 dias de oração.';

  @override
  String get subscriptionActive => 'Assinatura Ativa (Premium)';

  @override
  String get subscriptionManage => 'Gerenciar Assinatura';

  @override
  String get betaLabel => 'BETA';

  @override
  String get novenaCarloAcutisTitle => 'Novena a São Carlo Acutis';

  @override
  String get novenaCarloAcutisDesc => 'Padroeiro da juventude e da internet';

  @override
  String get novenaCarloAcutisIcon => 'computer';

  @override
  String get novenaCarloAcutisOpening =>
      'Ó Deus eterno e misericordioso, que manifestais a vossa glória na santidade dos pequenos e humildes, nós Vos louvamos pelas virtudes cristãs com que ornastes a vida de São Carlo Acutis. Pela sua intercessão, suplicamos humildemente que nos concedais a graça que ardentemente Vos pedimos nesta novena, se for para a vossa honra e salvação das nossas almas. (Faz-se o pedido). Por Cristo, Nosso Senhor. Amém.';

  @override
  String get novenaCarloAcutisClosing =>
      'Senhor Jesus Cristo, pão vivo descido do Céu, que fostes o centro da vida e o tesouro do coração de São Carlo Acutis, inflamai também as nossas almas no amor ao vosso Sacrário e na fidelidade à Santa Igreja. Pela intercessão de Maria Santíssima e de São Carlo Acutis, conservai-nos em vossa graça até a hora da morte. Amém.';

  @override
  String get novenaCarloAcutisDay1Title => '1º Dia - Amor a Deus acima de tudo';

  @override
  String get novenaCarloAcutisDay1Meditation =>
      'São Carlo Acutis, que desde a infância colocastes a vontade divina acima dos desejos terrenos, alcançai-nos o desapego do mundo e o desejo sincero de agradar somente a Deus. Amém.';

  @override
  String get novenaCarloAcutisDay2Title => '2º Dia - União constante com Jesus';

  @override
  String get novenaCarloAcutisDay2Meditation =>
      'São Carlo Acutis, que fizestes da amizade com Nosso Senhor a regra de cada instante do vosso dia, obtende-nos a graça da presença de Deus em todas as nossas ações. Amém.';

  @override
  String get novenaCarloAcutisDay3Title =>
      '3º Dia - Devoção ao Santo Anjo da Guarda';

  @override
  String get novenaCarloAcutisDay3Meditation =>
      'São Carlo Acutis, que cultivastes filial confiança nos santos Anjos enviados por Deus para nos guardar, ensinai-nos a ouvir o nosso Anjo da Guarda e a evitar toda ocasião de pecado. Amém.';

  @override
  String get novenaCarloAcutisDay4Title =>
      '4º Dia - Pureza de alma e Confissão frequente';

  @override
  String get novenaCarloAcutisDay4Meditation =>
      'São Carlo Acutis, que buscáveis com assiduidade o sacramento da Penitência para manter limpa a veste batismal, alcançai-nos verdadeira contrição e firme propósito de emenda. Amém.';

  @override
  String get novenaCarloAcutisDay5Title =>
      '5º Dia - Alegria que nasce da contemplação';

  @override
  String get novenaCarloAcutisDay5Meditation =>
      'São Carlo Acutis, que encontrastes na oração e no esquecimento de si a verdadeira alegria cristã, livrai-nos do egoísmo e voltai os nossos olhos para os bens eternos. Amém.';

  @override
  String get novenaCarloAcutisDay6Title =>
      '6º Dia - Desejo ardente da santidade';

  @override
  String get novenaCarloAcutisDay6Meditation =>
      'São Carlo Acutis, que nada mais pedistes a Deus senão corresponder fielmente à vocação à santidade, acendei em nós a fome e a sede da perfeição evangélica. Amém.';

  @override
  String get novenaCarloAcutisDay7Title =>
      '7º Dia - Piedade filial à Virgem Maria';

  @override
  String get novenaCarloAcutisDay7Meditation =>
      'São Carlo Acutis, que honrastes todos os dias a Mãe de Deus com a recitação devota do Santo Rosário, alcançai-nos uma terna confiança na proteção materna de Maria. Amém.';

  @override
  String get novenaCarloAcutisDay8Title =>
      '8º Dia - Fervor diante da Santíssima Eucaristia';

  @override
  String get novenaCarloAcutisDay8Meditation =>
      'São Carlo Acutis, que adoráveis Jesus realmente presente no Santíssimo Sacramento e propagastes a fé nos milagres eucarísticos, aumentai em nós a fé viva no Altar. Amém.';

  @override
  String get novenaCarloAcutisDay9Title =>
      '9º Dia - Caridade para com os pobres e perseverança final';

  @override
  String get novenaCarloAcutisDay9Meditation =>
      'São Carlo Acutis, que socorrestes os necessitados e oferecestes vossos últimos sofrimentos pela Igreja e pelo Papa, alcançai-nos a graça da perseverança final e de uma santa morte. Amém.';

  @override
  String get novenaOpeningPrayerLabel => 'ORAÇÃO INICIAL';

  @override
  String get novenaMeditationLabel => 'MEDITAÇÃO DO DIA';

  @override
  String get novenaPrayersLabel => 'ORAÇÕES';

  @override
  String get novenaClosingPrayerLabel => 'ORAÇÃO FINAL';

  @override
  String get novenaTeresaTitle => 'Novena das Rosas';

  @override
  String get novenaTeresaDesc => 'Santa Teresinha do Menino Jesus';

  @override
  String get novenaTeresaOpening =>
      'Santíssima Trindade, Pai, Filho e Espírito Santo, eu Vos agradeço todos os favores, todas as graças com que enriquecestes a alma de Vossa serva Teresa do Menino Jesus durante os 24 anos que passou na Terra. Pelos méritos de tão querida santinha, concedei-me a graça que ardentemente Vos peço (fazer o pedido), se for conforme a Vossa Santíssima vontade e para salvação de minha alma. Ajudai minha fé e minha esperança, ó Santa Teresinha, cumprindo, mais uma vez, sua promessa de que ninguém vos invocaria em vão, fazendo-me ganhar uma rosa, sinal de que alcançarei a graça pedida.';

  @override
  String get novenaTeresaPrayers =>
      'Em seguida, reza-se 24 vezes: Glória ao Pai, ao Filho e ao Espírito Santo, assim como era no princípio, agora e sempre, por todos os séculos dos séculos. Amém!\n\nA cada Glória ao Pai pode-se acrescentar a jaculatória:\n\nSanta Teresinha do Menino Jesus, rogai por nós!\n\nOremos:\nPai-Nosso e Ave-Maria.';

  @override
  String get novenaTeresaDay1Title =>
      '\"Para mim, a oração é um impulso do coração, um simples olhar dirigido para o Céu, um grito de agradecimento e de amor, tanto em meio ao sofrimento como em meio a alegria. Em uma palavra, é algo grande, algo sobrenatural que me dilata a alma e me une a Jesus.\"';

  @override
  String get novenaTeresaDay2Title =>
      '\"O mérito não consiste em fazer nem em dar muito, mas, antes, em receber, em amar muito!\"';

  @override
  String get novenaTeresaDay3Title =>
      '\"O que me impulsiona a ir para o Céu é o pensamento de poder acender no amor de Deus uma multidão de almas que O louvarão eternamente.\"';

  @override
  String get novenaTeresaDay4Title =>
      '\"Como é grande o poder da oração! É como uma rainha que em todo o momento tem acesso direto ao rei e pode conseguir tudo o que lhe pede.\"';

  @override
  String get novenaTeresaDay5Title =>
      '\"Não prefiro nem morrer nem viver… O que o Bom Deus prefere e escolhe para mim, eis o que me agrada mais.\"';

  @override
  String get novenaTeresaDay6Title =>
      '\"Depois da minha morte, farei cair do Céu uma chuva de rosas.\"';

  @override
  String get novenaTeresaDay7Title =>
      '\"Quando eu chegar ao Céu, quantas graças vou pedir para vocês! Atormentarei tanto a Nosso Senhor que, se Ele a princípio pensar em me recusar, minha insistência vai obrigá-lo a atender meus desejos.\"';

  @override
  String get novenaTeresaDay8Title =>
      '\"A caridade não deve consistir em simples sentimentos, mas em obras.\"';

  @override
  String get novenaTeresaDay9Title =>
      '\"Quero passar o Céu, a fazer bem sobre a Terra. Não olharei para as almas somente, mas hei de descer para junto delas. Vai começar a minha missão que é ensinar os homens a amar a Deus como eu O amo. Só descansarei no fim do mundo quando estiver completo o número dos eleitos.\"';

  @override
  String get novenaSagradoCoracaoTitle => 'Novena ao Sagrado Coração';

  @override
  String get novenaSagradoCoracaoDesc => 'Em honra ao Coração de Jesus';

  @override
  String get novenaSagradoCoracaoOpening =>
      'Lembrai-vos, ó dulcíssimo Jesus, que nunca se ouviu dizer que alguém, recorrendo com confiança ao vosso Sagrado Coração, implorando vossa divina assistência e reclamando a vossa infinita misericórdia, fosse por Vós abandonado. Possuído, pois, e animado da mesma confiança, ó Coração Sagrado de Jesus, Rei de todos os corações, recorro a Vós, e gemendo sob o peso de meus pecados, me prostro diante de Vós. Meu Jesus, pelo vosso precioso Sangue e pelo amor de vosso divino Coração, não desprezeis as minhas súplicas, mas ouvi-as favoravelmente e dignai-vos atender-me. Amém.';

  @override
  String get novenaSagradoCoracaoClosing =>
      'Dulcíssimo Coração de Jesus, vosso precioso Sangue é a vida da minha alma; só em Vós quero viver, só a Vós quero amar e servir. Pela sede ardente que vos abrasa de me salvar, iluminai o meu espírito com a luz de vossa divina graça. Santificai o meu coração, fortalecei a minha vontade, perdoai os meus pecados e curai todas as minhas misérias. Aumentai minha fé, fortificai a minha esperança e acendei em mim cada vez mais o fogo do vosso santo amor. Concedei-me, enfim, todas as graças que espero alcançar com esta novena. Ó dulcíssimo Jesus, vivei em mim agora e por todo o sempre. Amém.\n\n℣. Doce Coração de Jesus,\n℟. fazei que eu vos ame cada vez mais!';

  @override
  String get novenaSagradoCoracaoPrayers =>
      'Pai-nosso, Ave-Maria e Glória.\n\n℣. Jesus, manso e humilde de coração,\n℟. Fazei o nosso coração semelhante ao vosso.';

  @override
  String get novenaSagradoCoracaoDay1Title =>
      'Coração de Jesus, Templo da Santíssima Trindade';

  @override
  String get novenaSagradoCoracaoDay1Meditation =>
      'Pondera, alma minha, como o Coração de Jesus foi o templo mais sagrado que neste mundo teve a Trindade Santíssima e Beatíssima. Um só ato de amor ou de reverência, ou de adoração, ou de outra qualquer virtude que saiu deste Coração unido à Pessoa do divino Verbo era para Deus de estima infinitamente maior que todos os atos que podiam formar todas as criaturas do mundo, ainda que todas fossem abrasados serafins. Considera, pois, alma minha, que aumentos de glória teria a Santíssima Trindade com as adorações e louvores que Jesus Cristo lhe deu neste templo? E se tu, alma minha, também deves ser templo da Santíssima Trindade pela graça, pede a este Senhor que faça o teu coração conforme a este ardentíssimo Coração.';

  @override
  String get novenaSagradoCoracaoDay2Title =>
      'Coração de Jesus, Artífice do Santíssimo Sacramento';

  @override
  String get novenaSagradoCoracaoDay2Meditation =>
      'Pondera, alma minha, que do soberano Coração de Jesus saiu o Diviníssimo Sacramento, onde temos depositado o Sangue sacratíssimo que manou do seu lado; e foi tal a fineza do Coração de Jesus, disse o Senhor a uma serva sua, que, se não se deixara no Santíssimo Sacramento, não poderia morrer na Cruz. Tão apegado estava aquele amante Coração aos homens que, impaciente de ausências, vendo que havia de partir para o Pai, inventou esta indústria amorosa de partir e ficar juntamente, de glorificar os santos no Céu e nos fazer companhia na terra. Considera, alma minha, quanto deves ao abrasado Coração do teu Senhor, e confunde-te de tão pouco lhe agradeceres por realizar, com a instituição do Santíssimo Sacramento, a ideia de boa obra em que Ele te comunica infinitos bens.';

  @override
  String get novenaSagradoCoracaoDay3Title =>
      'Coração de Jesus, Sarça de penetrantes espinhos';

  @override
  String get novenaSagradoCoracaoDay3Meditation =>
      'Pondera, alma minha, que desde que principiaram neste Coração os alentos da vida, até que se exalaram na morte, nunca viveu sem penas este inocente Coração, porque, como, logo que esteve animado, aceitou o preceito de padecer pelos homens, logo com a vida principiaram suas penas. Antes que chegassem os tormentos exteriores, Jesus tolerava interiormente as penas, vendo as grandes ofensas que os homens faziam ao seu Eterno Pai. No Horto foi tão viva a representação de suas penas, que rompeu-se-lhe o sangue por todos os poros. E se as penas somente consideradas causaram-lhe tanta amargura, que seriam quando verdadeiramente padecidas? Confunde-te, alma minha, da tibieza com que amas este Divino Coração, e da negligência com que não o imitas, pois tanto te repugna padecer, e tanto foges de mortificar-te.';

  @override
  String get novenaSagradoCoracaoDay4Title =>
      'Coração de Jesus, Fornalha abrasadíssima de caridade';

  @override
  String get novenaSagradoCoracaoDay4Meditation =>
      'Pondera, alma minha, que o extremo com que este Sagrado Coração amou e ama a Deus, só o mesmo Deus o pode compreender. O peito era fornalha de incêndios, o Coração era mina de labaredas que subiam tão alto, que lá iam rematar em Deus. Veio à terra este ardentíssimo Coração para lhe pôr fogo, e sendo o mundo tão grande, ainda sobrariam incêndios, se o mundo fôra infinitas vezes maior. As raras finezas que o Senhor obrou por nós e os contínuos benefícios que nos está fazendo, tudo são chamas que continuamente saem dessa fornalha de abrasadíssima caridade. E é possível, alma minha, que vendo o teu coração rodeado de tantas chamas quantos são os benefícios que recebes do Coração de Jesus, ainda esteja tão fria e tíbia?';

  @override
  String get novenaSagradoCoracaoDay5Title =>
      'Coração de Jesus, Paraíso de delícias celestiais';

  @override
  String get novenaSagradoCoracaoDay5Meditation =>
      'Pondera, alma minha, que neste suavíssimo Coração se encerram todas as delícias do Paraíso. Ele é o mar onde elas entram, e de onde saem todos os rios dos divinos regalos; entram nele, comunicados por Deus, e saem dele para deliciarem as almas justas. No paraíso deste Coração deu o Senhor entrada a muitos santos que se singularizaram em virtudes eminentes, e vendo-se eles quase submergidos em um mar de consolações, pediam ao Senhor que os moderasse, porque sem desfalecerem não podiam suportar abundância tão excessiva. Pobre de ti, alma minha, que tão pouco participas destas riquezas! Mas de que te admiras, se tu não amas aquele centro de amor? Aprende tu a amá-lo, e far-te-ás digna das delícias deste paraíso.';

  @override
  String get novenaSagradoCoracaoDay6Title =>
      'Coração de Jesus, Tesouro riquíssimo de graças';

  @override
  String get novenaSagradoCoracaoDay6Meditation =>
      'Pondera, alma minha, que assim como o tesouro é um agregado de muitas riquezas, também o Coração de Jesus é um depósito de infinitas graças. Aqui acharás uma inocência suma, uma humildade profundíssima, uma fortaleza imensa, uma sabedoria infinda; e enfim, para fazeres conceito das graças e riquezas deste tesouro, hás de primeiro considerar quem as comunicou e a quem se comunicaram. O Eterno Pai foi quem as comunicou, e o Filho de Deus foi a quem se comunicaram. E tendo o Eterno Pai uma liberalidade infinita, que graças não receberia o Filho de Deus desta infinita liberalidade? Aqui se perde o juízo e aqui se abisma a consideração humana. Alma minha, se as graças deste tesouro são tantas, ama tu a este Coração para poderes participar das suas riquezas.';

  @override
  String get novenaSagradoCoracaoDay7Title =>
      'Coração de Jesus, Abismo de imensa piedade';

  @override
  String get novenaSagradoCoracaoDay7Meditation =>
      'Pondera, alma minha, que é tão piedoso este amante Coração, que a ninguém nega sua piedade; tanto que, se alguma alma aflita recorre a Ele com viva fé, logo acode a consolá-la com seu remédio; tanto que, quando vê algum atribulado, logo corre, piedoso, com seu afeto para o socorrer. Vendo-se ofendido com as nossas culpas, dissimula tudo, e espera o nosso arrependimento para nos perdoar. Se depois de arrependidos tornamos a cair nas mesmas misérias, ainda não cansa a sua paciência, ainda não esgota a sua misericórdia, ainda não fecha as portas da sua piedade, mas antes nos busca com auxílios e nos chama com repetidas inspirações, e se nos voltamos para Ele, logo se alegra e se põe bem conosco. E crendo tu, alma minha, tudo isto, não morres de amor por este Coração?';

  @override
  String get novenaSagradoCoracaoDay8Title =>
      'Coração de Jesus, Atrativo dos nossos corações';

  @override
  String get novenaSagradoCoracaoDay8Meditation =>
      'Pondera, alma minha, o que disse Nosso Senhor: que só depois de ser exaltado na Cruz, e não antes, é que lhe abririam o lado, ficando assim patente o seu amante Coração. Porque julgou o Senhor que quem pusesse os olhos nele, atraído por uma suavíssima violência, certissimamente se havia de render. E se tu, alma minha, te não rendes, é porque não pões nele os olhos. Se tu viras que deste Coração manam as celestes verdades, com que se afugentam as trevas das culpas; se tu viras que dele mana o fogo que abrasa as almas frias, as luzes que desterram as nossas ignorâncias, as misericórdias que lavam as nossas culpas, as doçuras, os auxílios, as inspirações... e enfim, se viras que deste Coração mana todo o bem, deixarias tu, alma minha, de amar este Coração? Deixarias de ficar presa em laços de tanto amor?';

  @override
  String get novenaSagradoCoracaoDay9Title =>
      'Coração de Jesus, Penhor de vida eterna';

  @override
  String get novenaSagradoCoracaoDay9Meditation =>
      'Pondera, alma minha, que assim como o coração humano é o princípio da vida temporal, assim o Coração de Jesus é para nós o princípio da vida eterna; porque, se para a vida eterna é necessário o perdão das culpas e a remissão dos pecados, saindo deste Coração sangue e água, e tendo nós o Sangue de Cristo como fundamento de nossa redenção, e na água uma representação do Batismo, sem o qual ninguém entra na glória, segue-se daqui que este Coração é a porta por onde todos entram para a vida eterna. Assim como Deus lá no Paraíso deu a vida ao homem com um sopro, também com um outro sopro infundiu Cristo nos seus discípulos a graça do Espírito Santo, porque, como o hálito da boca sai do coração, quis Cristo mostrar que do seu Coração é que nos vem a graça. Pois, alma minha, se tu crês tudo isto, sabe, que se amares a este Divino Coração, e o imitares, alcançarás a graça, e conseguirás a glória na vida eterna.';

  @override
  String get novenaConceicaoTitle => 'Novena à Imaculada Conceição';

  @override
  String get novenaConceicaoDesc =>
      'Novena tradicional a Nossa Senhora da Conceição';

  @override
  String get novenaConceicaoOpening =>
      'Vinde, Espírito Santo, enchei o coração dos vossos fiéis e acendei neles o fogo do vosso amor.\n℣. Enviai o vosso Espírito, e tudo será criado.\n℟. E renovareis a face da terra.\n\nOremos.\nÓ Deus, que instruístes os corações dos vossos fiéis com a luz do Espírito Santo, concedei-nos amar, no mesmo Espírito, o que é reto e gozar sempre a sua consolação. Por Cristo, Senhor nosso. Amém.\n\nÓ Virgem puríssima concebida sem pecado, desde o primeiro instante toda bela e sem mancha. Ó gloriosa Maria, cheia de graça e Mãe de meu Deus, Rainha dos anjos e dos homens. Humildemente vos venero como Mãe do meu Salvador, que, sendo Deus, me ensinou com sua estima, respeito e submissão a vós a honra e a homenagem que vos devo prestar. Dignai-vos acolher-me a mim, que nesta novena a vós me consagro. Sendo vós refúgio seguro dos pecadores arrependidos, tenho razão para recorrer a vós; sendo Mãe de misericórdia, não podeis não vos compadecer de minha miséria; sendo, depois de Jesus Cristo, toda a minha esperança, não podeis não vos agradar da tenra confiança que em vós tenho. Fazei-me digno de chamar-me vosso filho, a fim de que possa dizer com confiança: Mostrais que sois Mãe.';

  @override
  String get novenaConceicaoClosing =>
      '℣. Toda bela sois, Maria.\n℟. Toda bela sois, Maria.\n℣. E sem a mancha original.\n℟. E sem a mancha original.\n℣. Sois a glória de Jerusalém.\n℟. Sois a alegria de Israel.\n℣. Sois a honra do nosso povo.\n℟. Sois a Advogada dos pecadores.\n℣. Ó Maria.\n℟. Ó Maria.\n℣. Virgem prudentíssima.\n℟. Mãe clementíssima.\n℣. Rogai por nós.\n℟. Intercedei por nós ao Senhor Jesus Cristo.\n\n℣. Em vossa Conceição, ó Virgem, fostes imaculada.\n℟. Rogai por nós ao Pai cujo Filho destes à luz.\n\nOremos.\nÓ Deus, que pela Imaculada Conceição da Virgem Maria preparastes uma digna morada para o vosso Filho e em atenção aos méritos futuros da morte de Cristo a preservastes de toda mancha, concedei-nos, por sua intercessão, a graça de chegarmos purificados junto de Vós.\nÓ Deus, pastor e guia de todos os fiéis, olhai propício para o vosso servo o Papa, que constituístes pastor de vossa Igreja; dai-lhe, nós vos pedimos, servir por palavra e exemplo aqueles a quem governa, a fim de alcançar a vida eterna com o rebanho que lhe foi confiado.\nÓ Deus, nosso refúgio e fortaleza, ouvi as piedosas súplicas de vossa Igreja, Vós que sois o autor da piedade, e concedei-nos alcançar eficazmente o que com confiança vos pedimos. Por Cristo, Senhor nosso. Amém.';

  @override
  String get novenaConceicaoPrayers => 'Rezar uma Ave-Maria e um Glória.';

  @override
  String get novenaConceicaoDay1Title => 'Primeiro Dia';

  @override
  String get novenaConceicaoDay1Meditation =>
      'Eis-me aqui aos vossos pés santíssimos, ó Virgem Imaculada. Alegro-me grandemente convosco, eleita desde a eternidade para ser Mãe do Verbo eterno e preservada da culpa original. Dou graças e bendigo à Santíssima Trindade, que vos enriqueceu com este privilégio em vossa Conceição, e suplico-vos humildemente que me alcanceis a graça de vencer as tristes sequelas que em mim deixou o pecado original. Fazei que eu as supere e não deixe mais de amar ao meu Deus.';

  @override
  String get novenaConceicaoDay2Title => 'Segundo Dia';

  @override
  String get novenaConceicaoDay2Meditation =>
      'Ó Maria, lírio imaculado de pureza, alegro-me convosco, que desde o primeiro instante de vossa Conceição fostes cumulada de graça e recebestes o uso perfeito da razão. Dou graças e adoro à Santíssima Trindade, que vos concedeu dons tão sublimes. Confundo-me todo diante de vós, vendo-me tão pobre de graça. Vós, que fostes plenamente cumulada de graça celeste, fazei-me participar e compartilhar dos tesouros de vossa Imaculada Conceição.';

  @override
  String get novenaConceicaoDay3Title => 'Terceiro Dia';

  @override
  String get novenaConceicaoDay3Meditation =>
      'Ó Maria, rosa mística de pureza, alegro-me convosco, que em vossa Imaculada Conceição triunfastes gloriosamente da serpente infernal e fostes concebida sem a mancha do pecado original. Dou graças e louvo com todo o coração à Santíssima Trindade, que vos concedeu tal privilégio, e vos suplico que me alcanceis a força para superar todas as insídias do inimigo infernal e não manchar com o pecado a minha alma. Ajudai-me sempre e fazei-me, com vossa proteção, triunfar sempre do inimigo comum de nossa eterna salvação.';

  @override
  String get novenaConceicaoDay4Title => 'Quarto Dia';

  @override
  String get novenaConceicaoDay4Meditation =>
      'Ó Imaculada Virgem Maria, espelho de pureza, encho-me de sumo gozo ao ver que vos foram infusos desde a vossa Conceição os dons mais sublimes e perfeitos de virtude e também todos os dons do Espírito Santo. Dou graças e louvo à Santíssima Trindade, que vos favoreceu com estes privilégios, e vos suplico, ó Mãe benigna, que me alcanceis a prática da virtude e a graça de tornar-me digno de receber os dons e a graça do Espírito Santo.';

  @override
  String get novenaConceicaoDay5Title => 'Quinto Dia';

  @override
  String get novenaConceicaoDay5Meditation =>
      'Ó Maria, lua reluzente de pureza, alegro-me convosco, pois o mistério de vossa Imaculada Conceição foi o início da salvação de todo o gênero humano e a alegria do mundo inteiro. Dou graças e bendigo à Santíssima Trindade, que assim vos engrandeceu e glorificou, e vos suplico que me alcanceis a graça de saber aproveitar-me da paixão e morte do vosso Jesus. Que não seja para mim inútil o Sangue derramado na cruz, mas que eu viva santamente e me salve.';

  @override
  String get novenaConceicaoDay6Title => 'Sexto Dia';

  @override
  String get novenaConceicaoDay6Meditation =>
      'Ó Maria Imaculada, estrela esplendorosa de pureza, alegro-me convosco, porque a vossa Imaculada Conceição foi motivo de grandíssima alegria para todos os anjos do paraíso. Dou graças e bendigo à Santíssima Trindade, que vos enriqueceu de tão belo privilégio. Fazei-me entrar um dia nesta alegria e poder, na companhia dos anjos, louvar-vos e bendizer-vos eternamente.';

  @override
  String get novenaConceicaoDay7Title => 'Sétimo Dia';

  @override
  String get novenaConceicaoDay7Meditation =>
      'Ó Maria Imaculada, aurora nascente de pureza, alegro-me convosco, admirado de que no momento mesmo de vossa Conceição fostes confirmada em graça e tornada impecável. Dou graças e exalto à Santíssima Trindade, que vos distinguiu somente a vós com este particular privilégio. Impetrai-me, ó Virgem santa, um total e contínuo horror ao pecado, mais do que a qualquer outro mal, e que eu prefira antes morrer que voltar a pecar.';

  @override
  String get novenaConceicaoDay8Title => 'Oitavo Dia';

  @override
  String get novenaConceicaoDay8Meditation =>
      'Ó Virgem Maria, sol sem mancha, alegro-me convosco, cheio de gozo por terdes recebido de Deus em vossa Conceição uma graça maior e mais copiosa que a alcançada por todos os anjos e santos no auge de seus méritos. Dou graças à Santíssima Trindade, admirado da suma beneficência com que vos dispensou este privilégio. Fazei-me corresponder à graça divina e a dela não mais abusar. Transformai-me o coração e fazei que eu me arrependa desde agora de minhas culpas.';

  @override
  String get novenaConceicaoDay9Title => 'Nono Dia';

  @override
  String get novenaConceicaoDay9Meditation =>
      'Ó Maria, Virgem Imaculada, luz viva de santidade, exemplo de pureza e Mãe minha. Vós, apenas concebida, adorastes profundamente a Deus e lhe rendestes graças, já que por meio de vós, desfeita a antiga maldição, derramou-se a maior bênção sobre os filhos de Adão. Fazei que esta bênção acenda em meu coração um amor ardente a Deus. Inflamai-o vós, para que eu o ame constantemente e dele goze depois para sempre no paraíso, onde poderei dar-lhe graças mais ardentemente pelos singulares privilégios que vos concedeu e gozar de vós coroada de tanta glória.';

  @override
  String get novenaNatalTitle => 'Novena de Natal';

  @override
  String get novenaNatalDesc =>
      'Meditações de Santo Afonso de Ligório. Uma preparação profunda para receber o Menino Jesus.';

  @override
  String get novenaNatalOpening =>
      'Cântico Inicial: Puer Natus\n(Ou outro cântico de Natal)';

  @override
  String get novenaNatalClosing =>
      'Cântico Final: Adeste Fideles\n(Ou outro cântico de Natal)';

  @override
  String get novenaNatalPrayers =>
      'Ao final da meditação e oração, reza-se o Terço e a Ladainha de Nossa Senhora.';

  @override
  String get novenaNatalDay1Title => 'Primeiro Dia - 16 de Dezembro';

  @override
  String get novenaNatalDay1Meditation =>
      'DEUS NOS DEU SEU FILHO UNIGÊNITO POR SALVADOR\n\nEu te constitui em luz para os gentios, para que minha salvação chegue até os confins da terra. (Is. 49, 6)\n\nConsideremos como o Pai eterno disse ao Menino Jesus no instante de sua concepção estas palavras: Filho, eu te dei ao mundo como luz e vida das gentes, para que busques sua salvação, que estimo tanto como se fosse a minha. É necessário, pois, que te empenhes completamente em benefício dos homens. \'Dado completamente aos homens, e inteiramente entregue a suas necessidades\'. É necessário que ao nascer padeças extrema pobreza, para que o homem se enriqueça; é necessário que sejas vendido como escravo, para que o homem seja livre; é necessário que, como escravo, sejas açoitado e crucificado, para pagar à minha justiça a pena devida pelos homens; é necessário que sacrifiques sangue e vida, para livrar o homem da morte eterna. Fica sabendo, enfim, que já não és teu, mas do homem. Pois um filho lhes nasceu, e um menino lhes foi dado. Assim amado Filho meu, o homem voltará a amar-me a ser meu, vendo que te dou inteiramente a ele, meu Filho Unigênito, e que já não me resta mais o que lhe possa dar.\n\nAssim amou Deus - oh, amor infinito, digno somente de um Deus infinito - assim amou Deus o mundo de tal forma, que lhe entregou seu Filho Unigênito. O Menino Jesus não se entristeceu com esta proposta, mas, ao contrário, comprazeu-se nela e a aceitou com amor e alegria: \'como um esposo procedente de seu tálamo, exultou como gigante a percorrer seu caminho\' (Sl. 18,6). E desde o primeiro momento de sua encarnação se entregou por completo ao homem e abraçou com gosto todas as dores e ignomínias que havia de sofrer na terra por amor dos homens. Esses foram, segundo São Bernardo, as colinas e vales que com tanta pressa devia atravessar Jesus Cristo, segundo o Cântico dos Cânticos, para salvar os homens. Ei-lo que vem saltando pelas montanhas, brincando pelas colinas.\n\nReflitamos aqui como o Pai, enviando-nos seu Filho para ser nosso Redentor e para selar a paz entre Ele e os homens, obrigou-se de certo modo a perdoar-nos e a amar-nos, em razão do pacto que fez de receber-nos em sua graça, posto que o Filho satisfaz por nós a justiça divina. Por sua vez, o Verbo divino, tendo aceito a missão que lhe foi dada pelo Pai, o qual, enviando-o para redimir-nos no-lo deu, obrigou-se também a amar-nos, não por nossos méritos, mas para cumprir a piedosa vontade de seu Pai.';

  @override
  String get novenaNatalDay2Title => 'Segundo Dia - 17 de Dezembro';

  @override
  String get novenaNatalDay2Meditation =>
      'AFLIÇÃO DO CORAÇÃO DE JESUS NO SEIO DE MARIA\n\nHóstias e oblações não quisestes, mas formastes-me um corpo. (Hebr. 10,5)\n\nConsidera a grande amargura com que devia sentir-se afligido e oprimido o coração do Menino Jesus no seio de Maria, naquele primeiro instante em que o Pai lhe propôs a série de desprezos, trabalhos e agonias que havia de sofrer em sua vida para libertar os homens de suas misérias: \'Pela manhã chama a meus ouvidos..., não retrocedi..., entreguei meu corpo aos que me feriam\' (Is. 50, 4-6). Assim falou Jesus pela boca do Profeta: \'Pela manhã...\', quer dizer, desde o primeiro instante de minha concepção, meu Pai me fez compreender sua vontade: que eu tivesse uma vida de sofrimento e fosse, finalmente, sacrificado na cruz; \'não retrocedi; entreguei meu corpo aos que me feriam\'. E tudo aceitei pela salvação das almas e, desde então, entreguei meu corpo aos açoites, aos cravos, e à morte.\n\nPondera então quanto padeceu Jesus Cristo em sua vida e em sua paixão; tudo lhe foi posto ante os olhos desde o seio de sua Mãe e tudo Ele abraçou com amor; mas, ao consentir nessa aceitação e vencer a natural repugnância dos sentidos, quanta angústia e opressão não teve que sofrer o inocente Coração de Jesus! Conhecia bem o que primeiramente tinha que padecer; os sofrimentos e opróbrios do nascimento numa fria gruta, estábulo de animais; os trinta anos de trabalho como artesão; o considerar que seria tratado pelos homens como ignorante, escravo, sedutor e réu da morte mais infame e dolorosa que se reservava aos criminosos.\n\nTudo aceitou nosso amável Redentor a cada momento, e a cada momento em que o aceitava, padecia reunidas todas as penas a abatimentos que depois padeceria até sua morte. O próprio conhecimento de sua dignidade divina contribuía para que sentisse mais as injúrias recebidas dos homens: \'Tenho sempre presente a minha ignomínia\'. Continuamente teve diante dos olhos sua vergonha, especialmente a confusão que sentiria ao ver-se um dia despido, açoitado, pregado com três cravos de ferro, entregando assim sua vida entre vitupérios e maldições daqueles que se beneficiavam com sua morte. \'Feito obediente até a morte e morte de cruz\' (Phil. 2,8) e para quê? Para salvar-nos, a nós, míseros e ingratos pecadores.\n\nORAÇÃO\nAmado Redentor nosso, quanto vos custou desde que entrastes no mundo, tirar-nos do abismo em que nosso pecados nos haviam submergido. Para livrar-nos da escravidão do demônio, ao qual nós mesmos nos vendemos voluntariamente, aceitastes ser tratado como o pior dos escravos; e, nós que o sabíamos, tantas vezes tivemos a ousadia de amargurar vosso amabilíssimo Coração, que tanto nos amou. Mas já que Vós, nosso Deus, sendo inocente, aceitastes vida e morte tão penosas, aceitamos por vosso amor, Jesus, todas as dores que nos venham de vossas mãos. Aceitamo-las e abraçamo-las porque procedem daquelas mãos transpassadas um dia para livrar-nos do inferno, que tantas vezes merecemos. Vosso amor, nosso Redentor, ao oferecer-vos para sofrer tanto por nós, obriga-nos a aceitar por Vós qualquer pena e desprezo. Dai-nos a aceitar por Vós qualquer pena e desprezo. Dai-nos, Senhor, por vossos méritos, vosso santo amor, que nos torna doces todas as dores e todas as ignomínias. Amamo-vos acima de todas as coisas, amamo-vos com todo o coração, amamo-vos mais que a nós mesmos. Vós, em vossa vida, nos destes tantas e tão grandes provas de afeto e nós, ingratos, que prova de amor vos damos? Fazei, pois, ó nosso Deus, que durante os anos que nos restam de vida vos demos alguma prova de amor. Não nos atreveríamos, no dia do juízo, a comparecer diante de Vós tão pobres como somos agora e sem fazer nada por vosso amor; mas que podemos fazer sem vossa graça? Apenas rogar-vos que nos socorrais, e ainda essa nossa súplica é graça vossa. Oh, Jesus, socorrei-nos pelo mérito de vossas dores e do sangue que derramastes por mim.\nMaria Santíssima, recomendai-nos a Vosso Filho, já que por nosso amor o tivestes em vosso seio. Lembrai-vos que somos daquelas almas por quem morreu vosso Filho.';

  @override
  String get novenaNatalDay3Title => 'Terceiro Dia - 18 de Dezembro';

  @override
  String get novenaNatalDay3Meditation =>
      'JESUS FAZ-SE MENINO PARA CONQUISTAR NOSSA CONFIANÇA E NOSSO AMOR\n\nUm menino nos nasceu, um filho nos foi dado. (Is. 9,6)\n\nConsideremos como depois de tantos séculos, depois de tantas orações e pedidos, veio, nasceu e se deu todo a nós o Messias, que não foram dignos de ver os santos patriarcas e profetas; o desejado pelos gentios, o desejado pelas colinas eternas, nosso Salvador: \'Um menino nos nasceu, um filho nos foi dado\'. O Filho de Deus se fez pequeno para fazer-nos grandes: deu-se a nós para que nos déssemos a Ele; veio mostrar-nos seu amor, para que lhe déssemos o nosso. Recebamo-lo, pois com afeto, amemo-lo e recorramos a Ele em todas as nossas necessidade. As crianças, diz São Bernardo, facilmente concedem o que se lhes pede. Jesus veio como criança, para mostrar-nos que está disposto a dar-nos todos os seus bens. \'No qual se acham todos os tesouros\' (Col. 2,3). \'O Pai...entregou tudo em suas mãos\' (Jo. 3,35). Se queremos luz, Ele veio para nos iluminar; se queremos força para resistir aos inimigos, Ele veio para nos fortalecer; se queremos o perdão e a salvação, Ele veio precisamente para nos perdoar e nos salvar; se queremos, em uma palavra, o supremo dom do amor divino, Ele veio para nos abrasar; e, para isto, sobretudo, se fez menino e quis apresentar-se a nós pobre e humilde, para parecer mais amável, para tirar-nos todo o temor e conquistar nosso afeto: \'Assim devia vir quem quis desterrar o temor e buscar a caridade\', diz São Pedro Crisólogo.\n\nAlém disso, Jesus Cristo quis vir criança, para que o amássemos não só com amor apreciativo, mas com amor terno. Todas as crianças sabem conquistar para si afetuoso carinho daqueles que a rodeiam e, quem não amará com ternura seu Deus, vendo-o criancinha, com frio, pobre, humilhado e abandonado, que chora sobre as palhas de um presépio?\n\nVinde amar Deus feito menino e feito pobre, e que é tão amável que desceu do céu para entregar-se por completo a nós.\n\nORAÇÃO\nÓ amável Jesus, tão desprezado por nós! Descestes do céu para resgatar-nos do inferno e dar-vos por completo a nós, como pudemos tantas vezes, voltar-vos as costas, ó Deus! Os homens são tão gratos às criaturas que se alguém lhes dá um presente, se lhes envia um cumprimento, se lhes dá qualquer prova de afeto, não se esquecem e se sentem forçados a corresponder. E, pelo contrário, são tão ingratos convosco, que sois seu Deus, e tão amável que por seu amor não recusastes dar o sangue e a vida. Mas, ai de nós, nós fomos ainda piores que os outros, porque fomos mais amados e mais ingratos. Ah! Se as graças que nos destes, as tivesses dado a um herege, a um idólatra, talvez se tivessem santificado, e nós vos ofendemos. Por favor, não vos lembreis, Senhor, das injúrias que vos fizemos. Dissestes que, quando um pecador se arrepende, esquecei-vos de todos os pecados cometidos: \'Nenhum dos pecados que cometeu lhe será recordado\' (Ez. 18, 22). Se no passado não nos amamos, no futuro não queremos senão vos amar. Já que vos destes completamente a nós, damo-vos em troca toda a nossa vontade; com ela vos amamos e que vos amamos queremos repetir para sempre. Queremos viver repetindo-o e repetindo-o morrer, para começarmos desde o instante que entramos na eternidade a amar-vos com um amor contínuo que durará eternamente. Entretanto, Senhor, nosso único bem e único amor, propomo-nos a antepor vossa vontade a todos os nossos prazeres. Por nada queremos deixar de amar quem nos amou tanto; não queremos mais desgostar a quem devemos amor infinito. Secundai, Jesus, nosso desejo com vossa graça.\nRainha nossa, Maria, reconhecemos que todas as graças recebidas de Deus são devidas à vossa intercessão; continuai a interceder por nós, alcançai-nos a perseverança, vós que sois a Mãe de todas as graças.';

  @override
  String get novenaNatalDay4Title => 'Quarto Dia - 19 de Dezembro';

  @override
  String get novenaNatalDay4Meditation =>
      'A PAIXÃO DE JESUS CRISTO DUROU TODA SUA VIDA\n\nMinha dor está sempre diante de mim. (Ps. 37,18)\n\nConsideremos como naquele primeiro instante em que foi criada e unida a alma de Jesus Cristo a seu corpo, no seio de Maria, o Padre Eterno mostrou a seu Filho sua vontade de que morresse pela redenção do mundo; e naquele mesmo instante lhe mostrou todas as penas que devia sofrer até a morte para redimir os homens. Mostrou-lhe então todos os trabalho, desprezos e pobreza que devia padecer em sua vida, tanto em Belém como no Egito e em Nazaré, e depois todas as dores e ignomínias da paixão: açoites, espinhos, cravos e cruz; todos os tédios, tristezas, agonias e abandonos no meio dos quais havia de terminar sua vida no Calvário.\n\nAbrão, conduzindo seu filho à morte, não quis afligi-lo dizendo-lhe antecipadamente que morreria, e isso no pouco tempo que era necessário para chegar ao monte. Mas o Eterno Pai quis que seu Filho encarnado, destinado como vítima de nossos pecados à sua justiça, padecesse imediatamente, pelo conhecimento delas, todas as penas a que depois teria que sujeitar-se durante sua vida e em sua morte. Daí, a tristeza padecida por Jesus no Horto, capaz de tirar-lhe a vida, como ele declarou: \'Minha alma está triste até a morte\' (Mt. 26,38), padeceu-a também constantemente desde o primeiro momento em que esteve no seio de sua Mãe. Assim, desde então sentiu vivamente e sofreu o peso reunido de todas as dores e vitupérios que O esperavam.\n\nA vida inteira e todos os anos de nosso Redentor foram cheios de penas e lágrimas: \'Na dor se consome minha vida, e em soluços meus anos\' (Ps. 30,11). Seu divino Coração não teve um momento livre de sofrimentos; quer vigiasse ou dormisse, quer trabalhasse ou descansasse, rezasse ou falasse, sempre tinha diante dos olhos essa amarga representação, que atormentava mais sua santíssima Alma do que atormentaram aos santos mártires todas as suas penas. Eles padeceram, mas, ajudados pela graça divina, padeceram com alegria e fervor. Jesus Cristo sofreu, mas sofreu sempre com o coração cheio de tédio e tristeza, e tudo aceitou por nosso amor.\n\nORAÇÃO\nÓ doce, ó amável, ó amante Coração de Jesus, assim desde menino fostes amargurado e agonizáveis no seio de Maria? Tudo isto sofrestes, Jesus, para satisfazer pela pena e agonia eterna que nos cabia padecer no inferno por nosso pecados. Vós pois, padecestes sem nenhum alívio para salvar-nos, depois de nós termos nos atrevido a abandonar a Deus e voltar-lhe as costas, para satisfazer nossos gostos miseráveis. Graças vos damos, Coração amante e aflito de Nosso Senhor. Agradecemo-vos e nos compadecemos de Vós ao considerar que padecestes tanto pelos homens e que estes não se compadecem de Vós. Como são grandes o amor de Deus e a ingratidão dos homens. Ó Redentor nosso, como são poucos os homens que pensam em vossas dores e em vosso amor. Ó Deus, como são poucos os que vos amam. E desgraçados de nós que também vivemos tantos anos sem lembrarmo-nos de Vós! Vós padecestes tanto para que vos amássemos e não vos amamos. Perdoai-nos, Jesus, perdoai-nos que queremos nos emendar e queremos vos amar. Pobres de nós, Senhor, se resistirmos à Vossa graça e por nossa resistência nos condenarmos. Quantas misericórdias usastes conosco e especialmente vossa voz que agora nos convida a amar-vos, seriam nossas maiores penas no inferno. Amado Jesus, tende piedade de nós, não permitais que vivamos mais ingratos a vosso amor; dai-nos luz e força para vencer tudo e para cumprir vossa vontade. Escutai-nos, rogamo-vos, pelos méritos de vossa Paixão.\nDe Vós esperamos tudo e de vossa intercessão, ó Maria. Querida Mãe, socorrei-nos, Vós que nos alcançastes todas as graças que recebemos de Deus; continuai a nos ajudar, pois se não o fazeis seremos infiéis, como o fomos no passado. Vós sois toda a nossa esperança e toda a razão de nossa confiança.';

  @override
  String get planoVidaTitle => 'Plano de Oração';

  @override
  String get planoVidaCalendarTab => 'Calendário';

  @override
  String get planoVidaPrayersTab => 'Orações';

  @override
  String get planoVidaConfessionTab => 'Confissão';

  @override
  String get liturgicalSeasonAdvent => 'Advento';

  @override
  String get liturgicalSeasonChristmas => 'Natal';

  @override
  String get liturgicalSeasonLent => 'Quaresma';

  @override
  String get liturgicalSeasonEaster => 'Páscoa';

  @override
  String get liturgicalSeasonOrdinary => 'Tempo Comum';

  @override
  String get nextConfessionTitle => 'Próxima Confissão';

  @override
  String get noConfessionPlanned => 'Nenhuma confissão planejada';

  @override
  String get confessionPlannedFor => 'Planejada para:';

  @override
  String daysRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Faltam $count dias',
      one: 'Amanhã',
      zero: 'Hoje',
    );
    return '$_temp0';
  }

  @override
  String get startExaminationButton => 'REALIZAR EXAME DE CONSCIÊNCIA';

  @override
  String get confessionHistoryTitle => 'Histórico de Confissões';

  @override
  String get confessionReminderTitle => 'Lembrete de Confissão';

  @override
  String get confessionReminderNotSet => 'Toque para configurar um lembrete';

  @override
  String get confessionReminderSet => 'Lembrete configurado com sucesso!';

  @override
  String confessionReminderTimeSet(Object time) {
    return 'Lembrete às $time';
  }

  @override
  String get confessionReminderCancelled => 'Lembrete cancelado.';

  @override
  String get confessionReminderQuestion =>
      'Deseja configurar um lembrete para esta confissão?';

  @override
  String get confessionReminderConfigTitle => 'Configurar Lembrete';

  @override
  String get confessionReminderDaysLabel => 'Quantos dias de antecedência?';

  @override
  String confessionReminderDaysOption(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias antes',
      one: '1 dia antes',
      zero: 'No dia',
    );
    return '$_temp0';
  }

  @override
  String get confessionReminderTimeLabel => 'Em qual horário?';

  @override
  String get noLabel => 'Não';

  @override
  String get yesLabel => 'Sim';

  @override
  String get confirmLabel => 'Confirmar';

  @override
  String get morningOffering => 'Oferecimento da Manhã';

  @override
  String get angelus => 'Angelus / Regina Caeli';

  @override
  String get rosary => 'Santo Terço';

  @override
  String get examination => 'Exame de Consciência';

  @override
  String get nightPrayer => 'Oração da Noite';

  @override
  String get addPrayerForDay => 'Adicionar oração neste dia';

  @override
  String get prayersOfTheDay => 'Orações do dia:';

  @override
  String get deletePrayerTitle => 'Remover oração?';

  @override
  String get deletePrayerContent => 'Esta ação não pode ser desfeita.';

  @override
  String get selectPrayerType => 'Selecionar tipo de oração';

  @override
  String get customPrayerOption => 'Outra oração...';

  @override
  String get customPrayerName => 'Nome da oração';

  @override
  String get customPrayerHint => 'Digite o nome...';

  @override
  String get prayerAddedSuccess => 'Oração adicionada com sucesso!';

  @override
  String get dailyPrayersCategory => 'Orações Diárias';

  @override
  String get mainPrayersCategory => 'Orações Principais';

  @override
  String get specialPrayersCategory => 'Orações Especiais';

  @override
  String get saintsPrayersCategory => 'Devoções aos Santos';

  @override
  String get jaculatoriasCategory => 'Jaculatórias';

  @override
  String get litaniesCategory => 'Ladainhas';

  @override
  String get novenaCategory => 'Novenas';

  @override
  String get selectNovenaDay => 'Qual dia da novena?';

  @override
  String get calendarEventsTitle => 'Eventos do Dia';

  @override
  String get novenaNatalDay5Title => 'Quinto Dia - 20 de Dezembro';

  @override
  String get novenaNatalDay5Meditation =>
      'JESUS CRISTO SE OFERECEU DESDE O PRINCÍPIO POR NOSSA SALVAÇÃO\n\nFoi imolado, porque Ele mesmo quis. (Is. 53,7)\n\nO Verbo divino, desde o primeiro instante em que se viu feito homem e criança no seio de Maria, se ofereceu por si mesmo às penas e à morte para resgate do mundo. Sabia que todos os sacrifícios dos cordeiros e dos touros oferecidos a Deus na Antigüidade não tinham podido satisfazer pelas culpas dos homens, mas que era necessário que uma pessoa divina satisfizesse por eles o preço de sua redenção. Pelo que disse, como afirma o Apóstolo: \'Não quiseste hóstia nem oblação, mas me formaste um corpo. Então eu disse; Eis-me aqui presente\' (Heb. 10,5). Meu Pai, disse Jesus Cristo, todas as vítimas que vos foram oferecidas até agora não bastam nem bastarão para satisfazer vossa justiça; destes-me um corpo passível para que com a efusão de meu sangue vos aplaque e salve os homens: eis-me aqui presente, \'ecce venio\', tudo aceito e tudo submeto a vossa vontade.\n\nA parte inferior de sua vontade experimentava, naturalmente, repugnância e recusava-se a viver e a morrer entre tantas dores e opróbrios, mas venceu a parte racional, que estava completamente subordinada à vontade do Pai, e aceitou tudo, começando Jesus a padecer desde aquele instante, todas as angústias e dores que sofreria nos anos de sua vida, assim agiu nosso divino Redentor desde os primeiros instantes de sua entrada no mundo.\n\nE como nos portamos nós com Jesus Cristo, desde que, chegados ao uso da razão, começamos a conhecer, com as luzes da fé, os sagrados mistérios da redenção? Que pensamentos, que desígnios, que bens temos amado? Prazeres, passatempos, soberbas, vinganças, sensualidade, eis os bens que aprisionaram os afetos de nosso coração. Mas, se temos fé, mudemos de vida e de amores; amemos a um Deus que tanto padeceu por nós. Lembremo-nos das penas que o Coração de Jesus padeceu por nós desde criança, e assim não poderemos amar senão esse Coração, que tanto nos amou.\n\nORAÇÃO\nSenhor nosso, quereis saber como nos portamos convosco em nossa vida? Desde que começamos a ter o uso da razão começamos a menosprezar vossa graça e vosso amor. Mas melhor que nós o sabeis vós e, apesar disso, nos suportastes porque nos amais muito. Fugíamos de Vós, e vós vos aproximastes chamando-nos. Aquele mesmo amor que vos fez baixar do céu para buscar as ovelhas perdidas, fez com que nos suportásseis. Jesus, agora nos buscais e nós vos buscamos. Percebemos que vossa graça nos assiste; assiste-nos com a dor de nossos pecados, que odiamos mais que todos os outros males; assisti-nos com o desejo que temos de vos amar e de vos dar gosto. Sim Senhor nosso, queremos amar-vos e tanto quanto possamos. Certo que tememos por nossa fragilidade e debilidade contraídas por causa de nossos pecados, mas muito amor é a confiança que vossa graça nos infunde, fazendo-nos esperar em vossos méritos e dando-nos grande ânimo para exclamar: \'Tudo posso naquele que me conforta\' (Phil. 4,13). Se somos débeis, Vós nos dareis força contra nossos inimigos; se estamos enfermos, esperamos que vosso sangue seja nossa medicina; se somos pecadores, confiamos em que nos santificareis. Confessamos que no passado cooperamos com nossa ruína porque deixamos de recorrer a Vós nos perigos. De hoje em diante, Deus e esperança nossa, a Vós queremos recorrer e de Vós esperamos toda ajuda e todo o bem. Amamos-vos sobre todas as coisas e nada queremos amar fora de vós. Ajudai-nos, por piedade, pelo mérito de tantos sofrimentos que desde o princípio sofrestes por nós. Eterno Pai, por amor de Jesus Cristo, aceitai que vos amemos. Se vos iramos, aplacai-vos ao ver as lágrimas do menino Jesus, que vos roga por nós: \'Põe teus olhos na face de teu ungido\' (Ps. 83,10). Não merecemos graças, mas merece-as esse Filho inocente, que vos oferece uma vida de penas para que sejais conosco misericordioso.\nE Vós, Maria, Maria, Mãe Misericordiosa, não deixeis de interceder por nós; sabeis quanto confiamos em Vós, e sabemos bem que não abandonais a quem recorre a Vós.';

  @override
  String get novenaNatalDay6Title => 'Sexto Dia - 21 de Dezembro';

  @override
  String get novenaNatalDay6Meditation =>
      'JESUS NO SEIO DE MARIA\n\nSou contado entre os que descem à cova, tornei-me como um homem sem força. (Ps. 87,5)\n\nConsideremos a vida penosa por que passou Jesus Cristo no seio de sua Mãe. Era livre, porque se tinha feito voluntariamente prisioneiro de amor, mas o amor o privava do uso da liberdade e o mantinha em cadeias tão apertadas que não podia mover-se. Ó grande paciência do Salvador! Ao pensar nas penas de Nosso Senhor ainda no seio de sua Mãe.\n\nVejamos a que se reduz o Filho de Deus por amor dos homens: priva-se de sua liberdade e se encadeia para livrar-nos das cadeias do inferno. Muito, pois, merece ser reconhecida com gratidão e amor a graça de nosso libertador e fiador, que, não por obrigação, mas por afeto, se ofereceu para pagar e pagou nossas dívidas e nossas penas, dando por elas sua vida: \'Não te esqueças do benefício que te fez o que ficou por teu fiador, porque ele expôs a sua vida por ti\' (Eccli. 29,20).\n\nORAÇÃO\n\'Não te esqueças do benefício que te fez o que ficou por teu fiador\'. Sim, ó Jesus, com razão nos adverte o Profeta de que não nos esqueçamos da imensa graça que nos fizeste. Nós éramos devedores e réus, e, Vós inocente. Vós, nosso Deus, quisestes satisfazer por nossos pecados com vossas penas e com vossa morte. E depois esquecemos esta graça e vosso amor e nos atrevemos a voltar-vos as costas, como se não fosseis nosso Senhor, o Senhor que nos amou tanto. Mas, se no passado o esquecemos, não queremos, Redentor nosso, esquecer-vos no futuro. Vossas penas e vossa morte serão nosso contínuo pensamento, e elas nos recordarão sempre o amor que nos tivestes. Maldizemos os dias em que, esquecidos de quanto sofrestes por nós, abusamos lamentavelmente da liberdade que nos destes para amar-vos e empregamos em desprezar-vos. Essa liberdade que nos destes, hoje vo-la consagramos. Livrai-nos, ó Jesus, da desgraça de ver-nos de novo separados de Vós e feitos escravos do demônio. Prendei a vossos pés nossas almas a fim de que não nos separemos mais de vós. Padre Eterno, pelo cativeiro que o Menino Jesus padeceu no seio de Maria, livrai-nos das cadeias do demônio e do inferno.\nE Vós, Mãe de Deus, socorrei-nos. Carregai-nos aprisionados e estreitados ao Filho de Deus. Pois, já que Jesus é vosso prisioneiro, fará tudo o que mandardes. Dizei-lhe que nos perdoe e que nos faça santo. Ajudai-nos, nossa Mãe, pela graça e honra que vos fez Jesus Cristo de habitar nove meses em vosso seio.';

  @override
  String get novenaNatalDay7Title => 'Sétimo Dia - 22 de Dezembro';

  @override
  String get novenaNatalDay7Meditation =>
      'DOR QUE CAUSOU A JESUS CRISTO A INGRATIDÃO DOS HOMENS\n\nVeio para o que era seu e os seus não o receberam. (Jo. 1,11)\n\nEm certo Natal andava São Francisco pela floresta e pelos caminhos gemendo e suspirando, e, ao perguntarem-lhe a causa de sua tristeza, respondeu: \'Como quereis que não chore vendo que o amor não é amado? Vejo Deus inebriado de amor pelos homens e os homens tão ingratos para com esse Deus\'. Se tanto afligia essa ingratidão dos homens a São Francisco, consideremos quanto mais afligirão ao Coração de Jesus. Tão logo foi concebido no seio de Maria viu a cruel correspondência que havia de receber dos homens. Tinha vindo do céu para atear o fogo do amor divino, e esse desejo o tinha feito descer à terra e sofrer um abismo de penas e ignomínias: \'Vim trazer o fogo à terra e que quero senão que se ateie?\' (Lc. 12,49). E depois via o abismo de pecados que cometeriam os homens apesar de terem sido testemunhas de tantas provas de seu amor. Esse foi, disse São Bernardino de Sena, o que lhe fez padecer uma dor infinita. Ainda entre nós, quando alguém se Vê tratado ingratamente por outro é uma dor insuportável, pois a ingratidão freqüentemente aflige a alma mais que outra dor ao corpo. Que dor, pois, ocasionaria a Jesus, que era nosso Deus, ver que, por nossa ingratidão, seus benefícios e seu amor seriam pagos com desgostos e injúrias? \'Deram-me males em troca de bens e ódio em troca do amor que eu lhes tinha\'. (Ps. 108,5). E ainda hoje se lamenta Jesus Cristo: \'Fui um estrangeiro para meus irmãos\' (Ps. 68,9), pois vê que não é amado nem conhecido de muitos, como se não lhes tivesse feito bem nenhum nem tivesse sofrido nada por seu amor.\n\nÓ meu Deus, que caso fazemos, mesmo os cristãos, do amor de Jesus Cristo? Apareceu um dia Ele ao Beato Henrique Suso como um peregrino que mendigava de porta em porta, sendo sempre posto fora com injúrias. Quantos são semelhantes àqueles de quem falou Jó: \'Eles diziam a Deus: Retira-te de nós, e julgavam o Onipotente, como se não pudesse fazer nada; sendo que ele cumulou de bens as suas casas\' (Job,22,17). Nós, ainda que no passado nos tenhamos unido a esses ingratos, queremos continuar com nossa ingratidão no futuro? Não, porque não o merece aquele amável Menino que veio do céu padecer e morrer por nós para que o amássemos.\n\nORAÇÃO\nSenhor Jesus, que descestes do céu para que nós vos amássemos, tomando uma vida cheia de trabalho e a morte numa cruz, como pudemos tantas vezes dizer-vos: \'Retirai-vos de nós\', não vos queremos, ó nosso Deus, se não fôsseis bondade infinita nem tivésseis dado a vida para perdoar-nos, não nos atreveríamos a pedir-vos perdão; mas sabemos que Vós mesmo nos quereis dar a paz: \'Convertei-vos a mim, diz o Senhor Deus dos exércitos e eu me voltarei para Vós\' (Zach. 1,3). Vós mesmo, Jesus, que sois o ofendido, intercedeis por nós. Não queremos, pois, ofender-vos ainda uma vez, desconfiados de vossa misericórdia. Arrependemo-nos com toda a alma de vos ter desprezado, meu sumo Bem. Dignai-vos receber-nos em vossa graça pelo sangue derramado por Vós. \'Pai, não sou digno de ser chamado teu filho\' (Lc.15,21). Não, nosso Redentor e Pai, não somos dignos de ser vossos filhos, porque tantas vezes renunciamos ao vosso amor; mas Vós nos tornais dignos com vossos merecimentos. Que só o pensamento da paciência com que suportastes nossos pecados durante tantos anos e das graças que nos concedestes, depois de todas as injúrias que vos fizemos, faça-nos viver ardendo nas chamas de vosso amor. Vinde, pois, Senhor, que não vos expulsaremos mais, vinde habitar nosso pobre coração. Amamo-vos e queremos amar-vos para sempre, e Vós abrasai-nos sempre mais, com a lembrança do amor que nos tivestes.';

  @override
  String get novenaNatalDay8Title => 'Oitavo Dia - 23 de Dezembro';

  @override
  String get novenaNatalDay8Meditation =>
      'AMOR DE DEUS AOS HOMENS NO NASCIMENTO DE JESUS\n\nPorque apareceu a graça de Deus nosso Salvador a todos os homens, ensinando-nos que renunciando à impiedade... vivamos piedosamente no presente século, aguardando a esperança bem-aventurada e a vinda gloriosa do grande Deus e Salvador Nosso Senhor Jesus Cristo. (Tit. 2, 12-14)\n\nConsideremos que a graça salvadora de Deus que se manifestou a todos os homens foi o profundíssimo amor de Jesus Cristo aos homens. Esse amor, embora tenha sido da parte de Deus sempre idêntico, nem sempre foi igualmente manifesto.\n\nAntes fora prometido muitas profecias e encoberto sob o véu de muitas figuras. Mas, no nascimento do Redentor, deixou-se ver claramente, aparecendo aos homens o Verbo eterno como menino deitado sobre o feno, gemendo e tremendo de frio, começando já assim a satisfazer pelas penas que merecíamos e dando-nos a conhecer o afeto que nos tinha, sacrificando por nós a vida: \'Nisto conhecemos a caridade de Deus, porque Ele deu sua vida por nós\'. Manifestou-se, pois, a graça salvadora de Deus, e manifestou-se a todos os homens. Mas porque não o conheceram todos e ainda hoje há tantos que, podendo, não o conhecem? Porque \'a luz veio ao mundo e os homens amaram mais as trevas que a luz\' (Jo. 3,19). Não o conheceram nem o conhecem porque não querem conhecê-lo e amam mais as trevas do pecado do que a luz da graça. Não pertençamos ao número desses infelizes. Se até aqui temos fechado os olhos à luz, pensando pouco no amor de Jesus Cristo, procuremos, até o fim de nossa vida, ter sempre ante os olhos os sofrimentos e a morte de nosso Redentor, para amar a quem tanto nos amou: \'Aguardando a bem-aventurada esperança e a vinda gloriosa do grande Deus e Salvador Nosso Jesus Cristo\' (Tit. 2,13).\n\nAssim poderemos confiar fundadamente, segundo as divinas promessas, alcançar aquele paraíso que Jesus Cristo nos conquistou com seu sangue. Nesta primeira manifestação vem Jesus Cristo como menino, pobre e desprezado, nascido num estábulo, coberto de pobres panos e reclinado na palha, mas na segunda aparição virá sobre um trono de majestade: \'E verão o Filho do Homem vir sobre as nuvens do céu com grande poder e majestade\' (Mt. 24,30). Feliz naquela hora quem não o tenha odiado ou desprezado.\n\nORAÇÃO\nOh, Santo Menino, agora vos contemplamos sobre a palha, pobre, aflito e abandonado; mas sabemos que vireis um dia para julgar-nos sobre esplendoroso trono, rodeado de anjos. Perdoai-nos antes de julgar-nos. Então sereis um juiz rigoroso, mas agora sois nosso Redentor e nosso Pai misericordioso. Ingratos fomos, não vos conhecendo por não querer conhecer-vos, e em vez de pensar em amar-vos, considerando o amor que nos tivestes, só pensamos em satisfazer nosso apetite, desprezando vossa graça e vosso amor. Em vossas mãos pomos nossa alma, que tantas vezes nos esforçamos por perder, para que Vós as salveis. \'Em tuas mãos entrego meu espírito: tu me livrarás. Senhor, Deus de Verdade\' (Ps. 30,6). Em Vós deposito minhas esperanças, pois seis que, para resgatar-me do inferno, destes sangue e vida. Tu me livrarás, Senhor, Deus de Verdade. Não me fizestes morrer quando eu estava em pecado e me esperastes com tanta paciência para que, entrando em mim, me arrependesse de vos ter ofendido, começasse a amar-vos e assim pudésseis perdoar-me e salvar-me. Sim, meu Jesus, quero agradar-vos; arrependo-me de todo o mal e desgosto que vos tenho causado. Salvai-me por vossa misericórdia e seja minha salvação amar-vos sempre nesta vida e por toda a eternidade.\nMinha amada Mãe, recomendai-me a vosso Filho, fazei-o ver que sou servo vosso e que em Vós pus minha esperança, pois Ele vos ouve e não vos nega nada.';

  @override
  String get novenaNatalDay9Title => 'Nono Dia - 24 de Dezembro';

  @override
  String get novenaNatalDay9Meditation =>
      'VIAGEM DE SÃO JOSÉ E MARIA SANTÍSSIMA A BELÉM\n\nSubiu também José para inscrever-se no censo com Maria, sua esposa, que estava prestes a dar à luz. (Lc. 2,5)\n\nTinha Deus decretado que seu Filho nascesse nem sequer na casa de José, mas numa gruta, num estábulo, do modo mais pobre e penoso que possa nascer uma criança; já para isso dispôs que César Augusto publicasse um édito no qual ordenava que fossem todos recensear-se em sua cidade natal. José, ao ter notícia dessa ordem, certamente hesitou sobre deixar ou levar consigo Maria Santíssima, próxima de dar à luz, uma vez que não tinha riqueza para proporcionar-lhe uma viagem conveniente, nem queria, por outro lado, deixá-la sozinha e sem amparo.\n\nSabia, contudo, Maria que, como anunciara o profeta Miquéias, devia o Salvador nascer em Belém; por isso, tomando os panos e roupas que preparara para seu Filho, partiu Ela com José, pobremente, em tempo de inverno, prestes a dar à luz, para submeter-se à vontade de Deus.\n\nUna-nos a eles, e através das penas e dores da nossa viagem por esta vida, louvemos a Deus, sejamos-lhe gratos, pedindo-lhe apenas que esteja sempre conosco Nosso Senhor Jesus Cristo.\n\nPeçamos a José e a Maria que pelo mérito das penas padecidas em sua viagem, nos acompanhem na viagem que estamos fazendo para a eternidade.\n\nORAÇÃO\nMeu amado Redentor, acompanhado na terra apenas por José e Maria, ao ir a Belém, permiti-me que vos acompanhe também eu, Vós descestes do céu para ser meu companheiro na terra, e eu tantas vezes já vos abandonei ofendendo-vos ingratamente. Quando penso que, tantas vezes, para seguir minhas malditas inclinações, separei-me de Vós, renunciando a vossa amizade, quisera morrer de dor. Vós viestes para perdoar-me; assim, pois, perdoai-me imediatamente, pois com toda a alma me arrependo de vos ter dado tantas vezes as costas e abandonado. Proponho e espero, com vossa graça, não vos deixar mais nem separar-me mais de Vós. Uni-me, estreitai-me com os suaves laços de vosso santo amor, meu Redentor e meu Deus.\nMaria Santíssima, venho acompanhar-vos em vossa viagem; não deixeis de assistir-me na que estou fazendo para a eternidade. Assisti-me sempre e, especialmente, quando me achar no fim de minha vida, próximo ao instante de que depende estar sempre convosco para amar a Jesus no paraíso, ou estar sempre longe de vós, para odiar a Jesus no inferno. Minha Rainha, salvai-me por vossa intercessão, e seja a minha salvação amar-vos, a vós e a Jesus, para sempre, no tempo e na eternidade. Sois minha esperança; em vós confio.';

  @override
  String get novenaTemplateTitle => '[TEMPLATE] Nome da Novena';

  @override
  String get novenaTemplateDesc => 'Descrição breve da novena';

  @override
  String get novenaTemplateOpening =>
      'Oração inicial da novena. Esta oração é rezada no início de cada dia.';

  @override
  String get novenaTemplateClosing =>
      'Oração final da novena. Esta oração é rezada ao final de cada dia. (Deixe vazio se não houver)';

  @override
  String get novenaTemplatePrayers =>
      'Instruções de orações (ex: Pai-nosso, Ave-Maria e Glória).';

  @override
  String get novenaTemplateDay1Title => 'Título do Dia 1';

  @override
  String get novenaTemplateDay1Meditation =>
      'Meditação do Dia 1. Texto completo da reflexão deste dia.';

  @override
  String get novenaTemplateDay2Title => 'Título do Dia 2';

  @override
  String get novenaTemplateDay2Meditation =>
      'Meditação do Dia 2. Texto completo da reflexão deste dia.';

  @override
  String get novenaTemplateDay3Title => 'Título do Dia 3';

  @override
  String get novenaTemplateDay3Meditation =>
      'Meditação do Dia 3. Texto completo da reflexão deste dia.';

  @override
  String get novenaTemplateDay4Title => 'Título do Dia 4';

  @override
  String get novenaTemplateDay4Meditation =>
      'Meditação do Dia 4. Texto completo da reflexão deste dia.';

  @override
  String get novenaTemplateDay5Title => 'Título do Dia 5';

  @override
  String get novenaTemplateDay5Meditation =>
      'Meditação do Dia 5. Texto completo da reflexão deste dia.';

  @override
  String get novenaTemplateDay6Title => 'Título do Dia 6';

  @override
  String get novenaTemplateDay6Meditation =>
      'Meditação do Dia 6. Texto completo da reflexão deste dia.';

  @override
  String get novenaTemplateDay7Title => 'Título do Dia 7';

  @override
  String get novenaTemplateDay7Meditation =>
      'Meditação do Dia 7. Texto completo da reflexão deste dia.';

  @override
  String get novenaTemplateDay8Title => 'Título do Dia 8';

  @override
  String get novenaTemplateDay8Meditation =>
      'Meditação do Dia 8. Texto completo da reflexão deste dia.';

  @override
  String get novenaTemplateDay9Title => 'Título do Dia 9';

  @override
  String get novenaTemplateDay9Meditation =>
      'Meditação do Dia 9. Texto completo da reflexão deste dia.';

  @override
  String get dailyPrayersTitle => 'Orações Diárias';

  @override
  String get weeklyCommitmentsTitle => 'Compromissos Semanais';

  @override
  String get historyTitle => 'Calendário';

  @override
  String get sundayMass => 'Missa Dominical';

  @override
  String get confession => 'Confissão';

  @override
  String get fasting => 'Jejum / Abstinência';

  @override
  String get adoration => 'Adoração Eucarística';

  @override
  String get completed => 'Concluído';

  @override
  String get pending => 'Pendente';

  @override
  String get addPrayerTitle => 'Adicionar Oração';

  @override
  String get prayerNameHint => 'Nome da oração';

  @override
  String get addButton => 'Adicionar';

  @override
  String get confirmDeleteTitle => 'Confirmar exclusão';

  @override
  String get confirmDeleteMessage => 'Deseja remover esta oração do seu plano?';

  @override
  String get noEventsForDay => 'Nenhum evento registrado.';

  @override
  String get confessionCompletedTitle => 'Confissão Realizada';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Salvar';

  @override
  String get defaultTimeLabel => 'Horário Padrão';

  @override
  String get reminderActive => 'Lembrete Ativo';

  @override
  String get reminderTimeLabel => 'Horário';

  @override
  String get selectTime => 'Selecionar horário';

  @override
  String get frequencyLabel => 'Frequência';

  @override
  String get frequencyOnce => 'Apenas hoje';

  @override
  String get frequencyDaily => 'Diariamente';

  @override
  String get frequencyWeekly => 'Semanalmente';

  @override
  String get frequencyBiweekly => 'Quinzenalmente';

  @override
  String get frequencyMonthly => 'Mensalmente';

  @override
  String prayerUpdatedSuccess(String prayerName) {
    return '$prayerName atualizada com sucesso!';
  }

  @override
  String get confessionReminderEnabled => 'Ativar lembrete';

  @override
  String get confessionReminderDaysBefore => 'Lembrar';

  @override
  String get confessionReminder1Day => '1 dia antes';

  @override
  String get confessionReminder2Days => '2 dias antes';

  @override
  String get confessionReminder3Days => '3 dias antes';

  @override
  String get confessionReminder1Week => '1 Semana';

  @override
  String get confessionReminderTime => 'Horário';

  @override
  String get confessionReminderSaved => 'Lembrete de confissão configurado!';

  @override
  String get confessionReminderCanceled => 'Lembrete de confissão cancelado.';

  @override
  String get confessionReminderNotificationTitle => 'Lembrete: Confissão';

  @override
  String confessionReminderNotificationBody(String date) {
    return 'Sua confissão está marcada para $date.';
  }

  @override
  String get nextConfessionScheduled => 'Próxima Confissão Agendada';

  @override
  String scheduleDialogTitle(String title) {
    return 'Agendar \"$title\"';
  }

  @override
  String get scheduleDialogQuestion =>
      'Deseja definir um horário para lembrete?';

  @override
  String get reminderTypeLabel => 'Tipo de Lembrete';

  @override
  String get selectPrayer => 'Selecione uma oração';

  @override
  String get selectNovena => 'Selecione uma novena';

  @override
  String get selectMystery => 'Selecione um mistério';

  @override
  String get selectTypeLabel => 'Selecione o tipo';

  @override
  String get choosePrayerLabel => 'Escolha a Oração';

  @override
  String get chooseNovenaLabel => 'Escolha a Novena';

  @override
  String get chooseMysteryLabel => 'Escolha o Mistério';

  @override
  String get chooseExamTypeLabel => 'Tipo de Exame';

  @override
  String get timesLabel => 'Horários';

  @override
  String get addTimeButton => 'Adicionar Horário';

  @override
  String get everyLabel => 'A cada';

  @override
  String get weekdaysLabel => 'Dias da Semana';

  @override
  String get dayOfMonthLabel => 'Dia do Mês';

  @override
  String get titleLabel => 'Título';

  @override
  String get validationSelectWeekday => 'Selecione pelo menos um dia da semana';

  @override
  String get validationSelectDayOfMonth => 'Selecione um dia do mês';

  @override
  String dayNumberLabel(int day) {
    return 'Dia $day';
  }

  @override
  String get editButton => 'Editar';

  @override
  String get removeReminderTitle => 'Remover Lembrete';

  @override
  String removeReminderContent(String title) {
    return 'Deseja remover o lembrete \"$title\"?';
  }

  @override
  String reminderUpdatedMessage(String title) {
    return 'Lembrete \"$title\" atualizado!';
  }

  @override
  String reminderRemovedMessage(String title) {
    return 'Lembrete \"$title\" removido!';
  }

  @override
  String reminderCreatedMessage(String title) {
    return 'Lembrete \"$title\" criado!';
  }

  @override
  String get removePrayerTitle => 'Remover do plano?';

  @override
  String removePrayerContent(String title) {
    return 'Deseja remover \"$title\" do seu plano de oração?';
  }

  @override
  String prayerRemovedMessage(String title) {
    return '$title removida do plano';
  }

  @override
  String editPrayerTitle(String title) {
    return 'Editar \"$title\"';
  }

  @override
  String get prayerLevelLabel => 'Nível de Oração';

  @override
  String currentLevelLabel(int level) {
    return 'Atual: Nível $level';
  }

  @override
  String get activePrayersLabel => 'Orações Ativas';

  @override
  String get noPrayersConfigured => 'Nenhuma oração configurada.';

  @override
  String get confessionRegisteredMessage => 'Confissão registrada!';

  @override
  String confessionScheduledMessage(String date) {
    return 'Confissão agendada para $date';
  }

  @override
  String get confessionScheduledCard => 'Confissão Agendada';

  @override
  String get confessionTodaySubtitle => 'Hoje é dia de se confessar!';

  @override
  String get novenaInProgressCard => 'Novena em Andamento';

  @override
  String novenaDayProgress(int day, int total) {
    return 'Dia $day de $total';
  }

  @override
  String get finishPrayerButton => 'Finalizar Oração';

  @override
  String prayerRegisteredMessage(String title) {
    return 'Oração \"$title\" registrada!';
  }

  @override
  String prayerLoggedMessage(String title, String date) {
    return '$title registrada em $date!';
  }

  @override
  String prayerAlreadyInPlanMessage(String title) {
    return '$title já está no seu plano!';
  }

  @override
  String prayerAddedToPlanMessage(String title) {
    return '$title adicionada ao plano!';
  }

  @override
  String get heatmapPrayersLabel => 'orações';

  @override
  String get heatmapRosaryLabel => 'Terço';

  @override
  String get heatmapConfessionLabel => 'Confissão';

  @override
  String get heatmapNovenaLabel => 'Novena';

  @override
  String get threeHailMarysTitle => '3 Ave-Marias';

  @override
  String get threeHailMarysContent =>
      'Maria, Mãe de Jesus e minha Mãe, defendei-me do Maligno em vida e na hora da morte, pelo Poder que vos concedeu o Pai Eterno. Ave Maria... Pela Sabedoria que vos concedeu o Filho. Ave Maria... Pelo Amor que vos concedeu o Espírito Santo. Ave Maria...';

  @override
  String get examDailyLabel => 'Exame Diário';

  @override
  String get confirm => 'Confirmar';

  @override
  String get mysteryTodayTitle => 'Mistério do Dia';

  @override
  String get mysteryJoyfulDaysLuminous => 'Segunda e Sábado';

  @override
  String get mysteryGloriousDaysLuminous => 'Quarta e Domingo';

  @override
  String get feastMaryMotherOfGod => 'Santa Maria, Mãe de Deus';

  @override
  String get feastHolyNameJesus => 'Santíssimo Nome de Jesus';

  @override
  String get feastEpiphany => 'Epifania do Senhor';

  @override
  String get feastConversionPaul => 'Conversão de São Paulo';

  @override
  String get feastTimothyTitus => 'São Timóteo e São Tito';

  @override
  String get feastThomasAquinas => 'São Tomás de Aquino';

  @override
  String get feastJohnBosco => 'São João Bosco';

  @override
  String get feastPresentationLord => 'Apresentação do Senhor';

  @override
  String get feastLadyLourdes => 'Nossa Senhora de Lourdes';

  @override
  String get feastChairPeter => 'Cátedra de São Pedro';

  @override
  String get feastJosephHusband => 'São José, Esposo de Maria';

  @override
  String get feastAnnunciation => 'Anunciação do Senhor';

  @override
  String get feastMarkEvangelist => 'São Marcos, Evangelista';

  @override
  String get feastJosephWorker => 'São José Operário';

  @override
  String get feastPhilipJames => 'São Filipe e São Tiago';

  @override
  String get feastLadyFatima => 'Nossa Senhora de Fátima';

  @override
  String get feastVisitation => 'Visitação de Nossa Senhora';

  @override
  String get feastJustin => 'São Justino';

  @override
  String get feastAnthonyPadua => 'Santo Antônio de Pádua';

  @override
  String get feastBirthJohnBaptist => 'Nascimento de São João Batista';

  @override
  String get feastPeterPaul => 'São Pedro e São Paulo';

  @override
  String get feastThomasApostle => 'São Tomé, Apóstolo';

  @override
  String get feastBenedict => 'São Bento';

  @override
  String get feastMaryMagdalene => 'Santa Maria Madalena';

  @override
  String get feastJamesApostle => 'São Tiago Maior';

  @override
  String get feastJoachimAnne => 'São Joaquim e Santa Ana';

  @override
  String get feastMarthaMaryLazarus => 'Santa Marta, Maria e Lázaro';

  @override
  String get feastIgnatiusLoyola => 'Santo Inácio de Loyola';

  @override
  String get feastJohnVianney => 'São João Maria Vianney';

  @override
  String get feastTransfiguration => 'Transfiguração do Senhor';

  @override
  String get feastDominic => 'São Domingos';

  @override
  String get feastLawrence => 'São Lourenço';

  @override
  String get feastClare => 'Santa Clara';

  @override
  String get feastMaximilianKolbe => 'São Maximiliano Kolbe';

  @override
  String get feastAssumption => 'Assunção de Nossa Senhora';

  @override
  String get feastBartholomew => 'São Bartolomeu, Apóstolo';

  @override
  String get feastMonica => 'Santa Mônica';

  @override
  String get feastAugustine => 'Santo Agostinho';

  @override
  String get feastPassionJohnBaptist => 'Martírio de São João Batista';

  @override
  String get feastNativityMary => 'Natividade de Nossa Senhora';

  @override
  String get feastExaltationCross => 'Exaltação da Santa Cruz';

  @override
  String get feastLadySorrows => 'Nossa Senhora das Dores';

  @override
  String get feastMatthewApostle => 'São Mateus, Apóstolo';

  @override
  String get feastPadrePio => 'São Padre Pio';

  @override
  String get feastVincentPaul => 'São Vicente de Paulo';

  @override
  String get feastArchangels => 'Arcanjos Miguel, Gabriel e Rafael';

  @override
  String get feastJerome => 'São Jerônimo';

  @override
  String get feastThereseLisieux => 'Santa Teresinha do Menino Jesus';

  @override
  String get feastGuardianAngels => 'Santos Anjos da Guarda';

  @override
  String get feastFrancisAssisi => 'São Francisco de Assis';

  @override
  String get feastFaustina => 'Santa Faustina Kowalska';

  @override
  String get feastLadyRosary => 'Nossa Senhora do Rosário';

  @override
  String get feastLadyAparecida => 'Nossa Senhora Aparecida';

  @override
  String get feastTeresaAvila => 'Santa Teresa de Ávila';

  @override
  String get feastLukeEvangelist => 'São Lucas, Evangelista';

  @override
  String get feastJohnPaulII => 'São João Paulo II';

  @override
  String get feastSimonJude => 'São Simão e São Judas Tadeu';

  @override
  String get feastAllSaints => 'Todos os Santos';

  @override
  String get feastAllSouls => 'Fiéis Defuntos';

  @override
  String get feastLateranBasilica => 'Dedicação da Basílica de Latrão';

  @override
  String get feastPresentationMary => 'Apresentação de Nossa Senhora';

  @override
  String get feastCecilia => 'Santa Cecília';

  @override
  String get feastAndrewApostle => 'Santo André, Apóstolo';

  @override
  String get feastFrancisXavier => 'São Francisco Xavier';

  @override
  String get feastNicholas => 'São Nicolau';

  @override
  String get feastImmaculateConception => 'Imaculada Conceição';

  @override
  String get feastLadyGuadalupe => 'Nossa Senhora de Guadalupe';

  @override
  String get feastLucy => 'Santa Luzia';

  @override
  String get feastJohnCross => 'São João da Cruz';

  @override
  String get feastChristmas => 'Natal do Senhor';

  @override
  String get feastStephen => 'Santo Estêvão';

  @override
  String get feastJohnApostle => 'São João, Apóstolo';

  @override
  String get feastHolyInnocents => 'Santos Inocentes';

  @override
  String get feastSylvester => 'São Silvestre';

  @override
  String get feastAshWednesday => 'Quarta-feira de Cinzas';

  @override
  String get feastPalmSunday => 'Domingo de Ramos';

  @override
  String get feastHolyThursday => 'Quinta-feira Santa';

  @override
  String get feastGoodFriday => 'Sexta-feira Santa';

  @override
  String get feastEaster => 'Domingo de Páscoa';

  @override
  String get feastAscension => 'Ascensão do Senhor';

  @override
  String get feastPentecost => 'Pentecostes';

  @override
  String get feastTrinitySunday => 'Santíssima Trindade';

  @override
  String get feastCorpusChristi => 'Corpus Christi';

  @override
  String get feastSacredHeart => 'Sagrado Coração de Jesus';

  @override
  String get seasonAdvent => 'Advento';

  @override
  String get seasonChristmas => 'Natal';

  @override
  String get seasonLent => 'Quaresma';

  @override
  String get seasonEaster => 'Páscoa';

  @override
  String get seasonOrdinaryTime => 'Tempo Comum';

  @override
  String get tabToday => 'Hoje';

  @override
  String get tabCalendar => 'Calendário';

  @override
  String get tabReminders => 'Lembretes';

  @override
  String get gardenTitle => 'Jardim da Alma';

  @override
  String get gardenSubtitle => 'Cultive sua vida espiritual.';

  @override
  String get statsToday => 'Hoje';

  @override
  String get statsThisWeek => 'Esta Semana';

  @override
  String get catPrayersSpecial => 'Especiais';

  @override
  String get timeDuringDay => 'Durante o Dia';

  @override
  String rosaryHailMaryCount(int current, int total) {
    return 'Ave Maria $current/$total';
  }

  @override
  String novenaDayCounter(int day) {
    return 'Dia $day';
  }

  @override
  String get novenaConfigTitle => 'Configurar Novena';

  @override
  String get novenaConfigStartDate => 'Quando deseja iniciar?';

  @override
  String get novenaConfigReminder => 'Lembrete diário (Opcional)';

  @override
  String get novenaConfigNoReminder => 'Sem lembrete';

  @override
  String get novenaScheduledMessage => 'Novena agendada para iniciar em:';

  @override
  String novenaReminderMessage(String time) {
    return 'Lembrete às $time';
  }

  @override
  String get historyDayOfObligation => 'Dia de Preceito';

  @override
  String get historyAddPrayer => 'Adicionar oração neste dia';

  @override
  String get historyConfessionDone => 'Confissão Realizada';

  @override
  String get historyNextConfession => 'Próxima Confissão';

  @override
  String get historyNextConfessionSubtitle => 'Prepare-se para sua confissão.';

  @override
  String get historyNovena => 'Novena';

  @override
  String historyPrayersForDay(int count) {
    return 'Orações do dia: $count';
  }

  @override
  String get historyRemovePrayerTitle => 'Remover oração?';

  @override
  String historyRemovePrayerContent(String title) {
    return 'Deseja remover \"$title\" do histórico?';
  }

  @override
  String get historyConfessionHistoryTitle => 'HISTÓRICO DE CONFISSÕES';

  @override
  String get historyNoConfessions => 'Nenhuma confissão registrada.';

  @override
  String get historyRemoveConfessionTitle => 'Remover confissão?';

  @override
  String get historyRemoveConfessionContent =>
      'Esta ação não pode ser desfeita.';

  @override
  String get remindersAddButton => 'Adicionar';

  @override
  String get remindersEmptyTitle => 'Você ainda não criou lembretes';

  @override
  String get remindersEmptySubtitle =>
      'Toque em Adicionar para criar o primeiro: de uma oração, de uma novena ou personalizado.';

  @override
  String get remindersGroupPrayers => 'ORAÇÕES';

  @override
  String get remindersGroupNovenas => 'NOVENAS';

  @override
  String get remindersGroupExaminations => 'EXAMES';

  @override
  String get remindersGroupRosaries => 'TERÇOS';

  @override
  String get remindersGroupConfession => 'CONFISSÃO';

  @override
  String get remindersGroupOthers => 'OUTROS';

  @override
  String get statsSummary => 'Resumo';

  @override
  String statsActive(int count) {
    return '$count ativos';
  }

  @override
  String get statsNext => 'Próximo: ';

  @override
  String get statsDefaultTitle => 'Lembrete';

  @override
  String statsTodayTime(String time) {
    return 'Hoje, $time';
  }

  @override
  String statsTomorrowTime(String time) {
    return 'Amanhã, $time';
  }

  @override
  String get reminderEditTitle => 'Editar Lembrete';

  @override
  String get reminderNewTitle => 'Novo Lembrete';

  @override
  String get reminderTypePrayer => 'Oração';

  @override
  String get reminderTypeNovena => 'Novena';

  @override
  String get reminderTypeRosary => 'Terço';

  @override
  String get reminderTypeExamination => 'Exame';

  @override
  String get reminderTypeConfession => 'Confissão';

  @override
  String get reminderTypePenance => 'Penitência';

  @override
  String get reminderTypeCustom => 'Personalizado';

  @override
  String get reminderTitleLabel => 'Título';

  @override
  String get reminderTitleHint => 'Digite um título';

  @override
  String get reminderTitleError => 'Por favor, digite um título';

  @override
  String get reminderRecurrenceLabel => 'Repetição';

  @override
  String get reminderRecurrenceOnce => 'Apenas uma vez';

  @override
  String get reminderRecurrenceDaily => 'Diariamente';

  @override
  String get reminderRecurrenceWeekly => 'Semanalmente';

  @override
  String get reminderRecurrenceMonthly => 'Mensalmente';

  @override
  String get reminderIntervalLabel => 'Intervalo';

  @override
  String reminderIntervalDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dias',
      one: 'dia',
    );
    return '$_temp0';
  }

  @override
  String reminderIntervalWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'semanas',
      one: 'semana',
    );
    return '$_temp0';
  }

  @override
  String reminderIntervalMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'meses',
      one: 'mês',
    );
    return '$_temp0';
  }

  @override
  String get reminderWeekDaysLabel => 'Dias da Semana';

  @override
  String get reminderMonthDayLabel => 'Dia do Mês';

  @override
  String reminderMonthDayValue(int day) {
    return 'Dia $day';
  }

  @override
  String get reminderCancelButton => 'Cancelar';

  @override
  String get reminderCreateButton => 'Criar';

  @override
  String get reminderSaveButton => 'Salvar';

  @override
  String get reminderDefaultTitlePrayer => 'Oração';

  @override
  String get reminderDefaultTitleNovena => 'Novena';

  @override
  String get reminderDefaultTitleRosary => 'Santo Terço';

  @override
  String get reminderDefaultTitleExamination => 'Exame de Consciência';

  @override
  String get reminderDefaultTitleCustom => 'Lembrete';

  @override
  String get monthDayLabel => 'Dia do Mês';

  @override
  String get reminderRecurrenceCustom => 'Personalizado';

  @override
  String reminderFrequencyDailyInterval(int interval) {
    return 'A cada $interval dias';
  }

  @override
  String reminderFrequencyWeeklyInterval(int interval) {
    return 'A cada $interval semanas';
  }

  @override
  String reminderFrequencyMonthly(int day) {
    return 'Dia $day de cada mês';
  }

  @override
  String reminderFrequencyMonthlyInterval(int day, int interval) {
    return 'Dia $day a cada $interval meses';
  }

  @override
  String get configLanguageTitle => 'Idioma (Language)';

  @override
  String get configLanguageDesc =>
      'Selecione o idioma do aplicativo (Select application language)';

  @override
  String get languagePortuguese => 'Português (Portuguese)';

  @override
  String get languageEnglish => 'Inglês (English)';

  @override
  String get okAction => 'OK';

  @override
  String get contentNotFound => 'Conteúdo não encontrado.';

  @override
  String get rosarySelectMystery => 'Selecione o Mistério';

  @override
  String get rosaryDesc => 'Contemple os mistérios da vida de Cristo.';

  @override
  String get rosaryTraditionalToggle => 'Santo Terço - Modo Tradicional';

  @override
  String get rosaryTodaysMystery => 'Mistério de Hoje';

  @override
  String get rosaryFinish => 'Finalizar';

  @override
  String get rosaryAutoMysterySubtitle =>
      'O mistério será selecionado automaticamente.';

  @override
  String get rosarySelectSpecificMystery => 'Selecionar Mistério Específico';

  @override
  String get frequencyNone => 'Nenhuma';

  @override
  String get weeksUnit => 'semanas';

  @override
  String get monthUnit => 'mês';

  @override
  String get confessionFrequencyLabel => 'Frequência (Repetição)';

  @override
  String get confessionIntervalCustomTitle => 'Intervalo Personalizado (Dias)';

  @override
  String get confessionIntervalCustomLabel => 'Dias';

  @override
  String get confessionReminder2Weeks => '2 Semanas';

  @override
  String get confessionReminder3Weeks => '3 Semanas';

  @override
  String get confessionReminder1Month => '1 Mês';

  @override
  String get confessionReminder2Months => '2 Meses';

  @override
  String get confessionReminder3Months => '3 Meses';

  @override
  String get liturgicalCalendarTitle => 'Calendário Litúrgico';

  @override
  String get preceptDayLabel => 'Dia de Preceito';

  @override
  String get abstinenceDayLabel => 'Abstinência de Carne';

  @override
  String get fastingDayLabel => 'Dia de Jejum';

  @override
  String get notifyPreceptTitle => 'Notificar dias de Preceito';

  @override
  String get notifyPreceptSubtitle => 'Domingos e dias santos';

  @override
  String get notifyFastingTitle => 'Notificar dias de Jejum';

  @override
  String get notifyFastingSubtitle =>
      'Quarta-feira de Cinzas e Sexta-feira Santa';

  @override
  String get notifyAbstinenceTitle => 'Notificar dias de Abstinência';

  @override
  String get notifyAbstinenceSubtitle => 'Todas as sextas-feiras do ano';

  @override
  String get liturgicalReminderPrecept => 'Dias de Preceito';

  @override
  String get liturgicalReminderFasting => 'Dias de Jejum';

  @override
  String get liturgicalReminderAbstinence => 'Dias de Abstinência';

  @override
  String get notificationPreceptTitle => 'Dia de Preceito';

  @override
  String get notificationPreceptBody =>
      'Hoje é Domingo, dia do Senhor. Não se esqueça da Santa Missa!';

  @override
  String get notificationFastingTitle => 'Dia de Jejum e Abstinência';

  @override
  String get notificationFastingBody =>
      'Hoje é dia de Jejum e Abstinência de carne.';

  @override
  String get notificationAbstinenceTitle => 'Dia de Penitência';

  @override
  String get notificationAbstinenceBody =>
      'Hoje é Sexta-feira. Dia de abstinência de carne ou obra de piedade.';

  @override
  String get drawerAbout => 'Sobre o Projeto';

  @override
  String get aboutPageTitle => 'Sancta Devocionário Católico';

  @override
  String get donateSuccess => 'Chave Pix copiada com sucesso!';

  @override
  String get drawerSettings => 'Configurações';

  @override
  String get readMore => 'Ler mais';

  @override
  String get jornadaBannerTitle => 'Jornada de Confissão';

  @override
  String get jornadaBannerSubtitle =>
      'Prepare sua alma para o encontro com a Misericórdia';

  @override
  String get jornadaQuote1 =>
      'O padre não é juiz, é pai. Ele está ali para acolher e perdoar em nome de Cristo.';

  @override
  String get jornadaQuote2 =>
      'Deus já conhece todos os seus pecados e ainda assim te ama infinitamente.';

  @override
  String get jornadaQuote3 =>
      'A confissão é um tribunal de misericórdia, onde quem se declara culpado é perdoado.';

  @override
  String get jornadaAction => 'Iniciar Jornada';

  @override
  String get novenaTitleNatal => 'Novena de Natal';

  @override
  String get novenaTitleCarloAcutis => 'Novena a São Carlo Acutis';

  @override
  String get novenaTitleTeresaLisieux => 'Novena a Santa Teresinha';

  @override
  String get novenaTitleSagradoCoracao => 'Novena ao Sagrado Coração de Jesus';

  @override
  String get novenaTitleConceicao => 'Novena à Imaculada Conceição';

  @override
  String get prayerLevel1Description =>
      'Iniciante: Oração da Manhã, Noite e 3 Ave-Marias';

  @override
  String get prayerLevel2Description => 'Intermediário: + Santo Terço';

  @override
  String get prayerLevel3Description =>
      'Avançado: + Angelus e Leitura Espiritual';

  @override
  String get prayerLevel4Description =>
      'Contemplativo: + Exame de Consciência e Meditação';

  @override
  String get prayerTimeDescriptionMorning => 'Manhã';

  @override
  String get prayerTimeDescriptionNoon => 'Meio-dia';

  @override
  String get prayerTimeDescriptionNight => 'Noite';

  @override
  String get prayerTimeDescriptionAnytime => 'Durante o dia';

  @override
  String get prayerTimeDescriptionDefault => 'Qualquer hora';

  @override
  String get activeNovenasTitle => 'Novenas Ativas';

  @override
  String get activeNovenasEmpty => 'Nenhuma novena ativa.';

  @override
  String get confessionTitle => 'Confissão';

  @override
  String get confessionNextLabel => 'Próxima Confissão';

  @override
  String get confessionNotScheduled => 'Não agendada';

  @override
  String get confessionRegisterLabel => 'Registrar Confissão';

  @override
  String get confessionRegisterSubtitle => 'Marcar hoje como dia de confissão';

  @override
  String get addPrayerToPlanLabel => 'Adicionar Oração ao Plano';

  @override
  String get loginBackLabel => 'Voltar para login';

  @override
  String get penanceLabel => 'Penitência';

  @override
  String get penanceHint => 'Ex: Rezar 3 Ave-Marias';

  @override
  String get penanceOptional => 'Penitência (opcional)';

  @override
  String get novenaSaoJoseTitle => 'Novena a São José';

  @override
  String get novenaSaoJoseDesc =>
      'Para alcançar graças e a proteção de São José, pai nutrício de Jesus, esposo da Virgem Maria, chefe da Sagrada Família e padroeiro da Santa Igreja.';

  @override
  String get novenaSaoJoseOpening =>
      'Ó glorioso São José, pai nutrício de Jesus e castíssimo esposo de Maria, abri vosso coração paternal a nós que recorremos a vós com confiança. Pelo amor que tivestes ao Menino Deus, alcançai-nos as graças que humildemente vos pedimos. Amém.';

  @override
  String get novenaSaoJoseClosing =>
      'Glorioso São José, que fostes exaltado pelo Eterno Pai, obedecido pelo Verbo Encarnado, favorecido pelo Espírito Santo e amado pela Virgem Maria; louvo e bendigo a Santíssima Trindade pelos privilégios e méritos com que vos enriqueceu. Sois poderosíssimo e jamais se ouviu dizer que alguém tenha recorrido a vós e tenha sido por vós desamparado. Sois o consolador dos aflitos, o amparo dos míseros e o advogado dos pecadores. Acolhei, pois, com bondade paternal a quem vos invoca com filial confiança e alcançai-me as graças que vos peço nesta novena. Eu vos escolho por meu especial protetor. Sede, depois de Jesus e Maria, minha consolação nesta terra, meu refúgio nas desgraças, meu guia nas incertezas, meu conforto nas tribulações, meu pai solícito em todas as necessidades. Obtende-me, finalmente, como coroa dos vossos favores, uma boa e santa morte na graça de Nosso Senhor. Amém.';

  @override
  String get novenaSaoJosePrayers =>
      'Rezar 1 Pai-Nosso, 1 Ave-Maria e 1 Glória ao Pai.';

  @override
  String get novenaSaoJoseDay1Title =>
      '1º Dia - São José, Pai Nutrício de Jesus';

  @override
  String get novenaSaoJoseDay1Meditation =>
      'Amabilíssimo São José, que tivestes a honra de alimentar, educar e abraçar o Messias, a quem tantos profetas e reis desejaram ver e não viram, obtende-me, com o perdão das minhas culpas, a graça da oração humilde e confiante que tudo alcança de Deus. Acolhei com bondade paternal os pedidos que vos faço nesta novena e apresentai-os a Jesus, que se dignou obedecer-vos na terra. Amém.\n\nV/. Rogai por nós, São José, pai nutrício de Jesus.\nR/. Para que sejamos dignos das promessas de Cristo.\n\nOremos. Ó Deus, que por uma inefável Providência Vos dignastes escolher o bem-aventurado São José para Esposo de vossa Mãe Santíssima, concedei-nos que aquele mesmo que na terra veneramos como protetor, mereçamos tê-lo no céu por nosso intercessor. Vós que viveis e reinais por todos os séculos dos séculos. Amém.';

  @override
  String get novenaSaoJoseDay2Title =>
      '2º Dia - São José, Esposo da Virgem Maria';

  @override
  String get novenaSaoJoseDay2Meditation =>
      'São José, castíssimo Esposo da Mãe de Deus e guarda fiel da sua virgindade, obtende-me, por Maria, a pureza do corpo e da alma e a vitória em todas as tentações e dificuldades. Recomendo-vos também os esposos cristãos, para que, unidos com sincero amor e fortalecidos pela graça, amparem-se mutuamente nos sofrimentos e tribulações da vida. Amém.\n\nV/. Rogai por nós, São José, esposo da Mãe de Deus.\nR/. Para que sejamos dignos das promessas de Cristo.\n\nOremos. Ó Deus, que por uma inefável Providência Vos dignastes escolher o bem-aventurado São José para Esposo de vossa Mãe Santíssima, concedei-nos que aquele mesmo que na terra veneramos como protetor, mereçamos tê-lo no céu por nosso intercessor. Vós que viveis e reinais por todos os séculos dos séculos. Amém.';

  @override
  String get novenaSaoJoseDay3Title =>
      '3º Dia - São José, Chefe da Sagrada Família';

  @override
  String get novenaSaoJoseDay3Meditation =>
      'Glorioso São José, que gozastes durante tantos anos da presença e filial afeição de Jesus, a quem tivestes a dita de alimentar e vestir, juntamente com vossa Santíssima Esposa, eu vos suplico me alcanceis o dom inefável de sempre viver em união com Deus pela graça santificante. Obtende também para os pais cristãos a graça do fiel cumprimento de seus graves deveres de educadores e, aos filhos, o respeito e a obediência, segundo o exemplo do Menino Jesus. Amém.\n\nV/. Rogai por nós, São José, chefe da Sagrada Família.\nR/. Para que sejamos dignos das promessas de Cristo.\n\nOremos. Ó Deus, que por uma inefável Providência Vos dignastes escolher o bem-aventurado São José para Esposo de vossa Mãe Santíssima, concedei-nos que aquele mesmo que na terra veneramos como protetor, mereçamos tê-lo no céu por nosso intercessor. Vós que viveis e reinais por todos os séculos dos séculos. Amém.';

  @override
  String get novenaSaoJoseDay4Title =>
      '4º Dia - São José, Exemplo de Fidelidade';

  @override
  String get novenaSaoJoseDay4Meditation =>
      'Fidelíssimo São José, que nos destes tão belo exemplo no fiel cumprimento de vossos deveres de protetor da Santíssima Virgem e de pai nutrício do Redentor, rogo-vos me obtenhais a graça de imitar o vosso exemplo na fidelidade a todos os deveres do meu estado de vida. Ajudai-me a ser fiel nas coisas pequenas, para sê-lo também nas grandes. Alcançai essa mesma graça para todos os que me são caros nesta vida, a fim de chegarmos a gozar no céu o prêmio prometido aos que forem fiéis até a morte. Amém.\n\nV/. Rogai por nós, São José, exemplo de fidelidade.\nR/. Para que sejamos dignos das promessas de Cristo.\n\nOremos. Ó Deus, que por uma inefável Providência Vos dignastes escolher o bem-aventurado São José para Esposo de vossa Mãe Santíssima, concedei-nos que aquele mesmo que na terra veneramos como protetor, mereçamos tê-lo no céu por nosso intercessor. Vós que viveis e reinais por todos os séculos dos séculos. Amém.';

  @override
  String get novenaSaoJoseDay5Title =>
      '5º Dia - São José, Espelho de Paciência';

  @override
  String get novenaSaoJoseDay5Meditation =>
      'Bondoso São José, que suportastes com heroica paciência as provações e adversidades na viagem a Belém, na fuga para o Egito e durante a vida oculta em Nazaré e nos destes o exemplo de admirável conformidade com a vontade de Deus, obtende-me a virtude da paciência nas dificuldades de cada dia. Alcançai também invencível paciência a todos os que suportam pesadas cruzes, a fim de que se unam sempre mais a Jesus, divino modelo de mansidão e paciência. Amém.\n\nV/. Rogai por nós, São José, espelho de paciência.\nR/. Para que sejamos dignos das promessas de Cristo.\n\nOremos. Ó Deus, que por uma inefável Providência Vos dignastes escolher o bem-aventurado São José para Esposo de vossa Mãe Santíssima, concedei-nos que aquele mesmo que na terra veneramos como protetor, mereçamos tê-lo no céu por nosso intercessor. Vós que viveis e reinais por todos os séculos dos séculos. Amém.';

  @override
  String get novenaSaoJoseDay6Title =>
      '6º Dia - São José, Modelo dos Operários';

  @override
  String get novenaSaoJoseDay6Meditation =>
      'Humilde São José, que vivendo em pobreza dignificastes a vossa profissão pelo trabalho constante e vos sentistes feliz em servir a Jesus e a Maria com o fruto de vossos suores, alcançai-me amor ao trabalho, que me foi imposto como dever de estado, procurando cumprir nisto sempre a vontade de Deus. Protegei os lares dos trabalhadores do Brasil contra as influências nefastas dos inimigos de Cristo e da Santa Igreja. Obtende-lhes a graça de santificarem o seu trabalho, pela reta intenção, em tudo conformados com os desígnios da Divina Providência. Amém.\n\nV/. Rogai por nós, São José, modelo dos operários.\nR/. Para que sejamos dignos das promessas de Cristo.\n\nOremos. Ó Deus, que por uma inefável Providência Vos dignastes escolher o bem-aventurado São José para Esposo de vossa Mãe Santíssima, concedei-nos que aquele mesmo que na terra veneramos como protetor, mereçamos tê-lo no céu por nosso intercessor. Vós que viveis e reinais por todos os séculos dos séculos. Amém.';

  @override
  String get novenaSaoJoseDay7Title =>
      '7º Dia - São José, Protetor da Santa Igreja';

  @override
  String get novenaSaoJoseDay7Meditation =>
      'Glorioso Patriarca São José, Protetor e Padroeiro da Igreja Universal, obtende-me a graça de amar a Igreja como Mãe e de a honrar como verdadeiro discípulo de Cristo. Rogo-vos que veleis sobre o seu Corpo Místico, como outrora velastes sobre Jesus e Maria. Protegei o Santo Padre e os Bispos, os Sacerdotes e os Religiosos. Alcançai-lhes santidade de vida e eficácia no apostolado. Guardai a inocência da infância, a castidade da juventude, a honestidade do lar, a ordem e a paz da sociedade. Amém.\n\nV/. Rogai por nós, São José, protetor da Santa Igreja.\nR/. Para que sejamos dignos das promessas de Cristo.\n\nOremos. Ó Deus, que por uma inefável Providência Vos dignastes escolher o bem-aventurado São José para Esposo de vossa Mãe Santíssima, concedei-nos que aquele mesmo que na terra veneramos como protetor, mereçamos tê-lo no céu por nosso intercessor. Vós que viveis e reinais por todos os séculos dos séculos. Amém.';

  @override
  String get novenaSaoJoseDay8Title =>
      '8º Dia - São José, Consolo dos Enfermos';

  @override
  String get novenaSaoJoseDay8Meditation =>
      'Compassivo São José, esperança dos doentes e necessitados, valei-me em todas as enfermidades e tribulações, alcançando-me plena conformidade com os admiráveis desígnios de Deus. Obtende-me também, para mim e para todos por quem rezo nesta novena, a cura das enfermidades espirituais, que são as paixões desordenadas, fraquezas, faltas e pecados, e protegei-nos contra as tentações do inimigo da nossa salvação. Amém.\n\nV/. Rogai por nós, São José, consolo dos enfermos.\nR/. Para que sejamos dignos das promessas de Cristo.\n\nOremos. Ó Deus, que por uma inefável Providência Vos dignastes escolher o bem-aventurado São José para Esposo de vossa Mãe Santíssima, concedei-nos que aquele mesmo que na terra veneramos como protetor, mereçamos tê-lo no céu por nosso intercessor. Vós que viveis e reinais por todos os séculos dos séculos. Amém.';

  @override
  String get novenaSaoJoseDay9Title =>
      '9º Dia - São José, Padroeiro dos Moribundos';

  @override
  String get novenaSaoJoseDay9Meditation =>
      'Ditoso São José, que morrendo nos braços de Jesus e Maria, partistes deste mundo ornado de virtudes e enriquecido de méritos, assisti-me na hora suprema e decisiva da minha vida contra os ataques do poder infernal. Obtende-me a graça de morrer confortado com os santos Sacramentos, necessários para a minha salvação. Tende compaixão de todos os agonizantes, alcançando-lhes a graça da salvação por intermédio de Maria, vossa Santíssima Esposa. Amém.\n\nV/. Rogai por nós, São José, padroeiro dos moribundos.\nR/. Para que sejamos dignos das promessas de Cristo.\n\nOremos. Ó Deus, que por uma inefável Providência Vos dignastes escolher o bem-aventurado São José para Esposo de vossa Mãe Santíssima, concedei-nos que aquele mesmo que na terra veneramos como protetor, mereçamos tê-lo no céu por nosso intercessor. Vós que viveis e reinais por todos os séculos dos séculos. Amém.';

  @override
  String get novenaSaoJudasTitle => 'Novena a São Judas Tadeu';

  @override
  String get novenaSaoJudasDesc =>
      'Aos corações aflitos e casos desesperados, recorremos ao glorioso São Judas.';

  @override
  String get novenaSaoJudasOpening =>
      'Oração: São Judas glorioso, apóstolo fiel e mártir de Jesus Cristo! O título de traidor foi a causa de serdes esquecido por muitos, mas a Igreja vos honra e vos invoca universalmente como Padroeiro nos casos manifestamente desesperados, nos negócios sem remédio. Intercedei por mim, que sou tão miserável; fazei uso daquele particular privilégio que vos foi concedido de trazer viável e imediato auxílio, onde o socorro desapareceu quase por completo. Assisti-me nesta grande necessidade, para que eu possa receber o consolo e o auxílio do céu em todas as minhas precisões, atribulações e sofrimentos, alcançando a graça que peço. (Faça o seu pedido)';

  @override
  String get novenaSaoJudasClosing =>
      'Oração final: São Judas Tadeu, rogai por nós e por todos que vos honram e invocam o vosso auxílio! Prometo, ó bendito São Judas, lembrar-me sempre deste grande favor e nunca deixar de vos honrar como meu especial e poderoso padroeiro, e fazer tudo o que estiver ao meu alcance para incentivar a devoção para convosco. Amém.';

  @override
  String get novenaSaoJudasPrayers =>
      'Rezar 3 Pai-Nossos, 3 Ave-Marias e 3 Glórias ao Pai.';

  @override
  String get novenaSaoJudasDay1Title => '1º Dia - Fidelidade incondicional';

  @override
  String get novenaSaoJudasDay1Meditation =>
      'São Judas, testemunha valente, peço-vos a graça de permanecer fiel na minha fé, não obstante os tempos sombrios, e a força para nunca perder a esperança nas promessas do Cristo.';

  @override
  String get novenaSaoJudasDay2Title => '2º Dia - O amor à Cruz';

  @override
  String get novenaSaoJudasDay2Meditation =>
      'Glorioso apóstolo, ajudai-me a abraçar a minha cruz de cada dia com a mesma alegria e prontidão com as quais destes a vossa vida pelo Evangelho.';

  @override
  String get novenaSaoJudasDay3Title => '3º Dia - A pureza de intenções';

  @override
  String get novenaSaoJudasDay3Meditation =>
      'São Judas amado, purificai meus desejos mundanos para que eu busque antes de tudo agradar a Deus, amando o próximo como a mim mesmo.';

  @override
  String get novenaSaoJudasDay4Title => '4º Dia - A paz nos desesperos';

  @override
  String get novenaSaoJudasDay4Meditation =>
      'Ó Padroeiro dos aflitos, descei sobre meu coração perturbado a paz serena e a plena confiança na Divina Providência.';

  @override
  String get novenaSaoJudasDay5Title => '5º Dia - A salvação das almas';

  @override
  String get novenaSaoJudasDay5Meditation =>
      'Inspirado pelo vosso zelo, São Judas, rogo para que eu seja instrumento do Senhor para a salvação e a santificação da minha família.';

  @override
  String get novenaSaoJudasDay6Title => '6º Dia - A virtude da paciência';

  @override
  String get novenaSaoJudasDay6Meditation =>
      'Nas contrariedades do caminho, ó Santo valente, dai-me paciência de suportar tudo em expiação por minhas próprias faltas.';

  @override
  String get novenaSaoJudasDay7Title => '7º Dia - A defesa da verdadeira fé';

  @override
  String get novenaSaoJudasDay7Meditation =>
      'Vós, São Judas, que em vossa Epístola condenastes as seitas e heresias, alcançai-me a graça de defender vigorosamente a Doutrina Católica.';

  @override
  String get novenaSaoJudasDay8Title => '8º Dia - O auxílio infalível';

  @override
  String get novenaSaoJudasDay8Meditation =>
      'Nos problemas sem solução aparente, firmo a minha confiança em vossa intercessão. O Senhor jamais negará o vosso pedido, pois por Ele destes o sangue.';

  @override
  String get novenaSaoJudasDay9Title => '9º Dia - A glória eterna';

  @override
  String get novenaSaoJudasDay9Meditation =>
      'São Judas vencedor, guiai meus passos no cume desta vida exilada, a fim de que, merecendo o perdão por vossa assistência, possa bendizer a Deus convosco eternamente.';

  @override
  String get novenaPentecostesTitle => 'Novena de Pentecostes';

  @override
  String get novenaPentecostesDesc =>
      'A primeira novena da Igreja, pedindo os dons do Espírito Santo, como fizeram Maria e os Apóstolos no Cenáculo.';

  @override
  String get novenaPentecostesOpening =>
      'Vinde, Espírito Santo! Enchei os corações dos Vossos fiéis e acendei neles o fogo do Vosso amor. Enviai o Vosso Espírito, e tudo será criado; e renovareis a face da terra. Ó Deus, que instruístes os corações dos Vossos fiéis com a luz do Espírito Santo, fazei que apreciemos retamente todas as coisas segundo o mesmo Espírito e gozemos sempre da Sua consolação. Por Cristo, Senhor nosso. Amém.';

  @override
  String get novenaPentecostesClosing =>
      'Divino Espírito Santo, concede-me as Tuas graças e os Teus sete dons. Que a chama do Vosso Divino Amor purifique e santifique o meu coração, tornando-o um templo digno da Vossa habitação perpétua. Amém.';

  @override
  String get novenaPentecostesPrayers =>
      'Rezar 1 Pai-Nosso, 1 Ave-Maria e o canto Veni Creator Spiritus (ou 1 Glória ao Pai).';

  @override
  String get novenaPentecostesDay1Title =>
      '1º Dia - Vem, Santo Espírito do Céu';

  @override
  String get novenaPentecostesDay1Meditation =>
      'O Espírito Santo é a promessa do Pai e a luz da nossa alma. Peçamos que o Espírito da Verdade desça e acenda a nossa fé morna.';

  @override
  String get novenaPentecostesDay2Title => '2º Dia - O Dom do Temor de Deus';

  @override
  String get novenaPentecostesDay2Meditation =>
      'Espírito Santo, dai-me o sagrado temor de ofender a Deus, livrando-me do desrespeito e do apego ao pecado.';

  @override
  String get novenaPentecostesDay3Title => '3º Dia - O Dom da Piedade';

  @override
  String get novenaPentecostesDay3Meditation =>
      'Senhor, inundai-me de terna afeição por Vós, para que Vos chame de Pai e sirva alegremente os meus irmãos e irmãs.';

  @override
  String get novenaPentecostesDay4Title => '4º Dia - O Dom da Ciência';

  @override
  String get novenaPentecostesDay4Meditation =>
      'Divino Mestre, concedei-me a verdadeira sabedoria das coisas criadas, para que não me iluda com o mundo e busque o eterno.';

  @override
  String get novenaPentecostesDay5Title => '5º Dia - O Dom da Fortaleza';

  @override
  String get novenaPentecostesDay5Meditation =>
      'Espírito Consolador, fortificai meu espírito contra o medo e as tentações. Dai-me a força dos mártires para testemunhar Cristo.';

  @override
  String get novenaPentecostesDay6Title => '6º Dia - O Dom do Conselho';

  @override
  String get novenaPentecostesDay6Meditation =>
      'Iluminador das almas, guiai minhas decisões. Nas hesitações da vida, dai-me escolher somente aquilo que é da Vossa santíssima vontade.';

  @override
  String get novenaPentecostesDay7Title => '7º Dia - O Dom do Entendimento';

  @override
  String get novenaPentecostesDay7Meditation =>
      'Luz Divina, abri meu intelecto às verdades reveladas da fé, e afugentai para longe as cegueiras e ignorâncias da minha mente.';

  @override
  String get novenaPentecostesDay8Title => '8º Dia - O Dom da Sabedoria';

  @override
  String get novenaPentecostesDay8Meditation =>
      'Fogo de Amor Sagrado, que este dom me faça degustar a beleza de Deus, unindo-me cada vez mais profundamente na verdadeira comunhão com o Cristo.';

  @override
  String get novenaPentecostesDay9Title => '9º Dia - Os Frutos do Espírito';

  @override
  String get novenaPentecostesDay9Meditation =>
      'Ao lado da Virgem no Cenáculo, abro totalmente meu coração. Formai em mim a caridade, a alegria, a paz e todas as virtudes.';

  @override
  String get novenaPerpetuoSocorroTitle => 'Novena a N. S. do Perpétuo Socorro';

  @override
  String get novenaPerpetuoSocorroDesc =>
      'Em todas as aflições, a Mãe Imaculada nunca nega Seu perpétuo auxílio e misericórdia.';

  @override
  String get novenaPerpetuoSocorroOpening =>
      'Ó Santíssima Virgem Maria, que para inspirar-nos confiança destes a vós mesma o dulcíssimo nome de Mãe do Perpétuo Socorro! Confiando na vossa misericórdia, rogo-vos me socorrais em todas as minhas necessidades e em todas as minhas misérias desta vida corruptível. Especialmente peço, Mãe bendita, a graça de recorrer sempre a Vós; porque assim sei bem que não cairei jamais no abismo das condenações eternas.';

  @override
  String get novenaPerpetuoSocorroClosing =>
      'Lembrai-vos, ó piíssima Virgem Maria, que nunca se ouviu dizer que algum daqueles que têm recorrido à vossa proteção fosse por vós desamparado. Animado com esta confiança a vós também corro. Protegei-me e concedei o Perpétuo Socorro que urgentemente preciso. Amém.';

  @override
  String get novenaPerpetuoSocorroPrayers =>
      'Rezar 3 Ave-Marias, seguidas da jaculatória: \'Ó Maria, concebida sem pecado, rogai por nós que recorremos a vós.\'';

  @override
  String get novenaPerpetuoSocorroDay1Title =>
      '1º Dia - N. S. Rainha de Misericórdia';

  @override
  String get novenaPerpetuoSocorroDay1Meditation =>
      'Maria tem seus olhos de misericórdia sempre postos sobre mim. Seus braços abençoados nunca se fecham aos meus apelos.';

  @override
  String get novenaPerpetuoSocorroDay2Title =>
      '2º Dia - O refúgio no desespero';

  @override
  String get novenaPerpetuoSocorroDay2Meditation =>
      'Diante das tentações desesperadoras, Mãe Imaculada, mostrai-me o Menino Jesus que trazeis nos braços, meu refúgio e salvação.';

  @override
  String get novenaPerpetuoSocorroDay3Title =>
      '3º Dia - Socorro na doença e aflição';

  @override
  String get novenaPerpetuoSocorroDay3Meditation =>
      'Nenhuma aflição terrena passa despercebida pela Senhora. Peço-Vos alívio corporal ou força e resignação para cumprir a vontade divina.';

  @override
  String get novenaPerpetuoSocorroDay4Title =>
      '4º Dia - Estrela em meio à escuridão';

  @override
  String get novenaPerpetuoSocorroDay4Meditation =>
      'Nas trevas que cobrem o mundo hoje, sede minha Estrela. Mãe amada, não deixei que as falsas modas me afastem da cruz.';

  @override
  String get novenaPerpetuoSocorroDay5Title =>
      '5º Dia - Proteção e auxílio das famílias';

  @override
  String get novenaPerpetuoSocorroDay5Meditation =>
      'Ó Perpétuo Socorro, derramai abundantes bênçãos em minha casa. Mantendei-nos em união, amor e pureza de vida.';

  @override
  String get novenaPerpetuoSocorroDay6Title => '6º Dia - Refúgio dos pecadores';

  @override
  String get novenaPerpetuoSocorroDay6Meditation =>
      'Eu me reconheço indigno e fraco. Por isso Vos peço: alcançai-me as lágrimas da sincera e duradoura confissão de minhas culpas.';

  @override
  String get novenaPerpetuoSocorroDay7Title =>
      '7º Dia - Consolo nas horas minguadas';

  @override
  String get novenaPerpetuoSocorroDay7Meditation =>
      'Pela dor pungente que tivestes ao pé da cruz, vinde consolar as angústias do meu coração e acalmar os que lutam e suam por mim.';

  @override
  String get novenaPerpetuoSocorroDay8Title => '8º Dia - Fidelidade ao Rosário';

  @override
  String get novenaPerpetuoSocorroDay8Meditation =>
      'Soberana Senhora, gravai no meu espírito a fidelidade e constância ao Santo Terço diário, corrente de graças e porta de salvação.';

  @override
  String get novenaPerpetuoSocorroDay9Title => '9º Dia - A Hora da nossa morte';

  @override
  String get novenaPerpetuoSocorroDay9Meditation =>
      'Ó Mãe clemente e piedosa! Na última e definitiva batalha da minha vida, socorrei-me. Recebei-me e levai minha alma na companhia dos anjos.';

  @override
  String get novenaSaoMiguelTitle => 'Novena a São Miguel Arcanjo';

  @override
  String get novenaSaoMiguelDesc =>
      'Príncipe das Milícias Celestes, intercessor e combatente poderoso para a vitória contra os ataques malignos.';

  @override
  String get novenaSaoMiguelOpening =>
      'São Miguel Arcanjo, defendei-nos no combate; sede o nosso refúgio contra as maldades e as ciladas do demônio. Ordene-lhe Deus, instantemente o pedimos. E vós, príncipe da milícia celeste, pelo poder divino, precipitai no inferno a satanás e aos outros espíritos malignos que andam pelo mundo para perder as almas. Amém.';

  @override
  String get novenaSaoMiguelClosing =>
      'Ó glorioso Príncipe da Milícia Celeste, São Miguel Arcanjo! Pelo Vosso clamor \'Quem como Deus?\', recebei os meus humildes pedidos e apresentai-os diante do trono do Altíssimo. Amém.';

  @override
  String get novenaSaoMiguelPrayers =>
      'Rezar 1 Pai-Nosso, 3 Ave-Marias e o Glória ao Pai (preferencialmente após a oração a São Miguel).';

  @override
  String get novenaSaoMiguelDay1Title => '1º Dia - Príncipe Fidelíssimo';

  @override
  String get novenaSaoMiguelDay1Meditation =>
      'São Miguel, pelo Vosso zelo à glória de Deus, impulsionai-me a não ter respeito humano e a dar sempre a honra devida a Nosso Senhor.';

  @override
  String get novenaSaoMiguelDay2Title => '2º Dia - Destruidor do Orgulho';

  @override
  String get novenaSaoMiguelDay2Meditation =>
      'Arcanjo luminoso, que despedaçastes o orgulho satânico, extirpai em mim tudo que não é humildade genuína.';

  @override
  String get novenaSaoMiguelDay3Title => '3º Dia - Terror de Satanás';

  @override
  String get novenaSaoMiguelDay3Meditation =>
      'Ó terror do abismo, afugentai com Vossa espada empunhada toda insinuação demoníaca de impureza e desespero.';

  @override
  String get novenaSaoMiguelDay4Title => '4º Dia - Defensor da Igreja';

  @override
  String get novenaSaoMiguelDay4Meditation =>
      'Protegei a Santa Mãe Igreja, o Sumo Pontífice, clérigos e leigos de todos os inimigos visíveis e invisíveis que planejam destruí-la.';

  @override
  String get novenaSaoMiguelDay5Title => '5º Dia - Consolo das Almas';

  @override
  String get novenaSaoMiguelDay5Meditation =>
      'São Miguel formidável, portador da balança da justiça divina, trazei consolação na hora extrema aos agonizantes e aflitos.';

  @override
  String get novenaSaoMiguelDay6Title =>
      '6º Dia - Vencedor nos perigos espirituais';

  @override
  String get novenaSaoMiguelDay6Meditation =>
      'Socorrei-me nas lutas ocultas. Rompei com o Vosso grito guerreiro as amarras de vícios secretos e faltas habituais em minha vida.';

  @override
  String get novenaSaoMiguelDay7Title =>
      '7º Dia - Padrão dos servos e militares de Cristo';

  @override
  String get novenaSaoMiguelDay7Meditation =>
      'Formai-me um verdadeiro discípulo valoroso da doutrina, não cedendo espaço e nem condescendência com as coisas enganosas do mundo.';

  @override
  String get novenaSaoMiguelDay8Title => '8º Dia - Escudo das famílias';

  @override
  String get novenaSaoMiguelDay8Meditation =>
      'Dignai-vos São Miguel colocar vossos anjos sob a porta de minha casa, defendendo minha família de discórdias e invejas.';

  @override
  String get novenaSaoMiguelDay9Title => '9º Dia - Apresentador das almas';

  @override
  String get novenaSaoMiguelDay9Meditation =>
      'No dia do juízo, quando minha alma comparecer diante do rigor da balança divina, peço que compareçais por mim como fiador. Amém.';

  @override
  String get novenaAlmasTitle => 'Novena pelas Almas do Purgatório';

  @override
  String get novenaAlmasDesc =>
      'A mais nobre obra de caridade: interceder através do sacrifício para abreviar o sofrimento das almas padecentes.';

  @override
  String get novenaAlmasOpening =>
      'Senhor meu Jesus Cristo, Redentor nosso, que Vos dignastes derramar o Vosso preciosíssimo Sangue para remir o mundo e salvar as almas, eu Vos suplico humildemente, pelas dores de Vossa Santíssima Mãe e por Vossa Divina chagas, tenhais misericórdia das Almas do Purgatório, especialmente aquelas por quem sou mais obrigado a pedir.';

  @override
  String get novenaAlmasClosing =>
      'Dai-lhes, Senhor, o descanso eterno. E que a luz perpétua as ilumine. Descansem em paz. Amém. Doce Coração de Maria, sede a salvação das almas do purgatório.';

  @override
  String get novenaAlmasPrayers =>
      'Rezar 1 Pai-Nosso, 1 Ave-Maria e a oração \'Dai-lhes Senhor o descanso eterno\'.';

  @override
  String get novenaAlmasDay1Title => '1º Dia - A gravidade do pecado';

  @override
  String get novenaAlmasDay1Meditation =>
      'As almas sofrem tormentos incríveis porque o pecado ofende um Deus de bondade infinita. Senhor, livrai as almas esquecidas e fazei-me chorar meus próprios pecados.';

  @override
  String get novenaAlmasDay2Title =>
      '2º Dia - Os pais e familiares no Purgatório';

  @override
  String get novenaAlmasDay2Meditation =>
      'Jesus amado, rogo por todas as almas de que minha família tem sangue ou dívida. Sede Vós sua libertação imediata e eterna purificação.';

  @override
  String get novenaAlmasDay3Title => '3º Dia - Almas e devoções à Virgem';

  @override
  String get novenaAlmasDay3Meditation =>
      'Descei, Senhora e Mãe Celeste, ao abismo dessas dores. Aliviai as devotas de Vosso rosário e escapulário com o orvalho dos Seus méritos.';

  @override
  String get novenaAlmasDay4Title => '4º Dia - A alma mais esquecida';

  @override
  String get novenaAlmasDay4Meditation =>
      'Ó Misericórdia de Deus, aplico esta intenção por aquela alma no purgatório que não tem absolutamente NINGUÉM no mundo inteiro que por ela reze.';

  @override
  String get novenaAlmasDay5Title => '5º Dia - Sacerdotes e Religiosos';

  @override
  String get novenaAlmasDay5Meditation =>
      'Lembrando da grande responsabilidade dos Santos Óleos, rogo em especial pelas almas sacerdotais que demoram a chegar até a Vossa visão celestial.';

  @override
  String get novenaAlmasDay6Title => '6º Dia - A justiça de Deus';

  @override
  String get novenaAlmasDay6Meditation =>
      'A santidade de Deus é fogo devorador, exigindo pagamento pelo menor dos faltosos passos. Pelos méritos da Santa Cruz, pagai Vós o débito, Senhor Jesus.';

  @override
  String get novenaAlmasDay7Title => '7º Dia - As que mais tempo lá estarão';

  @override
  String get novenaAlmasDay7Meditation =>
      'Aquelas almas culpadas pelas piores penas purificativas contam com um infinito intercessor. Peço, ó Sangue de Cristo, apagai a conta infindável.';

  @override
  String get novenaAlmasDay8Title => '8º Dia - As almas mais próximas do Céu';

  @override
  String get novenaAlmasDay8Meditation =>
      'Clamo por aquelas almas que estão à porta, carecendo daquela última gota de prece para entrar. Que subam hoje à glória!';

  @override
  String get novenaAlmasDay9Title => '9º Dia - O Santo Sacrifício da Missa';

  @override
  String get novenaAlmasDay9Meditation =>
      'Senhor, Vós que num altar oferecestes tudo, uni amanhã os méritos da Santa Missa a essas almas todas, resgatando as legiões aos coros celestes. Amém.';

  @override
  String get fontSizeTitle => 'Tamanho do texto';

  @override
  String get fontSizeSubtitle =>
      'Aumente para facilitar a leitura das orações em todo o app.';

  @override
  String get fontSizeSample =>
      'Pai nosso, que estais nos céus, santificado seja o vosso nome.';

  @override
  String get todayRosaryCardTitle => 'Rezar o terço de hoje';

  @override
  String get todayRosaryCardSubtitle => 'Mistérios do dia';

  @override
  String get onbWelcomeTitle => 'Bem-vindo ao Sancta Devocionário Católico';

  @override
  String get onbWelcomeBody =>
      'Um companheiro para a sua vida de oração e para a preparação da confissão.';

  @override
  String get onbFeaturesTitle => 'Tudo em um só lugar';

  @override
  String get onbFeatureGarden =>
      'Jardim: seu plano de orações do dia e o histórico';

  @override
  String get onbFeaturePrayers => 'Orações tradicionais, com busca por nome';

  @override
  String get onbFeatureExam => 'Exame de consciência protegido por senha';

  @override
  String get onbNotifTitle => 'Lembretes no seu horário';

  @override
  String get onbNotifBody =>
      'Ative as notificações para receber lembretes de oração, novenas e confissão. Você pode mudar isso depois.';

  @override
  String get onbEnableNotifications => 'Ativar lembretes';

  @override
  String get onbNext => 'Continuar';

  @override
  String get onbSkip => 'Pular';

  @override
  String get onbStart => 'Agora não';

  @override
  String get notifHealthTitle => 'Lembretes e notificações';

  @override
  String get notifHealthAllGood =>
      'Tudo certo: seus lembretes podem tocar no horário.';

  @override
  String get notifHealthNotificationsOff =>
      'As notificações estão desativadas.';

  @override
  String get notifHealthExactAlarmOff =>
      'Alarmes exatos estão bloqueados; os lembretes podem atrasar.';

  @override
  String get notifHealthFixAction => 'Corrigir';

  @override
  String get notifHealthBatteryHint =>
      'Se os lembretes ainda falharem, nos ajustes do aparelho retire o app da economia de bateria.';

  @override
  String get backupProtectTitle => 'Proteger o backup com senha?';

  @override
  String get backupProtectBody =>
      'O backup contém dados sensíveis, como o registro de pecados. Com uma senha, só quem a souber poderá abrir o arquivo. Guarde-a: sem ela o backup não pode ser recuperado.';

  @override
  String get backupPasswordLabel => 'Senha do backup';

  @override
  String get backupPasswordConfirmLabel => 'Repita a senha';

  @override
  String get backupPasswordMismatch => 'As senhas não conferem.';

  @override
  String get backupPasswordTooShort => 'Use pelo menos 6 caracteres.';

  @override
  String get backupProtectAction => 'Proteger e exportar';

  @override
  String get backupNoProtectAction => 'Exportar sem senha';

  @override
  String get backupEnterPasswordTitle => 'Backup protegido';

  @override
  String get backupEnterPasswordBody =>
      'Digite a senha usada ao exportar este backup.';

  @override
  String get backupWrongPassword => 'Senha incorreta ou arquivo alterado.';

  @override
  String get backupOpenAction => 'Abrir';

  @override
  String get backupExportError => 'Não foi possível exportar o backup.';

  @override
  String get backupImportError => 'Não foi possível importar o backup.';

  @override
  String get backupImportSuccess => 'Backup restaurado com sucesso!';

  @override
  String novenaPrayedTimes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Rezada $count vezes',
      one: 'Rezada 1 vez',
    );
    return '$_temp0';
  }

  @override
  String novenaCompletedOn(String date) {
    return 'Concluída em $date';
  }

  @override
  String get novenaStartAgain => 'Rezar novamente';

  @override
  String novenaPrayedBefore(int count, String date) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Você já rezou esta novena $count vezes',
      one: 'Você já rezou esta novena 1 vez',
    );
    return '$_temp0. Última conclusão: $date.';
  }

  @override
  String novenaMarkDayDone(int day) {
    return 'Marcar o dia $day como rezado';
  }

  @override
  String novenaDayDoneLabel(int day) {
    return 'Dia $day rezado';
  }

  @override
  String examSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marcados',
      one: '1 marcado',
    );
    return '$_temp0';
  }

  @override
  String examGuideTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count itens marcados no exame',
      one: '1 item marcado no exame',
    );
    return '$_temp0';
  }

  @override
  String get examGuideHint =>
      'Marque os pecados nas categorias para gerar o guia.';

  @override
  String get reportCopy => 'Copiar guia';

  @override
  String get reportShare => 'Compartilhar guia';

  @override
  String get reportCopied => 'Guia copiado. Cole só em lugares privados.';

  @override
  String get reportLastConfessionNone =>
      'Não tenho registro da minha última Confissão.';

  @override
  String rosaryMysteryOf(int current, int total) {
    return 'Mistério $current de $total';
  }

  @override
  String get rosaryOpeningPhase => 'Orações iniciais';

  @override
  String get rosaryClosingPhase => 'Encerramento';

  @override
  String get rosaryPrayNow => 'Rezar agora';

  @override
  String get rosaryOtherMysteries => 'Outros mistérios';

  @override
  String get rosaryHapticsToggle => 'Vibração no terço';

  @override
  String get rosaryHapticsSubtitle => 'Uma leve vibração a cada oração';

  @override
  String get prayerForMorning => 'Para esta manhã';

  @override
  String get prayerForNoon => 'Para o meio-dia';

  @override
  String get prayerForNight => 'Para esta noite';

  @override
  String get prayersSectionCategories => 'Categorias';

  @override
  String prayersCountLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count orações',
      one: '1 oração',
      zero: 'Nenhuma oração',
    );
    return '$_temp0';
  }

  @override
  String get novenasInProgress => 'Em andamento';

  @override
  String get novenasAll => 'Todas as novenas';

  @override
  String get novenasIntro =>
      'Uma novena são nove dias seguidos de oração. Escolha uma abaixo para começar.';

  @override
  String get novenaContinue => 'Continuar';

  @override
  String historyNovenaLabel(String title) {
    return 'Novena: $title';
  }

  @override
  String get planEmptyTitle => 'Seu plano de oração está vazio.';

  @override
  String get planEmptySubtitle =>
      'Adicione orações para começar a cultivar seu jardim.';

  @override
  String get penanceMarkedDone => 'Penitência marcada como cumprida';

  @override
  String get undoAction => 'Desfazer';

  @override
  String get confessionDateLabel => 'Data da Confissão';

  @override
  String get confessionRetroactiveHint =>
      'Agendado para hoje/amanhã (confissão retroativa)';

  @override
  String get backupShareSubject => 'Backup Jardim da Alma';

  @override
  String get prayerActContritionTitle => 'Ato de Contrição';

  @override
  String get prayerActContritionContent =>
      'Senhor meu Jesus Cristo, Deus e homem verdadeiro, Criador e Redentor meu, por serdes Vós quem sois, sumamente bom e digno de ser amado sobre todas as coisas, e porque Vos amo e estimo, pesa-me, Senhor, de todo o coração, de Vos ter ofendido.\n\nProponho firmemente nunca mais pecar e afastar-me de todas as ocasiões próximas de pecado. Confesso-me, satisfarei a penitência e espero na Vossa bondade e misericórdia infinita que me perdoareis, pela Vossa Paixão e Morte, e me dareis a graça de me emendar e de perseverar no Vosso santo serviço até o fim da minha vida. Amém.';

  @override
  String get prayerConfiteorTitle => 'Confiteor (Confesso a Deus)';

  @override
  String get prayerConfiteorContent =>
      'Eu, pecador, confesso a Deus todo-poderoso, à bem-aventurada sempre Virgem Maria, ao bem-aventurado Miguel Arcanjo, ao bem-aventurado João Batista, aos santos Apóstolos Pedro e Paulo, a todos os Santos e a vós, Padre, que pequei muitas vezes, por pensamentos, palavras e obras; por minha culpa, minha culpa, minha máxima culpa.\n\nPortanto, rogo à bem-aventurada sempre Virgem Maria, ao bem-aventurado Miguel Arcanjo, ao bem-aventurado João Batista, aos santos Apóstolos Pedro e Paulo, a todos os Santos e a vós, Padre, que rogueis por mim a Deus nosso Senhor. Amém.';

  @override
  String get prayerConfiteorContentLatin =>
      'Confiteor Deo omnipotenti, beatae Mariae semper Virgini, beato Michaeli Archangelo, beato Ioanni Baptistae, sanctis Apostolis Petro et Paulo, omnibus Sanctis, et tibi, Pater: quia peccavi nimis cogitatione, verbo et opere: mea culpa, mea culpa, mea maxima culpa.\n\nIdeo precor beatam Mariam semper Virginem, beatum Michaelem Archangelum, beatum Ioannem Baptistam, sanctos Apostolos Petrum et Paulum, omnes Sanctos, et te, Pater, orare pro me ad Dominum Deum nostrum. Amen.';

  @override
  String get prayerBeforeConfessionTitle => 'Antes da Confissão';

  @override
  String get prayerBeforeConfessionContent =>
      'Vinde, Espírito Santo, iluminai a minha consciência para que eu reconheça os meus pecados. Dai-me a graça de confessá-los com sinceridade, humildade e confiança na misericórdia de Deus.\n\nNossa Senhora, Mãe de misericórdia, rogai por mim. Amém.';

  @override
  String get prayerAfterConfessionTitle => 'Depois da Confissão';

  @override
  String get prayerAfterConfessionContent =>
      'Obrigado, Senhor, pelo perdão que me concedestes. Ajudai-me a cumprir a penitência, a evitar as ocasiões de pecado e a perseverar na Vossa graça.\n\nMaria, Refúgio dos pecadores, rogai por mim. Amém.';

  @override
  String get prayerBeforeCommunionTitle => 'Antes da Comunhão';

  @override
  String get prayerBeforeCommunionContent =>
      'Senhor Jesus, creio que estais verdadeiramente presente na Eucaristia, com o Vosso Corpo, Sangue, Alma e Divindade. Purificai o meu coração e preparai-me para Vos receber.\n\nSenhor, eu não sou digno de que entreis em minha morada, mas dizei uma palavra e serei salvo.';

  @override
  String get prayerAfterCommunionTitle => 'Depois da Comunhão';

  @override
  String get prayerAfterCommunionContent =>
      'Jesus, meu Senhor e meu Deus, agradeço-Vos por Vos dardes a mim neste Sacramento. Permanecei comigo, guardai-me do pecado e fazei de mim instrumento da Vossa paz.\n\nAlma de Cristo, santificai-me. Corpo de Cristo, salvai-me. Sangue de Cristo, inebriai-me. Amém.';

  @override
  String get prayerTheologicalActsTitle => 'Atos de Fé, Esperança e Caridade';

  @override
  String get prayerTheologicalActsContent =>
      'Ato de Fé\nMeu Deus, creio firmemente em tudo o que a Santa Igreja Católica propõe a crer, porque Vós o revelastes, Vós que sois a própria Verdade e não podeis enganar-Vos nem enganar-nos.\n\nAto de Esperança\nMeu Deus, espero da Vossa bondade, pelos méritos de Jesus Cristo, a vida eterna e as graças necessárias para a merecer pelas boas obras que devo e quero praticar.\n\nAto de Caridade\nMeu Deus, amo-Vos de todo o coração sobre todas as coisas, porque sois infinitamente bom e digno de ser amado; e, por amor de Vós, amo o meu próximo como a mim mesmo.';

  @override
  String get prayerTantumErgoTitle => 'Tantum Ergo';

  @override
  String get prayerTantumErgoContent =>
      'Veneremos, prostrados, tão grande Sacramento; e o antigo rito dê lugar ao novo culto; a fé supra o que faltam os sentidos.\n\nAo Pai e ao Filho, louvor e júbilo, salvação, honra, poder e bênção; e Àquele que procede de ambos, igual louvor. Amém.';

  @override
  String get prayerTantumErgoContentLatin =>
      'Tantum ergo Sacramentum\nveneremur cernui:\net antiquum documentum\nnovo cedat ritui:\npraestet fides supplementum\nsensuum defectui.\n\nGenitori, Genitoque\nlaus et iubilatio,\nsalus, honor, virtus quoque\nsit et benedictio:\nprocedenti ab utroque\ncompar sit laudatio.\nAmen.';

  @override
  String get prayerPsalm50Title => 'Salmo 50 (Miserere)';

  @override
  String get prayerPsalm50Content =>
      'Tem piedade de mim, ó Deus, segundo a tua grande misericórdia. E segundo as muitas mostras da tua clemência, apaga a minha maldade. Lava-me mais e mais da minha iniquidade: e purifica-me do meu pecado.\n\nPorque a minha maldade eu a conheço: e o meu pecado diante de mim está sempre. Contra ti só pequei, e fiz o mal diante dos teus olhos: para que sejas justificado nas tuas palavras, e venças quando fores julgado.\n\nEis aqui sabes que eu fui concebido em iniquidades: e em pecados me concebeu minha mãe. E bem vejo que tu amaste a verdade: e me revelaste o segredo, e o escondido do teu saber.\n\nTu me borrifarás com o hissopo, e serei purificado: lavar-me-ás, e me tornarei mais branco que a neve. Ao meu ouvido darás gozo e alegria: e se regozijarão os meus ossos humilhados.\n\nAparta o teu rosto dos meus pecados: e apaga todas as minhas maldades. Cria em mim, ó Deus, um coração puro: e renova nas minhas entranhas um espírito reto. Não me arremesses da tua presença: e não tires de mim o teu Espírito Santo.\n\nDá-me a alegria da tua salvação: e conforta-me por meio do espírito principal. Ensinarei aos iníquos os teus caminhos: e os ímpios se converterão a ti.\n\nLivra-me dos sangues, ó Deus, Deus da minha salvação: e a minha língua exaltará a tua justiça. Senhor, abrirás os meus lábios: e a minha boca anunciará o teu louvor.\n\nPorque, se quisesses sacrifícios, tos dera: tu não te deleitarás em holocaustos. O sacrifício para Deus é um espírito atribulado: o coração quebrantado e humilhado, ó Deus, não o desprezarás.\n\nSenhor, trata benignamente a Sião segundo a tua boa vontade: para que sejam edificados os muros de Jerusalém. Então aceitarás o sacrifício de justiça, as oblações, e os holocaustos: então porão touros sobre o teu altar.';

  @override
  String get prayerPsalm50ContentLatin =>
      'Miserere mei, Deus, secundum magnam misericordiam tuam. Et secundum multitudinem miserationum tuarum, dele iniquitatem meam.\n\nAmplius lava me ab iniquitate mea, et a peccato meo munda me. Quoniam iniquitatem meam ego cognosco, et peccatum meum contra me est semper.\n\nTibi soli peccavi, et malum coram te feci: ut iustificeris in sermonibus tuis, et vincas cum iudicaris.\n\nEcce enim in iniquitatibus conceptus sum, et in peccatis concepit me mater mea. Ecce enim veritatem dilexisti: incerta et occulta sapientiae tuae manifestasti mihi.\n\nAsperges me hyssopo, et mundabor: lavabis me, et super nivem dealbabor. Auditui meo dabis gaudium et laetitiam: et exsultabunt ossa humiliata.\n\nAverte faciem tuam a peccatis meis, et omnes iniquitates meas dele. Cor mundum crea in me, Deus: et spiritum rectum innova in visceribus meis.\n\nNe proiicias me a facie tua: et spiritum sanctum tuum ne auferas a me. Redde mihi laetitiam salutaris tui: et spiritu principali confirma me.\n\nDocebo iniquos vias tuas: et impii ad te convertentur.\n\nLibera me de sanguinibus, Deus, Deus salutis meae: et exsultabit lingua mea iustitiam tuam. Domine, labia mea aperies: et os meum annuntiabit laudem tuam.\n\nQuoniam si voluisses sacrificium, dedissem utique: holocaustis non delectaberis. Sacrificium Deo spiritus contribulatus: cor contritum, et humiliatum, Deus, non despicies.\n\nBenigne fac, Domine, in bona voluntate tua Sion: ut aedificentur muri Ierusalem. Tunc acceptabis sacrificium iustitiae, oblationes, et holocausta: tunc imponent super altare tuum vitulos.';

  @override
  String get prayerPsalm129Title => 'Salmo 129 (De Profundis)';

  @override
  String get prayerPsalm129Content =>
      'Das profundezas clamei a vós, Senhor; Senhor, escutai a minha voz. Estejam os vossos ouvidos atentos à voz da minha súplica.\n\nSe observardes, Senhor, as iniquidades: Senhor, quem poderá subsistir? Porque em vós está a misericórdia; e por amor da vossa lei esperei em vós, Senhor.\n\nEsperou a minha alma na sua palavra; esperou a minha alma no Senhor. Desde a vigília matutina até à noite, espere Israel no Senhor. Porque no Senhor está a misericórdia: e nele há copiosa redenção. E ele mesmo remirá a Israel de todas as suas iniquidades.\n\nDai-lhes, Senhor, o eterno descanso, e brilhe para eles a luz perpétua. Amém.';

  @override
  String get prayerPsalm129ContentLatin =>
      'De profundis clamavi ad te, Domine; Domine, exaudi vocem meam. Fiant aures tuae intendentes in vocem deprecationis meae.\n\nSi iniquitates observaveris, Domine, Domine, quis sustinebit? Quia apud te propitiatio est, et propter legem tuam sustinui te, Domine.\n\nSustinuit anima mea in verbo eius; speravit anima mea in Domino. A custodia matutina usque ad noctem speret Israel in Domino.\n\nQuia apud Dominum misericordia, et copiosa apud eum redemptio. Et ipse redimet Israel ex omnibus iniquitatibus eius.\n\nRequiem aeternam dona eis, Domine, et lux perpetua luceat eis. Amen.';

  @override
  String get prayerPsalm22Title => 'Salmo 22 (O Senhor é meu pastor)';

  @override
  String get prayerPsalm22Content =>
      'O Senhor me governa, e nada me faltará: em um lugar de pastos ali me colocou. Ele me conduziu junto a uma água de refeição: converteu a minha alma.\n\nLevou-me por veredas de justiça, por amor do seu nome. Pois ainda quando andar no meio da sombra da morte, não temerei males: porquanto tu estás comigo. A tua vara, e o teu báculo, eles me consolaram.\n\nPreparaste uma mesa diante de mim, à vista daqueles que me angustiavam. Ungiste com o óleo pingue a minha cabeça: e o meu cálix que embriaga quão precioso é!\n\nE a tua misericórdia irá após de mim todos os dias da minha vida: e a fim de que eu habite na casa do Senhor, por diuturnidade de dias.';

  @override
  String get prayerPsalm22ContentLatin =>
      'Dominus regit me, et nihil mihi deerit: in loco pascuae ibi me collocavit. Super aquam refectionis educavit me: animam meam convertit.\n\nDeduxit me super semitas iustitiae, propter nomen suum. Nam et si ambulavero in medio umbrae mortis, non timebo mala: quoniam tu mecum es. Virga tua, et baculus tuus: ipsa me consolata sunt.\n\nParasti in conspectu meo mensam, adversus eos qui tribulant me. Impinguasti in oleo caput meum: et calix meus inebrians quam praeclarus est!\n\nEt misericordia tua subsequetur me omnibus diebus vitae meae: et ut inhabitem in domo Domini, in longitudinem dierum.';

  @override
  String get prayerMagnificatTitle => 'Magnificat';

  @override
  String get prayerMagnificatContent =>
      'A minha alma glorifica o Senhor, e o meu espírito se alegrou por extremo em Deus, meu Salvador, por ele ter posto os olhos na baixeza da sua escrava: porque eis aí de hoje em diante me chamarão bem-aventurada todas as gerações.\n\nPorque me fez grandes coisas o que é Poderoso: e santo o seu nome. E a sua misericórdia se estende de geração a geração sobre os que o temem.\n\nEle manifestou o poder do seu braço: dissipou os que no fundo do seu coração formavam altivos pensamentos. Depôs do trono os poderosos, e elevou os humildes. Encheu de bens os famintos: e despediu vazios os ricos.\n\nRecebeu a Israel seu servo, lembrado da sua misericórdia. Como tinha falado a nossos pais, a Abraão e à sua descendência para sempre.';

  @override
  String get prayerMagnificatContentLatin =>
      'Magnificat anima mea Dominum, et exsultavit spiritus meus in Deo salutari meo, quia respexit humilitatem ancillae suae; ecce enim ex hoc beatam me dicent omnes generationes.\n\nQuia fecit mihi magna qui potens est, et sanctum nomen eius, et misericordia eius in progenies et progenies timentibus eum.\n\nFecit potentiam in brachio suo, dispersit superbos mente cordis sui; deposuit potentes de sede et exaltavit humiles; esurientes implevit bonis et divites dimisit inanes.\n\nSuscepit Israel puerum suum, recordatus misericordiae suae, sicut locutus est ad patres nostros, Abraham et semini eius in saecula.';

  @override
  String get prayerViaSacraTitle => 'Via-Sacra';

  @override
  String get prayerViaSacraContent =>
      'Em cada estação, diz-se:\nV. Nós vos adoramos, Senhor Jesus Cristo, e vos bendizemos.\nR. Porque pela vossa santa Cruz remistes o mundo.\n\n1ª Estação – Jesus é condenado à morte\nJesus, inocente, aceita a sentença injusta por amor de mim.\n\n2ª Estação – Jesus carrega a cruz\nSenhor, ajudai-me a levar com amor as cruzes de cada dia.\n\n3ª Estação – Jesus cai pela primeira vez\nQuando eu cair no pecado, levantai-me, Senhor.\n\n4ª Estação – Jesus encontra sua Mãe\nMaria, Mãe das Dores, ensinai-me a permanecer junto à cruz.\n\n5ª Estação – Simão Cireneu ajuda Jesus a carregar a cruz\nQue eu saiba ajudar quem sofre ao meu lado.\n\n6ª Estação – Verônica enxuga o rosto de Jesus\nGravai em meu coração o Vosso santo rosto.\n\n7ª Estação – Jesus cai pela segunda vez\nNão permitais que o desânimo me vença.\n\n8ª Estação – Jesus consola as mulheres de Jerusalém\nDai-me a graça de chorar os meus pecados.\n\n9ª Estação – Jesus cai pela terceira vez\nDai-me perseverança até o fim.\n\n10ª Estação – Jesus é despojado de suas vestes\nDespojai-me do apego às coisas passageiras.\n\n11ª Estação – Jesus é pregado na cruz\nSenhor, pregai ao Vosso amor a minha vontade.\n\n12ª Estação – Jesus morre na cruz\nObrigado, Jesus, por Vos entregardes por mim.\n\n13ª Estação – Jesus é descido da cruz e entregue a sua Mãe\nMaria, acolhei-me também em vossos braços.\n\n14ª Estação – Jesus é colocado no sepulcro\nQue eu morra para o pecado e ressuscite convosco.\n\nAo final, reza-se um Pai-Nosso, uma Ave-Maria e um Glória pelas intenções do Santo Padre.';

  @override
  String get prayerDivineMercyChapletTitle => 'Terço da Divina Misericórdia';

  @override
  String get prayerDivineMercyChapletContent =>
      'Faz-se o Sinal da Cruz e reza-se, opcionalmente:\nExpirastes, Jesus, mas jorrou uma fonte de vida para as almas e abriu-se um mar de misericórdia para o mundo inteiro. Ó fonte de vida, insondável misericórdia de Deus, envolvei o mundo inteiro e derramai-Vos sobre nós. Jesus, eu confio em Vós!\n\nInício: um Pai-Nosso, uma Ave-Maria e o Credo.\n\nNas contas grandes (uma vez em cada dezena):\nEterno Pai, eu Vos ofereço o Corpo e Sangue, Alma e Divindade de Vosso diletíssimo Filho, Nosso Senhor Jesus Cristo, em expiação dos nossos pecados e dos do mundo inteiro.\n\nNas contas pequenas (dez vezes em cada dezena):\nPela sua dolorosa Paixão, tende misericórdia de nós e do mundo inteiro.\n\nAo final (três vezes):\nSanto Deus, Santo Forte, Santo Imortal, tende piedade de nós e do mundo inteiro.\n\nReza-se de preferência às 15 horas, a hora da misericórdia.';

  @override
  String get prayerMemorareTitle => 'Lembrai-vos (Memorare)';

  @override
  String get prayerMemorareContent =>
      'Lembrai-vos, ó piíssima Virgem Maria, que nunca se ouviu dizer que algum daqueles que recorreram à vossa proteção, imploraram a vossa assistência e reclamaram o vosso socorro fosse por vós desamparado.\n\nAnimado eu, pois, de igual confiança, a vós, ó Virgem entre todas singular, como a Mãe recorro, de vós me valho e, gemendo sob o peso dos meus pecados, me prostro a vossos pés.\n\nNão rejeiteis as minhas súplicas, ó Mãe do Filho de Deus humanado, mas dignai-vos de as ouvir propícia e de me alcançar o que vos rogo. Amém.';

  @override
  String get prayerMemorareContentLatin =>
      'Memorare, o piissima Virgo Maria, non esse auditum a saeculo, quemquam ad tua currentem praesidia, tua implorantem auxilia, tua petentem suffragia, esse derelictum.\n\nEgo tali animatus confidentia, ad te, Virgo Virginum, Mater, curro, ad te venio, coram te gemens peccator assisto.\n\nNoli, Mater Verbi, verba mea despicere; sed audi propitia et exaudi. Amen.';

  @override
  String get prayerStMichaelTitle => 'Oração a São Miguel Arcanjo';

  @override
  String get prayerStMichaelContent =>
      'São Miguel Arcanjo, defendei-nos no combate; sede o nosso refúgio contra a maldade e as ciladas do demônio.\n\nOrdene-lhe Deus, instantemente o pedimos, e vós, príncipe da milícia celeste, pelo poder divino, precipitai no inferno a satanás e a todos os espíritos malignos que andam pelo mundo para perder as almas. Amém.';

  @override
  String get prayerStMichaelContentLatin =>
      'Sancte Michael Archangele, defende nos in proelio; contra nequitiam et insidias diaboli esto praesidium.\n\nImperet illi Deus, supplices deprecamur: tuque, Princeps militiae caelestis, Satanam aliosque spiritus malignos, qui ad perditionem animarum pervagantur in mundo, divina virtute in infernum detrude. Amen.';

  @override
  String get prayerEternalRestTitle => 'Eterno Descanso (pelos defuntos)';

  @override
  String get prayerEternalRestContent =>
      'Dai-lhes, Senhor, o eterno descanso, e brilhe para eles a luz perpétua.\n\nDescansem em paz. Amém.';

  @override
  String get prayerEternalRestContentLatin =>
      'Requiem aeternam dona eis, Domine, et lux perpetua luceat eis.\n\nRequiescant in pace. Amen.';

  @override
  String get prayerGraceAfterMealsTitle => 'Graças depois das refeições';

  @override
  String get prayerGraceAfterMealsContent =>
      'Agradecemos-vos, Deus todo-poderoso, todos os vossos benefícios, vós que viveis e reinais pelos séculos dos séculos. Amém.\n\nDeus nos dê a sua paz e a vida eterna. Amém.\n\nE as almas dos fiéis defuntos, pela misericórdia de Deus, descansem em paz. Amém.';

  @override
  String get prayerGraceAfterMealsContentLatin =>
      'Agimus tibi gratias, omnipotens Deus, pro universis beneficiis tuis, qui vivis et regnas in saecula saeculorum. Amen.';

  @override
  String get catPrayersSacraments => 'Sacramentos';

  @override
  String get catPrayersPsalms => 'Salmos e Cânticos';

  @override
  String get catPrayersDevotions => 'Devoções';

  @override
  String get massCardTitle => 'Fui à missa';

  @override
  String get massCardSubtitle =>
      'Registre a missa de hoje e faça florescer uma flor dourada';

  @override
  String get massCardSubtitleSunday =>
      'Domingo, dia do Senhor. Registre a sua missa';

  @override
  String get massCardDoneTitle => 'Missa de hoje registrada';

  @override
  String get massCardDoneSubtitle => 'Uma flor dourada floresceu no seu jardim';

  @override
  String get massMarkedSnack => 'Missa registrada. Deus abençoe o seu jardim!';

  @override
  String get massUnmarkedSnack => 'Missa desmarcada';

  @override
  String get heatmapMassLabel => 'Missa';

  @override
  String get massMarkDay => 'Marcar missa neste dia';

  @override
  String get massUnmarkDay => 'Desmarcar missa';

  @override
  String massMonthCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count missas neste mês',
      one: '1 missa neste mês',
    );
    return '$_temp0';
  }

  @override
  String massSundayStreak(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count domingos seguidos',
      one: '1 domingo',
    );
    return '$_temp0';
  }

  @override
  String get gardenGrowthHint =>
      'Sem oração, o gramado do dia fica seco e amarelado; a cada oração ele reverdece, e a missa ou a confissão o deixam totalmente verde. Cada oração planta uma florzinha. Toque em um dia para ver o que foi rezado.';

  @override
  String gardenSemantics(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Jardim da Alma: $count dias com oração no último ano',
      one: 'Jardim da Alma: 1 dia com oração no último ano',
      zero: 'Jardim da Alma: nenhum dia com oração no último ano',
    );
    return '$_temp0';
  }

  @override
  String get novenaAparecidaTitle => 'Novena a Nossa Senhora Aparecida';

  @override
  String get novenaAparecidaDesc =>
      'Padroeira do Brasil. Festa em 12 de outubro. Nove dias aos pés da Mãe que o povo encontrou nas águas do rio Paraíba.';

  @override
  String get novenaAparecidaOpening =>
      'Ó Virgem Imaculada, Mãe de Deus e minha Mãe, Senhora Aparecida, Rainha e Padroeira do Brasil, eu me coloco sob o vosso manto. Acolhei os meus pedidos e os meus agradecimentos e levai-os ao vosso Filho, Jesus Cristo, meu Senhor e meu Salvador.';

  @override
  String get novenaAparecidaClosing =>
      'Nossa Senhora Aparecida, Mãe do Redentor, abençoai o Brasil, as nossas famílias e a todos os que recorrem a vós. Mostrai-nos Jesus e conduzi-nos a Ele. Amém.';

  @override
  String get novenaAparecidaPrayers =>
      'Rezar 1 Pai-Nosso, 3 Ave-Marias e a Salve Rainha.';

  @override
  String get novenaAparecidaDay1Title => '1º Dia - A Mãe que nos acolhe';

  @override
  String get novenaAparecidaDay1Meditation =>
      'Mãe Aparecida, que vos deixastes encontrar pelos simples, ensinai-me a procurar Deus na humildade e a confiar no vosso amor de Mãe.';

  @override
  String get novenaAparecidaDay2Title => '2º Dia - A rede que se encheu';

  @override
  String get novenaAparecidaDay2Meditation =>
      'Como os pescadores que lançaram a rede e a encheram, ajudai-me a confiar na palavra de Jesus e a lançar a rede de novo, mesmo depois de noites sem fruto.';

  @override
  String get novenaAparecidaDay3Title => '3º Dia - Mãe de Deus';

  @override
  String get novenaAparecidaDay3Meditation =>
      'Santa Maria, Mãe de Deus, que dissestes sim ao anjo, dai-me um coração disponível para cumprir a vontade do Senhor em tudo.';

  @override
  String get novenaAparecidaDay4Title => '4º Dia - Mãe dos pobres e aflitos';

  @override
  String get novenaAparecidaDay4Meditation =>
      'Mãe Aparecida, olhai pelos que passam fome, pelos que não têm casa nem trabalho, e tornai-me atento às necessidades de quem está perto de mim.';

  @override
  String get novenaAparecidaDay5Title => '5º Dia - Mãe da Igreja';

  @override
  String get novenaAparecidaDay5Meditation =>
      'Protegei a Santa Igreja, o Papa, os bispos, os sacerdotes e todos os fiéis. Fazei-nos um só povo, unido em torno de Jesus.';

  @override
  String get novenaAparecidaDay6Title => '6º Dia - Mãe das famílias';

  @override
  String get novenaAparecidaDay6Meditation =>
      'Guardai as nossas famílias do egoísmo e da discórdia. Que em cada lar reinem a oração, o perdão e a paz de Nazaré.';

  @override
  String get novenaAparecidaDay7Title => '7º Dia - Refúgio dos pecadores';

  @override
  String get novenaAparecidaDay7Meditation =>
      'Mãe de misericórdia, levai-me ao confessionário e à conversão sincera. Livrai-me do pecado e fortalecei o meu desejo de recomeçar.';

  @override
  String get novenaAparecidaDay8Title => '8º Dia - Saúde dos enfermos';

  @override
  String get novenaAparecidaDay8Meditation =>
      'Cuidai dos doentes e dos que cuidam deles. Dai-lhes alívio e esperança, e a mim a graça de visitá-los e consolá-los.';

  @override
  String get novenaAparecidaDay9Title => '9º Dia - Padroeira do Brasil';

  @override
  String get novenaAparecidaDay9Meditation =>
      'Mãe e Rainha do Brasil, consagro-vos a minha vida e a minha pátria. Que o vosso povo viva a fé, a justiça e a fraternidade. Amém.';

  @override
  String get novenaFatimaTitle => 'Novena a Nossa Senhora de Fátima';

  @override
  String get novenaFatimaDesc =>
      'Festa em 13 de maio. A mensagem de Fátima: oração, penitência, reparação e o Rosário todos os dias.';

  @override
  String get novenaFatimaOpening =>
      'Ó Virgem de Fátima, Mãe do Céu, que viestes ao mundo para pedir oração, penitência e conversão, acolhei esta novena que faço com confiança. Ensinai-me a rezar o terço todos os dias e a oferecer a Deus os meus sacrifícios pela salvação das almas.';

  @override
  String get novenaFatimaClosing =>
      'Ó meu Jesus, perdoai-nos, livrai-nos do fogo do inferno, levai as almas todas para o Céu, principalmente as que mais precisarem. Nossa Senhora do Rosário de Fátima, rogai por nós. Amém.';

  @override
  String get novenaFatimaPrayers =>
      'Rezar o terço (ou ao menos uma dezena do Rosário) e a oração: \"Ó meu Jesus, perdoai-nos\".';

  @override
  String get novenaFatimaDay1Title => '1º Dia - Rezar o terço todos os dias';

  @override
  String get novenaFatimaDay1Meditation =>
      'Nossa Senhora pediu que rezássemos o terço diariamente. Dai-me a perseverança para ser fiel a este encontro com a Mãe e com o seu Filho.';

  @override
  String get novenaFatimaDay2Title => '2º Dia - A penitência';

  @override
  String get novenaFatimaDay2Meditation =>
      'Ensinai-me a aceitar com amor as pequenas cruzes do dia a dia e a oferecê-las a Deus em reparação dos pecados.';

  @override
  String get novenaFatimaDay3Title => '3º Dia - A reparação';

  @override
  String get novenaFatimaDay3Meditation =>
      'Ó Mãe, quero consolar o Coração de Jesus e o vosso, tão ofendidos. Aceitai a minha oração como reparação pelos pecados do mundo.';

  @override
  String get novenaFatimaDay4Title => '4º Dia - A conversão dos pecadores';

  @override
  String get novenaFatimaDay4Meditation =>
      'Rezai por mim e por todos os pecadores. Que ninguém se perca, e que cada um volte para os braços do Pai.';

  @override
  String get novenaFatimaDay5Title => '5º Dia - A paz no mundo';

  @override
  String get novenaFatimaDay5Meditation =>
      'Mãe da Paz, afastai as guerras e os ódios. Fazei de mim um instrumento de paz nos lugares onde vivo.';

  @override
  String get novenaFatimaDay6Title => '6º Dia - O exemplo dos pastorinhos';

  @override
  String get novenaFatimaDay6Meditation =>
      'Francisco, Jacinta e Lúcia, ensinai-me a simplicidade, a coragem e o espírito de sacrifício com que respondestes ao pedido da Senhora.';

  @override
  String get novenaFatimaDay7Title => '7º Dia - O Imaculado Coração de Maria';

  @override
  String get novenaFatimaDay7Meditation =>
      'Coração Imaculado de Maria, sede o meu refúgio e o caminho que me conduz a Deus. Em vós quero encontrar abrigo e força.';

  @override
  String get novenaFatimaDay8Title => '8º Dia - A comunhão reparadora';

  @override
  String get novenaFatimaDay8Meditation =>
      'Quero aproximar-me dos sacramentos com fé: confessar, comungar e rezar o terço nos primeiros sábados, como pedistes.';

  @override
  String get novenaFatimaDay9Title => '9º Dia - A consagração';

  @override
  String get novenaFatimaDay9Meditation =>
      'Mãe do Céu, consagro-vos a minha vida, a minha família e o mundo inteiro. Que o vosso Imaculado Coração triunfe. Amém.';

  @override
  String get novenaMisericordiaTitle => 'Novena da Divina Misericórdia';

  @override
  String get novenaMisericordiaDesc =>
      'Começa na Sexta-feira Santa e termina no sábado antes da Festa da Misericórdia. Cada dia, uma intenção pedida por Jesus a Santa Faustina.';

  @override
  String get novenaMisericordiaOpening =>
      'Jesus, eu confio em Vós! Fonte de misericórdia, trago a esta novena as almas que me pedis para levar ao vosso Coração. Que o sangue e a água que jorraram do vosso lado sejam o refúgio de toda a humanidade.';

  @override
  String get novenaMisericordiaClosing =>
      'Eterno Pai, olhai com misericórdia para as almas que Vos apresentei e, pelos méritos da dolorosa Paixão do vosso Filho, derramai sobre elas a vossa graça. Jesus, eu confio em Vós! Amém.';

  @override
  String get novenaMisericordiaPrayers =>
      'Rezar o Terço da Divina Misericórdia, em favor da intenção do dia.';

  @override
  String get novenaMisericordiaDay1Title =>
      '1º Dia - Toda a humanidade, especialmente os pecadores';

  @override
  String get novenaMisericordiaDay1Meditation =>
      'Jesus misericordioso, trago-Vos todos os homens, sobretudo os pecadores. Mergulhai-os no abismo da vossa misericórdia.';

  @override
  String get novenaMisericordiaDay2Title =>
      '2º Dia - Os sacerdotes e os religiosos';

  @override
  String get novenaMisericordiaDay2Meditation =>
      'Trago-Vos os sacerdotes e as almas consagradas. Dai-lhes força para serem fiéis e para levarem a luz da vossa misericórdia aos outros.';

  @override
  String get novenaMisericordiaDay3Title =>
      '3º Dia - As almas piedosas e fiéis';

  @override
  String get novenaMisericordiaDay3Meditation =>
      'Trago-Vos as almas devotas e fiéis. Fortalecei-as em suas provações e fazei-as crescer no vosso amor.';

  @override
  String get novenaMisericordiaDay4Title =>
      '4º Dia - Os que ainda não conhecem Jesus';

  @override
  String get novenaMisericordiaDay4Meditation =>
      'Trago-Vos os que ainda não Vos conhecem. Que a luz do vosso Coração os ilumine e os atraia a Vós.';

  @override
  String get novenaMisericordiaDay5Title =>
      '5º Dia - Os que se afastaram da Igreja';

  @override
  String get novenaMisericordiaDay5Meditation =>
      'Trago-Vos os que se separaram da unidade da Igreja. Reconduzi-os à comunhão, para que todos sejam um.';

  @override
  String get novenaMisericordiaDay6Title =>
      '6º Dia - Os mansos, os humildes e as crianças';

  @override
  String get novenaMisericordiaDay6Meditation =>
      'Trago-Vos as almas mansas e humildes e as crianças. Que encontrem repouso no vosso Coração.';

  @override
  String get novenaMisericordiaDay7Title =>
      '7º Dia - Os que veneram a Misericórdia';

  @override
  String get novenaMisericordiaDay7Meditation =>
      'Trago-Vos as almas que veneram e glorificam a vossa misericórdia. Que sejam apóstolos da confiança em Vós.';

  @override
  String get novenaMisericordiaDay8Title => '8º Dia - As almas do Purgatório';

  @override
  String get novenaMisericordiaDay8Meditation =>
      'Trago-Vos as almas do Purgatório. Que o sangue e a água do vosso lado as refresquem e as levem à alegria do Céu.';

  @override
  String get novenaMisericordiaDay9Title => '9º Dia - As almas tépidas';

  @override
  String get novenaMisericordiaDay9Meditation =>
      'Trago-Vos as almas tíbias e frias. Reacendei nelas o fogo do vosso amor e dai-lhes a graça de recomeçar. Amém.';

  @override
  String get novenaSantoAntonioTitle => 'Novena a Santo Antônio';

  @override
  String get novenaSantoAntonioDesc =>
      'Festa em 13 de junho. Doutor da Igreja, pregador do Evangelho e amigo dos pobres, invocado por quem busca o que perdeu.';

  @override
  String get novenaSantoAntonioOpening =>
      'Glorioso Santo Antônio, doutor do Evangelho e amigo dos pobres, que Deus encheu de sabedoria e de bondade, escutai os meus pedidos. Ajudai-me a encontrar o que me falta e, sobretudo, a encontrar sempre Jesus.';

  @override
  String get novenaSantoAntonioClosing =>
      'Santo Antônio, intercessor poderoso, apresentai a Deus as nossas necessidades. Fazei que, por vossa intercessão, encontremos o que perdemos e, acima de tudo, não percamos jamais a graça de Deus. Amém.';

  @override
  String get novenaSantoAntonioPrayers =>
      'Rezar 1 Pai-Nosso, 1 Ave-Maria e 1 Glória ao Pai, e o Responso a Santo Antônio, se desejar.';

  @override
  String get novenaSantoAntonioDay1Title => '1º Dia - Pregador do Evangelho';

  @override
  String get novenaSantoAntonioDay1Meditation =>
      'Santo Antônio, que anunciastes a Palavra com a vida e com os lábios, dai-me o desejo de conhecer e viver o Evangelho.';

  @override
  String get novenaSantoAntonioDay2Title => '2º Dia - Doutor da Igreja';

  @override
  String get novenaSantoAntonioDay2Meditation =>
      'Sábio mestre das Escrituras, ensinai-me a unir a fé e a inteligência e a defender a verdade com humildade e caridade.';

  @override
  String get novenaSantoAntonioDay3Title => '3º Dia - Amigo dos pobres';

  @override
  String get novenaSantoAntonioDay3Meditation =>
      'Vós que repartistes o que tínheis, abri o meu coração aos necessitados e livrai-me do apego ao dinheiro.';

  @override
  String get novenaSantoAntonioDay4Title => '4º Dia - Modelo de humildade';

  @override
  String get novenaSantoAntonioDay4Meditation =>
      'Santo Antônio, que escolhestes o último lugar, livrai-me do orgulho e da vaidade e ensinai-me a servir sem esperar reconhecimento.';

  @override
  String get novenaSantoAntonioDay5Title => '5º Dia - Taumaturgo';

  @override
  String get novenaSantoAntonioDay5Meditation =>
      'Santo dos milagres, que Deus operou prodígios por vosso intermédio, fortalecei a minha fé nas promessas do Senhor.';

  @override
  String get novenaSantoAntonioDay6Title =>
      '6º Dia - Protetor do que se perdeu';

  @override
  String get novenaSantoAntonioDay6Meditation =>
      'Ajudai-me a encontrar as coisas perdidas, e também a paz, o rumo e a fé que eu possa ter perdido pelo caminho.';

  @override
  String get novenaSantoAntonioDay7Title => '7º Dia - Protetor das famílias';

  @override
  String get novenaSantoAntonioDay7Meditation =>
      'Abençoai os casais, os noivos e as famílias. Que vivam unidos no amor e na fidelidade a Deus.';

  @override
  String get novenaSantoAntonioDay8Title => '8º Dia - Devoto da Eucaristia';

  @override
  String get novenaSantoAntonioDay8Meditation =>
      'Santo Antônio, que adorastes Jesus no Santíssimo Sacramento, ensinai-me a amar a Eucaristia e a recebê-la com fé.';

  @override
  String get novenaSantoAntonioDay9Title => '9º Dia - Intercessor junto a Deus';

  @override
  String get novenaSantoAntonioDay9Meditation =>
      'Levai ao Senhor os meus pedidos e dai-me confiança no vosso auxílio. Que eu alcance a graça de que preciso e o Céu que espero. Amém.';

  @override
  String get novenaSantaRitaTitle => 'Novena a Santa Rita de Cássia';

  @override
  String get novenaSantaRitaDesc =>
      'Festa em 22 de maio. Esposa, mãe, viúva e religiosa, invocada nas causas difíceis e desesperadas.';

  @override
  String get novenaSantaRitaOpening =>
      'Santa Rita, advogada das causas impossíveis, que levastes a vida inteira unida a Cristo crucificado, escutai o meu pedido. Alcançai-me de Deus a graça de que preciso, se for para a sua glória e para o bem da minha alma.';

  @override
  String get novenaSantaRitaClosing =>
      'Santa Rita de Cássia, mulher de oração e de perdão, rogai por nós. Alcançai-nos paciência nas cruzes, paz nas famílias e a graça de confiar em Deus quando tudo parece perdido. Amém.';

  @override
  String get novenaSantaRitaPrayers =>
      'Rezar 1 Pai-Nosso, 3 Ave-Marias e 1 Glória ao Pai.';

  @override
  String get novenaSantaRitaDay1Title => '1º Dia - Esposa paciente';

  @override
  String get novenaSantaRitaDay1Meditation =>
      'Santa Rita, que suportastes com paciência um casamento difícil, dai-me paz e fortaleza nas provações da vida em família.';

  @override
  String get novenaSantaRitaDay2Title => '2º Dia - Mãe dedicada';

  @override
  String get novenaSantaRitaDay2Meditation =>
      'Rezai por todas as mães e pelos filhos. Que eu saiba educar na fé, com amor e firmeza.';

  @override
  String get novenaSantaRitaDay3Title => '3º Dia - Mulher de perdão';

  @override
  String get novenaSantaRitaDay3Meditation =>
      'Vós que perdoastes os assassinos de vosso marido, ensinai-me a perdoar de coração quem me feriu.';

  @override
  String get novenaSantaRitaDay4Title => '4º Dia - Viúva confiante';

  @override
  String get novenaSantaRitaDay4Meditation =>
      'Consolai os que choram a perda de alguém querido e os que vivem na solidão. Que encontrem em Deus a sua esperança.';

  @override
  String get novenaSantaRitaDay5Title => '5º Dia - Religiosa obediente';

  @override
  String get novenaSantaRitaDay5Meditation =>
      'Santa Rita, que vencestes as dificuldades para consagrar a vida a Deus, ajudai-me a perseverar no que o Senhor me pede.';

  @override
  String get novenaSantaRitaDay6Title => '6º Dia - Amante da Paixão de Cristo';

  @override
  String get novenaSantaRitaDay6Meditation =>
      'Vós que recebestes em vossa fronte um espinho do Senhor, fazei-me compreender o valor do sofrimento unido à cruz de Jesus.';

  @override
  String get novenaSantaRitaDay7Title => '7º Dia - Pacificadora';

  @override
  String get novenaSantaRitaDay7Meditation =>
      'Santa Rita, que reconciliastes inimigos, levai a paz às famílias divididas e aos corações endurecidos.';

  @override
  String get novenaSantaRitaDay8Title =>
      '8º Dia - Advogada das causas impossíveis';

  @override
  String get novenaSantaRitaDay8Meditation =>
      'Intercedei por esta causa que parece sem saída. Alcançai-me a graça, ou a força para aceitar a vontade de Deus.';

  @override
  String get novenaSantaRitaDay9Title => '9º Dia - Consolo dos doentes';

  @override
  String get novenaSantaRitaDay9Meditation =>
      'Santa Rita, socorrei os enfermos e os que sofrem em corpo e alma. Que eu confie sempre na bondade do Senhor. Amém.';

  @override
  String get novenaCristoReiTitle => 'Novena a Cristo Rei';

  @override
  String get novenaCristoReiDesc =>
      'Solenidade de Nosso Senhor Jesus Cristo, Rei do Universo, no último domingo do Tempo Comum. Nove dias para pedir que Cristo reine em nossa vida.';

  @override
  String get novenaCristoReiOpening =>
      'Senhor Jesus Cristo, Rei do Universo, eu me coloco diante de Vós para Vos reconhecer como meu Senhor e meu Rei. Vinde reinar em meu coração, em minha família e em toda a sociedade.';

  @override
  String get novenaCristoReiClosing =>
      'Cristo Rei, Príncipe da Paz, venha a nós o vosso Reino de verdade, de justiça, de amor e de paz. Reinai em nossos corações, em nossos lares e em nossas nações, agora e para sempre. Amém.';

  @override
  String get novenaCristoReiPrayers =>
      'Rezar 1 Pai-Nosso, 1 Ave-Maria e 1 Glória ao Pai, e a ladainha do Sagrado Coração, se desejar.';

  @override
  String get novenaCristoReiDay1Title => '1º Dia - Rei do Universo';

  @override
  String get novenaCristoReiDay1Meditation =>
      'Senhor Jesus, por Vós todas as coisas foram criadas. Ensinai-me a reconhecer a vossa soberania sobre o mundo e sobre a minha vida.';

  @override
  String get novenaCristoReiDay2Title => '2º Dia - Rei da Verdade';

  @override
  String get novenaCristoReiDay2Meditation =>
      'Vós viestes dar testemunho da verdade. Dai-me a graça de viver na verdade e de nunca me envergonhar do Evangelho.';

  @override
  String get novenaCristoReiDay3Title => '3º Dia - Rei da Paz';

  @override
  String get novenaCristoReiDay3Meditation =>
      'Príncipe da Paz, desarmai o meu coração e as nações. Fazei de mim um construtor da paz que só Vós podeis dar.';

  @override
  String get novenaCristoReiDay4Title => '4º Dia - Rei de misericórdia';

  @override
  String get novenaCristoReiDay4Meditation =>
      'Rei que perdoa, acolhei-me quando caio. Que eu receba o vosso perdão e o leve aos meus irmãos.';

  @override
  String get novenaCristoReiDay5Title => '5º Dia - Rei dos corações';

  @override
  String get novenaCristoReiDay5Meditation =>
      'Reinai em meus pensamentos, desejos e afetos. Que nada em mim seja contrário à vossa vontade.';

  @override
  String get novenaCristoReiDay6Title => '6º Dia - Rei das famílias';

  @override
  String get novenaCristoReiDay6Meditation =>
      'Que o vosso reino de amor se estabeleça em nossos lares. Que a oração e o perdão sejam o alicerce de cada família.';

  @override
  String get novenaCristoReiDay7Title => '7º Dia - Rei das nações';

  @override
  String get novenaCristoReiDay7Meditation =>
      'Iluminai os governantes e os povos. Que as leis e as sociedades respeitem a dignidade da pessoa e o bem comum.';

  @override
  String get novenaCristoReiDay8Title => '8º Dia - Rei eucarístico';

  @override
  String get novenaCristoReiDay8Meditation =>
      'Vós reinais no altar e no Sacrário. Ensinai-me a adorar-Vos e a Vos receber com amor e reverência.';

  @override
  String get novenaCristoReiDay9Title => '9º Dia - Rei da glória';

  @override
  String get novenaCristoReiDay9Meditation =>
      'Que eu um dia contemple a vossa glória e reine convosco no Céu. Venha a nós o vosso Reino. Amém.';

  @override
  String get novenaSuggestLabel => 'Sugestão para esta época';

  @override
  String get novenaSuggestAction => 'Ver novena';

  @override
  String novenaSuggestToday(String date) {
    return 'Hoje é o dia ideal para começar: a festa é em $date.';
  }

  @override
  String novenaSuggestSoon(int days, String date) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dias',
      one: '1 dia',
    );
    return 'Começa em $_temp0; a festa é em $date.';
  }

  @override
  String novenaSuggestLate(String date) {
    return 'Ainda dá tempo: a festa é em $date.';
  }

  @override
  String get prayerStFrancisPeaceTitle => 'Oração da Paz (São Francisco)';

  @override
  String get prayerStFrancisPeaceContent =>
      'Senhor, fazei-me instrumento de vossa paz.\nOnde houver ódio, que eu leve o amor;\nOnde houver ofensa, que eu leve o perdão;\nOnde houver discórdia, que eu leve a união;\nOnde houver dúvida, que eu leve a fé;\nOnde houver erro, que eu leve a verdade;\nOnde houver desespero, que eu leve a esperança;\nOnde houver tristeza, que eu leve a alegria;\nOnde houver trevas, que eu leve a luz.\n\nÓ Mestre, fazei que eu procure mais\nConsolar, que ser consolado;\nCompreender, que ser compreendido;\nAmar, que ser amado.\nPois é dando que se recebe,\nÉ perdoando que se é perdoado,\nE é morrendo que se vive para a vida eterna.\n\nAmém.';

  @override
  String get prayerStFrancisPeaceContentLatin =>
      'Domine, fac me servum pacis tuae.\nUbi odium est, ibi caritatem afferam;\nubi iniuria, veniam;\nubi discordia, concordiam;\nubi dubium, fidem;\nubi error, veritatem;\nubi desperatio, spem;\nubi tristitia, laetitiam;\nubi tenebrae, lucem.\n\nO Magister, fac ut non quaeram\nconsolari, sed consolare;\nintellegi, sed intellegere;\namari, sed amare.\nQuia dando accipitur,\nignoscendo ignoscitur,\net moriendo ad vitam aeternam resurgitur.\n\nAmen.';

  @override
  String get prayerStBenedictMedalTitle => 'Medalha de São Bento';

  @override
  String get prayerStBenedictMedalContent =>
      'A Cruz Sagrada seja a minha luz,\nNão seja o dragão meu guia.\nRetira-te, satanás!\nNunca me aconselhes coisas vãs.\nÉ mau o que tu me ofereces,\nBebe tu mesmo o teu veneno.\n\nEm nome do Pai, e do Filho e do Espírito Santo.\n\nAmém.';

  @override
  String get prayerStBenedictMedalContentLatin =>
      'Crux sacra sit mihi lux,\nnon draco sit mihi dux.\nVade retro, Satana!\nNumquam suade mihi vana;\nsunt mala quae libas,\nipse venena bibas.\n\nIn nomine Patris, et Filii, et Spiritus Sancti.\n\nAmen.';

  @override
  String get prayerUniversalClementTitle =>
      'Oração Universal (Papa Clemente XI)';

  @override
  String get prayerUniversalClementContent =>
      'Creio, Senhor, mas fazei que eu creia com mais firmeza; espero, mas fazei que eu espere com mais segurança; amo-Vos, mas fazei que eu Vos ame com mais ardor; arrependo-me, mas fazei que eu me arrependa com mais veemência.\n\nAdoro-Vos como primeiro princípio; desejo-Vos como fim último; louvo-Vos como benfeitor perpétuo; invoco-Vos como defensor propício.\n\nDirigi-me com a vossa sabedoria, contei-me com a vossa justiça, consolai-me com a vossa clemência, protegei-me com o vosso poder.\n\nOfereço-Vos, Senhor, os meus pensamentos, para que sejam para Vós; as minhas palavras, para que sejam de Vós; as minhas obras, para que sejam segundo Vós; e os meus sofrimentos, para que sejam por Vós.\n\nQuero tudo o que quereis, quero porque quereis, quero do modo como quereis e enquanto o quiserdes.\n\nPeço-Vos, Senhor: iluminai o meu entendimento, inflamai a minha vontade, purificai o meu coração e santificai a minha alma.\n\nNão seja eu contaminado pela soberba, nem seduzido pela adulação, nem enganado pelo mundo, nem surpreendido por Satanás.\n\nConcedei-me a graça de purificar a memória, refrear a língua, guardar os olhos e reprimir os sentidos.\n\nChore eu as iniquidades passadas, repila as tentações futuras, corrija as inclinações viciosas e cultive as virtudes convenientes.\n\nConcedei-me, bom Deus, o amor de Vós, o desapego de mim mesmo, o zelo pelo próximo e o desprezo do mundo.\n\nEsforce-me por obedecer aos superiores, socorrer os inferiores, aconselhar os amigos e a ninguém invejar.\n\nLembre-me eu, ó Jesus, do vosso mandamento e exemplo, amando os inimigos, sofrendo as injúrias, fazendo bem aos que me perseguem e orando pelos que me caluniam.\n\nVença eu o prazer sensual pela austeridade, a avareza pela largueza, a ira pela mansidão e a tibieza pela piedade.\n\nTornai-me prudente nos conselhos, constante nos perigos, paciente nas adversidades e humilde nas prosperidades.\n\nFazei, Senhor, que eu seja atento na oração, sóbrio nas refeições, diligente nos deveres e firme nos propósitos.\n\nProcure eu ter santidade interior, modéstia exterior, trato exemplar e vida regrada.\n\nVele eu constantemente para domar a natureza, alimentar a graça, guardar a vossa lei e merecer a salvação.\n\nAlcance eu a santidade pela sincera confissão dos pecados, pela fervorosa comunhão do Corpo de Cristo, pelo contínuo recolhimento da mente e pela pura intenção do coração.\n\nAprenda eu de Vós, meu Deus, quão pequeno é o que é terreno, quão grande o que é divino, quão breve o que é temporal e quão durável o que é eterno. Amém.';

  @override
  String get prayerUniversalClementContentLatin =>
      'Credo, Domine, sed credam firmius; spero, sed sperem securius; amo, sed amem ardentius; doleo, sed doleam vehementius.\n\nAdoro te ut primum principium; desidero ut finem ultimum; laudo ut benefactorem perpetuum; invoco ut defensorem propitium.\n\nTua me sapientia dirige, iustitia contine, clementia solare, potentia protege.\n\nOffero tibi, Domine, cogitanda, ut sint ad te; dicenda, ut sint de te; facienda, ut sint secundum te; ferenda, ut sint propter te.\n\nVolo quidquid vis, volo quia vis, volo quomodo vis, volo quamdiu vis.\n\nOro, Domine: intellectum illumines, voluntatem inflammes, cor emundes, animam sanctifices.\n\nA superbia non inficiar; adulatione non afficiar; a mundo non decipiar; a Satana non circumveniar.\n\nGratiam praesta memoriam purgandi, linguam frenandi, oculos cohibendi, sensus coercendi.\n\nDefleam praeteritas iniquitates, repellam futuras tentationes, corrigam vitiosas propensiones, excolam idoneas virtutes.\n\nTribue mihi, bone Deus, amorem tui, odium mei, zelum proximi, contemptum mundi.\n\nStudeam superioribus oboedire, inferioribus subvenire, amicis consulere, nemini invidere.\n\nMeminerim, o Iesu, mandati tui et exempli, inimicos diligendo, iniurias sufferendo, persequentibus benefaciendo, pro calumniantibus orando.\n\nVincam voluptatem austeritate, avaritiam largitate, iracundiam lenitate, tepiditatem pietate.\n\nRedde me prudentem in consiliis, constantem in periculis, patientem in adversis, humilem in prosperis.\n\nFac, Domine, ut sim in oratione attentus, in epulis sobrius, in munere sedulus, in proposito firmus.\n\nCurem habere sanctitatem interiorem, modestiam exteriorem, conversationem exemplarem, vitam regularem.\n\nNaturae invigilem domandae, gratiae fovendae, legi servandae, saluti promerendae.\n\nSanctimoniam assequar sincera peccatorum confessione, fervida Corporis Christi communione, continua mentis recollectione, pura cordis intentione.\n\nDiscam a te, Deus, quam tenue, quod terrenum; quam grande, quod divinum; quam breve, quod temporaneum; quam durabile, quod aeternum. Amen.';

  @override
  String get prayerStTeresaAvilaTitle =>
      'Nada te perturbe (Santa Teresa d\'Ávila)';

  @override
  String get prayerStTeresaAvilaContent =>
      'Nada te perturbe,\nNada te espante,\nTudo passa.\nDeus não muda.\nA paciência tudo alcança.\nQuem a Deus tem,\nNada lhe falta:\nSó Deus basta.\n\nAmém.';

  @override
  String get prayerStTeresaAvilaContentLatin =>
      'Nihil te perturbet,\nnihil te terreat,\nomnia transeunt.\nDeus non mutatur.\nPatientia omnia assequitur.\nQui Deum habet,\nnihil illi deest:\nsolus Deus sufficit.\n\nAmen.';

  @override
  String get prayerStAugustineTitle => 'Tarde Te amei (Santo Agostinho)';

  @override
  String get prayerStAugustineContent =>
      'Tarde Te amei, ó Beleza tão antiga e tão nova, tarde Te amei! Eis que habitavas dentro de mim e eu Te procurava fora! Eu, disforme, lançava-me sobre as belas formas das Tuas criaturas. Estavas comigo e eu não estava contigo. Retinham-me longe de Ti as coisas que não existiriam se não existissem em Ti.\n\nChamaste-me, clamaste por mim e rompeste a minha surdez. Brilhaste, resplandeceste e dissipaste a minha cegueira. Exalaste o Teu perfume: aspirei-o e suspiro por Ti. Provei-Te e agora tenho fome e sede de Ti. Tocaste-me e abrasei-me na Tua paz.\n\nAmém.';

  @override
  String get prayerStAugustineContentLatin =>
      'Sero te amavi, pulchritudo tam antiqua et tam nova, sero te amavi! Et ecce intus eras et ego foris, et ibi te quaerebam, et in ista formosa, quae fecisti, deformis irruebam. Mecum eras, et tecum non eram. Ea me tenebant longe a te, quae si in te non essent, non essent.\n\nVocasti et clamasti et rupisti surditatem meam; coruscasti, splenduisti et fugasti caecitatem meam; fragrasti, et duxi spiritum et anhelo tibi; gustavi et esurio et sitio; tetigisti me, et exarsi in pacem tuam.\n\nAmen.';

  @override
  String get prayerStAnthonyTitle => 'Oração a Santo Antônio';

  @override
  String get prayerStAnthonyContent =>
      'Ó Santo Antônio, o mais afável e bondoso dos santos, vosso amor a Deus e vossa caridade com o próximo vos tornaram digno, na terra, de operar milagres e prodígios. Animado por esta confiança, a vós recorro com filial devoção.\n\nÓ terno e milagroso Santo Antônio, cujo coração sempre transbordou de simpatia humana, apresentai a minha prece ao Menino Jesus, que tanto se alegrava em repousar em vossos braços. Uma só palavra vossa alcançará a graça de que tanto necessito.\n\nCompadecei-vos de mim e alcançai-me esta graça, para que o meu coração eternamente vos louve e agradeça, e sobretudo alcance a fidelidade aos mandamentos de Deus até o fim da minha vida.\n\nV. Rogai por nós, bem-aventurado Santo Antônio.\nR. Para que sejamos dignos das promessas de Cristo.\n\nAmém.';

  @override
  String get prayerStAnthonyContentLatin =>
      'O beate Antoni, sanctorum mitissime, cuius caritas in Deum ac proximum te miraculis clarum fecit in terris. Eadem fiducia recreati, ad te supplices confugimus ut gratiam quam fidenter expetimus impetrare digneris.\n\nO dulcissime Sancte Antoni, cuius pectus misericordia redundabat, affer precem nostram ad aures Divini Infantis Iesu, qui in ulnis tuis requiescere gaudebat. Sufficit enim verbum tuum ut nostra exaudiatur petitio.\n\nMiserere nostri et hanc gratiam impetra, ut gratias tibi semper agamus, et praesertim mandatis Dei usque ad vitae finem fideles maneamus.\n\nV. Ora pro nobis, beate Antoni.\nR. Ut digni efficiamur promissionibus Christi.\n\nAmen.';

  @override
  String get prayerStRitaTitle => 'Oração a Santa Rita de Cássia';

  @override
  String get prayerStRitaContent =>
      'Ó poderosa e gloriosa Santa Rita de Cássia, eis a vossos pés uma alma desamparada que, necessitando de auxílio, a vós recorre com a doce esperança de ser atendida por vós, que tendes o incomparável título de Santa dos Casos Impossíveis e Desesperados.\n\nÓ cara Santa, tomai interesse pela minha causa, intercedei junto de Deus para que me conceda a graça de que tanto necessito. Não permitais que eu tenha de me afastar dos vossos pés sem ser atendido.\n\nSe houver em mim algum obstáculo que me impeça de alcançar a graça que imploro, ajudai-me a afastá-lo. Olhai para os meus sofrimentos e abençoai o meu coração desolado com a vossa eficaz intercessão. Confiando no vosso poder junto ao Sagrado Coração de Jesus, eu vos suplico que me alcanceis esta graça.\n\nV. Rogai por nós, Santa Rita, advogada dos impossíveis.\nR. Para que sejamos dignos das promessas de Cristo.\n\nAmém.';

  @override
  String get prayerStRitaContentLatin =>
      'O potens et gloriosa Sancta Rita, ecce ad pedes tuos afflicta anima, quae ad te confugit spe plena exaudiendi a te, quae Patrona Causarum Impossibilium et Desperatarum merito appellaris.\n\nO dilecta Sancta, suscipe causam meam, intercede pro me apud Deum ut gratiam qua vehementer indigeo consequi merear. Noli me a pedibus tuis vacuum dimittere.\n\nSi quid in me est quod divinae gratiae obstet, adiuva me ut illud expellam. Respice tribulationes meas et consolare cor meum maerens. Fidens potentia tua apud Sacratissimum Cor Iesu, auxilium tuum imploro.\n\nV. Ora pro nobis, Sancta Rita, patrona impossibilium.\nR. Ut digni efficiamur promissionibus Christi.\n\nAmen.';

  @override
  String get prayerLitanyHumilityTitle => 'Ladainha da Humildade';

  @override
  String get prayerLitanyHumilityContent =>
      'Ó Jesus, manso e humilde de coração, ouvi-me.\n\nDo desejo de ser estimado, livrai-me, Jesus.\nDo desejo de ser amado, livrai-me, Jesus.\nDo desejo de ser louvado, livrai-me, Jesus.\nDo desejo de ser honrado, livrai-me, Jesus.\nDo desejo de ser preferido aos outros, livrai-me, Jesus.\nDo desejo de ser consultado, livrai-me, Jesus.\nDo desejo de ser aprovado, livrai-me, Jesus.\n\nDo temor de ser humilhado, livrai-me, Jesus.\nDo temor de ser desprezado, livrai-me, Jesus.\nDo temor de ser repreendido, livrai-me, Jesus.\nDo temor de ser caluniado, livrai-me, Jesus.\nDo temor de ser esquecido, livrai-me, Jesus.\nDo temor de ser ridicularizado, livrai-me, Jesus.\nDo temor de ser injuriado, livrai-me, Jesus.\nDo temor de ser suspeito, livrai-me, Jesus.\n\nQue os outros sejam mais amados do que eu, Jesus, dai-me a graça de o desejar.\nQue os outros sejam mais estimados do que eu, Jesus, dai-me a graça de o desejar.\nQue os outros cresçam na opinião do mundo e que eu diminua, Jesus, dai-me a graça de o desejar.\nQue os outros sejam escolhidos e eu posto de lado, Jesus, dai-me a graça de o desejar.\nQue os outros sejam louvados e eu esquecido, Jesus, dai-me a graça de o desejar.\nQue os outros sejam preferidos a mim em tudo, Jesus, dai-me a graça de o desejar.\nQue os outros se tornem mais santos do que eu, contanto que eu me torne tão santo quanto puder, Jesus, dai-me a graça de o desejar.\n\nAmém.';

  @override
  String get prayerLitanyHumilityContentLatin =>
      'Iesu, mitis et humilis corde, exaudi me.\n\nA desiderio aestimandi, libera me, Iesu.\nA desiderio amandi, libera me, Iesu.\nA desiderio laudandi, libera me, Iesu.\nA desiderio honorandi, libera me, Iesu.\nA desiderio praeferendi aliis, libera me, Iesu.\nA desiderio consulendi, libera me, Iesu.\nA desiderio approbandi, libera me, Iesu.\n\nA timore humiliandi, libera me, Iesu.\nA timore contemnendi, libera me, Iesu.\nA timore reprehendendi, libera me, Iesu.\nA timore calumniandi, libera me, Iesu.\nA timore oblivioni tradendi, libera me, Iesu.\nA timore irridendi, libera me, Iesu.\nA timore iniuria afficiendi, libera me, Iesu.\nA timore suspecti habendi, libera me, Iesu.\n\nUt alii magis amentur quam ego, Iesu, da mihi gratiam hoc exoptandi.\nUt alii magis aestimentur quam ego, Iesu, da mihi gratiam hoc exoptandi.\nUt alii crescant in existimatione saeculi et ego minuar, Iesu, da mihi gratiam hoc exoptandi.\nUt alii eligantur et ego praeterear, Iesu, da mihi gratiam hoc exoptandi.\nUt alii laudentur et ego negligar, Iesu, da mihi gratiam hoc exoptandi.\nUt alii mihi in omnibus praeferantur, Iesu, da mihi gratiam hoc exoptandi.\nUt alii sanctiores evadant quam ego, dummodo ego tam sanctus fiam quam debeo, Iesu, da mihi gratiam hoc exoptandi.\n\nAmen.';

  @override
  String get prayerLitanyPreciousBloodTitle =>
      'Ladainha do Preciosíssimo Sangue';

  @override
  String get prayerLitanyPreciousBloodContent =>
      'Senhor, tende piedade de nós.\nCristo, tende piedade de nós.\nSenhor, tende piedade de nós.\n\nJesus Cristo, ouvi-nos.\nJesus Cristo, atendei-nos.\n\nDeus Pai dos céus, tende piedade de nós.\nDeus Filho, Redentor do mundo, tende piedade de nós.\nDeus Espírito Santo, tende piedade de nós.\nSantíssima Trindade, que sois um só Deus, tende piedade de nós.\n\nSangue de Cristo, Filho Único do Pai Eterno, salvai-nos.\nSangue de Cristo, Verbo de Deus encarnado, salvai-nos.\nSangue de Cristo, do Novo e Eterno Testamento, salvai-nos.\nSangue de Cristo, a correr pela terra na agonia, salvai-nos.\nSangue de Cristo, a verter na flagelação, salvai-nos.\nSangue de Cristo, a emanar na coroação de espinhos, salvai-nos.\nSangue de Cristo, derramado na Cruz, salvai-nos.\nSangue de Cristo, preço da nossa salvação, salvai-nos.\nSangue de Cristo, sem o qual não há remissão, salvai-nos.\nSangue de Cristo, bebida e purificação das almas na Eucaristia, salvai-nos.\nSangue de Cristo, torrente de misericórdia, salvai-nos.\nSangue de Cristo, vencedor dos demônios, salvai-nos.\nSangue de Cristo, fortaleza dos mártires, salvai-nos.\nSangue de Cristo, virtude dos confessores, salvai-nos.\nSangue de Cristo, que dais origem às virgens, salvai-nos.\nSangue de Cristo, sustentáculo dos que estão em perigo, salvai-nos.\nSangue de Cristo, alívio dos que sofrem, salvai-nos.\nSangue de Cristo, consolo nas lágrimas, salvai-nos.\nSangue de Cristo, esperança dos penitentes, salvai-nos.\nSangue de Cristo, conforto dos moribundos, salvai-nos.\nSangue de Cristo, paz e doçura dos corações, salvai-nos.\nSangue de Cristo, penhor de vida eterna, salvai-nos.\nSangue de Cristo, que libertais as almas do Purgatório, salvai-nos.\nSangue de Cristo, digno de toda a honra e glória, salvai-nos.\n\nCordeiro de Deus, que tirais os pecados do mundo, perdoai-nos, Senhor.\nCordeiro de Deus, que tirais os pecados do mundo, ouvi-nos, Senhor.\nCordeiro de Deus, que tirais os pecados do mundo, tende piedade de nós.\n\nV. Vós nos remistes, Senhor, no vosso Sangue.\nR. E fizestes de nós um reino para o nosso Deus.\n\nOremos: Deus todo-poderoso e eterno, que constituístes o vosso Filho Unigênito Redentor do mundo e quisestes ser aplacado com o Seu Sangue, concedei-nos a graça de venerar o preço da nossa salvação e de sermos por ele defendidos na terra contra todos os males, para que alcancemos a alegria dos seus frutos eternos no céu. Por Cristo, Nosso Senhor. Amém.';

  @override
  String get prayerLitanyPreciousBloodContentLatin =>
      'Kyrie, eleison.\nChriste, eleison.\nKyrie, eleison.\n\nChriste, audi nos.\nChriste, exaudi nos.\n\nPater de caelis, Deus, miserere nobis.\nFili, Redemptor mundi, Deus, miserere nobis.\nSpiritus Sancte, Deus, miserere nobis.\nSancta Trinitas, unus Deus, miserere nobis.\n\nSanguis Christi, Unigeniti Patris Aeterni, salva nos.\nSanguis Christi, Verbi Dei incarnati, salva nos.\nSanguis Christi, Novi et Aeterni Testamenti, salva nos.\nSanguis Christi, in agonia decurrens in terram, salva nos.\nSanguis Christi, in flagellatione effusus, salva nos.\nSanguis Christi, in coronatione spinarum emanans, salva nos.\nSanguis Christi, in Cruce effusus, salva nos.\nSanguis Christi, pretium nostrae salutis, salva nos.\nSanguis Christi, sine quo non fit remissio, salva nos.\nSanguis Christi, in Eucharistia potus et lavacrum animarum, salva nos.\nSanguis Christi, flumen misericordiae, salva nos.\nSanguis Christi, victor daemonum, salva nos.\nSanguis Christi, fortitudo martyrum, salva nos.\nSanguis Christi, virtus confessorum, salva nos.\nSanguis Christi, germinans virgines, salva nos.\nSanguis Christi, robur periclitantium, salva nos.\nSanguis Christi, levamen laborantium, salva nos.\nSanguis Christi, in fletu solatium, salva nos.\nSanguis Christi, spes paenitentium, salva nos.\nSanguis Christi, solamen morientium, salva nos.\nSanguis Christi, pax et dulcedo cordium, salva nos.\nSanguis Christi, pignus vitae aeternae, salva nos.\nSanguis Christi, animas liberans de lacu Purgatorii, salva nos.\nSanguis Christi, omni honore et gloria dignissimus, salva nos.\n\nAgnus Dei, qui tollis peccata mundi, parce nobis, Domine.\nAgnus Dei, qui tollis peccata mundi, exaudi nos, Domine.\nAgnus Dei, qui tollis peccata mundi, miserere nobis.\n\nV. Redemisti nos, Domine, in sanguine tuo.\nR. Et fecisti nos Deo nostro regnum.\n\nOremus: Omnipotens sempiterne Deus, qui unigenitum Filium tuum mundi Redemptorem constituisti, ac eius sanguine placari voluisti: concede, quaesumus, salutis nostrae pretium ita venerari, atque a praesentis vitae malis eius virtute defendi in terris, ut fructu perpetuo laetemur in caelis. Per eundem Christum Dominum nostrum. Amen.';

  @override
  String get prayerLitanyBlessedSacramentTitle =>
      'Ladainha do Santíssimo Sacramento';

  @override
  String get prayerLitanyBlessedSacramentContent =>
      'Senhor, tende piedade de nós.\nCristo, tende piedade de nós.\nSenhor, tende piedade de nós.\n\nJesus Cristo, ouvi-nos.\nJesus Cristo, atendei-nos.\n\nDeus Pai dos céus, tende piedade de nós.\nDeus Filho, Redentor do mundo, tende piedade de nós.\nDeus Espírito Santo, tende piedade de nós.\nSantíssima Trindade, que sois um só Deus, tende piedade de nós.\n\nPão vivo que desceu do céu, tende piedade de nós.\nDeus escondido e Salvador, tende piedade de nós.\nTrigo dos eleitos, tende piedade de nós.\nVinho que faz germinar virgens, tende piedade de nós.\nPão substancioso e delícia dos reis, tende piedade de nós.\nSacrifício perpétuo, tende piedade de nós.\nOblação pura, tende piedade de nós.\nCordeiro sem mancha, tende piedade de nós.\nMesa puríssima, tende piedade de nós.\nAlimento dos anjos, tende piedade de nós.\nManá escondido, tende piedade de nós.\nMemorial das maravilhas de Deus, tende piedade de nós.\nPão supersubstancial, tende piedade de nós.\nVerbo feito carne, habitando entre nós, tende piedade de nós.\nHóstia santa, tende piedade de nós.\nCálice de bênção, tende piedade de nós.\nMistério da fé, tende piedade de nós.\nSublime e venerável Sacramento, tende piedade de nós.\nSacrifício santíssimo sobre todos os sacrifícios, tende piedade de nós.\nVerdadeiro propiciatório pelos vivos e pelos mortos, tende piedade de nós.\nRemédio celestial contra todos os males, tende piedade de nós.\nMilagre admirável sobre todos os milagres, tende piedade de nós.\nSagrada memória da Paixão do Senhor, tende piedade de nós.\nDom que excede toda a plenitude, tende piedade de nós.\nPenhor da glória futura, tende piedade de nós.\n\nSede-nos propício, perdoai-nos, Senhor.\nSede-nos propício, ouvi-nos, Senhor.\n\nDe receber indignamente o vosso Corpo e o vosso Sangue, livrai-nos, Senhor.\nDa concupiscência da carne, livrai-nos, Senhor.\nDa soberba da vida, livrai-nos, Senhor.\nDe toda ocasião de pecar, livrai-nos, Senhor.\nPelo vosso ardente desejo de comer esta Páscoa com os discípulos, livrai-nos, Senhor.\nPela vossa profunda humildade ao lavar os pés dos discípulos, livrai-nos, Senhor.\nPelo vosso infinito amor ao instituir este Santíssimo Sacramento, livrai-nos, Senhor.\n\nNós que somos pecadores, nós vos rogamos, ouvi-nos.\nPara que vos digneis aumentar em nós a fé, o respeito e a devoção a este admirável Sacramento, nós vos rogamos, ouvi-nos.\nPara que vos digneis conduzir-nos à comunhão frequente com sincera pureza e piedade, nós vos rogamos, ouvi-nos.\nPara que vos digneis preservar-nos de toda heresia, sacrilégio e tibieza espiritual, nós vos rogamos, ouvi-nos.\n\nCordeiro de Deus, que tirais os pecados do mundo, perdoai-nos, Senhor.\nCordeiro de Deus, que tirais os pecados do mundo, ouvi-nos, Senhor.\nCordeiro de Deus, que tirais os pecados do mundo, tende piedade de nós.\n\nV. Vós lhes destes o pão do céu.\nR. Que contém em si todo o sabor.\n\nOremos: Deus, que neste admirável sacramento nos deixastes o memorial da vossa paixão, concedei-nos a graça de venerar de tal modo os sagrados mistérios do vosso Corpo e do vosso Sangue, que sintamos continuamente em nós os frutos da vossa redenção. Vós que viveis e reinais para todo o sempre. Amém.';

  @override
  String get prayerLitanyBlessedSacramentContentLatin =>
      'Kyrie, eleison.\nChriste, eleison.\nKyrie, eleison.\n\nChriste, audi nos.\nChriste, exaudi nos.\n\nPater de caelis, Deus, miserere nobis.\nFili, Redemptor mundi, Deus, miserere nobis.\nSpiritus Sancte, Deus, miserere nobis.\nSancta Trinitas, unus Deus, miserere nobis.\n\nPanis vivus, qui de caelo descendisti, miserere nobis.\nDeus absconditus et Salvator, miserere nobis.\nFrumentum electorum, miserere nobis.\nVinum germinans virgines, miserere nobis.\nPanis pinguis et daps regalis, miserere nobis.\nIuge sacrificium, miserere nobis.\nOblatio munda, miserere nobis.\nAgnus absque macula, miserere nobis.\nMensa purissima, miserere nobis.\nAngelorum esca, miserere nobis.\nManna absconditum, miserere nobis.\nMemoriale mirabilium Dei, miserere nobis.\nPanis supersubstantialis, miserere nobis.\nVerbum caro factum, habitans in nobis, miserere nobis.\nHostia sancta, miserere nobis.\nCalix benedictionis, miserere nobis.\nMysterium fidei, miserere nobis.\nPraecelsum et venerabile Sacramentum, miserere nobis.\nSacrificium omnium sanctissimum, miserere nobis.\nVere propitiatorium pro vivis et defunctis, miserere nobis.\nCaeleste antidotum, quo a peccatis praeservamur, miserere nobis.\nMiraculum praestantissimum, miserere nobis.\nMemoria sacratissima Passionis Dominicae, miserere nobis.\nPignus futurae gloriae, miserere nobis.\n\nPropitius esto, parce nobis, Domine.\nPropitius esto, exaudi nos, Domine.\n\nAb indigna Corporis et Sanguinis tui sumptione, libera nos, Domine.\nA concupiscentia carnis, libera nos, Domine.\nA superbia vitae, libera nos, Domine.\nAb omni peccandi occasione, libera nos, Domine.\nPer desiderium quo hoc Pascha cum discipulis manducare cupiisti, libera nos, Domine.\nPer immensam caritatem qua hoc Sacramentum instituisti, libera nos, Domine.\n\nPeccatores, te rogamus, audi nos.\nUt fidem, reverentiam et devotionem erga hoc admirabile Sacramentum in nobis augere digneris, te rogamus, audi nos.\nUt ad frequentem et dignam sanctae Eucharistiae sumptionem nos perducere digneris, te rogamus, audi nos.\nUt ab omni haeresi, sacrilegio et cordis tepore nos praeservare digneris, te rogamus, audi nos.\n\nAgnus Dei, qui tollis peccata mundi, parce nobis, Domine.\nAgnus Dei, qui tollis peccata mundi, exaudi nos, Domine.\nAgnus Dei, qui tollis peccata mundi, miserere nobis.\n\nV. Panem de caelo praestitisti eis.\nR. Omne delectamentum in se habentem.\n\nOremus: Deus, qui nobis sub sacramento mirabili passionis tuae memoriam reliquisti: tribue, quaesumus, ita nos Corporis et Sanguinis tui sacra mysteria venerari, ut redemptionis tuae fructum in nobis iugiter sentiamus. Qui vivis et regnas in saecula saeculorum. Amen.';

  @override
  String get prayerLitanyHolyAngelsTitle => 'Ladainha dos Santos Anjos';

  @override
  String get prayerLitanyHolyAngelsContent =>
      'Senhor, tende piedade de nós.\nCristo, tende piedade de nós.\nSenhor, tende piedade de nós.\n\nJesus Cristo, ouvi-nos.\nJesus Cristo, atendei-nos.\n\nDeus Pai dos céus, tende piedade de nós.\nDeus Filho, Redentor do mundo, tende piedade de nós.\nDeus Espírito Santo, tende piedade de nós.\nSantíssima Trindade, que sois um só Deus, tende piedade de nós.\n\nSanta Maria, Rainha dos Anjos, rogai por nós.\nSão Miguel Arcanjo, rogai por nós.\nSão Gabriel Arcanjo, rogai por nós.\nSão Rafael Arcanjo, rogai por nós.\nSantos Anjos e Arcanjos, rogai por nós.\nSantos Serafins, querubins e tronos, rogai por nós.\nSantas dominações, potestades e virtudes, rogai por nós.\nSantos principados, anjos e arcanjos, rogai por nós.\nSantos Anjos da Guarda, rogai por nós.\nSantos Anjos, nossos defensores no combate espiritual, rogai por nós.\nSantos Anjos, mensageiros da vontade divina, rogai por nós.\nSantos Anjos, que contemplais a face do Pai celeste, rogai por nós.\nSantos Anjos, consoladores nas aflições, rogai por nós.\nSantos Anjos, companheiros nas nossas peregrinações, rogai por nós.\nSantos Anjos, sustentáculos na hora da tentação, rogai por nós.\nSantos Anjos, que apresentais as nossas preces a Deus, rogai por nós.\nSantos Anjos, nosso conforto na agonia da morte, rogai por nós.\nSantos Anjos, que conduzis as almas dos justos ao Paraíso, rogai por nós.\n\nCordeiro de Deus, que tirais os pecados do mundo, perdoai-nos, Senhor.\nCordeiro de Deus, que tirais os pecados do mundo, ouvi-nos, Senhor.\nCordeiro de Deus, que tirais os pecados do mundo, tende piedade de nós.\n\nV. Deus deu ordens aos Seus Anjos a teu respeito.\nR. Para que te guardem em todos os teus caminhos.\n\nOremos: Deus todo-poderoso e eterno, que por vossa inefável providência vos dignais enviar os vossos Santos Anjos para nossa guarda, concedei aos vossos servos suplicantes sermos sempre defendidos pela sua proteção na terra e gozarmos da sua eterna companhia nos céus. Por Cristo, Nosso Senhor. Amém.';

  @override
  String get prayerLitanyHolyAngelsContentLatin =>
      'Kyrie, eleison.\nChriste, eleison.\nKyrie, eleison.\n\nChriste, audi nos.\nChriste, exaudi nos.\n\nPater de caelis, Deus, miserere nobis.\nFili, Redemptor mundi, Deus, miserere nobis.\nSpiritus Sancte, Deus, miserere nobis.\nSancta Trinitas, unus Deus, miserere nobis.\n\nSancta Maria, Regina Angelorum, ora pro nobis.\nSancte Michael Archangele, ora pro nobis.\nSancte Gabriel Archangele, ora pro nobis.\nSancte Raphael Archangele, ora pro nobis.\nSancti Angeli et Archangeli, orate pro nobis.\nSancti Seraphim, Cherubim et Throni, orate pro nobis.\nSanctae Dominationes, Potestates et Virtutes, orate pro nobis.\nSancti Principatus, orate pro nobis.\nSancti Angeli Custodes nostri, orate pro nobis.\nSancti Angeli, defensores nostri in certamine spiritali, orate pro nobis.\nSancti Angeli, nuntii divinae voluntatis, orate pro nobis.\nSancti Angeli, qui faciem Patris assidue contemplamini, orate pro nobis.\nSancti Angeli, consolatores in afflictionibus, orate pro nobis.\nSancti Angeli, fideles comites peregrinationis nostrae, orate pro nobis.\nSancti Angeli, robur nostrum in tempore tentationis, orate pro nobis.\nSancti Angeli, qui orationes nostras Deo offertis, orate pro nobis.\nSancti Angeli, solatores nostri in agone mortis, orate pro nobis.\nSancti Angeli, ductores animarum in Paradisum, orate pro nobis.\n\nAgnus Dei, qui tollis peccata mundi, parce nobis, Domine.\nAgnus Dei, qui tollis peccata mundi, exaudi nos, Domine.\nAgnus Dei, qui tollis peccata mundi, miserere nobis.\n\nV. Angelis suis Deus mandavit de te.\nR. Ut custodiant te in omnibus viis tuis.\n\nOremus: Deus, qui ineffabili providentia sanctos Angelos tuos ad nostram custodiam mittere dignaris: largire supplicibus tuis, et eorum semper protectione defendi, et aeterna societate gaudere. Per Christum Dominum nostrum. Amen.';

  @override
  String get prayerLitanyGoodDeathTitle => 'Ladainha da Boa Morte';

  @override
  String get prayerLitanyGoodDeathContent =>
      'Senhor Jesus, Deus de bondade e Pai de misericórdia, apresento-me diante de Vós com o coração humilhado e contrito, e vos recomendo a minha última hora e aquilo que depois dela me espera.\n\nQuando os meus pés imóveis me avisarem que a minha carreira neste mundo está prestes a terminar, misericordioso Jesus, tende piedade de mim.\nQuando as minhas mãos trêmulas já não puderem segurar o Crucifixo e eu o deixar cair sobre o meu leito de dor, misericordioso Jesus, tende piedade de mim.\nQuando os meus olhos embaciados e escurecidos pela proximidade da morte se fixarem em Vós pela última vez, misericordioso Jesus, tende piedade de mim.\nQuando os meus lábios frios e trêmulos pronunciarem pela última vez o vosso adorável Nome, misericordioso Jesus, tende piedade de mim.\nQuando os meus ouvidos, fechados às vozes dos homens, escutarem a vossa sentença divina irrevogável, misericordioso Jesus, tende piedade de mim.\nQuando a minha alma, agitada pelas angústias da morte, lutar contra os assaltos do demônio, misericordioso Jesus, tende piedade de mim.\nQuando o meu coração bater com fraqueza e travar os últimos combates da agonia, misericordioso Jesus, tende piedade de mim.\nQuando a minha alma se separar do meu corpo, deixando-o pálido, frio e sem vida, recebei o meu espírito em vossas mãos divinas, misericordioso Jesus, tende piedade de mim.\n\nOremos: Ó Deus, que nos condenastes à morte, mas nos ocultastes o momento e a hora dela, fazei que, passando em santidade e justiça todos os dias da nossa vida, mereçamos sair deste mundo em vosso santo amor. Por Jesus Cristo, Nosso Senhor. Amém.';

  @override
  String get prayerLitanyGoodDeathContentLatin =>
      'Domine Iesu, Deus bonitatis et Pater misericordiarum, contrito et humiliato corde ad Te accedo; Tibi ultimam meam horam et quidquid me post eam manet commendo.\n\nCum pedes mei immobiles me commonefacient cursum meum in hoc saeculo finiri, misericors Iesu, miserere mei.\nCum manus meae trementes Crucifixum tenere non poterunt, misericors Iesu, miserere mei.\nCum oculi mei caligantes in Te ultimum aspectum figent, misericors Iesu, miserere mei.\nCum labia mea frigida et trementia ultimum nomen Tuum invocabunt, misericors Iesu, miserere mei.\nCum aures meae vocibus hominum clausae Te solum iudicem audient, misericors Iesu, miserere mei.\nCum anima mea in agone mortis contra insidias diaboli decertabit, misericors Iesu, miserere mei.\nCum cor meum languidum ultimos motus efficiet, misericors Iesu, miserere mei.\nCum anima mea e corpore evolabit, suscipe spiritum meum in manus tuas, misericors Iesu, miserere mei.\n\nOremus: Deus, qui nos mori statuisti, sed horam mortis nostrae occultasti: concede ut in iustitia et sanctitate omnes dies vitae nostrae transeuntes, in caritate tua ex hoc saeculo migrare mereamur. Per Christum Dominum nostrum. Amen.';

  @override
  String get prayerConsecTotusTuusTitle => 'Totus Tuus (consagração a Maria)';

  @override
  String get prayerConsecTotusTuusContent =>
      'Totus Tuus ego sum, et omnia mea tua sunt.\n\nSou todo vosso, ó Maria, e tudo quanto tenho é vosso. Eu vos tomo hoje, ó minha Mãe, por meu tudo. Emprestai-me o vosso Coração para que eu possa amar a Deus com a mesma pureza e fervor com que Vós o amastes.\n\nRecebei-me, Virgem Imaculada, sob a vossa maternal proteção. Guardai os meus sentidos, purificai a minha alma e santificai todas as minhas ações, para que eu viva unicamente para Jesus, por Vós e convosco.\n\nTotus Tuus ego sum, et omnia mea tua sunt. Amém.';

  @override
  String get prayerConsecTotusTuusContentLatin =>
      'Totus Tuus ego sum, et omnia mea tua sunt.\n\nAccipio te in mea omnia, o Maria, Mater mea dulcissima. Praebe mihi cor tuum, ut Deum eodem amore et puritate qua tu amasti diligere valeam.\n\nSuscipe me, Virgo Immaculata, sub materno praesidio tuo. Custodi sensus meos, munda animam meam, et omnes actiones meas sanctifica, ut soli Iesu per te et tecum vivam.\n\nTotus Tuus ego sum, et omnia mea tua sunt. Amen.';

  @override
  String get prayerConsecMontfortTitle =>
      'Consagração a Jesus por Maria (São Luís de Montfort)';

  @override
  String get prayerConsecMontfortContent =>
      'Ó Sabedoria Eterna e Encarnada! Ó amabilíssimo e adorável Jesus, verdadeiro Deus e verdadeiro homem, Filho Único do Pai Eterno e de Maria, sempre Virgem! Adoro-Vos profundamente no seio e nas glórias de vosso Pai, durante a eternidade, e no seio virginal de Maria, vossa Mãe digníssima, no tempo da vossa Encarnação.\n\nAgradeço-Vos ter-Vos aniquilado a Vós mesmo, tomando a forma de escravo, para livrar-me da cruel escravidão do demônio. Louvo-Vos e glorifico-Vos por ter-Vos submetido a Maria, vossa santa Mãe, em todas as coisas, a fim de tornar-me, por Ela, vosso fiel escravo. Mas, ai de mim! Ingrato e infiel que sou, não guardei os votos e as promessas que tão solenemente Vos fiz no meu Batismo. Não cumpri as minhas obrigações; não mereço ser chamado vosso filho nem vosso escravo; e, como nada há em mim que não mereça as vossas repulsas e a vossa cólera, não ouso mais aproximar-me por mim mesmo da vossa santíssima e augusta Majestade.\n\nPor isso, recorro à intercessão e à misericórdia de vossa Mãe Santíssima, que me destes por medianeira junto de Vós; e é por intermédio d\'Ela que espero obter de Vós a contrição e o perdão dos meus pecados, a aquisição e a conservação da Sabedoria.\n\nAve, pois, ó Maria Imaculada, sacrário vivo da Divindade, onde a Sabedoria Eterna escondida quer ser adorada pelos anjos e pelos homens! Ave, ó Rainha do céu e da terra, a cujo império tudo está sujeito, abaixo de Deus! Ave, ó refúgio seguro dos pecadores, cuja misericórdia a ninguém falta! Atendei aos desejos que tenho da divina Sabedoria, e recebei, para isso, os votos e as ofertas que a minha baixeza vos apresenta.\n\nEu, pecador infiel, renovo e ratifico hoje, em vossas mãos, os votos do meu Batismo: renuncio para sempre a satanás, às suas pompas e às suas obras, e dou-me inteiramente a Jesus Cristo, a Sabedoria Encarnada, para levar a minha cruz após Ele todos os dias da minha vida, e para Lhe ser mais fiel do que tenho sido até aqui.\n\nEscolho-vos hoje, em presença de toda a corte celeste, por minha Mãe e minha Senhora. Entrego-vos e consagro-vos, na qualidade de escravo, o meu corpo e a minha alma, os meus bens interiores e exteriores, e o próprio valor das minhas boas ações passadas, presentes e futuras, deixando-vos pleno e inteiro direito de dispor de mim e de tudo o que me pertence, sem exceção, segundo o vosso beneplácito, para a maior glória de Deus, no tempo e na eternidade.\n\nRecebei, ó Virgem benigna, esta pequena oferenda da minha escravidão, em honra e união daquela submissão que a Sabedoria Eterna quis ter à vossa maternidade; em homenagem ao poder que tendes ambos sobre este vermezinho e miserável pecador; e em ação de graças pelos privilégios com que a Santíssima Trindade vos favoreceu. Protesto que quero doravante, como vosso verdadeiro escravo, procurar a vossa honra e obedecer-vos em todas as coisas.\n\nÓ Mãe admirável, apresentai-me ao vosso querido Filho na qualidade de escravo perpétuo, para que, tendo-me resgatado por Vós, por Vós me receba!\n\nÓ Mãe de misericórdia, concedei-me a graça de obter a verdadeira Sabedoria de Deus, e de colocar-me, para isso, no número daqueles a quem amais, ensinais, guiais, sustentais e protegeis como filhos e escravos vossos!\n\nÓ Virgem fiel! Tornai-me em todas as coisas um tão perfeito discípulo, imitador e escravo da Sabedoria Encarnada, Jesus Cristo, vosso Filho, que eu chegue, por vossa intercessão e a vosso exemplo, à plenitude da Sua idade sobre a terra e da Sua glória nos céus. Amém.';

  @override
  String get prayerConsecMontfortContentLatin =>
      'O Aeterna et Incarnata Sapientia! O dulcissime et adorabilis Iesu, verus Deus et verus homo, Fili unigenite Patris Aeterni et Mariae semper Virginis! Te profundissime adoro in sinu et splendoribus Patris tui in aeternitate, atque in sinu virginali Mariae, sanctissimae Matris tuae, in tempore Incarnationis tuae.\n\nGratias tibi ago quod teipsum exinanisti, formam servi accipiens, ut me a crudeli diaboli servitute liberares. Te laudo et glorifico quod Mariae, Matri tuae sanctissimae, in omnibus subditus esse voluisti, ut me per ipsam fidelem servum tuum efficeres. Sed heu! ingratus et infidelis, promissa meo Baptismate tam solemniter facta non servavi; ideo confugio ad misericordiam et intercessionem sanctissimae Matris tuae, quam mihi mediatricem dedisti.\n\nAve igitur, o Maria Immaculata, vivum Divinitatis tabernaculum! Ave, Regina caeli et terrae! Ave, refugium peccatorum! Ego infidelis peccator renovo et ratifico hodie in manibus tuis vota mei Baptismi: renuntio in perpetuum satanae, pompis et operibus eius, et me totum trado Iesu Christo, Sapientiae Incarnatae, ad crucem meam post eum ferendam omnibus diebus vitae meae.\n\nEligo te hodie, coram omni curia caelesti, in Matrem et Dominam meam. Trado et consecro tibi, in statu servi, corpus et animam meam, bona mea interiora et exteriora, atque ipsum pretium bonorum meorum actuum praeteritorum, praesentium et futurorum, relinquens tibi plenum et integrum ius de me disponendi secundum beneplacitum tuum, ad maiorem Dei gloriam in tempore et in aeternitate.\n\nAccipe, o Virgo benigna, hanc meae servitutis oblationem, et praesenta me dilecto Filio tuo tamquam servum sempiternum, ut qui me per te redemit, per te me recipiat. Amen.';

  @override
  String get prayerConsecSacredHeartTitle =>
      'Consagração ao Sagrado Coração de Jesus';

  @override
  String get prayerConsecSacredHeartContent =>
      'Eu dou e consagro ao Sagrado Coração de Nosso Senhor Jesus Cristo a minha pessoa e a minha vida, as minhas ações, penas e sofrimentos, para não querer mais servir-me de nenhuma parte do meu ser senão para O honrar, amar e glorificar.\n\nÉ esta a minha determinação irrevogável: ser todo d\'Ele e fazer tudo por Seu amor, renunciando de todo o meu coração a tudo quanto Lhe possa desagradar.\n\nEu vos tomo, pois, ó Sagrado Coração, por único objeto do meu amor, protetor da minha vida, segurança da minha salvação, remédio da minha fragilidade e inconstância, reparador de todos os defeitos da minha vida e asilo seguro na hora da minha morte.\n\nSede, pois, ó Coração de bondade, a minha justificação para com Deus vosso Pai, e afastai de mim os castigos da Sua justa cólera. Ó Coração de amor, ponho em Vós toda a minha confiança, pois tudo temo da minha fraqueza e malícia, mas tudo espero da vossa bondade!\n\nDestruí em mim tudo o que Vos possa desagradar ou resistir. Imprimi o vosso puro amor tão profundamente no meu coração, que nunca mais Vos possa esquecer nem de Vós me separar.\n\nSuplico-Vos, pela vossa bondade, que o meu nome seja gravado em Vós, porque quero fazer consistir toda a minha felicidade e a minha glória em viver e morrer na qualidade de vosso fiel servo.\n\nAmém.';

  @override
  String get prayerConsecSacredHeartContentLatin =>
      'Ego me totum trado et consecro Sacratissimo Cordi Domini nostri Iesu Christi: personam et vitam meam, actiones, aerumnas et dolores meos, ut nulla amplius entis mei parte uti velim, nisi ad Ipsum honorandum, amandum et glorificandum.\n\nHaec est voluntas mea irrevocabilis: totum Eius esse, et omnia pro Eius amore facere, renuntiando ex toto corde meo omnibus quae Ipsi displicere possunt.\n\nTe igitur eligo, o Cor Sacratissimum, in unicum meae dilectionis obiectum, vitae meae custodem, salutis meae securitatem, meae infirmitatis et inconstantiae remedium, omnium vitae meae culparum expiationem, atque certum in hora mortis refugium.\n\nEsto igitur, o Cor bonitatis, mea iustificatio apud Deum Patrem tuum, et averte a me iustae Ipsius irae flagella. O Cor dilectionis, in Te totam fiduciam meam pono; omnia enim timeo a mea fragilitate, sed omnia spero a tua bonitate!\n\nDele in me quidquid Tibi displicere vel resistere potest; infige amorem tuum tam alte cordi meo, ut numquam Tui oblivisci neque a Te separari valeam.\n\nAmen.';

  @override
  String get prayerConsecStJosephTitle => 'Consagração a São José';

  @override
  String get prayerConsecStJosephContent =>
      'Ó glorioso São José, a vós recorremos em nossa tribulação e, depois de ter implorado o auxílio de vossa santíssima Esposa, cheios de confiança solicitamos também o vosso patrocínio.\n\nPor aquele laço sagrado de caridade que vos uniu à Virgem Imaculada, Mãe de Deus, e pelo amor paternal que tivestes ao Menino Jesus, ardentemente vos suplicamos que lanceis um olhar benigno para a herança que Jesus Cristo adquiriu com o Seu Sangue, e nos socorrais com o vosso auxílio e poder nas nossas necessidades.\n\nProtegei, ó guarda providentíssimo da Sagrada Família, a raça eleita de Jesus Cristo. Afastai de nós, ó pai amantíssimo, toda mancha de erro e corrupção. Do alto do céu sede-nos propício, ó nosso fortíssimo sustentáculo, na luta contra o poder das trevas.\n\nE assim como outrora livrastes da morte a vida ameaçada do Menino Jesus, defendei agora a Santa Igreja de Deus contra as ciladas dos inimigos e contra toda adversidade. Amparai a cada um de nós com o vosso perpétuo patrocínio, a fim de que, a vosso exemplo e sustentados pelo vosso auxílio, possamos viver santamente, piedosamente morrer e alcançar a eterna bem-aventurança no céu.\n\nAmém.';

  @override
  String get prayerConsecStJosephContentLatin =>
      'Ad te, beate Ioseph, in tribulatione nostra confugimus, atque, implorato Sponsae tuae sanctissimae auxilio, patrocinium quoque tuum fidenter exposcimus.\n\nPer eam, quaesumus, quae te cum immaculata Virgine Dei Genetrice coniunxit, caritatis necessitudinem, perque paternum, quo Puerum Iesum amplexus es, amorem, supplices deprecamur, ut ad hereditatem, quam Iesus Christus acquisivit Sanguine suo, benignus respicias, ac necessitatibus nostris tua virtute et ope succurras.\n\nTuere, o Custos providentissime divinae Familiae, Iesu Christi sobolem electam; prohibe a nobis, amantissime pater, omnem errorum ac corruptelarum luem; propitius nobis, sospitator noster fortissime, in hoc cum potestate tenebrarum certamine e caelo adesto.\n\nEt sicut olim Puerum Iesum e summo eripuisti vitae discrimine, ita nunc sanctam Dei Ecclesiam ab hostilibus insidiis atque omni adversitate defende: nosque singulos perpetuo tege patrocinio, ut ad tui exemplar et ope suffulti, sancte vivere, pie emori, sempiternamque in caelis beatitudinem assequi valeamus.\n\nAmen.';

  @override
  String get catPrayersConsecrations => 'Consagrações';

  @override
  String get drawerIntentions => 'Intenções de oração';

  @override
  String get drawerMassGuide => 'Guia da Missa';

  @override
  String get drawerAdoration => 'Adoração Eucarística';

  @override
  String get intentionsTitle => 'Intenções de oração';

  @override
  String get intentionsSubtitle => 'Anote por quem e pelo quê você reza.';

  @override
  String get intentionsEmpty =>
      'Nenhuma intenção ainda. Toque em \"Nova intenção\" para anotar a primeira.';

  @override
  String get intentionsAdd => 'Nova intenção';

  @override
  String get intentionsEditTitle => 'Editar intenção';

  @override
  String get intentionsHint => 'Ex.: pela saúde de um familiar';

  @override
  String get intentionsOpenSection => 'Em oração';

  @override
  String get intentionsAnsweredSection => 'Graças recebidas';

  @override
  String get intentionsMarkAnswered => 'Marcar como graça recebida';

  @override
  String get intentionsMarkOpen => 'Voltar para \"em oração\"';

  @override
  String get intentionsEdit => 'Editar';

  @override
  String get intentionsDelete => 'Apagar';

  @override
  String get intentionsDeleted => 'Intenção apagada';

  @override
  String get massGuideTitle => 'Guia da Missa';

  @override
  String get massGuideSubtitle => 'Acompanhe cada parte da celebração.';

  @override
  String get massGuideTipsTitle => 'Antes de ir';

  @override
  String get massGuideTipsBody =>
      'Chegue alguns minutos antes e desligue o celular. Para comungar, esteja em estado de graça: se houver pecado grave, procure antes a Confissão. Guarde o jejum de uma hora antes da Comunhão. Faça a genuflexão diante do Santíssimo no sacrário. A missa aos domingos e nas solenidades é de preceito.';

  @override
  String get massGuidePart1Title => '1. Ritos iniciais';

  @override
  String get massGuidePart1Body =>
      'Canto de entrada, sinal da cruz e saudação. No ato penitencial, peça perdão a Deus. Aos domingos (fora do Advento e da Quaresma) canta-se o Glória. A Oração do dia (coleta) reúne a assembleia.\n\nO Senhor esteja convosco.\n— Ele está no meio de nós.';

  @override
  String get massGuidePart2Title => '2. Liturgia da Palavra';

  @override
  String get massGuidePart2Body =>
      'Primeira leitura, Salmo responsorial e, aos domingos, segunda leitura. Aclamação ao Evangelho, Evangelho, homilia e, aos domingos e solenidades, o Credo. Termina com a oração dos fiéis, em que se apresentam as intenções.\n\nPalavra do Senhor.\n— Graças a Deus.\n\nPalavra da Salvação.\n— Glória a vós, Senhor.';

  @override
  String get massGuidePart3Title => '3. Liturgia Eucarística';

  @override
  String get massGuidePart3Body =>
      'Apresentação do pão e do vinho, Oração Eucarística com o Santo e a consagração, e o Pai-Nosso. Segue o rito da paz e o Cordeiro de Deus. Na Comunhão, o ministro diz \"O Corpo de Cristo\" e você responde \"Amém\".\n\nSenhor, eu não sou digno de que entreis em minha morada, mas dizei uma palavra e serei salvo.';

  @override
  String get massGuidePart4Title => '4. Ritos finais';

  @override
  String get massGuidePart4Body =>
      'Avisos, bênção final e despedida.\n\nIde em paz, e o Senhor vos acompanhe.\n— Graças a Deus.';

  @override
  String get adorationTitle => 'Adoração Eucarística';

  @override
  String get adorationSubtitle =>
      'Uma hora diante de Jesus no Santíssimo Sacramento.';

  @override
  String get adorationStep1Title => '1. Ao entrar';

  @override
  String get adorationStep1Body =>
      'Faça o sinal da cruz, genuflita diante do Santíssimo (exposto ou no sacrário) e procure um lugar tranquilo.';

  @override
  String get adorationStep2Title => '2. Faça silêncio';

  @override
  String get adorationStep2Body =>
      'Fique diante de Jesus sem pressa. Você não precisa dizer muito: olhe para Ele e deixe que Ele olhe para você.';

  @override
  String get adorationStep3Title => '3. Ore';

  @override
  String get adorationStep3Body => 'Algumas orações que podem ajudar:';

  @override
  String get adorationStep4Title => '4. Fale com Jesus';

  @override
  String get adorationStep4Body =>
      'Agradeça, peça perdão e apresente as suas intenções e as de quem você ama. Se quiser, leia o Evangelho do dia.';

  @override
  String get adorationStep5Title => '5. Ao sair';

  @override
  String get adorationStep5Body =>
      'Agradeça, faça o sinal da cruz, genuflita e leve a paz recebida para o seu dia.';

  @override
  String get examSectionPrepare => 'Preparar-se';

  @override
  String get examSectionExamine => 'Examinar a consciência';

  @override
  String get examSectionConfess => 'Confessar';

  @override
  String get nextConfessionToday => 'É hoje';

  @override
  String get examClearMarks => 'Limpar';

  @override
  String get examClearTitle => 'Limpar as marcações?';

  @override
  String get examClearConfirm => 'Limpar';

  @override
  String get examCleared => 'Marcações limpas';

  @override
  String nextConfessionInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Em $days dias',
      one: 'Amanhã',
    );
    return '$_temp0';
  }

  @override
  String nextConfessionOverdue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Atrasada $days dias',
      one: 'Atrasada 1 dia',
    );
    return '$_temp0';
  }

  @override
  String examClearBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Os $count itens marcados no exame serão desmarcados.',
      one: 'O item marcado no exame será desmarcado.',
    );
    return '$_temp0 Isso não pode ser desfeito.';
  }

  @override
  String get massGuideFormTitle => 'Forma da Missa';

  @override
  String get massGuideFormOrdinary => 'Missa ordinária (português)';

  @override
  String get massGuideFormOrdinaryDesc =>
      'A Missa de hoje, celebrada na língua do povo.';

  @override
  String get massGuideFormTraditional => 'Missa tradicional (latim)';

  @override
  String get massGuideFormTraditionalDesc =>
      'A Missa celebrada com o Missal Romano de 1962, em latim.';

  @override
  String get massGuideTradSubtitle => 'Acompanhe a Missa tradicional em latim.';

  @override
  String get massGuideTradTipsTitle => 'Antes de ir';

  @override
  String get massGuideTradTipsBody =>
      'A Missa tradicional é celebrada com o Missal Romano de 1962. Procure saber, na sua diocese, onde ela é celebrada. Leve um missal bilíngue (latim e português) para acompanhar. É costume o silêncio no templo, as mulheres cobrirem a cabeça com um véu e receber a Comunhão de joelhos e na língua. Boa parte das orações é dita em voz baixa pelo sacerdote: a participação é sobretudo interior. As normas de jejum e estado de graça para comungar são as mesmas.';

  @override
  String get massGuideTradPart1Title => '1. Ao pé do altar';

  @override
  String get massGuideTradPart1Body =>
      'O sacerdote e os ministros se preparam com o sinal da cruz e o Salmo 42. Em seguida, o Confiteor (confissão dos pecados) e o pedido de perdão.\n\n» In nomine Patris, et Filii, et Spiritus Sancti. Amen.\n» Introibo ad altare Dei.\n» Ad Deum qui laetificat juventutem meam.\nSubirei ao altar de Deus. — A Deus, que alegra a minha juventude.';

  @override
  String get massGuideTradPart2Title => '2. Intróito, Kyrie e Glória';

  @override
  String get massGuideTradPart2Body =>
      'O Intróito é o canto de entrada. Segue o Kyrie, súplica de misericórdia, e, nos domingos fora do Advento e da Quaresma, o Glória. A Coleta é a oração do dia.\n\n» Kyrie, eleison. Christe, eleison. Kyrie, eleison.\nSenhor, tende piedade. Cristo, tende piedade. Senhor, tende piedade.\n\n» Dominus vobiscum.\n» Et cum spiritu tuo.\nO Senhor esteja convosco. — E com o teu espírito.\n\n» Oremus. (…) — Amen.';

  @override
  String get massGuideTradPart3Title => '3. Epístola, Gradual e Evangelho';

  @override
  String get massGuideTradPart3Body =>
      'Lê-se a Epístola, canta-se o Gradual (e o Aleluia) e proclama-se o Evangelho, ouvido de pé. Costuma-se fazer três pequenos sinais da cruz na testa, nos lábios e no peito.\n\n» Deo gratias.\nGraças a Deus. (depois da Epístola)\n\n» Dominus vobiscum. — Et cum spiritu tuo.\n» Sequentia sancti Evangelii secundum N.\n» Gloria tibi, Domine.\nLeitura do santo Evangelho segundo N. — Glória a vós, Senhor.\n\n» Laus tibi, Christe.\nLouvor a vós, Cristo. (depois do Evangelho)';

  @override
  String get massGuideTradPart4Title => '4. Sermão, Credo e Ofertório';

  @override
  String get massGuideTradPart4Body =>
      'Depois do sermão, nos domingos e festas, reza-se o Credo (genuflexão em \"et incarnatus est\"). No Ofertório, o sacerdote oferece o pão e o vinho.\n\n» Credo in unum Deum, Patrem omnipotentem…\nCreio em um só Deus, Pai todo-poderoso…\n\n» Orate, fratres: ut meum ac vestrum sacrificium acceptabile fiat apud Deum Patrem omnipotentem.\n» Suscipiat Dominus sacrificium de manibus tuis ad laudem et gloriam nominis sui, ad utilitatem quoque nostram, totiusque Ecclesiae suae sanctae.\nOrai, irmãos, para que o meu e o vosso sacrifício seja aceito por Deus Pai todo-poderoso. — Receba o Senhor o sacrifício por tuas mãos, para louvor e glória do seu nome, para nosso bem e de toda a sua santa Igreja.';

  @override
  String get massGuideTradPart5Title => '5. Prefácio, Sanctus e Cânon';

  @override
  String get massGuideTradPart5Body =>
      'O Prefácio abre a grande oração de ação de graças. Após o Sanctus, o sacerdote reza o Cânon em silêncio. Na consagração, ajoelhados, adoramos Jesus presente na Hóstia e no Cálice, ao toque da campainha.\n\n» Sursum corda.\n» Habemus ad Dominum.\n» Gratias agamus Domino Deo nostro.\n» Dignum et justum est.\nCorações ao alto. — Os temos no Senhor. — Demos graças ao Senhor nosso Deus. — É digno e justo.\n\n» Sanctus, Sanctus, Sanctus Dominus Deus Sabaoth. Pleni sunt caeli et terra gloria tua. Hosanna in excelsis. Benedictus qui venit in nomine Domini. Hosanna in excelsis.\nSanto, Santo, Santo, Senhor Deus dos exércitos. Os céus e a terra estão cheios da vossa glória. Hosana nas alturas. Bendito o que vem em nome do Senhor. Hosana nas alturas.';

  @override
  String get massGuideTradPart6Title => '6. Pai-Nosso, Agnus Dei e Comunhão';

  @override
  String get massGuideTradPart6Body =>
      'O sacerdote canta o Pai-Nosso, o povo responde ao final. Segue o Agnus Dei. Antes da Comunhão, repete-se três vezes a oração de humildade. Recebe-se a Comunhão de joelhos, na balaustrada.\n\n» Et ne nos inducas in tentationem.\n» Sed libera nos a malo.\nE não nos deixeis cair em tentação. — Mas livrai-nos do mal.\n\n» Agnus Dei, qui tollis peccata mundi: miserere nobis. (duas vezes)\n» Agnus Dei, qui tollis peccata mundi: dona nobis pacem.\nCordeiro de Deus, que tirais os pecados do mundo, tende piedade de nós. (duas vezes) — Cordeiro de Deus, que tirais os pecados do mundo, dai-nos a paz.\n\n» Domine, non sum dignus ut intres sub tectum meum: sed tantum dic verbo, et sanabitur anima mea. (três vezes)\nSenhor, eu não sou digno de que entreis em minha morada, mas dizei uma palavra e serei salvo.';

  @override
  String get massGuideTradPart7Title => '7. Ritos finais e Último Evangelho';

  @override
  String get massGuideTradPart7Body =>
      'Depois da oração final, o sacerdote despede o povo e dá a bênção. A Missa termina com a leitura do Prólogo de São João, o Último Evangelho.\n\n» Ite, missa est.\n» Deo gratias.\nPodeis ir, é a despedida. — Graças a Deus.\n\n» Benedicat vos omnipotens Deus, Pater, et Filius, et Spiritus Sanctus.\n» Amen.\nAbençoe-vos Deus todo-poderoso, Pai, Filho e Espírito Santo. — Amém.\n\n» Et Verbum caro factum est, et habitavit in nobis.\nE o Verbo se fez carne e habitou entre nós. (genuflexão)';

  @override
  String get searchPrayersHint => 'Buscar oração…';

  @override
  String get searchNovenasHint => 'Buscar novena…';

  @override
  String get searchExamHint => 'Buscar pecado ou tema…';

  @override
  String get searchNoPrayers =>
      'Nenhuma oração encontrada.\nTente outra palavra ou só o começo do nome.';

  @override
  String get searchNoNovenas =>
      'Nenhuma novena encontrada.\nTente outra palavra ou o nome do santo.';

  @override
  String get searchNoSins =>
      'Nenhum item encontrado.\nTente outra palavra, um sinônimo ou só o começo dela.';

  @override
  String get searchApproximate => 'Resultados aproximados';

  @override
  String get searchClear => 'Limpar busca';

  @override
  String get rosaryFullComplete => 'Rosário completo!';

  @override
  String rosaryFullDetail(int chaplets, int decades) {
    return 'Hoje você rezou $chaplets terços: $decades dezenas.';
  }

  @override
  String rosaryProgress(int done, int total) {
    return '$done de $total terços de hoje para completar o Rosário';
  }

  @override
  String get prayerMealsContentLatin =>
      'Benedic, Domine, nos et haec tua dona, quae de tua largitate sumus sumpturi. Per Christum Dominum nostrum. Amen.';

  @override
  String get todaySectionPending => 'Para hoje';

  @override
  String get todaySectionDone => 'Feito hoje';

  @override
  String get todayKindPrayer => 'Oração';

  @override
  String get todayKindRosary => 'Terço';

  @override
  String get todayKindNovena => 'Novena';

  @override
  String get todayKindMass => 'Missa';

  @override
  String get todayKindConfession => 'Confissão';

  @override
  String get todayKindPenance => 'Penitência';

  @override
  String get todayDoneEmpty =>
      'Nada registrado ainda. O que você rezar e fizer hoje aparece aqui.';

  @override
  String get todayAllDone => 'Tudo feito por hoje. Deus abençoe o seu dia!';

  @override
  String get addSheetSubtitleToday => 'Para hoje';

  @override
  String addSheetSubtitleFuture(String date) {
    return 'Para $date';
  }

  @override
  String addSheetSubtitlePast(String date) {
    return 'Registrar como rezada em $date';
  }

  @override
  String get addSheetReminderTitle => 'Novo lembrete de oração';

  @override
  String get addSheetReminderSubtitle =>
      'Escolha a oração ou novena que quer lembrar';

  @override
  String get addSheetSearchHint => 'Buscar oração ou novena…';

  @override
  String get addNowTitle => 'Rezei agora';

  @override
  String get addNowDesc => 'Registra em Hoje, sem criar lembrete.';

  @override
  String get addPlanTitle => 'Adicionar ao meu plano';

  @override
  String get addPlanDesc =>
      'Entra na lista de orações do dia, com horário e lembrete opcionais.';

  @override
  String get reminderChooserTitle => 'Novo lembrete';

  @override
  String get reminderChooserPrayerTitle => 'Lembrete de uma oração';

  @override
  String get reminderChooserPrayerDesc =>
      'Escolha uma oração ou novena, o horário e a frequência.';

  @override
  String get reminderChooserCustomTitle => 'Lembrete personalizado';

  @override
  String get reminderChooserCustomDesc => 'Escreva o seu próprio lembrete.';

  @override
  String get calendarTodayButton => 'Hoje';

  @override
  String get calendarLegendFeast => 'Festa';

  @override
  String get calendarLegendPrayer => 'Oração';

  @override
  String get calendarRecordTitle => 'Registro do dia';

  @override
  String get calendarNothingRecorded =>
      'Nada registrado neste dia. Use os botões acima para adicionar.';

  @override
  String get calendarFutureHint =>
      'Dia futuro: adicione uma oração para planejá-lo.';

  @override
  String get calendarActionPrayer => 'Oração';

  @override
  String get calendarActionMass => 'Missa';

  @override
  String get calendarActionConfession => 'Confissão';

  @override
  String get calendarSummaryTitle => 'Resumo do mês';

  @override
  String get calendarUpcomingTitle => 'Próximos dias';

  @override
  String get calendarUpcomingEmpty =>
      'Nenhuma festa ou evento nas próximas semanas.';

  @override
  String calendarSummaryPrayerDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias com oração',
      one: '1 dia com oração',
      zero: '0 dias com oração',
    );
    return '$_temp0';
  }

  @override
  String calendarSummaryRosary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias de terço',
      one: '1 dia de terço',
      zero: '0 dias de terço',
    );
    return '$_temp0';
  }

  @override
  String calendarSummaryMass(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count missas',
      one: '1 missa',
      zero: '0 missas',
    );
    return '$_temp0';
  }

  @override
  String calendarSummaryConfession(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count confissões',
      one: '1 confissão',
      zero: '0 confissões',
    );
    return '$_temp0';
  }

  @override
  String calendarInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Em $count dias',
      one: 'Amanhã',
    );
    return '$_temp0';
  }

  @override
  String get remindersYourTitle => 'Seus lembretes';

  @override
  String get remindersChurchTitle => 'Avisos da Igreja';

  @override
  String get remindersChurchSubtitle =>
      'Domingos e dias santos, jejum e abstinência, no horário que você escolher.';

  @override
  String get confessionCycleNone =>
      'Sem repetição: o lembrete toca uma vez, para a data planejada';

  @override
  String get cyclePeriodMonth => 'mês';

  @override
  String confessionCycleText(String period) {
    return 'A cada $period, depois de cada confissão marcada como realizada';
  }

  @override
  String confessionReminderPlanned(String date) {
    return 'Confissão planejada: $date';
  }

  @override
  String cyclePeriodWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count semanas',
      one: 'semana',
    );
    return '$_temp0';
  }

  @override
  String cyclePeriodDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias',
      one: 'dia',
    );
    return '$_temp0';
  }

  @override
  String get prayerActionsTitle => 'O que fazer com esta oração?';

  @override
  String get prayerActionOpen => 'Abrir oração';

  @override
  String get prayerActionOpenDesc => 'Ler e rezar agora';

  @override
  String get prayerActionRemove => 'Excluir do plano';

  @override
  String get prayerActionRemoveDesc => 'Tira esta oração da lista de hoje';

  @override
  String get prayerActionEdit => 'Momento e lembrete';

  @override
  String get prayerActionEditDesc => 'Quando rezar e se o app deve avisar';

  @override
  String get prayerMoreOptions => 'Mais opções';

  @override
  String get prayerEditSheetTitle => 'Ajustar oração';

  @override
  String get prayerEditMomentLabel => 'Quando você costuma rezar';

  @override
  String get prayerEditReminderLabel => 'Lembrete';

  @override
  String get prayerEditReminderOn => 'O app vai avisar você';

  @override
  String get prayerEditReminderOff => 'Sem lembrete';

  @override
  String get prayerEditTimeLabel => 'Horário do aviso';

  @override
  String get prayerEditRepeatLabel => 'Repetir';

  @override
  String get prayersSectionGuides => 'Guias e devoções';

  @override
  String get guideMassDesc => 'Acompanhe cada parte da Missa';

  @override
  String get guideAdorationDesc => 'Um roteiro para a visita ao Santíssimo';

  @override
  String get guideIntentionsDesc => 'Seus pedidos e as graças recebidas';

  @override
  String get supportTitle => 'Apoie o projeto';

  @override
  String get supportSubtitle => 'Gratuito para todos, sempre';

  @override
  String get supportStory =>
      'Este aplicativo é gratuito e continuará sendo. Ele nasceu também de um sonho: o nosso casamento. Se ele ajuda você na vida de oração, considere uma doação de qualquer valor para as despesas da cerimônia, ou reze por nós. As duas coisas são um presente enorme.';

  @override
  String get supportSectionPrayer => 'Com oração';

  @override
  String get supportSectionDonate => 'Com uma doação';

  @override
  String get supportPrayerTitle => 'Reze pelos noivos';

  @override
  String get supportPrayerDesc =>
      'Uma Ave-Maria pelo nosso casamento e pela nossa futura família';

  @override
  String get supportPrayerButton => 'Vou rezar por vocês';

  @override
  String get supportPrayerThanks =>
      'Muito obrigado! Que Nossa Senhora interceda por você também.';

  @override
  String get supportPixTitle => 'PIX';

  @override
  String get supportPixDesc =>
      'Aponte a câmera do app do banco para o QR Code, ou copie o código';

  @override
  String get supportPixCopyPaste => 'Copiar PIX copia e cola';

  @override
  String get supportPixCopied =>
      'Código PIX copiado. Cole no app do seu banco.';

  @override
  String get supportPixKey => 'Chave PIX';

  @override
  String get supportCardTitle => 'Cartão de crédito';

  @override
  String get supportCardDesc => 'Doação internacional, por uma página segura';

  @override
  String get supportCryptoTitle => 'Criptomoedas';

  @override
  String get supportCryptoDesc => 'Confira a rede antes de enviar';

  @override
  String get supportAddressCopied => 'Endereço copiado';

  @override
  String get supportLinkCopied => 'Não foi possível abrir. O link foi copiado.';

  @override
  String get supportShowQr => 'Mostrar QR Code';

  @override
  String get supportHideQr => 'Esconder QR Code';

  @override
  String get supportFootnote =>
      'Doações são voluntárias e não liberam nada a mais: o app inteiro é gratuito.';

  @override
  String get aboutSupportButton => 'Apoie o projeto';

  @override
  String get nudgeTitle => 'Um pedido dos noivos';

  @override
  String get nudgeBody =>
      'Este app é gratuito e nasceu para ajudar nas despesas do nosso casamento. Se ele faz bem à sua vida de oração, considere uma doação, ou reze uma Ave-Maria por nós.';

  @override
  String get nudgeSupport => 'Apoiar';

  @override
  String get nudgeNotNow => 'Agora não';

  @override
  String get nudgeAlreadySupported => 'Já apoiei';

  @override
  String get nudgeThanksSupported =>
      'Muito obrigado pelo seu apoio! Deus lhe pague.';

  @override
  String get supportHeroTitle => 'Um app gratuito, um sonho a dois';

  @override
  String get supportQuote =>
      '“Portanto, o que Deus uniu, o homem não separe.” (Mt 19,6)';

  @override
  String get supportBadgeFree => '100% gratuito';

  @override
  String get supportBadgeNoAds => 'Sem anúncios';

  @override
  String get supportBadgePrivate => 'Dados só no seu celular';

  @override
  String get supportChooseMethod => 'Como você quer ajudar?';

  @override
  String get supportMethodPix => 'PIX';

  @override
  String get supportMethodCard => 'Cartão';

  @override
  String get supportMethodCrypto => 'Cripto';

  @override
  String get supportPixAmountLabel => 'Escolha um valor (ou deixe em aberto)';

  @override
  String get supportPixAmountFree => 'Outro valor';

  @override
  String get supportPrayerAlt => 'Prefere ajudar com oração?';

  @override
  String get supportCryptoLinkButton => 'Doar com cripto';

  @override
  String get drawerTour => 'Guia do app';

  @override
  String get drawerTourDesc => 'Passo a passo de onde fica cada coisa';

  @override
  String get tourSkip => 'Pular';

  @override
  String get tourBack => 'Voltar';

  @override
  String get tourNext => 'Próximo';

  @override
  String get tourFinish => 'Começar';

  @override
  String get tourWelcomeTitle => 'Bem-vindo! Vamos conhecer o app?';

  @override
  String get tourWelcomeBody =>
      'Em poucos passos você vai ver onde fica cada coisa: o plano do dia, as orações, as novenas, o terço e o exame de consciência. Toque em Próximo (ou em qualquer lugar da tela) para seguir.';

  @override
  String get tourNavGardenTitle => 'Jardim: a sua página do dia';

  @override
  String get tourNavGardenBody =>
      'Este botão, na barra de baixo, sempre traz você de volta para cá. É aqui que fica o seu plano de oração do dia.';

  @override
  String get tourGardenTitle => 'Jardim da Alma';

  @override
  String get tourGardenBody =>
      'Cada quadradinho é um dia. Ele vai ficando mais verde conforme você reza, e fica todo verde nos dias de Missa ou Confissão. É o retrato da sua constância.';

  @override
  String get tourTodayTitle => 'Hoje';

  @override
  String get tourTodayBody =>
      'Aqui ficam as orações do seu plano para hoje, separadas por manhã, meio-dia e noite. Toque no quadradinho ao lado de uma oração para marcar como rezada. Toque no nome para abri-la, e no botão de três pontinhos, à direita, para mudar o horário, criar um lembrete ou tirar do plano.';

  @override
  String get tourAddTitle => 'Adicionar ao plano';

  @override
  String get tourAddBody =>
      'Use o botão + para colocar no seu plano uma oração, uma novena ou o terço. Você escolhe o momento do dia e, se quiser, um lembrete.';

  @override
  String get tourCalendarTitle => 'Calendário';

  @override
  String get tourCalendarBody =>
      'Veja o que você rezou em cada dia, as Missas, confissões e novenas, além do tempo litúrgico. Toque em um dia para ver os detalhes.';

  @override
  String get tourRemindersTitle => 'Lembretes';

  @override
  String get tourRemindersBody =>
      'Todos os avisos do app em um só lugar: orações, novenas, confissão e os dias de preceito da Igreja. Você pode pausar, editar ou criar um lembrete seu.';

  @override
  String get tourMenuTitle => 'Menu';

  @override
  String get tourMenuBody =>
      'Aqui ficam Sobre o Projeto, este Guia do app (para rever quando quiser) e as Configurações, como idioma, tamanho do texto e backup.';

  @override
  String get tourPrayersTitle => 'Orações';

  @override
  String get tourPrayersBody =>
      'Todas as orações do app, organizadas por categoria. No topo aparece a oração indicada para este momento do dia e o santo do dia.';

  @override
  String get tourSearchTitle => 'Buscar uma oração';

  @override
  String get tourSearchBody =>
      'Digite parte do nome ou do texto. A busca entende palavras sem acento e até pequenos erros de digitação.';

  @override
  String get tourGuidesTitle => 'Guias e devoções';

  @override
  String get tourGuidesBody =>
      'Guia da Missa (tradicional ou atual), roteiro de Adoração ao Santíssimo e as suas intenções de oração.';

  @override
  String get tourNovenasTitle => 'Novenas';

  @override
  String get tourNovenasBody =>
      'Uma novena é uma oração de nove dias seguidos. Aqui ficam as novenas tradicionais, como a de Natal, as do Sagrado Coração e da Imaculada Conceição, e a de santos como São José. Você acompanha cada dia sem perder a conta.';

  @override
  String get tourRosaryTitle => 'Santo Terço';

  @override
  String get tourRosaryBody =>
      'O terço guiado: o app mostra cada oração na hora certa, para você rezar sem se perder nas contas. Funciona em qualquer lugar, sem internet.';

  @override
  String get tourExamTitle => 'Exame de consciência';

  @override
  String get tourExamBody =>
      'O coração do app para a confissão. Examine a consciência com calma, marque o que lembrar e leve um resumo para o confessionário. Tudo fica só no seu celular e pode ser protegido por senha.';

  @override
  String get tourEndTitle => 'Pronto!';

  @override
  String get tourEndBody =>
      'Você pode rever este guia quando quiser, no menu (as três linhas no canto de cima) › Guia do app. Que este app ajude você a rezar todos os dias. Deus abençoe!';

  @override
  String get onbFeatureRosary =>
      'Santo Terço conta por conta e novenas com lembrete diário';

  @override
  String get onbFeatureGuides =>
      'Guias da Missa, da Adoração e suas intenções de oração';

  @override
  String get onbPrivacyTitle => 'Sua oração é só sua';

  @override
  String get onbPrivacyBody =>
      'Tudo o que você registra fica guardado apenas neste celular.';

  @override
  String get onbPrivacyNoAccount => 'Sem conta e sem login';

  @override
  String get onbPrivacyNoAds => 'Sem anúncios e sem rastreamento';

  @override
  String get onbPrivacyBackup => 'O backup é você quem faz, quando quiser';

  @override
  String get onbProjectTitle => 'Gratuito, feito com amor';

  @override
  String get onbProjectBody =>
      'O Sancta é gratuito e sem anúncios. Foi feito por um casal que está se preparando para o matrimônio. Rezar por nós já é um grande presente; quem quiser ajudar encontra como em Sobre o Projeto, no menu.';

  @override
  String get onbProjectBodyStore =>
      'O Sancta é gratuito e sem anúncios. Foi feito por um casal que está se preparando para o matrimônio. Se puder, reze por nós!';

  @override
  String get onbReadyTitle => 'Tudo pronto!';

  @override
  String get onbReadyBody =>
      'Quer um passeio rápido pela tela? O guia mostra onde fica cada coisa. Você pode revê-lo quando quiser em Menu › Guia do app.';

  @override
  String get onbTourStart => 'Ver o guia';

  @override
  String get onbTourSkip => 'Começar sem o guia';

  @override
  String get gardenDemoHint =>
      'Exemplo: assim fica o jardim depois de um ano de oração e perseverança. O seu começa hoje!';

  @override
  String get afterTourTitle => 'Sobre este app';

  @override
  String get afterTourBody =>
      'O Sancta foi criado para ajudar a pagar as despesas do meu casamento, mas também para que os católicos rezem bem e vivam a fé a cada dia. Ele é gratuito e sem anúncios. Se ele te ajuda e você quiser colaborar, toque no botão abaixo; e uma oração por nós já é um grande presente.';

  @override
  String get afterTourBodyStore =>
      'O Sancta foi criado para que os católicos rezem bem e vivam a fé a cada dia, e também para ajudar nas despesas do meu casamento. Ele é gratuito e sem anúncios. Uma oração por nós já é um grande presente.';

  @override
  String get afterTourButton => 'Conhecer o projeto';

  @override
  String get afterTourLater => 'Agora não';

  @override
  String get tourNovenaSearchTitle => 'Encontre a sua novena';

  @override
  String get tourNovenaSearchBody =>
      'Digite o nome do santo ou da devoção. A busca aceita erros de digitação e acentos. Quando há uma festa chegando, o app sugere a novena certa no topo da lista.';

  @override
  String get tourNovenaStartTitle => 'Iniciar e acompanhar';

  @override
  String get tourNovenaStartBody =>
      'Toque numa novena para ler a oração de cada dia. Em Iniciar Novena você escolhe o primeiro dia e o horário do lembrete. Daí em diante a oração do dia aparece na aba Hoje, o progresso fica salvo e uma vela acende no seu Jardim.';

  @override
  String get tourRosaryProgressTitle => 'Seu Rosário de hoje';

  @override
  String get tourRosaryProgressBody =>
      'Cada bolinha é um terço rezado hoje. Quatro terços (com os mistérios luminosos) ou três (no Modo Tradicional, que você escolhe em Configurações) completam um Rosário inteiro, e o app comemora quando você chega lá.';

  @override
  String get tourRosaryTodayTitle => 'Mistérios do dia';

  @override
  String get tourRosaryTodayBody =>
      'O app já escolhe os mistérios do dia da semana. Toque no cartão para rezar: as orações vão passando conta por conta, com Próxima e Anterior. A tela fica acesa, o celular vibra a cada Ave-Maria, mais longo ao fim de cada mistério, e ao terminar uma chuva de pétalas e uma rosa no Jardim.';

  @override
  String get tourExamHeaderTitle => 'Suas confissões';

  @override
  String get tourExamHeaderBody =>
      'Aqui você registra a última confissão e planeja a próxima. O app avisa quando está chegando a hora e mostra há quanto tempo você não se confessa.';

  @override
  String get tourExamJornadaTitle => 'Jornada de Confissão';

  @override
  String get tourExamJornadaBody =>
      'Um caminho passo a passo para quem quer se preparar bem: oração, exame, arrependimento e propósito, até o dia de se confessar. Ótimo para quem está voltando à confissão depois de muito tempo.';

  @override
  String get tourExamSectionsTitle => 'Examine por categorias';

  @override
  String get tourExamSectionsBody =>
      'Percorra as categorias, como os Mandamentos e os pecados capitais, e toque em + em cada item de que se lembrar (se repetiu, toque de novo). Use a busca para achar um pecado pelo nome.';

  @override
  String get tourExamGuideTitle => 'Gerar o guia';

  @override
  String get tourExamGuideBody =>
      'Quando terminar, toque em Gerar guia: o app monta um resumo organizado do que você marcou, para levar à confissão. Ao confirmar a confissão, as marcações são apagadas e o Jardim ganha um lírio.';

  @override
  String get backupRestoring =>
      'Restaurando seu backup… Isso pode levar alguns segundos.';
}
