import 'package:agent_porta/pages/request_money.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:flutter/material.dart';
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

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Wallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'qs',
      ),
      home: CryptoWalletScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
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
      appBar: PreferredSize(preferredSize: Size.fromHeight(1), child: AppBar(backgroundColor: Colors.black,)),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        kPrimaryColor,
                        kPrimaryColor.withOpacity(.8)
                      ])
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -50,
                    right: -30,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: -40,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -90,
                    right: 20,
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.06),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(25,25,25,40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(UIcons.solidRounded.angle_left,size: 15, color: Colors.white),
                              onPressed: () { Navigator.pop(context); },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.white12)
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white12,
                                backgroundImage: AssetImage('assets/images/me.jpg'),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 60),

                        // Overall Balance
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Balance Amount',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '\₹1,614',
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '.00',
                                    style: TextStyle(
                                      fontSize: 30,
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

            SizedBox(height: 30),

            // Buy and Sell Buttons
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                        RequestMoneyDialog.show(context);
                        },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(PhosphorIconsRegular.handArrowDown, color: Colors.white, size: 18),
                          SizedBox(width: 10),
                          Text(
                            'Request Money',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
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
            SizedBox(height: 30),

            // Transactions Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent History',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'See all ',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[500],
                        ),
                      ),
                      Icon(Icons.chevron_right,size: 17,)
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Transaction Items using ListView.builder
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
      padding: EdgeInsets.fromLTRB(0,16,16,16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 17,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${amount}\$',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}