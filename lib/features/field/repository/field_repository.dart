import 'package:app/core/repository/generic_api_reposotory.dart';
import 'package:app/features/field/models/field.dart';

final fieldRepo = GenericApiRepository<Field>(
  baseUrl: 'http://localhost:8080/api/fields',
  fromJson: (json) => Field.fromJson(json),
  toJson: (b) => b.toJson(),
);
