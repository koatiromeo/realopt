import 'package:flutter/material.dart';
import 'package:realopt/constants/colors.dart';
import 'package:realopt/components/landing/responsive_layout.dart';
import 'package:realopt/utils/route_name.dart';

class DownloadScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final navLinks = ["Home", "Features", "Download", "About Us"];

  DownloadScreen({super.key});

  List<Widget> navItem(BuildContext context) {
    return navLinks.map((text) {
      return Padding(
        padding: EdgeInsets.only(left: 18),
        child: InkWell(
          onTap: () {
            switch (text) {
              case "Home":
                Navigator.pushNamed(context, RoutesName.landingScreen);
                break;
              case "Features":
                Navigator.pushNamed(context, RoutesName.featuresScreen);
                break;
              case "Download":
                Navigator.pushNamed(context, RoutesName.downloadScreen);
                break;
              case "About Us":
                Navigator.pushNamed(context, RoutesName.aboutUsScreen);
                break;
            }
          },
          child: Text(text, style: TextStyle(fontFamily: "Montserrat-Bold")),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFFF8FBFF),
          Color(0xFFFCFDFD),
        ]),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.blueDarkColor,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.landingScreen);
                },
              ),
              ListTile(
                leading: Icon(Icons.featured_play_list),
                title: Text('Features'),
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.featuresScreen);
                },
              ),
              ListTile(
                leading: Icon(Icons.download),
                title: Text('Download'),
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.downloadScreen);
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About Us'),
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.aboutUsScreen);
                },
              ),
              ListTile(
                leading: Icon(Icons.get_app),
                title: Text('Get Started'),
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.startedScreen);
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            gradient: LinearGradient(
                              colors: [
                                AppColors.mainBlueColor,
                                AppColors.blueDarkColor
                              ],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                            ),
                          ),
                          child: Center(
                            child: Text("R",
                                style: TextStyle(fontSize: 30, color: Colors.white)),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text("RealOpt", style: TextStyle(fontSize: 26)),
                      ],
                    ),
                    if (!ResponsiveLayout.isSmallScreen(context))
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ...navItem(context),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RoutesName.startedScreen);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 20),
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.blueDarkColor,
                                        AppColors.mainBlueColor],
                                      begin: Alignment.bottomRight,
                                      end: Alignment.topLeft),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xFF6078ea).withOpacity(.3),
                                        offset: Offset(0, 8),
                                        blurRadius: 8)
                                  ]),
                              child: Material(
                                color: Colors.transparent,
                                child: Center(
                                  child: Text("Get Started",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          letterSpacing: 1,
                                          fontFamily: "Montserrat-Bold")),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      Builder(
                        builder: (context) => InkWell(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                          child: Image.network("lib/assets/menu.png", width: 26, height: 26),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.2),
              DownloadBody(),
            ],
          ),
        ),
      ),
    );
  }
}

class DownloadBody extends StatefulWidget {
  @override
  _DownloadBodyState createState() => _DownloadBodyState();
}

class _DownloadBodyState extends State<DownloadBody> {
  String selectedPlatform = 'macOS';

  final List<Map<String, String>> platforms = [
    {'name': 'macOS', 'icon': 'lib/assets/mac.png'},
    {'name': 'Linux', 'icon': 'lib/assets/linux.png'},
    {'name': 'Windows', 'icon': 'lib/assets/windows.png'},
    {'name': 'Android', 'icon': 'lib/assets/android.png'},
    {'name': 'iOS', 'icon': 'lib/assets/ios.png'},
    {'name': 'WebExtension', 'icon': 'lib/assets/webextension.png'},
  ];

  void _showPlatformModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: platforms.map((platform) {
            return ListTile(
              leading: Image.network(platform['icon']!, width: 40),
              title: Text(platform['name']!),
              onTap: () {
                setState(() {
                  selectedPlatform = platform['name']!;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      largeScreen: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Download RealOpt',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: platforms.map((platform) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedPlatform = platform['name']!;
                  });
                },
                child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: selectedPlatform == platform['name']
                          ? [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 0,
                          spreadRadius: 0,
                          offset: Offset(0, 1),
                        )
                      ]
                          : [],
                    ),
                    child: Column(
                      children: [
                        Image.network(platform['icon']!, width: 60),
                        SizedBox(height: 8),
                        Text(platform['name']!),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: Size(400, 50),
              ),
            onPressed: () {
              // Open download link based on the selected platform
            },
            child: Text('Download for $selectedPlatform'),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              'Our application is available on all platforms, including WebExtension for Google Chrome, Firefox, and Edge. \n There\'s no reason not to take advantage of our platform to maximize your investments and ease your decision-making in the real estate domain.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 27),
            ),
          ),
        ],
      ),
      smallScreen: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Download RealOpt',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Select Your Plateform',
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              _showPlatformModal(context);
            },
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(platforms.firstWhere((platform) => platform['name'] == selectedPlatform)['icon']!, width: 60),
                  ],
                ),
                SizedBox(height: 8),
                Text(selectedPlatform),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(400, 50),
            ),
            onPressed: () {
              // Open download link based on the selected platform
            },
            child: Text('Download for $selectedPlatform'),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Our application is available on all platforms, including WebExtension for Google Chrome, Firefox, and Edge.\n There\'s no reason not to take advantage of our platform to maximize your investments and ease your decision-making in the real estate domain.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 27),
            ),
          ),
        ],
      ),
      mediumScreen: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Download RealOpt',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: platforms.map((platform) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedPlatform = platform['name']!;
                  });
                },
                child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: selectedPlatform == platform['name']
                          ? [
                        BoxShadow(
                          color: Colors.white24,
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(0, 5),
                        )
                      ]
                          : [],
                    ),
                    child: Column(
                      children: [
                        Image.network(platform['icon']!, width: 60),
                        SizedBox(height: 8),
                        Text(platform['name']!),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(400, 50),
            ),
            onPressed: () {
              // Open download link based on the selected platform
            },
            child: Text('Download for $selectedPlatform'),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              'Our application is available on all platforms, including WebExtension for Google Chrome, Firefox, and Edge. \n There\'s no reason not to take advantage of our platform to maximize your investments and ease your decision-making in the real estate domain.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 27),
            ),
          ),
        ],
      ),
    );
  }
}
