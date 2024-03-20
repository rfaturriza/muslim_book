import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quranku/core/constants/asset_constants.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';

class NumberPin extends StatelessWidget {
  final String number;

  const NumberPin({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          AssetConst.starSvg,
          color: context.theme.colorScheme.primary,
        ),
        Text(
          number,
          style: context.textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
