import 'package:flutter/material.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';

class BackgroundGradient extends StatelessWidget {
  const BackgroundGradient({
    super.key,
    this.isShowTop = true,
    this.isShowBottom = true,
  });

  final bool isShowTop;
  final bool isShowBottom;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isShowTop) ...[
          Positioned(
            top: 0,
            child: Container(
              width: context.width,
              height: context.height * 0.2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    context.theme.primaryColor,
                    context.theme.primaryColor.withOpacity(0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ],
        if (isShowBottom) ...[
          Positioned(
            bottom: 0,
            child: Container(
              width: context.width,
              height: context.height * 0.2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    context.theme.primaryColor,
                    context.theme.primaryColor.withOpacity(0.0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
