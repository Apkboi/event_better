part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class GoogleSigninLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}
class GoogleSigninSuccesState extends AuthState {
  @override
  List<Object?> get props => [];
}
class GoogleSigninFailureState extends AuthState {
  String error;
  GoogleSigninFailureState({required this.error});

  @override
  List<Object?> get props => [error];

}


class AuthStateChangedState extends AuthState{
  String? uid;
  @override
  List<Object?> get props => [uid];

  AuthStateChangedState(this.uid);
}


class LogoutLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}
class LogoutSuccesState extends AuthState {

  @override
  List<Object?> get props => [];
}
class LogoutFailureState extends AuthState {
  String error;
  LogoutFailureState({required this.error});

  @override
  List<Object?> get props => [error];

}

class RegisterLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}
class RegisterSuccesState extends AuthState {
  @override
  List<Object?> get props => [];
}
class RegisterFailureState extends AuthState {
  String error;
  RegisterFailureState({required this.error});

  @override
  List<Object?> get props => [error];

}

class LoginLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}
class  LoginSuccesState extends AuthState {
  @override
  List<Object?> get props => [];
}
class LoginFailureState extends AuthState {
  String error;
  LoginFailureState({required this.error});

  @override
  List<Object?> get props => [error];

}
