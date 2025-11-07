import 'package:agent_porta/pages/find%20you%20match/find_you_matchCreation.dart';
import 'package:agent_porta/pages/profile_page.dart';
import 'package:agent_porta/pages/businessCreation.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
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
                backgroundColor: Colors.white.withOpacity(0.1),
                automaticallyImplyLeading: false,
                scrolledUnderElevation: 0,
                elevation: 2,
                centerTitle: false,
                title: Row(
                  children: [
                    Image(
                      image: AssetImage('assets/images/portalogoBg.png'),
                      height: isLandscape ? 35.h : 25.h,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Porta',
                      style: GTextStyle.bodyBold.copyWith(
                        fontSize: isLandscape ? 11.sp : 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                titleSpacing: 30.w,
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
                    icon: Icon(PhosphorIconsBold.user, size: 23),
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
                            image: AssetImage('assets/images/portalogoBg.png'),
                            height: isLandscape ? 35.h : 25.h,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'Porta',
                            style: GTextStyle.bodyBold.copyWith(
                              fontSize: isLandscape ? 13.sp : 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),

                      titleSpacing: isLandscape ? 40 : 30.w,
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
                          icon: Icon(PhosphorIconsBold.user, size: 23),
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
              padding: EdgeInsets.symmetric(horizontal: 23.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),

                  Row(
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
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _buildActionCard(
                          context: context,
                          imagepath: "assets/images/deal.png",
                          title: "Find you Match",
                          subtitle:
                              "Life is an Adventure When you the find right \n Partner to explore with",
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
            // SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Activity",
                        textAlign: TextAlign.start,
                        style: GTextStyle.bodyBold.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: isLandscape ? 8.sp : 16.0.sp,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                        ),
                        child: Text(
                          'view all',
                          style: GTextStyle.bodyBold.copyWith(
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor,
                            fontSize: isLandscape ? 8.sp : 16.0.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 18.w,
                vertical: isLandscape ? 6.h : 8.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildStatusColumn(
                    icon: Ionicons.checkmark_done_outline,
                    count: '06',
                    label: 'Approved',
                    iconcolor: Colors.green.shade500,
                  ),

                  buildStatusColumn(
                    icon: Ionicons.hourglass_outline,
                    count: '02',
                    label: 'Pending',
                    iconcolor: Colors.orange.shade500,
                  ),

                  buildStatusColumn(
                    icon: Ionicons.close,
                    count: '01',
                    label: 'Declined',
                    iconcolor: Colors.red.shade500,
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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isLandscape ? 8 : 5.h,
        horizontal: 20.w,
      ),
      child: ListTile(
        title: Text(
          'Business name',
          style: GTextStyle.bodyBold.copyWith(
            fontSize: isLandscape ? 8.sp : 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Department name',
              style: GTextStyle.bodyBold.copyWith(
                fontSize: isLandscape ? 8.sp : 13.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              'Location',
              style: GTextStyle.bodyBold.copyWith(
                fontSize: isLandscape ? 8.sp : 13.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              'Phone number',
              style: GTextStyle.bodyBold.copyWith(
                fontSize: isLandscape ? 8.sp : 13.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        trailing: getStatusIcon(status),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        dense: true,
        contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        tileColor: Colors.grey.shade100,
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

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icons[status] ?? Icons.help_outline,
            color: colors[status] ?? Colors.grey,
            size: 20,
          ),
          SizedBox(height: 2.h),
          Text(
            status,
            style: GTextStyle.bodyLight.copyWith(
              fontSize: isLandscape ? 8.sp : 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget sliderAds() {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isLandscape ? 80 : 23.w),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.h),
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                height: isLandscape ? 250.h : 180.h,
                autoPlayCurve: Curves.easeInOut,
                // autoPlayAnimationDuration: const Duration(milliseconds: 00),
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
              padding: const EdgeInsets.only(top: 10),
              child: AnimatedSmoothIndicator(
                activeIndex: myCurrentIndex,
                count: _items.length,
                effect: WormEffect(
                  dotHeight: isLandscape ? 4.h : 5.h,
                  dotWidth: isLandscape ? 3.w : 6.w,
                  spacing: 3.w,
                  activeDotColor: kPrimaryColor,
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

  Widget buildStatusColumn({
    IconData? icon,
    String? count,
    String? label,
    Color? color,
    Color? maincolor,
    required Color iconcolor,
  }) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: maincolor ?? Colors.grey.shade100,
          border: Border.all(color: iconcolor.withOpacity(0.2), width: 1.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: iconcolor),
            Text(
              count ?? "",
              style: GTextStyle.bodyBold.copyWith(
                fontSize: isLandscape ? 12.sp : 5.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              label ?? "",
              style: GTextStyle.label.copyWith(
                fontSize: isLandscape ? 8.sp : 10.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
      padding: EdgeInsets.symmetric(
        horizontal: isLandscape ? 25.w : 16.w,
        vertical: isLandscape ? 25.h : 16.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        // color: kBackgroundColor
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.1),

            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(isLandscape ? 8.w : 12.w),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(
              imagepath,
              fit: BoxFit.cover,
              height: isLandscape ? 35.h : 35.h,
              width: isLandscape ? 35.h : 35.h,
            ),
          ),
          SizedBox(height: isLandscape ? 8.h : 12.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GTextStyle.bodyBold.copyWith(
              fontSize: isLandscape ? 12.sp : 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 4.h),
          Text(
            textAlign: TextAlign.center,
            subtitle,
            maxLines: 2,
            style: GTextStyle.bodyBold.copyWith(
              fontSize: isLandscape ? 8.sp : 12.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
          ),
          SizedBox(height: 5.h),
        ],
      ),
    ),
  );
}
