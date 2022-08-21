import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:square_tickets/presenter/views/auth/views/signup_screen.dart';
import '../../../../di/injector.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../home/views/home_screen.dart';
import 'login_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateChangedState) {}
      },
      bloc: injector.get<AuthBloc>(),
      buildWhen: (prevState, currentState) {
        return currentState is AuthStateChangedState;
      },
      builder: (context, state) {
        if (state is AuthStateChangedState) {
          if (state.uid == null) {
            return const SignupScreen();
          } else {
            return const HomeScreen();
          }
        }
        return Container(
          color: Colors.redAccent,
        );
      },
    );
  }
}
