import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentor/blocs/login_registration/registration_form_bloc.dart';
import 'package:flutter_mentor/blocs/user_profile/user_profile_bloc.dart';
import 'package:flutter_mentor/config/global_translations.dart';
import 'package:flutter_mentor/mixins/show_snackbar_content.dart';
import 'package:flutter_mentor/widgets/input/custom_password_textfield.dart';
import 'package:flutter_mentor/widgets/input/custom_textfield.dart';
import 'package:flutter_mentor/widgets/selectors/language_selector.dart';

const EdgeInsets _kPaddingScreen =
    const EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 16.0);

class RegisterPage extends StatefulWidget {
  RegisterPage({
    Key key,
  }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with ShowSnackBarContentMixin {
  _UserData userData;
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _aliasController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _retypePasswordController;
  RegistrationFormBloc _registrationFormBloc;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _firstNameController = new TextEditingController();
    _lastNameController = new TextEditingController();
    _aliasController = new TextEditingController();
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
    _retypePasswordController = new TextEditingController();

    _registrationFormBloc = RegistrationFormBloc();

    _initDataFromInput();
  }

  @override
  void dispose() {
    _firstNameController?.dispose();
    _lastNameController?.dispose();
    _aliasController?.dispose();
    _emailController?.dispose();
    _passwordController?.dispose();
    _retypePasswordController?.dispose();
    _registrationFormBloc?.dispose();

    super.dispose();
  }

  ///
  /// If we are registering based on a Social Network,
  /// let's pre-fill some already available data
  ///
  _initDataFromInput() {
    userData = _UserData();
  }

  Widget _conditionalPassword() {
    Widget verticalSpacing = SizedBox(height: 8.0);

    return Column(
      children: <Widget>[
        //
        // Password
        //
        verticalSpacing,
        Divider(),
        StreamBuilder<String>(
          stream: _registrationFormBloc.password,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return CustomPasswordTextField(
              controller: _passwordController,
              maxLength: 80,
              labelText: allTranslations.text("register.labels.password"),
              hintText: allTranslations.text("register.hint.password"),
              errorText: snapshot.error,
              icon: const Icon(Icons.lock_outline),
              onChanged: _registrationFormBloc.onPasswordChanged,
            );
          },
        ),

        //
        // Confirm Password
        //
        verticalSpacing,
        StreamBuilder<String>(
          stream: _registrationFormBloc.confirmPassword,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return CustomPasswordTextField(
              controller: _retypePasswordController,
              maxLength: 80,
              labelText:
                  allTranslations.text("register.labels.retype_password"),
              hintText: allTranslations.text("register.hint.retype_password"),
              errorText: snapshot.error,
//                      icon: const Icon(Icons.lock_outline),
              onChanged: _registrationFormBloc.onRetypePasswordChanged,
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget verticalSpacing = SizedBox(height: 8.0);

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(allTranslations.text("register.labels.title")),
          actions: <Widget>[
            LanguageSelector(),
          ],
        ),
        body: SingleChildScrollView(
          padding: _kPaddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //
              // Introduction text
              //
              Text(
                allTranslations.text("register.labels.enter_your_data"),
                textAlign: TextAlign.center,
              ),

              //
              // First Name
              //
              verticalSpacing,
              StreamBuilder<String>(
                stream: _registrationFormBloc.firstName,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return CustomTextField(
                    controller: _firstNameController,
                    keyboardType: TextInputType.text,
                    maxLength: 80,
                    labelText:
                        allTranslations.text("register.labels.firstName"),
                    hintText: allTranslations.text("register.hint.firstName"),
                    errorText: snapshot.error,
//                      icon: const Icon(Icons.alternate_email),
                    onChanged: _registrationFormBloc.onFirstNameChanged,
                  );
                },
              ),

              //
              // Last Name
              //
              verticalSpacing,
              StreamBuilder<String>(
                stream: _registrationFormBloc.lastName,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return CustomTextField(
                    controller: _lastNameController,
                    keyboardType: TextInputType.text,
                    maxLength: 80,
                    labelText: allTranslations.text("register.labels.lastName"),
                    hintText: allTranslations.text("register.hint.lastName"),
                    errorText: snapshot.error,
//                      icon: const Icon(Icons.alternate_email),
                    onChanged: _registrationFormBloc.onLastNameChanged,
                  );
                },
              ),

              //
              // Alias
              //
              verticalSpacing,
              StreamBuilder<String>(
                stream: _registrationFormBloc.alias,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return CustomTextField(
                    controller: _aliasController,
                    keyboardType: TextInputType.text,
                    maxLength: 20,
                    labelText: allTranslations.text("register.labels.alias"),
                    hintText: allTranslations.text("register.hint.alias"),
                    errorText: snapshot.error,
//                      icon: const Icon(Icons.alternate_email),
                    onChanged: _registrationFormBloc.onAliasChanged,
                  );
                },
              ),

              //
              // Email
              //
              verticalSpacing,
              StreamBuilder<String>(
                stream: _registrationFormBloc.email,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return CustomTextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 80,
                    labelText: allTranslations.text("register.labels.email"),
                    hintText: allTranslations.text("register.hint.email"),
                    errorText: snapshot.error,
                    icon: const Icon(Icons.alternate_email),
                    onChanged: _registrationFormBloc.onEmailChanged,
                  );
                },
              ),

              //
              // Password and Retype Password
              // [If we are not authenticating via Social Network]
              //
              _conditionalPassword(),

              //
              // Terms and Conditions
              //
              verticalSpacing,
              Divider(),
              StreamBuilder<bool>(
                  stream: _registrationFormBloc.termsConditions,
                  initialData: userData.termsAndConditions,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    return CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                      onChanged: _registrationFormBloc.onTermsConditionsChanged,
                      value: snapshot.data,
                      title: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new Text(
                                allTranslations.text('register.labels.terms')),
                          ),
                          new IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/conditions');
                            },
                            color: Theme.of(context).primaryColor,
                            icon: const Icon(Icons.visibility),
                          ),
                        ],
                      ),
                    );
                  }),

              //
              // Submit button
              //
              verticalSpacing,
              StreamBuilder<bool>(
                stream: _registrationFormBloc.canRegisterPassword,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  return RaisedButton(
                    onPressed: (snapshot.hasData && snapshot.data == true)
                        ? _onSubmit
                        : null,
                    child:
                        Text(allTranslations.text("register.buttons.submit")),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  ///
  /// The user wants to register
  ///
  _onSubmit() async {
    
    // Collect the data
    var data = {
      "FirstName": _firstNameController.text.trim(),
      "LastName": _lastNameController.text.trim(),
      "Alias": _aliasController.text.trim(),
      "Email": _emailController.text.trim(),
      "Password": _passwordController.text.trim(),
    };

    ///
    /// Try to register the user
    ///
    userProfileBloc.register(
      data,
      onError: (RegistrationFailureType registrationFailureType) {
        String errorMessage;

        switch(registrationFailureType){
          case RegistrationFailureType.network:
            errorMessage = "connection_failure";
            break;
          case RegistrationFailureType.alias_used:
            errorMessage = "error_alias_used";
            break;
          case RegistrationFailureType.email_used:
            errorMessage = "error_email_used";
            break;
        }

        showErrorMessageInSnackBar(
          scaffoldKey: _scaffoldKey,
          errorMessage: errorMessage,
        );
        // Force repaint
        setState((){});
      });
  }

}

class _UserData {
  String alias = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  bool termsAndConditions = false;
}
