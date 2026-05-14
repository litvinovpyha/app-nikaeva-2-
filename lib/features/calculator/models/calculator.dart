import 'package:app/core/model/base_model.dart';
import 'package:app/features/field/models/field.dart';

class Calculator extends BaseModel {
  @override
  final String id;
  final int position;
  final String title;
  final String? clientId;
  final List<Field>? calculatorFields;

  Calculator({
    required this.id,
    required this.position,
    required this.title,
    required this.clientId,
    required this.calculatorFields,
  });

  Calculator copyWith({
    String? id,
    int? position,
    String? title,
    String? clientId,
    List<Field>? calculatorFields,
  }) {
    return Calculator(
      id: id ?? this.id,
      position: position ?? this.position,
      title: title ?? this.title,
      clientId: clientId ?? this.clientId,
      calculatorFields: calculatorFields ?? this.calculatorFields,
    );
  }

  factory Calculator.fromJson(Map<String, dynamic> json) {
    return Calculator(
      id: json['id'].toString(),
      position: (json['position'] as num).toInt(),
      title: json['title'] as String,
      clientId: json['client_id'] as String?,
      calculatorFields: (json['calculatorFields'] as List? ?? [])
          .map((e) => Field.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'position': position,
      'title': title,
      'client_id': clientId,
      'calculatorFields': calculatorFields?.map((e) => e.toJson()).toList(),
    };
  }
}
