import 'package:app/core/auth/presentation/components/login_button.dart';
import 'package:app/core/auth/presentation/cubits/auth_cubits.dart';
import 'package:app/features/calculator/views/widgets/my_text_field.dart';
import 'package:app/shared/dimens.dart';
import 'package:app/shared/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;

  const RegisterPage({super.key, required this.togglePages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final confirmPwController = TextEditingController();

  void register() {
    final name = nameController.text;
    final email = emailController.text;
    final pw = pwController.text;
    final confirmPw = confirmPwController.text;

    final authCubit = context.read<AuthCubits>();
    if (email.isNotEmpty &&
        name.isNotEmpty &&
        pw.isNotEmpty &&
        confirmPw.isNotEmpty) {
      if (pw == confirmPw) {
        authCubit.register(name, email, pw);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Пароли не совпадают!')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста заполните все поля!')),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    pwController.dispose();
    confirmPwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            MyTextField(controller: nameController, title: 'Ваше Имя'),
            const SizedBox(height: Dimens.height12),
            MyTextField(
              controller: emailController,
              obscureText: false,
              title: 'Почта',
            ),
            const SizedBox(height: Dimens.height12),
            MyTextField(
              controller: pwController,
              obscureText: true,
              title: 'Пароль',
            ),
            const SizedBox(height: Dimens.height12),
            MyTextField(
              controller: confirmPwController,
              obscureText: true,
              title: 'Подтвердите Пароль',
            ),
            const SizedBox(height: Dimens.height24),
            LoginButton(onTap: register, title: 'РЕГИСТРАЦИЯ'),
            const SizedBox(height: Dimens.height12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Есть аккаунт?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: widget.togglePages,

                  child: Text(
                    ' Войти сейчас!',
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
    );
  }
}
