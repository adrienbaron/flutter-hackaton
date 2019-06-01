class UserProfile {
  int userId;
  String firstName;
  String lastName;
  String email;
  UserProfileState status;

  UserProfile({
    this.status = UserProfileState.inactive,
    this.userId = -1,
    this.firstName = "",
    this.lastName = "",
    this.email = "",
  });

  factory UserProfile.fromJSON(Map<String, dynamic> json){
    return UserProfile(
      userId: json["userId"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      status: UserProfileState.values[int.parse(json["status"] ?? UserProfileState.inactive)],
    );
  }
}

enum UserProfileState {
  active,
  inactive,
}