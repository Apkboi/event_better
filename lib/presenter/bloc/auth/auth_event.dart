part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class GoogleSigninEvent extends AuthEvent {
  bool register;

  GoogleSigninEvent(this.register);

  @override
  List<Object?> get props => [register];
}

class AuthStateChangedEvent extends AuthEvent {
  String? uid;

  @override
  List<Object?> get props => [uid];

  AuthStateChangedEvent(this.uid);
}

class LogoutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];

  LogoutEvent();
}

class LoginEvent extends AuthEvent {
  String email, password;

  LoginEvent(this.email, this.password);

  @override
  List<Object?> get props => throw UnimplementedError();
}
class RegisterUserEvent extends AuthEvent{
 final  String name,email,password;

 const RegisterUserEvent(this.name, this.email, this.password);

  @override
  List<Object?> get props => [email,name,password];

}
