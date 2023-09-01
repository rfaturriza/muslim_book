import 'package:flutter/material.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/themes/color.dart';

import '../utils/debouncer.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.initialValue,
    required this.hintText,
    required this.onChanged,
    required this.onSubmitted,
  });

  final String initialValue;
  final String hintText;
  final void Function(String) onChanged;
  final void Function() onSubmitted;

  @override
  Widget build(BuildContext context) {
    final debouncer = Debouncer(milliseconds: 1000);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: secondaryColor.shade800,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: primaryColor.shade50,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              initialValue: initialValue,
              onTapOutside: (_) => context.dismissKeyboard(),
              onChanged: (val) {
                debouncer.run(() => onChanged(val));
              },
              onFieldSubmitted: (_) => context.dismissKeyboard(),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: primaryColor.shade50,
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
