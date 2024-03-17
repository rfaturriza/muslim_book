import 'package:flutter/material.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/themes/color_schemes_material.dart';

import '../utils/debouncer.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.initialValue,
    required this.hintText,
    required this.onChanged,
    this.onSubmitted,
    this.isDense = false,
  });

  final String initialValue;
  final String hintText;
  final void Function(String) onChanged;
  final void Function()? onSubmitted;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    final debouncer = Debouncer(milliseconds: 1000);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? MaterialTheme.darkScheme().surfaceContainer
            : MaterialTheme.lightScheme().surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.manage_search,
            color: context.theme.colorScheme.onSurface,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              initialValue: initialValue,
              onTapOutside: (_) => context.dismissKeyboard(),
              onChanged: (val) {
                debouncer.run(() => onChanged(val));
              },
              onSaved: (val) => onSubmitted?.call(),
              onFieldSubmitted: (_) => context.dismissKeyboard(),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                isDense: isDense,
                hintText: hintText,
                hintStyle: context.theme.textTheme.titleSmall?.copyWith(
                  color: context.theme.colorScheme.onSurface.withOpacity(0.5),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
