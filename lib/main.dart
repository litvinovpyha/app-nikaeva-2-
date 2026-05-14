import 'package:app/core/auth/data/firebase_auth_perository.dart';
import 'package:app/core/auth/presentation/cubits/auth_cubits.dart';
import 'package:app/core/auth/presentation/cubits/auth_states.dart';
import 'package:app/core/auth/presentation/views/auth_page.dart';
import 'package:app/core/bloc/generic_bloc.dart';
import 'package:app/core/bloc/generic_event.dart';
import 'package:app/core/entryPoint/entry_point.dart';
import 'package:app/core/theme/light_mode.dart';
import 'package:app/features/booking/model/booking.dart';
import 'package:app/features/booking/repository/booking_repository.dart';
import 'package:app/features/calculator/models/calculator.dart';
import 'package:app/features/calculator/repository/calculator_repository.dart';
import 'package:app/features/clients/models/client.dart';
import 'package:app/features/clients/repository/client_repository.dart';
import 'package:app/features/field/models/field.dart';
import 'package:app/features/field/repository/field_repository.dart';
import 'package:app/features/userservice/model/user_service.dart';
import 'package:app/features/userservice/repository/user_services_repository.dart';
import 'package:app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthCubits(r: FirebaseAuthPerository())..checkAuth(),
        ),

        BlocProvider(
          create: (_) =>
              GenericBloc<Field>(repository: fieldRepo)
                ..add(LoadItems<Field>()),
        ),
        BlocProvider(
          create: (_) =>
              GenericBloc<Client>(repository: clientRepo)
                ..add(LoadItems<Client>()),
        ),
        BlocProvider(
          create: (_) =>
              GenericBloc<UserService>(repository: userServicesRepo)
                ..add(LoadItems<UserService>()),
        ),
        BlocProvider(
          create: (_) =>
              GenericBloc<Booking>(repository: bookingRepo)
                ..add(LoadItems<Booking>()),
        ),
        BlocProvider(
          create: (_) =>
              GenericBloc<Calculator>(repository: calculatorRepo)
                ..add(LoadItems<Calculator>()),
        ),
      ],
      child: MaterialApp(
        title: 'Nikaeva App',
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: Scaffold(
          body: BlocConsumer<AuthCubits, AuthState>(
            builder: (context, state) {
              if (state is Unauthenticated) {
                return const AuthPage();
              } else if (state is Authenticated) {
                return const EntryPoint();
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
        ),
      ),
    );
  }
}
