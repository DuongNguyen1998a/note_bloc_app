import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_bloc_app/blocs/login/login_bloc.dart';
import 'package:note_bloc_app/screen/base_screen.dart';
import 'package:note_bloc_app/utils/support_utils.dart';
import 'package:note_bloc_app/widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Login screen build');
    return const BaseScreen(
      isShowBottomNav: false,
      body: Center(
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  Future<void> doLogin() async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      } else {
        // close soft keyboard
        FocusManager.instance.primaryFocus?.unfocus();
        // run function login
        context.read<LoginBloc>().add(
              DoLogin(
                email: emailTextController.text,
                password: passwordTextController.text,
              ),
            );
        // save data to local storage

      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build login form');
    return BlocListener(
      bloc: context.read<LoginBloc>(),
      listener: (context, state) async {
        debugPrint(state.toString());
        if (state is LoginSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, '/note', (route) => true);
          SupportUtils.showSnackBarDialog(
            context,
            'Login success',
            const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
          );
        } else if (state is LoginError) {
          SupportUtils.showSnackBarDialog(
            context,
            'Login failed, invalid email or password',
            const Icon(
              Icons.cancel_outlined,
              color: Colors.red,
            ),
          );
        } else if (state is LoginInitial) {
          // setState(() {
          //   obsecureTextPassword = state.isHide;
          // });
        }
      },
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomizeInputTextField(
                hintText: 'Email',
                iconData: Icons.email_outlined,
                controller: emailTextController,
                textColor: Colors.white,
                hintColor: Colors.white,
                iconColor: Colors.white70,
                obsecureText: false,
              ),
              const SizedBox(
                height: 25,
              ),
              CustomizeInputTextField(
                hintText: 'Password',
                iconData: Icons.password_outlined,
                controller: passwordTextController,
                textColor: Colors.white,
                hintColor: Colors.white,
                iconColor: Colors.white70,
                suffixIcon: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                  if (state is LoginInitial) {
                    return IconButton(
                      onPressed: () {
                        context
                            .read<LoginBloc>()
                            .add(TogglePassword(isHide: state.isHide));
                      },
                      icon: Icon(
                        state.isHide ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.visibility,
                        color: Colors.white,
                      ),
                    );
                  }
                }),
                obsecureText: true, //obsecureTextPassword,
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  doLogin();
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                    if (state is LoginLoading) {
                      return const CircularProgressIndicator(
                        color: Colors.white,
                      );
                    } else {
                      return const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      );
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
