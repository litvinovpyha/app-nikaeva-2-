import 'package:app/core/bloc/generic_bloc.dart';
import 'package:app/features/calculator/models/calculator.dart';
import 'package:app/features/calculator/repository/calculator_repository.dart';

final calculatorBloc = GenericBloc<Calculator>(repository: calculatorRepo);
