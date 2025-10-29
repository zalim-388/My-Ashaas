import 'package:agent_porta/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:uicons/uicons.dart';

class AgentDetails extends StatelessWidget {
  final String? image;
  const AgentDetails({super.key,  this.image});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    // Responsive dimensions
    final double headerHeight = screenHeight * 0.20; // 16% of screen height
    final double profileImageSize = screenWidth * 0.35; // 28% of screen width
    final double profileImageTop =
        headerHeight - (profileImageSize * 0.5); // Overlap calculation
    final double profileImageLeft =
        (screenWidth - profileImageSize) / 2; // Center horizontally
    final double contentTopPadding =
        profileImageSize * 0.6; // Space for overlapping image

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(UIcons.solidRounded.angle_left,size: 15, color: Colors.white),
          onPressed: () { Navigator.pop(context); },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: headerHeight,
                width: screenWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [kPrimaryColor, kPrimaryColor.withOpacity(.65)],
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  width: screenWidth,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: contentTopPadding),
                        Text(
                          'Murshid kk',
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          child: Text(
                            'murshidkk2002@gmail.com',
                            style: TextStyle(
                              fontSize:
                                  screenWidth * 0.035, // Responsive font size
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        // Menu items
                        Column(
                          children: [
                            _buildMenuItem(
                              context: context,
                              icon: UIcons.regularRounded.mobile_button,
                              heading: 'Mobile number',
                              data: '9544957003',
                            ),
                            _buildMenuItem(
                              context: context,
                              icon: UIcons.regularRounded.address_book,
                              heading: 'Address',
                              data:
                                'Kattukulath house , kelamkulam , chettiyamKinar , malappuram , kerala , india  \nPOST : klari  \nPIN : 676501',
                            ),
                            _buildMenuItem(
                              context: context,
                              icon: UIcons.regularRounded.credit_card,
                              heading: 'Pan card',
                              data: 'HSDFB5325J',
                            ),
                            _buildMenuItem(
                              context: context,
                              icon: Ionicons.id_card_outline,
                              heading: 'Aadhar card',
                              data: '123456789012',
                            ),
                            SizedBox(
                              height: screenHeight * 0.05,
                            ), // Bottom padding
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Positioned profile image to overlap both sections
          Positioned(
            top: profileImageTop,
            left: profileImageLeft,
            child: Container(
              width: profileImageSize,
              height: profileImageSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: screenWidth * 0.01, // Responsive border width
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: screenWidth * 0.025, // Responsive blur
                    offset: Offset(
                      0,
                      screenHeight * 0.006,
                    ), // Responsive offset
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  image!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.person,
                        size: profileImageSize * 0.4, // Responsive icon size
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                height: MediaQuery.of(context).padding.top,
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String heading,
    String? data,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01,
        horizontal: screenHeight * 0.03,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: screenHeight * 0.005, // Fixed padding for all items
        ),
        leading: Icon(
          icon,
          color: kPrimaryColor,
          size: screenWidth * 0.06, // Responsive icon size
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: TextStyle(
                fontSize: screenWidth * 0.035, // Responsive font size
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
            if (data != null && data.isNotEmpty)
              Text(
                data,
                style: TextStyle(
                  fontSize:
                      screenWidth * 0.035, // Responsive subtitle font size
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
        onTap: () {
          // Handle menu item tap
          _handleMenuItemTap(context, heading);
        },
      ),
    );
  }

  void _handleMenuItemTap(BuildContext context, String title) {
    // Handle different menu actions
    switch (title) {
      case 'View 4 Active Transaction':
        // Navigate to transactions screen
        break;
      case 'Edit Profile':
        // Navigate to edit profile screen
        break;
      case 'Discount Voucher':
        // Navigate to discount voucher screen
        break;
      case 'Support':
        // Navigate to support screen
        break;
      case 'Settings':
        // Navigate to settings screen
        break;
      case 'Log Out':
        // Show logout confirmation dialog
        _showLogoutDialog(context);
        break;
    }
  }

  void _showLogoutDialog(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Log Out',
            style: TextStyle(fontSize: screenWidth * 0.045),
          ),
          content: Text(
            'Are you sure you want to log out?',
            style: TextStyle(fontSize: screenWidth * 0.04),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Perform logout action
              },
              child: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Responsive App Widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SF Pro Display', // iOS-like font
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AgentDetails(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Ensure responsive scaling
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: MediaQuery.of(
              context,
            ).textScaleFactor.clamp(0.8, 1.2),
          ),
          child: child!,
        );
      },
    );
  }
}

void main() {
  runApp(const MyApp());
}
