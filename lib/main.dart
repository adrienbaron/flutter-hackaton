import 'package:flutter/material.dart';
import 'package:flutter_mentor/application.dart';
import 'package:flutter_mentor/blocs/user_profile/user_profile_bloc.dart';

void main() async {
  
  ///
  /// Initialization of the UserProfileBloc
  ///
  await userProfileBloc.init();

  runApp(Application());
}