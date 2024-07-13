import 'package:flutter/material.dart';
import 'package:realopt/constant/app_colors.dart';
import 'responsiveLayout.dart';
import 'search.dart';
import 'package:realopt/utils/route_name.dart';

class LandingPageScreen extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final navLinks = ["Home", "Features", "Download", "About Us"];


  LandingPageScreen({super.key});

  List<Widget> navItem(BuildContext context) {
    return navLinks.map((text) {
      return Padding(
        padding: EdgeInsets.only(left: 18),
        child: InkWell(
          onTap: () {
            switch (text) {
              case "Home":
                Navigator.pushNamed(context, RoutesName.landingPageScreen);
                break;
              case "Features":
                Navigator.pushNamed(context, RoutesName.featuresPageScreen);
                break;
              case "Download":
                Navigator.pushNamed(context, RoutesName.downloadPageScreen);
                break;
              case "About Us":
                Navigator.pushNamed(context, RoutesName.aboutUsPageScreen);
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
    final  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFF8FBFF),
            Color(0xFFFCFDFD),
          ])),
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
                  Navigator.pushNamed(context, RoutesName.landingPageScreen);
                },
              ),
              ListTile(
                leading: Icon(Icons.featured_play_list),
                title: Text('Features'),
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.featuresPageScreen);
                },
              ),
              ListTile(
                leading: Icon(Icons.download),
                title: Text('Download'),
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.downloadPageScreen);
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About Us'),
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.aboutUsPageScreen);
                },
              ),
              ListTile(
                leading: Icon(Icons.start),
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
            children: <Widget>[Padding(
              padding: EdgeInsets.symmetric(horizontal: 45, vertical: 38),
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
                            gradient: LinearGradient(colors: [
                              AppColors.mainBlueColor,
                              AppColors.blueDarkColor
                            ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
                        child: Center(
                          child: Text("R",
                              style: TextStyle(fontSize: 30, color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text("RealOpt", style: TextStyle(fontSize: 26))
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
                                    begin: Alignment.bottomRight, end: Alignment.topLeft),
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
              Body()
            ],
          ),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      largeScreen: LargeChild(),
      mediumScreen: LargeChild(),
      smallScreen: SmallChild(),
    );
  }
}

class LargeChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.centerRight,
            widthFactor: .6,
            child: Image.network("lib/assets/image_01.png", scale: .85),
          ),
          FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: .6,
            child: Padding(
              padding: EdgeInsets.only(left: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("I love RealOpt!",
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat-Regular",
                          color: Color(0xFF8591B0))),
                  RichText(
                    text: TextSpan(
                        text: "It has made my investment \n",
                        style:
                        TextStyle(fontSize: 50, color: Color(0xFF8591B0)),
                        children: [
                          TextSpan(
                              text: "decisions so much easier",
                              style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87))
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 20),
                    child: Text("LET’S EXPLORE THE WORLD OF REAL ESTATE INVESTMENT"),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Search(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SmallChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "I love RealOpt!",
              style: TextStyle(
                  fontSize: 40,
                  color: Color(0xFF8591B0),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat-Regular"),
            ),
            RichText(
              text: TextSpan(
                text: 'It has made my investment decisions ',
                style: TextStyle(fontSize: 40, color: Color(0xFF8591B0)),
                children: <TextSpan>[
                  TextSpan(
                      text: 'so much easier',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.black87)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 20),
              child: Text("LET’S EXPLORE THE WORLD OF REAL ESTATE INVESTMENT"),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Image.network(
                "lib/assets/image_01.png",
                scale: 1,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Search(),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
