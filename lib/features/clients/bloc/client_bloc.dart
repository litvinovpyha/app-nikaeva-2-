import 'package:app/core/bloc/generic_bloc.dart';
import 'package:app/features/clients/models/client.dart';
import 'package:app/features/clients/repository/client_repository.dart';

final clientBloc = GenericBloc<Client>(repository: clientRepo);
