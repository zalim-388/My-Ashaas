import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uicons/uicons.dart';
import 'package:agent_porta/styles/constants.dart';

class BankDetailsPage extends StatelessWidget {
  const BankDetailsPage({super.key});

  // Sample bank details - replace with actual data
  final String accountNumber = "1234567890123456";
  final String ifscCode = "SBIN0001234";
  final String userName = "John Doe";
  final String branchCode = "001234";

  void _copyToClipboard(BuildContext context, String text, String fieldName) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$fieldName copied to clipboard'),
        backgroundColor: kPrimaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kPrimaryColor, kPrimaryColor.withOpacity(.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            centerTitle: true,
            title: const Text(
              'Bank Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: IconButton(
              icon: Icon(UIcons.solidRounded.angle_left, size: 15, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card with bank icon
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kPrimaryColor, kPrimaryColor.withOpacity(.6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                //borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(
                    PhosphorIconsLight.bank,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Your Bank Information',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Secure banking details',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Bank details fields
            _buildDetailField(
              context: context,
              icon: PhosphorIconsLight.user,
              title: 'Account Holder Name',
              value: userName,
              fieldName: 'Account Holder Name',
            ),

            const SizedBox(height: 20),

            _buildDetailField(
              context: context,
              icon: PhosphorIconsLight.creditCard,
              title: 'Account Number',
              value: accountNumber,
              fieldName: 'Account Number',
              isSensitive: true,
            ),

            const SizedBox(height: 20),

            _buildDetailField(
              context: context,
              icon: PhosphorIconsLight.bank,
              title: 'IFSC Code',
              value: ifscCode,
              fieldName: 'IFSC Code',
            ),

            const SizedBox(height: 20),

            _buildDetailField(
              context: context,
              icon: PhosphorIconsLight.mapPin,
              title: 'Branch Code',
              value: branchCode,
              fieldName: 'Branch Code',
            ),

            const SizedBox(height: 32),

            // Note section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.fromLTRB(20,0,20,20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    PhosphorIconsLight.info,
                    size: 20,
                    color: kPrimaryColor,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Keep your bank details secure and do not share them with unauthorized persons. Tap on any field to copy the information.',
                      style: TextStyle(
                        fontSize: 12,
                        color: kPrimaryColor,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailField({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
    required String fieldName,
    bool isSensitive = false,
  }) {
    return GestureDetector(
      onTap: () => _copyToClipboard(context, value, fieldName),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          //border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 20,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isSensitive ? _maskAccountNumber(value) : value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              PhosphorIconsLight.copy,
              size: 18,
              color: Colors.grey.shade500,
            ),
          ],
        ),
      ),
    );
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    String masked = '*' * (accountNumber.length - 4);
    return masked + accountNumber.substring(accountNumber.length - 4);
  }
}