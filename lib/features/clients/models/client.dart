import 'package:app/core/model/base_model.dart';

class Client extends BaseModel {
  @override
  final String id;
  final String name;
  final String? phone;
  final String? photo;
  final String? inst;
  final String? telegram;
  final DateTime? birthDay;
  final String? comment;

  Client({
    required this.id,
    required this.name,
    this.phone,
    this.photo,
    this.inst,
    this.telegram,
    this.birthDay,
    this.comment,
  });

  Client copyWith({
    String? id,
    String? name,
    String? phone,
    String? photo,
    String? inst,
    String? telegram,
    DateTime? birthDay,
    String? comment,
  }) {
    return Client(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
      inst: inst ?? this.inst,
      telegram: telegram ?? this.telegram,
      birthDay: birthDay ?? this.birthDay,
      comment: comment ?? this.comment,
    );
  }

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'].toString(),
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString(),
      photo: json['photo']?.toString(),
      inst: json['inst']?.toString(),
      telegram: json['telegram']?.toString(),
      birthDay: json['birth_day'] != null
          ? DateTime.parse(json['birth_day'].toString())
          : null,
      comment: json['comment']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'photo': photo,
      'inst': inst,
      'telegram': telegram,
      'birthDay': birthDay?.toIso8601String(),
      'comment': comment,
    };
  }
}
