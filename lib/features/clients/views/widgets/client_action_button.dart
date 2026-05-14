import 'package:app/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClientActionButton extends StatelessWidget {
  final FaIconData icon;
  final Function()? onTap;
  const ClientActionButton(this.icon, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: FaIcon(icon, color: backgroundColor2.withValues(alpha: 0.7)),
        ),
      ),
    );
  }
}
