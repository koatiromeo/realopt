import 'package:realopt/Constant/ColorGlobal.dart';
import 'package:realopt/pages/profiles/profile_screen.dart';
import 'package:realopt/components/dashboard/NavBar.dart';
import 'package:realopt/components/guest/transfer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class GuestUserHomeScreen extends StatefulWidget {
  const GuestUserHomeScreen({super.key});

  @override
  State<GuestUserHomeScreen> createState() => _GuestUserHomeScreenState();
}

class _GuestUserHomeScreenState extends State<GuestUserHomeScreen> with SingleTickerProviderStateMixin{

  int _selectedItemIndex = 2;
  final GlobalKey _floatingButtonKey = GlobalKey();
  final GlobalKey _RecommendatioButtonKey = GlobalKey();
  final GlobalKey _DocumentButtonKey = GlobalKey();
  final GlobalKey _StaticButtonKey = GlobalKey();
  final GlobalKey _InvestorButtonKey = GlobalKey();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _animationController;

  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus> targets = [];



  void _toggleDrawer() {
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      _animationController.reverse();
      Navigator.of(context).pop();
    } else {
      _animationController.forward();
      _scaffoldKey.currentState?.openDrawer();
    }
  }



  void _initTarget(){
    targets = [
      TargetFocus(
          identify: "floating-button-key",
          keyTarget: _floatingButtonKey,
          contents: [
            TargetContent(
                align: ContentAlign.top,
                builder: (context, controller){
                  return CoachmarkDesc(
                    text: "fffffffffffffffff",
                    onNext: () {},
                    onSkip: () {},
                  );
                }
            )
          ]
      )
    ];
  }
  void _showTutorialCoachmark(){
    _initTarget();
    tutorialCoachMark = TutorialCoachMark(targets: targets)..show(context: context);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 1), (){
      _showTutorialCoachmark();
    });
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000), vsync: this,
    );

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
      drawer: NavBar(),
      bottomNavigationBar: Row(
        children: [
          buildNavBarItem(Icons.home, 0),
          buildNavBarItem(Icons.edit_document, 1),
          buildNavBarItem(Icons.camera, 2),
          buildNavBarItem(Icons.bar_chart, 3),
          buildNavBarItem(Icons.person, 4),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 300,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [ColorGlobal.colorPrimary, ColorGlobal.colorPrimaryDark]),
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 20, right: 20.0, top: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _toggleDrawer();
                            },
                          ),
                          IconButton(
                            key: _RecommendatioButtonKey,
                            icon: const Icon(
                              Icons.lightbulb,
                              color: Colors.white,
                            ), onPressed: () {  },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext context) => const ProfileScreen()));
                            },
                            child: Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                color: const Color(0XFF00B686),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(.1),
                                      blurRadius: 8,
                                      spreadRadius: 3)
                                ],
                                border: Border.all(
                                  width: 1.5,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: const CircleAvatar(
                                backgroundImage: AssetImage('assets/Images/defaultuser.png'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Guest User",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.camera_front,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: "320".toString() + " use cases".toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.grey.shade100,
                  child: ListView(
                    padding: const EdgeInsets.only(top: 75),
                    children: [
                      const Text(
                        "Activity",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildActivityButton(
                              Icons.home, "Properties",
                              Colors.blue.withOpacity(0.2),
                              const Color(0XFF01579B)),
                          buildActivityButton(
                              Icons.person_2, "Investors",
                              Colors.blue.withOpacity(0.2),
                              const Color(0XFF01579B)),
                          buildActivityButton(
                              Icons.edit_document,
                              "Documents",
                              Colors.cyanAccent.withOpacity(0.2),
                              const Color(0XFF0097A7)),
                          buildActivityButton(
                              Icons.bar_chart,
                              "Statistics",
                              const Color(0XFFD7CCC8).withOpacity(0.4),
                              const Color(0XFF9499B7)),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildCategoryCard(Icons.home, "Properties", 120, 20),
                      buildCategoryCard(Icons.edit_document, "Documents", 430, 17),
                      buildCategoryCard(Icons.bar_chart, "Statistics", 120, 20),
                      buildCategoryCard(Icons.person_2, "Investors", 120, 20),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 185,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              width: MediaQuery.of(context).size.width * 0.85,
              height: 160,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 8,
                      spreadRadius: 3,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(50),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Last Recommadation",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "ppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp",
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    width: double.maxFinite,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: const Text(
                      "Tell me more",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF00B686)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton:FloatingActionButton(
        key: _floatingButtonKey,
        onPressed: () {
          // Define the action to be performed when the button is pressed
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Robot button pressed!')),
          );
        },
        tooltip: 'Robot',
        backgroundColor: ColorGlobal.colorPrimary,
        foregroundColor: ColorGlobal.whiteColor,
        child: const FaIcon(FontAwesomeIcons.robot),),
    );
  }

  GestureDetector buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if(index == 4){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => const ProfileScreen()));
          }
          else{
            _selectedItemIndex = index;
          }

        });

      },
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        height: 60,
        decoration: index == _selectedItemIndex
            ? BoxDecoration(
            border:
            const Border(bottom: BorderSide(width: 4, color: Colors.green)),
            gradient: LinearGradient(colors: [
              Colors.green.withOpacity(0.3),
              Colors.green.withOpacity(0.016),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter))
            : const BoxDecoration(),
        child: Icon(
          icon,
          color: index == _selectedItemIndex ? const Color(0XFF00B868) : Colors.grey,
        ),
      ),
    );
  }

  Container buildCategoryCard(
      IconData icon, String title, int amount, int percentage) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: 85,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: const Color(0xFF00B686),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "$amount",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "($percentage%)",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Stack(
            children: [
              Container(
                height: 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.grey.shade300),
              ),
              Container(
                height: 5,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: const Color(0XFF00B686)),
              ),
            ],
          )
        ],
      ),
    );
  }


  GestureDetector buildActivityButton(
      IconData icon, String title, Color backgroundColor, Color iconColor) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => const TransferPage())),
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              style:
              const TextStyle(fontSize:10,color: Colors.black54, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class CoachmarkDesc extends StatefulWidget {
  const CoachmarkDesc({
    super.key,
    required this.text,
    this.skip = "Skip",
    this.next = "Next",
    this.onSkip,
    this.onNext
  });

  final String text;
  final String skip;
  final String next;
  final void Function()? onSkip;
  final void Function()? onNext;


  @override
  State<CoachmarkDesc> createState() => _CoachmarkDescState();
}

class _CoachmarkDescState extends State<CoachmarkDesc> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: widget.onSkip,
                child: Text(widget.skip),
              ),
              SizedBox(width: 16,),
              ElevatedButton(
                  onPressed: widget.onNext,
                  child: Text(widget.next)
              )
            ],
          )
        ],
      ),
    );
  }
}
