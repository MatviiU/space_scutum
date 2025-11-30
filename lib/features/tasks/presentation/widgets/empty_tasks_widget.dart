import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyTasksWidget extends StatelessWidget {
  const EmptyTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .center,
      mainAxisAlignment: .center,
      children: [
        SvgPicture.asset(
          'assets/no_data.svg',
          height: 200,
          width: 200,
          fit: .contain,
        ),
        const SizedBox(height: 16),
        const Text(
          'No tasks yet',
          style: TextStyle(fontSize: 18, fontWeight: .bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Tap the "+" to add a new task to get started',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
