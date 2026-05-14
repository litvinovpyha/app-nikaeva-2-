import 'package:app/core/repository/generic_api_reposotory.dart';
import 'package:app/features/userservice/model/user_service.dart';

final userServicesRepo = GenericApiRepository<UserService>(
  // для реального устройства  айпишка
  // baseUrl: 'http://192.168.5.49:8080/api/user-services',
  baseUrl: 'http://localhost:8080/api/user-services',
  fromJson: (json) => UserService.fromJson(json),
  toJson: (b) => b.toJson(),
);
