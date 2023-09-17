class SwapUser {
  String userId;
  String fullName;
  String email;
  DateTime timeCreated;

  SwapUser(
      {required this.userId,
      required this.fullName,
      required this.email,
      required this.timeCreated});

  factory SwapUser.fromJson(Map<String, dynamic> responseData) {
    return SwapUser(
      userId: responseData['id'],
      fullName: responseData['fullName'],
      email: responseData['email'],
      timeCreated: responseData['timeCreated'],
    );
  }
}
