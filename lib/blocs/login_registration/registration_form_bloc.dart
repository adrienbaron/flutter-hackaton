import 'dart:async';

import 'package:flutter_mentor/blocs/helpers/bloc_provider.dart';
import 'package:flutter_mentor/config/global_translations.dart';
import 'package:flutter_mentor/mixins/validators.dart';
import 'package:rxdart/rxdart.dart';

class RegistrationFormBloc extends Object with EmailValidator, PasswordValidator, NotEmptyValidator, IsCheckedValidator, AliasValidator  implements BlocBase {
  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();
  final BehaviorSubject<String> _firstNameController = BehaviorSubject<String>();
  final BehaviorSubject<String> _lastNameController = BehaviorSubject<String>();
  final BehaviorSubject<String> _aliasController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordConfirmController = BehaviorSubject<String>();
  final BehaviorSubject<bool> _termsConditionsController = BehaviorSubject<bool>();

  //
  //  Inputs
  //
  Function(String) get onEmailChanged => _emailController.sink.add;
  Function(String) get onPasswordChanged => _passwordController.sink.add;
  Function(String) get onFirstNameChanged => _firstNameController.sink.add;
  Function(String) get onLastNameChanged => _lastNameController.sink.add;
  Function(String) get onAliasChanged => _aliasController.sink.add;
  Function(String) get onRetypePasswordChanged => _passwordConfirmController.sink.add;
  Function(bool) get onTermsConditionsChanged => _termsConditionsController.sink.add;

  //
  // Validators
  //
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);
  Stream<String> get firstName => _firstNameController.stream.transform(validateNotEmpty);
  Stream<String> get lastName => _lastNameController.stream.transform(validateNotEmpty);
  Stream<String> get alias => _aliasController.stream.transform(validateAlias);
  Stream<bool> get termsConditions => _termsConditionsController.stream.transform(validateChecked);
  Stream<String> get confirmPassword => _passwordConfirmController.stream.transform(validatePassword)
    .doOnData((String c){
      // If the password is accepted (after validation of the rules)
      // we need to ensure both password and retyped password match
      if (0 != _passwordController.value.compareTo(c)){
        // If they do not match, add an error
        _passwordConfirmController.addError(allTranslations.text("validators.invalid.retype_password"));
      }
    });

  //
  // Registration button
  //
  Stream<bool> get canRegisterPassword => Observable.combineLatest7(
                                      email, 
                                      password,
                                      confirmPassword,
                                      firstName,
                                      lastName,
                                      alias,
                                      termsConditions, 
                                      (e, p, cp, f, l, a, t) => t
                                    );

  Stream<bool> get canRegisterNoPassword => Observable.combineLatest5(
                                      email, 
                                      firstName,
                                      lastName,
                                      alias,
                                      termsConditions, 
                                      (e, f, l, a, t) => t
                                    );

  @override
  void dispose() {
    _emailController?.close();
    _passwordController?.close();
    _firstNameController?.close();
    _lastNameController?.close();
    _aliasController?.close();
    _passwordConfirmController?.close();
    _termsConditionsController?.close();
  }
}