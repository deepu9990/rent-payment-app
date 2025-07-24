class LandlordInfo {
  final String name;
  final String iban;
  final String bankName;
  final String email;
  final String phone;

  LandlordInfo({
    required this.name,
    required this.iban,
    required this.bankName,
    required this.email,
    required this.phone,
  });

  LandlordInfo copyWith({
    String? name,
    String? iban,
    String? bankName,
    String? email,
    String? phone,
  }) {
    return LandlordInfo(
      name: name ?? this.name,
      iban: iban ?? this.iban,
      bankName: bankName ?? this.bankName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'iban': iban,
      'bankName': bankName,
      'email': email,
      'phone': phone,
    };
  }

  factory LandlordInfo.fromMap(Map<String, dynamic> map) {
    return LandlordInfo(
      name: map['name'] ?? '',
      iban: map['iban'] ?? '',
      bankName: map['bankName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  @override
  String toString() {
    return 'LandlordInfo(name: $name, iban: $iban, bankName: $bankName, email: $email, phone: $phone)';
  }
}
