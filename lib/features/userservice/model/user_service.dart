import 'package:app/core/model/base_model.dart';

class UserService extends BaseModel {
  @override
  final String id;
  final String name;

  UserService({required this.id, required this.name});

  UserService copyWith({String? id, String? name}) {
    return UserService(id: id ?? this.id, name: name ?? this.name);
  }

  factory UserService.fromJson(Map<String, dynamic> json) {
    return UserService(
      id: json['id'].toString(),
      name: json['name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
