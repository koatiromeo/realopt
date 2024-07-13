import 'package:flutter/material.dart';
import 'responsiveLayout.dart';
import 'package:realopt/utils/route_name.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:realopt/constant/app_colors.dart';

class FeaturesPageScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final navLinks = ["Home", "Features", "Download", "About Us"];

  FeaturesPageScreen({super.key});

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
                  color: Colors.blue,
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
            children: <Widget>[
              Padding(
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
                            child: Text(
                              "R",
                              style: TextStyle(fontSize: 30, color: Colors.white),
                            ),
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
                                    AppColors.mainBlueColor,
                                    AppColors.blueDarkColor
                                  ],
                                  begin: Alignment.bottomRight,
                                  end: Alignment.topLeft,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0, 8),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: Center(
                                  child: Text(
                                    "Get Started",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      letterSpacing: 1,
                                      fontFamily: "Montserrat-Bold",
                                    ),
                                  ),
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
                            _scaffoldKey.currentState?.openEndDrawer();
                          },
                          child: Image.network("lib/assets/menu.png", width: 26, height: 26),
                        ),
                      ),
                  ],
                ),
              ),
              FeaturesBody(),
            ],
          ),
        ),
      ),
    );
  }
}

class FeaturesBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      largeScreen: LargeFeaturesChild(),
      mediumScreen: LargeFeaturesChild(),
      smallScreen: SmallFeaturesChild(),
    );
  }
}

class LargeFeaturesChild extends StatelessWidget {
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'WKAMT_Ki24Y',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "The best way to Maximise",
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat-Regular",
                    color: Color(0xFF8591B0),
                  ),
                ),
                Text(
                  "The Investment return of your real estate investment",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Montserrat-Regular",
                  ),
                ),
                Text(
                  "Directly in your preferred devices (Web, Mobile, Desktop and Extension).",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Montserrat-Regular",
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.downloadPageScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(400, 50),
                  ),
                  child: Text("Download"),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange),
                    Icon(Icons.star, color: Colors.orange),
                    Icon(Icons.star, color: Colors.orange),
                    Icon(Icons.star, color: Colors.orange),
                    Icon(Icons.star_half, color: Colors.orange),
                    SizedBox(width: 10),
                    Text("4.7 of 5", style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Join the growing community of RealOpt users.",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Montserrat-Regular",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
                progressColors: const ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
                onReady: () {
                  _controller.addListener(() {});
                },
              ),
              builder: (context, player) {
                return Column(
                  children: [
                    player,
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SmallFeaturesChild extends StatelessWidget {
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'WKAMT_Ki24Y',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "The best way to Maximise",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              fontFamily: "Montserrat-Regular",
              color: Color(0xFF8591B0),
            ),
          ),
          Text(
            "The Investment return of your real estate investment",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Montserrat-Regular",
            ),
          ),
          Text(
            "Directly in your preferred devices (Web, Mobile, Desktop and Extension).",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Montserrat-Regular",
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Action de téléchargement
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(400, 50),
            ),
            child: Text("Download"),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange),
              Icon(Icons.star, color: Colors.orange),
              Icon(Icons.star, color: Colors.orange),
              Icon(Icons.star, color: Colors.orange),
              Icon(Icons.star_half, color: Colors.orange),
              SizedBox(width: 10),
              Text("4.7 of 5", style: TextStyle(fontSize: 18)),
            ],
          ),
          SizedBox(height: 20),
          YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              progressColors: const ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
              onReady: () {
                _controller.addListener(() {});
              },
            ),
            builder: (context, player) {
              return Column(
                children: [
                  player,
                ],
              );
            },
          ),
          SizedBox(height: 20),
          Text(
            "Join the growing community of RealOpt users.",
            style: TextStyle(
              fontSize: 18,
              fontFamily: "Montserrat-Regular",
            ),
          ),

        ],
      ),
    );
  }
}
