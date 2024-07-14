import 'package:flutter/material.dart';
import 'package:realopt/constants/colors.dart';
import 'package:realopt/components/landing/responsive_layout.dart';
import 'package:realopt/utils/route_name.dart';

class AboutUsScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final navLinks = ["Home", "Features", "Download", "About Us"];

  AboutUsScreen({super.key});

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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Discover RealOpt: Revolutionizing Real Estate Investment",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36, // Augmentation de la taille de police
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat-Bold",
                color: AppColors.blueDarkColor,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Image.network("lib/assets/about_us_image.png", width: 400), // Limite la taille de l'image
            ),
            SizedBox(height: 20),
            Container(
              constraints: BoxConstraints(maxWidth: 800), // Limite la largeur du texte
              child: Text(
                "RealOpt is a cutting-edge platform designed to empower real estate investors and brokers with advanced tools and insights. Through our comprehensive suite of modules, users can maximize the profitability of their real estate investments and streamline their decision-making processes. Here’s an in-depth look at the six main modules of RealOpt.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, height: 1.5), // Augmentation de la taille de police
              ),
            ),
            SizedBox(height: 20),
            _buildModuleSection(
              context,
              "Real Estate Investment Recommendation System",
              "This module provides personalized investment recommendations based on the user’s preferences and profile. It leverages machine learning algorithms to analyze market trends, property characteristics, and user financial goals.",
              "lib/assets/recommendation_system_image.png",
            ),
            _buildModuleSection(
              context,
              "Financial Simulation System",
              "The Financial Simulation module allows users to simulate various financial scenarios to evaluate the potential profitability of their real estate investments. It includes calculations for municipal taxes, insurance premiums, net present value (NPV), internal rate of return (IRR), and other essential financial metrics.",
              "lib/assets/financial_simulation_image.png",
            ),
            _buildModuleSection(
              context,
              "AI-Based Financial Simulation Summary",
              "Using natural language processing (NLP) models, this module generates intelligent summaries of the financial simulations conducted by users, offering a quick and comprehensive understanding of the simulation results.",
              "lib/assets/simulation_summary_image.png",
            ),
            _buildModuleSection(
              context,
              "Automated Administrative Document Generation",
              "This module automates the creation of administrative documents related to real estate investments, such as contracts, financial reports, and property sheets. It uses generative models to produce documents that comply with legal standards and requirements.",
              "lib/assets/document_generation_image.png",
            ),
            _buildModuleSection(
              context,
              "Investor Profile Management for Real Estate Brokers",
              "Real estate brokers can efficiently manage their investor clients’ profiles with this module. Features include adding, editing, deleting, and searching for investor profiles, as well as updating investment preferences and goals.",
              "lib/assets/profile_management_image.png",
            ),
            _buildModuleSection(
              context,
              "Real Estate Property Exploration",
              "This interactive module enables users to explore and search for available real estate properties on the market. Users can filter properties by various criteria and access detailed information about each property.",
              "lib/assets/property_exploration_image.png",
            ),
            SizedBox(height: 20),
            Text(
              "Conclusion",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30, // Augmentation de la taille de police
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat-Bold",
                color: AppColors.blueDarkColor,
              ),
            ),
            SizedBox(height: 10),
            Container(
              constraints: BoxConstraints(maxWidth: 800), // Limite la largeur du texte
              child: Text(
                "RealOpt stands out by integrating AI into its modules, significantly enhancing the platform's efficiency and performance. Advanced machine learning and NLP models ensure precise recommendations, detailed financial simulations, and automated document generation. The profile management and property exploration functionalities enrich the user experience, making RealOpt an indispensable tool for real estate investors and brokers.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, height: 1.5), // Augmentation de la taille de police
              ),
            ),
            SizedBox(height: 40),
            Text(
              "Customer Services",
              style: TextStyle(
                fontSize: 26, // Augmentation de la taille de police
                fontWeight: FontWeight.bold,
                color: AppColors.blueDarkColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "+1 (819) 349-1001\ncalculatriceimmobiliereca@gmail.com",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, height: 1.5), // Augmentation de la taille de police
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleSection(BuildContext context, String title, String description, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 26, // Augmentation de la taille de police
              fontWeight: FontWeight.bold,
              fontFamily: "Montserrat-Bold",
              color: AppColors.blueDarkColor,
            ),
          ),
          SizedBox(height: 10),
          Container(
            constraints: BoxConstraints(maxWidth: 800), // Limite la largeur du texte
            child: Text(
              description,
              style: TextStyle(fontSize: 18, height: 1.5), // Augmentation de la taille de police
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
          Image.network(imageUrl, width: 300), // Limite la taille de l'image
        ],
      ),
    );
  }
}
