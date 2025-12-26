import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_ashaas/pages/Profile/request_money.dart';
import 'package:my_ashaas/styles/style.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uicons/uicons.dart';
import 'package:my_ashaas/styles/constants.dart';

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

  CryptoWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(backgroundColor: kprimaryGreen),
      ),
      body: SafeArea(
        child: CustomScrollView(
          // physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Picture
                  Container(
                    decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //   colors: [
                      //     kprimaryGreen,
                      //     kPrimaryColor.withOpacity(.1),
                      //   ],
                      // ),
                    color: kprimaryGreen,
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
                              color: white.withOpacity(0.10),
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
                              color: white.withOpacity(0.08),
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
                              color: white.withOpacity(0.09),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.fromLTRB(10.w, 10.h, 25.w, 40.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      UIcons.solidRounded.angle_left,
                                      size: 18.spMin,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                            Colors.white12,
                                          ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: CircleAvatar(
                                      radius: 20.r,
                                      backgroundColor: white,
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
                                    style: GTextStyle.heading2Medium.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 8.w),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '\₹1,614',
                                          style: GTextStyle.heading1Bold
                                              .copyWith(color: Colors.white),
                                        ),
                                        TextSpan(
                                          text: '.00',
                                          style: GTextStyle.body.copyWith(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
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
                              backgroundColor: kprimaryGreen,
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
                                  size: 18.spMin,
                                ),
                                SizedBox(width: 10.w),
                                Flexible(
                                  child: Text(
                                    'Request Money',
                                    style: GTextStyle.bodyBold.copyWith(
                                      color: Colors.white,
                                    ),
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
                          style: GTextStyle.bodyBold.copyWith(),
                        ),
                        Row(
                          children: [
                            Text(
                              'See all ',
                              textAlign: TextAlign.justify,
                              style: GTextStyle.bodyMedium.copyWith(
                                color: Colors.grey[500],
                              ),
                            ),
                            Icon(Icons.chevron_right, size: 20.spMin),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final transaction = transactions[index];
                  return TransactionItem(
                    icon: transaction.icon,
                    iconColor: transaction.iconColor,
                    title: transaction.title,
                    subtitle: transaction.subtitle,
                    amount: transaction.amount,
                    amountColor: transaction.amountColor,
                  );
                }, childCount: transactions.length),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 20.h)),
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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        children: [
          Container(
            width: isLandscape ? 30.w : 40.w,
            height: isLandscape ? 30.h : 40.h,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: iconColor, size: 17.spMin),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GTextStyle.bodySmall.copyWith()),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GTextStyle.bodySmall.copyWith(color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          Text(
            '${amount}\$',
            style: GTextStyle.bodyBold.copyWith(color: amountColor),
          ),
        ],
      ),
    );
  }
}
