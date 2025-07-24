import 'package:flutter/material.dart';

import '../components/custom_app_bar.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../models/landlord_info.dart';
import '../services/app_data_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'pay_rent_details_screen.dart';

class PayRentScreen extends StatefulWidget {
  const PayRentScreen({Key? key}) : super(key: key);

  @override
  State<PayRentScreen> createState() => _PayRentScreenState();
}

class _PayRentScreenState extends State<PayRentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bankNameController = TextEditingController();
  final _landlordNameController = TextEditingController();
  final _landlordIbanController = TextEditingController();
  final _landlordEmailController = TextEditingController();
  final _landlordPhoneController = TextEditingController();

  bool _isLoading = false;
  final AppDataService _dataService = AppDataService();

  String? _validateDubaiMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    String cleanNumber = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    RegExp dubaiMobileRegex = RegExp(r'^(\+971|971|0)?[5][0-9]{8}$');

    if (!dubaiMobileRegex.hasMatch(cleanNumber)) {
      return 'Please enter a valid Dubai mobile number (05X XXX XXXX)';
    }

    return null;
  }

  String? _validateIban(String? value) {
    if (value == null || value.isEmpty) {
      return 'IBAN is required';
    }

    String cleanIban = value.replaceAll(' ', '').toUpperCase();

    if (!RegExp(r'^[A-Z0-9]+$').hasMatch(cleanIban)) {
      return 'IBAN should contain only numbers and letters';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    _loadExistingData();
  }

  void _loadExistingData() {
    final landlordInfo = _dataService.getLandlordInfo();
    if (landlordInfo != null) {
      _landlordNameController.text = landlordInfo.name;
      _landlordIbanController.text = landlordInfo.iban;
      _bankNameController.text = landlordInfo.bankName;
      _landlordEmailController.text = landlordInfo.email;
      _landlordPhoneController.text = landlordInfo.phone;
    }
  }

  @override
  void dispose() {
    _bankNameController.dispose();
    _landlordNameController.dispose();
    _landlordIbanController.dispose();
    _landlordEmailController.dispose();
    _landlordPhoneController.dispose();
    super.dispose();
  }

  void _proceedToDetails() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final landlordInfo = LandlordInfo(
        name: _landlordNameController.text.trim(),
        iban: _landlordIbanController.text.trim(),
        bankName: _bankNameController.text.trim(),
        email: _landlordEmailController.text.trim(),
        phone: _landlordPhoneController.text.trim(),
      );

      _dataService.setLandlordInfo(landlordInfo);

      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PayRentDetailsScreen()),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(title: 'Pay Your Rent'),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                    Text(
                      '3208, 32, Sulafa tower, Dubai Marina, Dubai, UAE',
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              CustomTextField(
                label: 'Landlord\'s Name',
                controller: _landlordNameController,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Landlord\'s IBAN',
                controller: _landlordIbanController,
                isRequired: true,
                keyboardType: TextInputType.text,
                validator: _validateIban,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Bank Name',
                isRequired: true,
                controller: _bankNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bank name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Landlord\'s Email',
                controller: _landlordEmailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'Landlord\'s Phone',
                controller: _landlordPhoneController,
                keyboardType: TextInputType.phone,
                isRequired: true,
                validator: _validateDubaiMobile,
              ),
              const SizedBox(height: 40),

              CustomButton(
                text: 'Done',
                onPressed: _proceedToDetails,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
