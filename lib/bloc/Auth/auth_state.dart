part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailed extends AuthState {
  final String e;

  const AuthFailed(this.e);

  @override
  List<Object> get props => [e];
}

class AuthSuccess extends AuthState {
  final AuthModel data;
  const AuthSuccess(this.data);
}

class AuthFailedAutoLogin extends AuthState {
  final String e;
  const AuthFailedAutoLogin(this.e);

  @override
  List<Object> get props => [e];
}
