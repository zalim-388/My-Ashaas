import 'package:agent_porta/pages/Profile/request_money.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uicons/uicons.dart';

// Transaction Model
class Transaction {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String amount;
  final Color amountColor;

  Transaction({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.amountColor,
  });
}

class CryptoWalletScreen extends StatelessWidget {
  // Dummy transaction data
  final List<Transaction> transactions = [
    Transaction(
      icon: PhosphorIconsRegular.arrowUpRight,
      iconColor: Colors.red.shade300,
      title: 'Apple TV',
      subtitle: '11:20, Monday',
      amount: '-80.00',
      amountColor: Color(0xffbf4c4c),
    ),
    Transaction(
      icon: PhosphorIconsRegular.arrowDownRight,
      iconColor: Colors.green,
      title: 'James McArthur',
      subtitle: '09:54, Saturday',
      amount: '+150.00',
      amountColor: Colors.green,
    ),
    Transaction(
      icon: PhosphorIconsRegular.arrowUpRight,
      iconColor: Colors.red.shade300,
      title: 'Netflix Subscription',
      subtitle: '10:30, Friday',
      amount: '-15.99',
      amountColor: Color(0xffbf4c4c),
    ),
    Transaction(
      icon: PhosphorIconsRegular.arrowDownRight,
      iconColor: Colors.green,
      title: 'Sarah Johnson',
      subtitle: '08:15, Thursday',
      amount: '+75.50',
      amountColor: Colors.green,
    ),
    Transaction(
      icon: PhosphorIconsRegular.arrowUpRight,
      iconColor: Colors.red.shade300,
      title: 'Amazon Purchase',
      subtitle: '14:22, Wednesday',
      amount: '-45.99',
      amountColor: Color(0xffbf4c4c),
    ),
    Transaction(
      icon: PhosphorIconsRegular.arrowDownRight,
      iconColor: Colors.green,
      title: 'Michael Brown',
      subtitle: '16:45, Tuesday',
      amount: '+200.00',
      amountColor: Colors.green,
    ),
    Transaction(
      icon: PhosphorIconsRegular.arrowUpRight,
      iconColor: Colors.red.shade300,
      title: 'Spotify Premium',
      subtitle: '09:10, Tuesday',
      amount: '-9.99',
      amountColor: Color(0xffbf4c4c),
    ),
    Transaction(
      icon: PhosphorIconsRegular.arrowDownRight,
      iconColor: Colors.green,
      title: 'Emily Davis',
      subtitle: '12:30, Monday',
      amount: '+120.25',
      amountColor: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: AppBar(backgroundColor: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kPrimaryColor, kPrimaryColor.withOpacity(.8)],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -50.h,
                    right: -30.w,
                    child: Container(
                      width: 150.w,
                      height: 150.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80.h,
                    left: -40.w,
                    child: Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -90.h,
                    right: 20.w,
                    child: Container(
                      width: 160.w,
                      height: 160.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.06),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(10.w, 10.h, 25.w, 40.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                UIcons.solidRounded.angle_left,
                                size: 15.sp,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.white12,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: CircleAvatar(
                                radius: 20.r,
                                backgroundColor: Colors.white12,
                                backgroundImage: AssetImage(
                                  'assets/images/man.png',
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 60.h),

                        // Overall Balance
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Balance Amount',
                              style: GTextStyle.bodyLight.copyWith(
                                fontSize: 17,
                                color: Colors.white38,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8.w),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '\₹1,614',
                                    style: GTextStyle.heading1Medium.copyWith(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '.00',
                                    style: GTextStyle.bodyLight.copyWith(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25.h),

            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: () {
                        RequestMoneyDialog.show(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            PhosphorIconsRegular.handArrowDown,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'Request Money',
                            style: GTextStyle.bodyBold.copyWith(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.h),

            // Transactions Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent History',
                    style: GTextStyle.heading1Medium.copyWith(fontSize: 15.sp),
                  ),
                  Row(
                    children: [
                      Text(
                        'See all ',
                        textAlign: TextAlign.justify,
                        style: GTextStyle.bodyMedium.copyWith(
                          fontSize: 14.sp,
                          color: Colors.grey[500],
                        ),
                      ),
                      Icon(Icons.chevron_right, size: 20.sp),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return TransactionItem(
                    icon: transaction.icon,
                    iconColor: transaction.iconColor,
                    title: transaction.title,
                    subtitle: transaction.subtitle,
                    amount: transaction.amount,
                    amountColor: transaction.amountColor,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String amount;
  final Color amountColor;

  const TransactionItem({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.amountColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: iconColor, size: 17.sp),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GTextStyle.bodySmall.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          Text(
            '${amount}\$',
            style: GTextStyle.bodyBold.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}
