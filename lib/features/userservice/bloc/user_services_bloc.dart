import 'package:app/core/bloc/generic_bloc.dart';
import 'package:app/features/userservice/model/user_service.dart';
import 'package:app/features/userservice/repository/user_services_repository.dart';

final userServiceBloc = GenericBloc<UserService>(repository: userServicesRepo);
