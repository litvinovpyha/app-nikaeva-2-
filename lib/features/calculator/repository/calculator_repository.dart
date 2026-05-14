import 'package:app/core/repository/generic_api_reposotory.dart';
import 'package:app/features/calculator/models/calculator.dart';

final calculatorRepo = GenericApiRepository<Calculator>(
  // для реального устройства  айпишка
  // baseUrl: 'http://192.168.5.49:8080/api/calculators',
  baseUrl: 'http://localhost:8080/api/calculators',
  fromJson: (json) => Calculator.fromJson(json),
  toJson: (b) => b.toJson(),
);
