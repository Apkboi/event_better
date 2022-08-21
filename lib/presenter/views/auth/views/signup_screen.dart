import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:line_icons/line_icons.dart';
import 'package:square_tickets/presenter/views/auth/views/login_screen.dart';
import '../../../../helpers/app_utils.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/outlined_form_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthBloc _authBloc = AuthBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: BlocListener<AuthBloc, AuthState>(
            bloc: _authBloc,
            listener: (context, state) {
              if(state is RegisterLoadingState){
                AppUtils.showAnimatedProgressDialog(context);
              }else if (state is RegisterSuccesState){
                Navigator.pop(context);
                log('Success');
              }else if (state is RegisterFailureState){
                Navigator.pop(context);
                CustomSnackBar.showError(context, message: state.error);
                log('Failed');
              }
            },
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
                    'Sign up',
                    style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Enter you credential to sign up \nwith square tickets and start  your\njourney of events ✈️ ✈️',
                    style: TextStyle(color: AppColors.textColor, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    ' Name',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedFormField(
                    inputType: TextInputType.name,
                    hint: 'Mr square checkout',
                    controller: nameController,
                    validator: RequiredValidator(errorText: 'Enter your name'),
                    preffix: const Icon(
                      LineIcons.userAlt,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
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
                    hint: 'squarecheckout@gmail.com',
                    controller: emailController,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Enter your name'),
                      EmailValidator(errorText: 'Invalid Email')
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
                    maxLine: 1,
                    controller: passwordController,
                    hint: '*********%%',
                    validator: RequiredValidator(errorText: 'Enter your name'),
                    suffix: const Icon(LineIcons.eyeSlash),
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
                        'Sign up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                       signup();
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
                      _authBloc.add(GoogleSigninEvent(true));
                    },
                    child: BlocConsumer<AuthBloc, AuthState>(
                      bloc: _authBloc,
                      listener: (context, state) {
                        if (state is GoogleSigninFailureState) {
                          CustomSnackBar.showError(context,
                              message: state.error);
                        }
                        if (state is GoogleSigninSuccesState) {
                          // CustomSnackBar.show(context, message: 'Signed in',backgroundColor: Colors.greenAccent);
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
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen() ,));
                    },
                    child: Text(
                      'Already have an account ? Login',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signup(){
    if(_formKey.currentState!.validate()){
      _authBloc.add(RegisterUserEvent(nameController.text,
          emailController.text, passwordController.text));
    }
  }
}
