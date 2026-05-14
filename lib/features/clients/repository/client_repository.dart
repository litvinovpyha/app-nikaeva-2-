import 'package:app/core/repository/generic_api_reposotory.dart';
import 'package:app/features/clients/models/client.dart';

final clientRepo = GenericApiRepository<Client>(
  // для реального устройства  айпишка
  // baseUrl: 'http://192.168.5.49:8080/api/clients',
  baseUrl: 'http://localhost:8080/api/clients',
  fromJson: (json) => Client.fromJson(json),
  toJson: (b) => b.toJson(),
);
