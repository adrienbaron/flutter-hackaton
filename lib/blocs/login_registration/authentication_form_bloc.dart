import 'dart:async';

import 'package:flutter_mentor/blocs/helpers/bloc_provider.dart';
import 'package:flutter_mentor/mixins/validators.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationFormBloc extends Object with EmailValidator, PasswordValidator implements BlocBase {

  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();

  //
  //  Inputs
  //
  Function(String) get onEmailChanged => _emailController.sink.add;
  Function(String) get onPasswordChanged => _passwordController.sink.add;

  //
  // Validators
  //
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);

  //
  // Authentication button
  //
  Stream<bool> get canAuthenticate => Observable.combineLatest2(
                                      email, 
                                      password, 
                                      (e, p) => true
                                    );

  @override
  void dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}