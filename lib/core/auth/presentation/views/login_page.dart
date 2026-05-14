// LOGIN PAGE
import 'package:app/core/auth/presentation/components/login_button.dart';
import 'package:app/core/auth/presentation/cubits/auth_cubits.dart';
import 'package:app/features/calculator/views/widgets/my_text_field.dart';
import 'package:app/shared/dimens.dart';
import 'package:app/shared/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;
  const LoginPage({super.key, required this.togglePages});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  late final authCubit = context.read<AuthCubits>();

  void login() {
    final email = emailController.text;
    final pw = pwController.text;

    if (email.isNotEmpty && pw.isNotEmpty) {
      authCubit.login(email, pw);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста заполните все поля!')),
      );
    }
  }

  void resetpass() async {
    final email = emailController.text;

    if (email.isNotEmpty) {
      final String message = await authCubit.resetpw(email);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста заполните поле с почтой!')),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.padding16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Logo(),
                const SizedBox(height: Dimens.height24),
                Text(
                  'Nikaeva Beauty Store',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(height: Dimens.height24),
                MyTextField(controller: emailController, title: 'Почта'),
                const SizedBox(height: Dimens.height12),
                MyTextField(
                  controller: pwController,
                  obscureText: true,
                  title: 'Пароль',
                ),
                const SizedBox(height: Dimens.height12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: resetpass,
                      child: Text(
                        'Забыли пароль?',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimens.height24),
                LoginButton(onTap: login, title: 'ВОЙТИ'),
                const SizedBox(height: Dimens.height24),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Divider(color: Theme.of(context).colorScheme.tertiary),
                //     ),
                //     const Padding(
                //       padding: EdgeInsets.symmetric(horizontal: Dimens.padding24),
                //       child: Text('Или войти с помощью'),
                //     ),
                //     Expanded(
                //       child: Divider(color: Theme.of(context).colorScheme.tertiary),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: Dimens.height24),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: () async => authCubit.signInWithApple(),
                //       child: const AppleSingInButton(),
                //     ),

                //     const SizedBox(width: 20),

                //     GestureDetector(
                //       onTap: () async => authCubit.signInWithGoogle(),
                //       child: const GoogleSingInButton(),
                //     ),
                //   ],
                // ),
                const SizedBox(height: Dimens.height12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Нет аккаунта?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.togglePages,
                      child: Text(
                        ' Создайте сейчас!',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
