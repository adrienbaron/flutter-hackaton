class UserProfile {
  int profileId;
  String firstName;
  String lastName;
  String email;
  UserProfileState state;

  UserProfile({
    this.state = UserProfileState.inactive,
    this.profileId = -1,
    this.firstName = "",
    this.lastName = "",
    this.email = "",
  });

  factory UserProfile.fromJSON(Map<String, dynamic> json){
    return UserProfile(
      profileId: json["ProfileId"],
      firstName: json["FirstName"],
      lastName: json["LastName"],
      email: json["Email"],
    );
  }
}

enum UserProfileState {
  active,
  inactive,
}