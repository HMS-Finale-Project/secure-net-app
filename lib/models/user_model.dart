// models/user_model.dart

class User {
  String username;
  String accountSid;
  String authToken;
  String fromNumber;
  String toNumber;

  User({
    required this.username,
    required this.accountSid,
    required this.authToken,
    required this.fromNumber,
    required this.toNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      accountSid: json['account_sid'],
      authToken: json['auth_token'],
      fromNumber: json['from_number'],
      toNumber: json['to_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'account_sid': accountSid,
      'auth_token': authToken,
      'from_number': fromNumber,
      'to_number': toNumber,
    };
  }
}
