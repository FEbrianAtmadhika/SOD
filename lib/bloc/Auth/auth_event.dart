part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthGetCurrent extends AuthEvent {
  final BuildContext context;
  const AuthGetCurrent(this.context);

  @override
  List<Object> get props => [context];
}

// class AuthRegister extends AuthEvent {
//   final SignUpFormModel data;
//   const AuthRegister(this.data);

//   @override
//   List<Object> get props => [data];
// }

class AuthLogin extends AuthEvent {
  final LoginModel data;
  const AuthLogin(this.data);

  @override
  List<Object> get props => [data];
}

class AuthLogout extends AuthEvent {
  final AuthModel data;
  const AuthLogout(this.data);

  @override
  List<Object> get props => [data];
}

class AuthAddAddress extends AuthEvent {
  final AuthModel user;
  final AddAddressModel data;

  const AuthAddAddress(this.user, this.data);

  @override
  List<Object> get props => [user, data];
}

class AuthEditAddress extends AuthEvent {
  final AuthModel user;
  final EditAddressModel data;
  final SubDistrictModel data2;

  const AuthEditAddress(this.user, this.data, this.data2);

  @override
  List<Object> get props => [user, data, data2];
}
