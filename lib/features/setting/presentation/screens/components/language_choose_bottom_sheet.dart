import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';

import '../../../../../core/utils/extension/string_ext.dart';
import '../../../../../core/utils/pair.dart';

class LanguageChooseBottomSheet extends StatelessWidget {
  final String title;
  final List<Pair<Locale, String>> languages;
  final Function(Locale) onTap;

  const LanguageChooseBottomSheet({
    super.key,
    required this.title,
    required this.languages,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: context.textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: languages.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        languages[index].second,
                      ),
                      subtitle: Text(
                        LocaleNames.of(context)?.nameOf(
                              languages[index].first.languageCode,
                            ) ??
                            emptyString,
                      ),
                      onTap: () {
                        onTap(
                          Locale(
                            languages[index].first.languageCode,
                          ),
                        );
                      },
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
