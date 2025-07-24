class UserAccount {
  final String fullName;
  final String dateOfBirth;
  final String email;
  final String phone;
  final String password;

  UserAccount({
    required this.fullName,
    required this.dateOfBirth,
    required this.email,
    required this.phone,
    required this.password,
  });

  UserAccount copyWith({
    String? fullName,
    String? dateOfBirth,
    String? email,
    String? phone,
    String? password,
  }) {
    return UserAccount(
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'dateOfBirth': dateOfBirth,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  factory UserAccount.fromMap(Map<String, dynamic> map) {
    return UserAccount(
      fullName: map['fullName'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
    );
  }

  @override
  String toString() {
    return 'UserAccount(fullName: $fullName, dateOfBirth: $dateOfBirth, email: $email, phone: $phone)';
  }
}
