import 'package:app/constants.dart';
import 'package:app/shared/borders.dart';
import 'package:app/shared/styles.dart';
import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isEnabled;

  const CreateButton({
    super.key,
    this.onTap,
    required this.title,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 42),
      child: SizedBox(
        width: double.infinity,
        height: 50, // можно задать высоту
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: isEnabled
                ? backgroundColor2
                : Colors.grey, // серая если неактивна
            shape: RoundedRectangleBorder(
              borderRadius: br10, // скруглённые края
            ),
          ),
          child: Text(title, style: whiteTitleTextStyle),
        ),
      ),
    );
  }
}
