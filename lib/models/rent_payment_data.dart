class RentPaymentData {
  final String address;
  final double rentAmount;
  final DateTime dueDate;
  final String propertyId;

  RentPaymentData({
    required this.address,
    required this.rentAmount,
    required this.dueDate,
    required this.propertyId,
  });

  RentPaymentData copyWith({
    String? address,
    double? rentAmount,
    DateTime? dueDate,
    String? propertyId,
  }) {
    return RentPaymentData(
      address: address ?? this.address,
      rentAmount: rentAmount ?? this.rentAmount,
      dueDate: dueDate ?? this.dueDate,
      propertyId: propertyId ?? this.propertyId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'rentAmount': rentAmount,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'propertyId': propertyId,
    };
  }

  factory RentPaymentData.fromMap(Map<String, dynamic> map) {
    return RentPaymentData(
      address: map['address'] ?? '',
      rentAmount: map['rentAmount']?.toDouble() ?? 0.0,
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate']),
      propertyId: map['propertyId'] ?? '',
    );
  }

  @override
  String toString() {
    return 'RentPaymentData(address: $address, rentAmount: $rentAmount, dueDate: $dueDate, propertyId: $propertyId)';
  }
}
