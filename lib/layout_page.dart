import 'pages/add_customer_page.dart';
import 'styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';


class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    AddCustomerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black, // Background color of bottom bar
          splashColor: Colors.transparent, // Remove click splash effect
          highlightColor: Colors.transparent, // Remove highlight effect
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.black,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: GTextStyle.bodyBold.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.bold, // Bold for selected label
            color: kPrimaryColor,
          ),
          unselectedLabelStyle: GTextStyle.bodyBold.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.normal, // Regular for unselected label
            color: Colors.grey,
          ),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              activeIcon: Icon(Icons.add_business),
              label: 'Add Business',
            ),
          ],
        ),
      ),
    );
  }
}
