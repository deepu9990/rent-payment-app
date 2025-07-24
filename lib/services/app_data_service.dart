import '../models/landlord_info.dart';
import '../models/rent_payment_data.dart';
import '../models/user_account.dart';

class AppDataService {
  static final AppDataService _instance = AppDataService._internal();
  factory AppDataService() => _instance;
  AppDataService._internal();

  UserAccount? _userAccount;
  LandlordInfo? _landlordInfo;
  RentPaymentData? _rentPaymentData;

  void setUserAccount(UserAccount userAccount) {
    _userAccount = userAccount;
  }

  UserAccount? getUserAccount() {
    return _userAccount;
  }

  void clearUserAccount() {
    _userAccount = null;
  }

  void setLandlordInfo(LandlordInfo landlordInfo) {
    _landlordInfo = landlordInfo;
  }

  LandlordInfo? getLandlordInfo() {
    return _landlordInfo;
  }

  void clearLandlordInfo() {
    _landlordInfo = null;
  }

  void setRentPaymentData(RentPaymentData rentPaymentData) {
    _rentPaymentData = rentPaymentData;
  }

  RentPaymentData? getRentPaymentData() {
    return _rentPaymentData ??
        RentPaymentData(
          address: '3208, 32, Sulafa tower, Dubai Marina, Dubai, UAE',
          rentAmount: 1200.0,
          dueDate: DateTime.now().add(const Duration(days: 30)),
          propertyId: 'PROP001',
        );
  }

  void clearRentPaymentData() {
    _rentPaymentData = null;
  }

  void clearAllData() {
    _userAccount = null;
    _landlordInfo = null;
    _rentPaymentData = null;
  }

  bool get isUserLoggedIn => _userAccount != null;

  String get userDisplayName {
    if (_userAccount != null) {
      return _userAccount!.fullName.split(' ').first;
    }
    return 'User';
  }

  String get formattedRentAmount {
    final rentData = getRentPaymentData();
    return '\$${rentData!.rentAmount.toStringAsFixed(2)}';
  }

  bool get isLandlordInfoComplete {
    return _landlordInfo != null &&
        _landlordInfo!.name.isNotEmpty &&
        _landlordInfo!.bankName.isNotEmpty;
  }

  Map<String, dynamic> getSummary() {
    return {
      'hasUserAccount': _userAccount != null,
      'hasLandlordInfo': _landlordInfo != null,
      'hasRentPaymentData': _rentPaymentData != null,
      'userDisplayName': userDisplayName,
      'formattedRentAmount': formattedRentAmount,
      'isLandlordInfoComplete': isLandlordInfoComplete,
    };
  }
}
