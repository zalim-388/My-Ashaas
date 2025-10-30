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
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  final List<String> _items = [
    'assets/images/porta.jpeg',
    'assets/images/offer.jpeg',
    'assets/images/50offer.jpeg',
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
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor1,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        elevation: 1,
        centerTitle: false,
        title: Row(
          children: [
            Image(
              image: AssetImage('assets/images/portalogoBg.png'),
              height: 25.h,
            ),
            SizedBox(width: 10.w),
            Text(
              'Porta',
              style: GTextStyle.bodyBold.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        titleSpacing: 30,
        actionsPadding: EdgeInsets.symmetric(horizontal: 15),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            icon: Icon(PhosphorIconsBold.user, size: 23),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),

              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child:
                    _items.isEmpty
                        ? _buildErrorcImage()
                        : CarouselSlider(
                          carouselController: _carouselController,
                          options: CarouselOptions(
                            height: 180.h,
                            aspectRatio: 16 / 9,
                            scrollDirection: Axis.horizontal,
                            reverse: false,
                            autoPlay: true,
                            enableInfiniteScroll: _items.length > 1,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration: const Duration(
                              milliseconds: 800,
                            ),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                          ),

                          items:
                              _items
                                  .map(
                                    (image) => ClipRect(
                                      child: Image.asset(
                                        image,
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return _buildErrorcImage();
                                        },
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
              ),
              if (_items.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: AnimatedSmoothIndicator(
                    activeIndex: _currentIndex,
                    count: _items.length,
                    effect: WormEffect(
                      dotHeight: 6.h,
                      dotWidth: 6.w,
                      spacing: 4.w,
                      activeDotColor: kPrimaryColor,
                      dotColor: Colors.grey,
                    ),
                    onDotClicked: (index) {
                      _carouselController.animateToPage(index);
                    },
                  ),
                ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: [
                      Expanded(
                        child: _buildActionCard(
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
                          imagepath: "assets/images/deal.png",
                          title: "Find you Match",
                          subtitle:
                              "Life is an Adventure When you the find right \n Partner to explore with",
                          onPressed: () {},
                        ),
                      ),
                      //  "Find the right partner to explore with",
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Activity",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child: Text(
                        'view all',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildStatusColumn(
                      icon: Ionicons.checkmark_done_outline,
                      count: '06',
                      label: 'Approved',
                      iconcolor: Colors.green.shade500,
                    ),
                    //verticalDivider(),
                    buildStatusColumn(
                      icon: Ionicons.hourglass_outline,
                      count: '02',
                      label: 'Pending',
                      iconcolor: Colors.orange.shade500,
                    ),
                    //verticalDivider(),
                    buildStatusColumn(
                      icon: Ionicons.close,
                      count: '01',
                      label: 'Declined',
                      iconcolor: Colors.red.shade500,
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              //   child: Text('Recent',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,),textAlign: TextAlign.start),
              // ),
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
                          padding: EdgeInsets.symmetric(vertical: 20.0),
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
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              overlayColor: MaterialStateProperty.all(
                                Colors.transparent,
                              ), // optional
                              shadowColor: MaterialStateProperty.all(
                                Colors.transparent,
                              ),

                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>((
                                    states,
                                  ) {
                                    if (states.contains(
                                      MaterialState.hovered,
                                    )) {
                                      return kPrimaryColor.withOpacity(
                                        0.7,
                                      ); // Background when pressed
                                    }
                                    return kPrimaryColor.withOpacity(
                                      0.1,
                                    ); // Normal background
                                  }),
                              foregroundColor:
                                  MaterialStateProperty.resolveWith<Color>((
                                    states,
                                  ) {
                                    if (states.contains(
                                      MaterialState.hovered,
                                    )) {
                                      return Colors
                                          .white; // Text color when pressed
                                    }
                                    return Colors.black; // Normal text color
                                  }),
                            ),
                            child: Text(
                              " Add more business",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...historyItems
                    .map((item) => buildHistoryItem(item['status']!))
                    .toList(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHistoryItem(String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: ListTile(
        title: Text(
          'Business name',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Department name',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            Text(
              'Location',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            Text(
              'Phone number',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        trailing: getStatusIcon(status),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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

    return Column(
      children: [
        Icon(
          icons[status] ?? Icons.help_outline,
          color: colors[status] ?? Colors.grey,
          size: 17,
        ),
        Text(
          status,
          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget sliderAds() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                height: 180,
                autoPlayCurve: Curves.easeInOut,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayInterval: const Duration(seconds: 6),
                onPageChanged: (index, reason) {
                  setState(() {
                    myCurrentIndex = index;
                  });
                },
              ),
              items:
                  myitems
                      .map((imageUrl) => RoundedImages(imageUrl: imageUrl))
                      .toList(),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          child: AnimatedSmoothIndicator(
            activeIndex: myCurrentIndex,
            count: myitems.length,
            effect: JumpingDotEffect(
              dotHeight: 3,
              dotWidth: 12,
              spacing: 7,
              dotColor: Color(0xFFD5D5D5),
              activeDotColor: kPrimaryColor,
              paintStyle: PaintingStyle.fill,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildStatusColumn({
    IconData? icon,
    String? count,
    String? label,
    Color? color,
    Color? maincolor,
    Color? iconcolor,
  }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: maincolor ?? Colors.grey.shade100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 15, color: iconcolor ?? Colors.black45),
            Text(
              count!,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: color ?? Colors.black87!,
              ),
            ),
            Text(
              label!,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w400,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget verticalDivider() {
    return Container(
      height: 40, // adjust based on your layout
      width: .5,
      color: Colors.grey.shade300,
      margin: EdgeInsets.symmetric(horizontal: 8),
    );
  }
}

class RoundedImages extends StatelessWidget {
  const RoundedImages({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Image.asset(imageUrl, fit: BoxFit.cover),
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
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: kBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.1),

            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imagepath, fit: BoxFit.cover, height: 40.h, width: 40.w),
          SizedBox(height: 12.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GTextStyle.bodyBold.copyWith(fontSize: 16.sp),
          ),

          SizedBox(height: 4.h),
          Text(
            textAlign: TextAlign.center,
            subtitle,
            style: GTextStyle.bodyBold.copyWith(
              fontSize: 12.sp,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 5.h),
        ],
      ),
    ),
  );
}
