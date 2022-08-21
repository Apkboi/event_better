import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:line_icons/line_icons.dart';
import 'package:square_tickets/presenter/views/auth/views/wrapper.dart';
import 'package:square_tickets/presenter/widgets/custom_button.dart';
import 'package:square_tickets/presenter/widgets/outlined_form_field.dart';

import '../../../../di/injector.dart';
import '../../../../helpers/app_utils.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../theme/app_colors.dart';
import '../../home/views/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthBloc _authBloc = AuthBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocListener<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is LoginLoadingState) {
            AppUtils.showAnimatedProgressDialog(context);
          } else if (state is LoginSuccesState) {
            Navigator.pop(context);
            log('Success');
          } else if (state is LoginFailureState) {
            Navigator.pop(context);
            CustomSnackBar.showError(context, message: state.error);
            log('Failed');
          }
        },
        child: Container(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Enter you credential to login with square tickets and continue you journey of events ✈️',
                    style: TextStyle(color: AppColors.textColor, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    ' Email Address',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedFormField(
                    inputType: TextInputType.emailAddress,
                    controller: emailController,
                    hint: 'squarecheckout@gmail.com',
                    validator: MultiValidator([
                      EmailValidator(
                        errorText: 'Invalid email',
                      ),
                      RequiredValidator(
                          errorText: 'Password field must nut be empty')
                    ]),
                    preffix: const Icon(
                      LineIcons.envelopeOpenAlt,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    ' Password',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedFormField(
                    inputType: TextInputType.visiblePassword,
                    obscure: true,
                    controller: passwordController,
                    validator: MultiValidator([
                      MinLengthValidator(
                        6,
                        errorText: '',
                      ),
                      RequiredValidator(
                          errorText: 'Password field must nut be empty')
                    ]),
                    maxLine: 1,
                    suffix: const Icon(LineIcons.eyeSlash),
                    hint: '*********',
                    preffix: const Icon(
                      LineIcons.lockOpen,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        'Forgot password ?',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        login();
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                      child: Text(
                    'OR',
                    style: TextStyle(fontSize: 18, color: AppColors.textColor),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Theme.of(context).cardTheme.color,
                        padding: const EdgeInsets.all(16),
                        side: const BorderSide(color: Colors.transparent)),
                    onPressed: () {
                      _authBloc.add(GoogleSigninEvent(false));
                    },
                    child: BlocConsumer<AuthBloc, AuthState>(
                      bloc: _authBloc,
                      listener: (context, state) {
                        if (state is GoogleSigninFailureState) {
                          CustomSnackBar.showError(context, message: state.error);
                        }
                        if (state is GoogleSigninSuccesState) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Wrapper() ,));
                          // CustomSnackBar.show(context,
                          //     message: 'Signed in',
                          //     backgroundColor: Colors.greenAccent);
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreen(),));
                        }
                      },
                      builder: (context, state) {
                        if (state is GoogleSigninLoadingState) {
                          return const Center(
                            child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator()),
                          );
                        } else if (state is GoogleSigninSuccesState) {
                          return Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  LineIcons.googlePlus,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Continue with google',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                )
                              ],
                            ),
                          );
                        }
                        return Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                LineIcons.googlePlus,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Continue with google',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void login() {
    if (_formKey.currentState!.validate()) {
      _authBloc
          .add((LoginEvent(emailController.text, passwordController.text)));
    }
  }


}
