import 'package:app/core/model/base_model.dart';

class Field extends BaseModel {
  @override
  final String id;
  final String title;
  final String hint;
  final bool isChecked;
  final int? position;

  Field({
    required this.id,
    required this.title,
    required this.hint,
    required this.isChecked,
    this.position,
  });

  Field copyWith({
    String? id,
    String? title,
    String? hint,
    bool? isChecked,
    int? position,
  }) {
    return Field(
      id: id ?? this.id,
      title: title ?? this.title,
      hint: hint ?? this.hint,
      isChecked: isChecked ?? this.isChecked,
      position: position ?? this.position,
    );
  }

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      id: json['id'].toString(),
      title: json['title'] as String,
      hint: json['hint'] as String,
      isChecked: json['ischecked'] as bool,
      position: json['position'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'hint': hint, 'isChecked': isChecked};
  }
}
