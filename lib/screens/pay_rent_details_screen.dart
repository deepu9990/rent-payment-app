import 'package:flutter/material.dart';

import '../components/custom_app_bar.dart';
import '../components/custom_button.dart';
import '../services/app_data_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class PayRentDetailsScreen extends StatefulWidget {
  const PayRentDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PayRentDetailsScreen> createState() => _PayRentDetailsScreenState();
}

class _PayRentDetailsScreenState extends State<PayRentDetailsScreen> {
  bool _isLoading = false;
  final AppDataService _dataService = AppDataService();

  void _editDetails() {
    Navigator.pop(context);
  }

  void _proceedToPayment() {
    setState(() {
      _isLoading = true;
    });

    final userAccount = _dataService.getUserAccount();
    final landlordInfo = _dataService.getLandlordInfo();
    final rentData = _dataService.getRentPaymentData();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.successColor,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Payment Successful!',
                    style: AppTextStyles.heading.copyWith(
                      color: AppColors.successColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Hello ${userAccount?.fullName.split(' ').first ?? 'User'}! Your rent payment of ${_dataService.formattedRentAmount} has been processed successfully.',
                    style: AppTextStyles.caption,
                    textAlign: TextAlign.center,
                  ),
                  if (landlordInfo != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      'Payment sent to ${landlordInfo.name}',
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
              actions: [
                CustomButton(
                  text: 'Done',
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final rentData = _dataService.getRentPaymentData();
    final landlordInfo = _dataService.getLandlordInfo();
    final userAccount = _dataService.getUserAccount();

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: CustomAppBar(
          title: 'Pay Your Rent',
          onBackPressed: () {
            Navigator.pop(context);
          },
          actions: [
            if (userAccount != null)
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Text(
                    'Hi, ${userAccount.fullName.split(' ').first}!',
                    style: const TextStyle(
                      fontFamily: 'Helvetica Neue',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
              ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ejari upload is optional. Users must ensure legal compliance.',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address Summary',
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(rentData!.address, style: AppTextStyles.body),
                    const SizedBox(height: 8),
                    Text(
                      'Rent Amount: ${_dataService.formattedRentAmount}',
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(13),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Landlord Name', style: AppTextStyles.caption),
                        GestureDetector(
                          onTap: _editDetails,
                          child: const Icon(
                            Icons.edit,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      landlordInfo?.name.isNotEmpty == true
                          ? landlordInfo!.name
                          : 'Mr. Giuseppe Marrafa',
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text('IBAN', style: AppTextStyles.caption),
                    const SizedBox(height: 8),
                    Text(
                      landlordInfo?.iban.isNotEmpty == true
                          ? landlordInfo!.iban
                          : '558468908-99-67579',
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text('Bank Name', style: AppTextStyles.caption),
                    const SizedBox(height: 8),
                    Text(
                      landlordInfo?.bankName.isNotEmpty == true
                          ? landlordInfo!.bankName
                          : 'Default Bank',
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text('Email', style: AppTextStyles.caption),
                    const SizedBox(height: 8),
                    Text(
                      landlordInfo?.email.isNotEmpty == true
                          ? landlordInfo!.email
                          : 'lowercase@gmail.com',
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text('Phone', style: AppTextStyles.caption),
                    const SizedBox(height: 8),
                    Text(
                      landlordInfo?.phone.isNotEmpty == true
                          ? landlordInfo!.phone
                          : '+971-566662969',
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              Center(
                child: CustomButton(
                  text: 'Continue',
                  onPressed: _proceedToPayment,
                  isLoading: _isLoading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
