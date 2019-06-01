import 'package:flutter/material.dart';
import 'package:flutter_mentor/blocs/user_profile/user_profile_bloc.dart';

///
/// Fake control that intercepts messages related to authentication failure
///
class AuthenticationFailure extends StatelessWidget {
  AuthenticationFailure({
    Key key,
    @required this.onFailure,
  })  : assert(onFailure != null),
        super(key: key);

  final VoidCallback onFailure;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: userProfileBloc.authenticationHasFailed,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == true){
          userProfileBloc.resetAuthenticationFailureController();
          onFailure();
        }
          
        return Container();
      },
    );
  }
}
