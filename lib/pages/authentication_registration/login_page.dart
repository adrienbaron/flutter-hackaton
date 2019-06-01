import 'package:flutter/material.dart';
import 'package:flutter_mentor/blocs/login_registration/authentication_form_bloc.dart';
import 'package:flutter_mentor/blocs/user_profile/user_profile_bloc.dart';
import 'package:flutter_mentor/config/global_translations.dart';
import 'package:flutter_mentor/mixins/show_snackbar_content.dart';
import 'package:flutter_mentor/widgets/failures/authentication_failure.dart';
import 'package:flutter_mentor/widgets/input/custom_password_textfield.dart';
import 'package:flutter_mentor/widgets/input/custom_textfield.dart';
import 'package:flutter_mentor/widgets/selectors/language_selector.dart';

const EdgeInsets _kPaddingTop = const EdgeInsets.only(top: 80.0);
const double _kSpacingBetweenTextFields = 8.0;
const EdgeInsets _kFormPadding = const EdgeInsets.all(40.0);

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ShowSnackBarContentMixin {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  AuthenticationFormBloc _authenticationFormBloc;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _authenticationFormBloc = AuthenticationFormBloc();
  }

  @override
  void dispose() {
    _authenticationFormBloc?.dispose();
    _emailController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(allTranslations.text("authentication.labels.title")),
          actions: <Widget>[
            LanguageSelector(),
          ],
        ),
        body: SingleChildScrollView(
          padding: _kPaddingTop,
          child: Container(
            padding: _kFormPadding,
            child: Column(
              children: <Widget>[
                // Email
                StreamBuilder<String>(
                  stream: _authenticationFormBloc.email,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return CustomTextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 80,
                      labelText:
                          allTranslations.text("authentication.labels.email"),
                      hintText:
                          allTranslations.text("authentication.hint.email"),
                      errorText: snapshot.error,
                      icon: const Icon(Icons.alternate_email),
                      onChanged: _authenticationFormBloc.onEmailChanged,
                    );
                  },
                ),

                // Spacing
                SizedBox(
                  height: _kSpacingBetweenTextFields,
                ),

                // Password
                StreamBuilder<String>(
                  stream: _authenticationFormBloc.password,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return CustomPasswordTextField(
                      controller: _passwordController,
                      maxLength: 80,
                      labelText: allTranslations
                          .text("authentication.labels.password"),
                      hintText:
                          allTranslations.text("authentication.hint.password"),
                      errorText: snapshot.error,
                      icon: const Icon(Icons.lock_outline),
                      onChanged: _authenticationFormBloc.onPasswordChanged,
                    );
                  },
                ),

                // Spacing
                SizedBox(
                  height: _kSpacingBetweenTextFields,
                ),

                // Submit button
                StreamBuilder<bool>(
                  stream: _authenticationFormBloc.canAuthenticate,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    return RaisedButton(
                      onPressed: (snapshot.hasData && snapshot.data == true)
                          ? _onSubmit
                          : null,
                      child:
                          Text(allTranslations.text("authentication.buttons.submit")),
                    );
                  },
                ),

                // Fake control to evaluate any authentication failure
                AuthenticationFailure(onFailure: () {
                  showErrorMessageInSnackBar(
                    scaffoldKey: _scaffoldKey,
                    errorMessage: "authentication.messages.login_email_failure",
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// User submits his email and password to authenticate
  ///
  void _onSubmit() {
    userProfileBloc.authenticateEmail(
        email: _emailController.text,
        password: _passwordController.text,
        onError: (AuthenticationFailureType authenticationFailureType) {
          if (authenticationFailureType == AuthenticationFailureType.network) {
            showErrorMessageInSnackBar(
              scaffoldKey: _scaffoldKey,
              errorMessage: "connection_failure",
            );
            // Force repaint
            setState((){});
          }
        });
  }
}
