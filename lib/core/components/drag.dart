import 'package:flutter/material.dart';

class DragContainer extends StatelessWidget {
  const DragContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(16),
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey.shade500,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
