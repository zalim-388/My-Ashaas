import 'package:agent_porta/pages/Profile/profile_page.dart';
import 'package:agent_porta/pages/find%20you%20match/find_you_matchCreation.dart';
import 'package:agent_porta/pages/businessCreation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../styles/constants.dart';
import '../styles/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  final List<String> _items = [
    'assets/images/pc.jpg',
    'assets/images/image2.jpg',
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
  ];

  final List<String> myitems = [
    'assets/images/porta.jpeg',
    'assets/images/offer.jpeg',
    'assets/images/50offer.jpeg',
  ];

  final List<Map<String, String>> historyItems = [
    {'status': 'Declined'},
    {'status': 'Approved'},
    {'status': 'Pending'},
    {'status': 'Approved'},
    {'status': 'Declined'},
  ];

  int myCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar:
          isLandscape
              ? null
              : AppBar(
                scrolledUnderElevation: 0,
                backgroundColor: Colors.white.withOpacity(0.1),
                automaticallyImplyLeading: false,
                centerTitle: false,
                title: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                        image: AssetImage("assets/images/ashaas.png"),
                        height: 40.h,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'My Ashaa\'s',
                        style: GTextStyle.heading2Bold.copyWith(color: black),
                      ),
                    ],
                  ),
                ),
                titleSpacing: 16.w,
                actionsPadding: EdgeInsets.zero,
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                      );
                    },
                    icon: Icon(PhosphorIconsBold.user, size: 23.spMin),
                  ),
                ],
              ),
      body:
          isLandscape
              ? NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: Colors.white.withOpacity(0.1),
                      automaticallyImplyLeading: false,
                      elevation: 2,
                      centerTitle: false,
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            image: AssetImage("assets/images/ashaas.png"),
                            height: 40.h,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'My Ashaa\'s',
                            style: GTextStyle.heading1Bold.copyWith(),
                          ),
                        ],
                      ),

                      titleSpacing: 40.spMin,
                      actionsPadding: EdgeInsets.symmetric(horizontal: 15.w),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(),
                              ),
                            );
                          },
                          icon: Icon(PhosphorIconsBold.user, size: 23.spMin),
                        ),
                      ],
                    ),
                  ];
                },
                body: _mainbody(isLandscape),
              )
              : _mainbody(isLandscape),
    );
  }

  Widget _mainbody(bool isLandscape) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16.h),

            sliderAds(),

            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildActionCard(
                          context: context,
                          imagepath: "assets/images/deal.png",
                          title: "Add Business",
                          subtitle: "Add more business to get more leads",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => businessCreation(),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildActionCard(
                          context: context,
                          imagepath: "assets/images/deal.png",
                          title: "Find your Match",
                          subtitle:
                              "Life is an Adventure When you find the right Partner to explore with",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FindYouMatchcreation(),
                              ),
                            );
                          },
                        ),
                      ),
                      //  "Find the right partner to explore with",
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Activity",
                      style: GTextStyle.heading3.copyWith(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'view all',
                      style: GTextStyle.heading3.copyWith(color: kBlackPrimary),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildStatusColumn(
                    icon: Ionicons.checkmark_done_outline,
                    count: '06',
                    label: 'Approved',
                    iconcolor: Colors.green.shade500,
                    maincolor: Colors.green.shade50,
                  ),

                  buildStatusColumn(
                    icon: Ionicons.hourglass_outline,
                    count: '02',
                    label: 'Pending',
                    iconcolor: Colors.orange.shade500,
                    maincolor: Colors.orange.shade50,
                  ),

                  buildStatusColumn(
                    icon: Ionicons.close,
                    count: '01',
                    label: 'Declined',
                    iconcolor: Colors.red.shade500,
                    maincolor: Colors.red.shade50,
                  ),
                  buildStatusColumn(
                    icon: Ionicons.layers_outline,
                    count: '09',
                    label: 'Total',
                    iconcolor: Colors.blue.shade500,
                    maincolor: Colors.blue.shade50,
                  ),
                ],
              ),
            ),

            if (historyItems.isEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 60, 30, 0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "You haven't added any businesses yet.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0.h),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => businessCreation(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                            ),
                            overlayColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),
                            shadowColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),

                            backgroundColor:
                                WidgetStateProperty.resolveWith<Color>((
                                  states,
                                ) {
                                  if (states.contains(WidgetState.hovered)) {
                                    return kPrimaryColor.withOpacity(0.7);
                                  }
                                  return kPrimaryColor.withOpacity(0.1);
                                }),
                            foregroundColor:
                                WidgetStateProperty.resolveWith<Color>((
                                  states,
                                ) {
                                  if (states.contains(WidgetState.hovered)) {
                                    return Colors.white;
                                  }
                                  return Colors.black;
                                }),
                          ),
                          child: Text(
                            " Add more business",
                            style: GTextStyle.bodyBold.copyWith(
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              ...historyItems.map(
                (item) => buildHistoryItem(item['status'] ?? ""),
              ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget buildHistoryItem(String status) {
    // final isLandscape =
    //     MediaQuery.of(context).orientation == Orientation.landscape;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 20.w),
      child: ListTile(
        title: Text('Business name', style: GTextStyle.bodyMedium.copyWith()),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Department name', style: GTextStyle.bodySmall.copyWith()),
            SizedBox(height: 2.h),
            Text('Location', style: GTextStyle.bodySmall.copyWith()),
            SizedBox(height: 2.h),

            Text('Phone number', style: GTextStyle.bodySmall.copyWith()),
          ],
        ),
        trailing: getStatusIcon(status),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        dense: false,
        contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        tileColor: kContainerBgColor,
      ),
    );
  }

  Widget getStatusIcon(String status) {
    final Map<String, IconData> icons = {
      'Approved': Ionicons.checkmark_done_outline,
      'Pending': Ionicons.hourglass_outline,
      'Declined': Ionicons.close,
    };

    final Map<String, Color> colors = {
      'Approved': Colors.green.shade500,
      'Pending': Colors.orange.shade500,
      'Declined': Colors.red.shade500,
    };

    // final isLandscape =
    //     MediaQuery.of(context).orientation == Orientation.landscape;
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icons[status] ?? Icons.help_outline,
            color: colors[status] ?? Colors.grey,
            size: 22.spMin,
          ),
          SizedBox(height: 1.h),
          Text(status, style: GTextStyle.bodyLight.copyWith()),
        ],
      ),
    );
  }

  //MARK:- slider ads
  Widget sliderAds() {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.w),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.h),
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                height: isLandscape ? 250.h : 160.h,
                autoPlayCurve: Curves.easeInOut,
                autoPlayInterval: const Duration(seconds: 6),
                onPageChanged: (index, reason) {
                  setState(() {
                    myCurrentIndex = index;
                  });
                },
              ),

              items:
                  _items
                      .map((imageUrl) => RoundedImages(imageUrl: imageUrl))
                      .toList(),
            ),
          ),
          if (_items.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: AnimatedSmoothIndicator(
                activeIndex: myCurrentIndex,
                count: _items.length,
                effect: WormEffect(
                  dotHeight: 5.h,
                  dotWidth: 6.w,
                  spacing: 3.w,
                  activeDotColor: kBlackPrimary,
                  dotColor: Colors.grey,
                ),
                onDotClicked: (index) {
                  _carouselController.animateToPage(index);
                },
              ),
            ),
        ],
      ),
    );
  }

  //MARK:- build status column
  Widget buildStatusColumn({
    IconData? icon,
    String? count,
    String? label,
    Color? color,
    Color? maincolor,
    required Color iconcolor,
  }) {
    // final isLandscape =
    //     MediaQuery.of(context).orientation == Orientation.landscape;
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: maincolor ?? Colors.grey.shade100,
          border: Border.all(color: iconcolor.withOpacity(0.2), width: 1.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24.spMin, color: iconcolor),
            SizedBox(height: 4.h),
            Text(
              count ?? "",
              style: GTextStyle.heading2Small.copyWith(),
              maxLines: 1,
            ),
            SizedBox(height: 2.h),
            Text(
              label ?? "",
              style: GTextStyle.bodySmall.copyWith(),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

//MARK:- rounded images
class RoundedImages extends StatelessWidget {
  const RoundedImages({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: MediaQuery.of(context).size.width,
      // margin: EdgeInsets.symmetric(horizontal: 2.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.r),
        //CachedNetworkImage
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
          // placeholder: (context, url) =>
          //     Container(
          //       color: Colors.grey[200],
          //       child: CircularProgressIndicator(
          //         color: kPrimaryColor,
          //         strokeWidth: 2.0.w,
          //       ),
          //     ),
          errorBuilder: (context, url, error) => _buildErrorcImage(),
        ),
      ),
    );
  }
}

Widget _buildErrorcImage() {
  return Container(
    height: 180.h,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.grey[800],
      borderRadius: BorderRadius.circular(8.0.r),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.broken_image_outlined, color: Colors.white, size: 50.sp),
        SizedBox(height: 8.h),
        Text(
          'image_load_failed',
          style: GTextStyle.bodyLight.copyWith(color: white),
        ),
      ],
    ),
  );
}

//MARK:- action card
Widget _buildActionCard({
  required String imagepath,
  required String title,
  required String subtitle,
  required VoidCallback onPressed,
  required BuildContext context,
}) {
  final isLandscape =
      MediaQuery.of(context).orientation == Orientation.landscape;
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: 180.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: isLandscape ? 30.h : 16.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),

        color: kContainerBgColor,
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.1),

            blurRadius: 10.r,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(
            padding: EdgeInsets.all(isLandscape ? 8.w : 12.w),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(
              imagepath,
              fit: BoxFit.contain,
              height: 35.h,
              width: 35.h,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.business);
              },
            ),
          ),
          SizedBox(height: isLandscape ? 5.h : 12.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GTextStyle.heading2Bold.copyWith(),
          ),

          SizedBox(height: 4.h),
          Expanded(
            child: Text(
              textAlign: TextAlign.center,
              subtitle,
              style: GTextStyle.caption.copyWith(color: Colors.grey[600]),
            ),
          ),
          // SizedBox(height: 5.h),
        ],
      ),
    ),
  );
}
