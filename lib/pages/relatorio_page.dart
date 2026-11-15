import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/models/categoria.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/widgets/confession_confirmation_dialog.dart';

class RelatorioPage extends StatelessWidget {
  const RelatorioPage({super.key});

  /// O texto do pecado termina em ponto; ele é seguido por "(2 vezes)".
  static String _semPonto(String s) => s.endsWith('.') ? s.substring(0, s.length - 1) : s;

  // Diálogo de confirmação
  void _mostrarDialogoConfirmacao(BuildContext context) async {
    final result = await showDialog<ConfessionConfirmationResult>(
      context: context,
      builder: (ctx) => const ConfessionConfirmationDialog(),
    );

    if (result != null && context.mounted) {
      _limparExameAposConfissao(
        context,
        confessionDate: result.date,
        penanceNote: result.penanceNote,
        reminderTime: result.reminderTime,
      );
    }
  }

  void _limparExameAposConfissao(
    BuildContext context, {
    required DateTime confessionDate,
    String? penanceNote,
    TimeOfDay? reminderTime,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final confessionProvider = Provider.of<ConfessionProvider>(context, listen: false);
    
    confessionProvider.confirmarConfissao(date: confessionDate, penanceNote: penanceNote);
    
    if (reminderTime != null) {
      final note = penanceNote ?? l10n.reminderTypePenance;
      confessionProvider.setPenanceReminder(note, reminderTime);
    }
    
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.reportConfessSuccess)),
    );
  }

  /// Texto simples do guia (só os pecados marcados), para copiar ou compartilhar.
  String _buildPlainText(BuildContext context, ConfessionProvider provider) {
    final l10n = AppLocalizations.of(context)!;
    final buf = StringBuffer()
      ..writeln(l10n.reportGuideTitle)
      ..writeln();

    for (final categoria in Categoria.getExaminationCategories(context)) {
      final subIds = categoria.itens.keys.toList()..sort();
      final linhas = <String>[];
      for (final sub in subIds) {
        final pecados = categoria.itens[sub]!;
        for (var i = 0; i < pecados.length; i++) {
          final n = provider.getContador('${categoria.id}-$sub-$i');
          if (n > 0) linhas.add('- ${l10n.reportSinCount(_semPonto(pecados[i]), n)}');
        }
      }
      if (linhas.isEmpty) continue;
      buf
        ..writeln(categoria.titulo.toUpperCase())
        ..writeAll(linhas, '\n')
        ..writeln()
        ..writeln();
    }
    return buf.toString().trimRight();
  }

  Future<void> _copy(BuildContext context, ConfessionProvider provider) async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: _buildPlainText(context, provider)));
    messenger.showSnackBar(SnackBar(content: Text(l10n.reportCopied)));
  }

  Future<void> _share(BuildContext context, ConfessionProvider provider) async {
    await SharePlus.instance.share(
      ShareParams(text: _buildPlainText(context, provider)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final confession = Provider.of<ConfessionProvider>(context);
    final hasSins = confession.totalPecados > 0;
    return InnerPageScaffold(
      title: l10n.reportTitle,
      actions: hasSins
          ? [
              IconButton(
                icon: const Icon(Icons.copy, color: Colors.white),
                tooltip: l10n.reportCopy,
                onPressed: () => _copy(context, confession),
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                tooltip: l10n.reportShare,
                onPressed: () => _share(context, confession),
              ),
            ]
          : const [],
      child: Consumer<ConfessionProvider>(
        builder: (context, confessionProvider, child) {
          final pecadosAtivos = confessionProvider.pecados.entries.where((entry) => entry.value > 0).toList();

          if (pecadosAtivos.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  l10n.reportEmpty,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: AppColors.secondaryText),
                ),
              ),
            );
          }

          // Build sins list from categories
          final categorias = Categoria.getExaminationCategories(context);
          List<Widget> pecadosWidgets = [];
          for (final categoria in categorias) {
            pecadosWidgets.addAll(_buildPecadosCategoria(context, categoria, confessionProvider));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Aviso importante
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color.lerp(AppColors.warningColor, Colors.white, 0.9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.warningColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.reportWarningTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.warningColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.reportWarningContent,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryText,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Título do relatório
                Text(
                  l10n.reportGuideTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.themeColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Introdução
                Text(
                  l10n.reportKneelInstruction,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  l10n.reportBlessMe,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 20),
                // Tempo desde última confissão
                Builder(
                  builder: (context) {
                    final lastConfession = confessionProvider.dataUltimaConfissao;
                    if (lastConfession == null) {
                      return Text(
                        l10n.reportLastConfessionNone,
                        style: const TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: AppColors.secondaryText,
                        ),
                      );
                    }
                    
                    final agora = DateTime.now();
                    final diferenca = agora.difference(lastConfession);
                    final dias = diferenca.inDays;
                    
                    String timeStr;
                    if (dias == 0) {
                      timeStr = l10n.timeAgoToday;
                    } else if (dias < 7) {
                      timeStr = l10n.timeAgoDays(dias);
                    } else if (dias < 30) {
                      final semanas = (dias / 7).floor();
                      final diasRestantes = dias % 7;
                      if (diasRestantes == 0) {
                        timeStr = l10n.timeAgoWeeks(semanas);
                      } else {
                        timeStr = '${l10n.timeAgoWeeks(semanas)}${l10n.timeAgoConnector}${l10n.timeAgoDays(diasRestantes)}';
                      }
                    } else if (dias < 365) {
                      final meses = (dias / 30).floor();
                      final diasRestantes = dias % 30;
                      if (diasRestantes == 0) {
                        timeStr = l10n.timeAgoMonths(meses);
                      } else {
                        final semanasRestantes = (diasRestantes / 7).floor();
                        if (semanasRestantes > 0) {
                          timeStr = '${l10n.timeAgoMonths(meses)}${l10n.timeAgoConnector}${l10n.timeAgoWeeks(semanasRestantes)}';
                        } else {
                          timeStr = '${l10n.timeAgoMonths(meses)}${l10n.timeAgoConnector}${l10n.timeAgoDays(diasRestantes)}';
                        }
                      }
                    } else {
                      final anos = (dias / 365).floor();
                      final diasRestantes = dias % 365;
                      final mesesRestantes = (diasRestantes / 30).floor();

                      if (mesesRestantes == 0) {
                        timeStr = l10n.timeAgoYears(anos);
                      } else {
                        timeStr = '${l10n.timeAgoYears(anos)}${l10n.timeAgoConnector}${l10n.timeAgoMonths(mesesRestantes)}';
                      }
                    }

                    return Text(
                      l10n.reportLastConfession(timeStr),
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: AppColors.secondaryText,
                      ),
                    );
                  }
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.reportMySins,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                // Lista de pecados
                ...pecadosWidgets,
                const SizedBox(height: 20),
                Text(
                  l10n.reportFinalPrayer,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 30),
                // Ato de Contrição
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.accentGold),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.reportActOfContritionTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.themeColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.reportActOfContrition,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Botão de Confessar-se
                SafeArea(
                  top: false,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _mostrarDialogoConfirmacao(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.themeColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        l10n.reportConfessButton,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildPecadosCategoria(BuildContext context, Categoria categoria, ConfessionProvider confessionProvider) {
    final l10n = AppLocalizations.of(context)!;
    List<Widget> widgets = [];
    bool temPecadosNestaCategoria = false;
    bool tituloAdicionado = false;

    // Ordenar subcategorias para garantir a ordem correta
    final subcategoriasOrdenadas = categoria.itens.keys.toList()..sort();

    for (final subcategoriaId in subcategoriasOrdenadas) {
      final pecados = categoria.itens[subcategoriaId]!;
      List<Widget> pecadosWidgets = [];

      for (int i = 0; i < pecados.length; i++) {
        // Construção da chave deve ser idêntica à usada em CategoriaPecadosPage
        final pecadoId = '${categoria.id}-$subcategoriaId-$i';
        final contador = confessionProvider.getContador(pecadoId);

        if (contador > 0) {
          temPecadosNestaCategoria = true;
          pecadosWidgets.add(
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                l10n.reportSinCount(_semPonto(pecados[i]), contador),
                style: const TextStyle(height: 1.4, fontSize: 15),
              ),
            ),
          );
        }
      }

      if (pecadosWidgets.isNotEmpty) {
        if (!tituloAdicionado) {
          widgets.addAll([
            const SizedBox(height: 16),
            Text(
              categoria.titulo.toUpperCase(),
              style: const TextStyle(
                color: AppColors.themeColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Divider(color: AppColors.accentGold, thickness: 1),
            const SizedBox(height: 8),
          ]);
          tituloAdicionado = true;
        }

        widgets.addAll([
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
            child: Text(
              Categoria.getTituloSubcategoria(context, categoria.id, subcategoriaId),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
                fontSize: 15,
              ),
            ),
          ),
          ...pecadosWidgets,
        ]);
      }
    }

    return temPecadosNestaCategoria ? widgets : [];
  }
}