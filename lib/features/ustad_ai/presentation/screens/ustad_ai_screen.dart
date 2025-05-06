import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/features/ustad_ai/presentation/blocs/ustad_ai/ustad_ai_bloc.dart';
import 'package:quranku/generated/locale_keys.g.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void onSubmit(String value) {
      FocusScope.of(context).unfocus();
      context.read<UstadAiBloc>().add(UstadAiEvent.sendPrompt(value));
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            LocaleKeys.ustadzAiScreen_title.tr(),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: BlocBuilder<UstadAiBloc, UstadAiState>(
                  builder: (context, state) {
                    if (state is UstadAiStreamingState) {
                      if (state.text.isEmpty) {
                        return Text(
                          LocaleKeys.ustadzAiScreen_generating.tr(),
                        );
                      }
                      return SingleChildScrollView(
                        child: MarkdownBody(data: state.text),
                      );
                    } else if (state is UstadAiErrorState) {
                      return SingleChildScrollView(
                        child: Text(
                          state.message,
                          style: context.textTheme.labelMedium,
                        ),
                      );
                    } else {
                      return Text(
                        LocaleKeys.ustadzAiScreen_description.tr(),
                      );
                    }
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: context.theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    autofocus: true,
                    onTapOutside: (_) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.ustadzAiScreen_labelTextField.tr(),
                    ),
                    onSubmitted: onSubmit,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: context.theme.colorScheme.primary,
                        ),
                        color: context.theme.colorScheme.onPrimary,
                        onPressed: () {
                          final value = controller.text;
                          if (value.isNotEmpty) {
                            onSubmit(value);
                          }
                        },
                        icon: BlocBuilder<UstadAiBloc, UstadAiState>(
                          builder: (context, state) {
                            if (state is UstadAiStreamingState) {
                              if (state.isGenerating) {
                                return SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: context.theme.colorScheme.onPrimary,
                                  ),
                                );
                              }
                            }
                            return const Icon(
                              Symbols.arrow_upward_alt_rounded,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
