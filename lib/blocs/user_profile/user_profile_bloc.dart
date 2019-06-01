import 'dart:async';

import 'package:flutter_mentor/blocs/helpers/bloc_provider.dart';
import 'package:flutter_mentor/config/preferences.dart';
import 'package:flutter_mentor/models/user_profile.dart';
import 'package:rxdart/rxdart.dart';

///
/// This BLoC is responsible for all activities
/// related to the user:
///    * handshaking
///    * authentication
///    * registration
///    * profile
///
typedef OnAuthenticationErrorCallback = Function(AuthenticationFailureType);
typedef OnRegistrationErrorCallback = Function(RegistrationFailureType);
typedef OnProfileSaveErrorCallback = Function(ProfileSaveFailureType);

class UserProfileBloc implements BlocBase {
  UserProfile _userProfile;

  BehaviorSubject<UserProfile> _userProfileController = BehaviorSubject<UserProfile>();
  Stream<UserProfile> get userProfile => _userProfileController;

  //
  // Authentication/Registration failure
  //
  PublishSubject<bool> _authenticationFailureController =
      PublishSubject<bool>();
  Stream<bool> get authenticationHasFailed => _authenticationFailureController;
  void _setAuthenticationFailure() {
    _authenticationFailureController.sink.add(true);
  }

  void resetAuthenticationFailureController() {
    _authenticationFailureController.sink.add(false);
  }

  //
  // Provides the current states of the initialization / user authentication
  //
  BehaviorSubject<UserProfileState> _userProfileStateController =
      BehaviorSubject<UserProfileState>.seeded(UserProfileState.inactive);
  Stream<UserProfileState> get userProfileState => _userProfileStateController;
  void _setUserProfileState(UserProfileState status) {
    _userProfile.status = status;
    _userProfileStateController.sink.add(status);
  }

  //
  // User Profile status
  //
  UserProfileState get status => _userProfile.status;

  //
  // Current User Profile
  //
  UserProfile get currentProfile => _userProfile;

  @override
  void dispose() {
    _userProfileController?.close();
    _userProfileStateController?.close();
    _authenticationFailureController?.close();
  }

  ///
  /// User wants to log out
  ///
  void logout() async {
    UserProfileState status = UserProfileState.inactive;
    _userProfile = UserProfile(
      status: status,
    );

    //
    // We need to remember the disconnection
    //
    await preferences.setDisconnected(true);

    //
    // Finally reset the UserProfileState
    //
    _setUserProfileState(status);
  }

  /// -------------------------------------------------------------------------
  ///  User Registration
  /// -------------------------------------------------------------------------
  Future<void> register(
    Map data, {
    OnRegistrationErrorCallback onError,
  }) async {
    //TODO
  }


  /// --------------------------------------------------------------------------
  ///  Authenticate via email
  /// --------------------------------------------------------------------------
  void authenticateEmail({
    String email,
    String password,
    OnAuthenticationErrorCallback onError,
  }) {
    //TODO
  }
  
  /// --------------------------------------------------------------------------
  /// Singleton Factory
  /// --------------------------------------------------------------------------
  static final UserProfileBloc _userProfileBloc = UserProfileBloc._internal();
  factory UserProfileBloc() {
    return _userProfileBloc;
  }
  UserProfileBloc._internal();

  ///
  /// One-time initialization
  ///
  Future<Null> init() async {
    if (_userProfile == null) {
      _userProfile = UserProfile();
    }
    return null;
  }
}

UserProfileBloc userProfileBloc = UserProfileBloc();



enum AuthenticationFailureType {
  network,
  authentication,
}

enum RegistrationFailureType {
  network,
  alias_used,
  email_used,
}

enum ProfileSaveFailureType {
  network,
  alias_used,
  email_used,
}
