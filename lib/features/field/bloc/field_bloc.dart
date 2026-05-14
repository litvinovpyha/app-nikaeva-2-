import 'package:app/core/bloc/generic_bloc.dart';
import 'package:app/features/field/models/field.dart';
import 'package:app/features/field/repository/field_repository.dart';

final fieldBloc = GenericBloc<Field>(repository: fieldRepo);
