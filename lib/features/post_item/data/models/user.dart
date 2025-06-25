class User {
final String userId;
  final String userName;
  final String? userImageUrl;
  User({
    required this.userId,
    required this.userName,
    this.userImageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userName: json['userName'],
      userImageUrl: json['userImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'userImageUrl': userImageUrl,
    };
  }

  @override
  String toString() {
    return 'User(userId: $userId, userName: $userName, userImageUrl: $userImageUrl)';
  } 

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.userId == userId &&
        other.userName == userName &&
        other.userImageUrl == userImageUrl;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userName.hashCode ^
        userImageUrl.hashCode;
  } 
}