import 'package:flutter/material.dart';

class FixedPriceSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const FixedPriceSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: const Text('Фиксированная цена'),
      subtitle: const Text('Если включено — цена будет постоянной'),
      contentPadding: EdgeInsets.zero,
    );
  }
}
