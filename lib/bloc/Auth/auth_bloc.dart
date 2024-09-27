import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sod_new/models/authmodel.dart';
import 'package:sod_new/models/loginmodel.dart';
import 'package:sod_new/services/authservice.dart';
import 'package:sod_new/services/securestorageservices.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthGetCurrent) {
        try {
          emit(AuthLoading());

          final LoginModel res =
              await SecureStorageServices().getCredentialFromLocal();

          AuthModel user = await AuthService().login(res);

          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthInitial());
        }
      }

      if (event is AuthLogin) {
        try {
          print('Auth login');

          emit(AuthLoading());

          AuthModel res = await AuthService().login(event.data);

          emit(AuthSuccess(res));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthLogout) {
        try {
          emit(AuthLoading());
          await AuthService().logout();
          emit(AuthInitial());
        } catch (e) {
          emit(AuthFailed(
              e.toString())); // Emit AuthFailed to handle the error state
          emit(AuthSuccess(
              event.data)); // Re-emit the last known successful state
        }
      }
    });
  }
}