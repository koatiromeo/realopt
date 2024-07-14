import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:realopt/screens/simulations_management_screen.dart';

class SimulationGenerationGuestUserScreen extends StatefulWidget {
  const SimulationGenerationGuestUserScreen({super.key});

  @override
  State<SimulationGenerationGuestUserScreen> createState() => _SimulationGenerationGuestUserScreenState();
}

class _SimulationGenerationGuestUserScreenState extends State<SimulationGenerationGuestUserScreen> {
  bool isPreviewExpanded = false;
  bool isProjectHidden = false;
  bool isPreviewHidden = false;
  bool isSwitchPreview = false;

  String documentName = 'Simulation Name';
  String selectedPropertyType = 'Properties Renovation';

  void togglePreview() {
    setState(() {
      isPreviewHidden = !isPreviewHidden;
    });
  }

  void switchPreview() {
    setState(() {
      isSwitchPreview = !isSwitchPreview;
    });
  }

  void toggleProjectVisibility() {
    setState(() {
      isProjectHidden = !isProjectHidden;
    });
  }

  void editDocumentName() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newDocumentName = documentName;
        return AlertDialog(
          title: Text('Edit Simulation Name'),
          content: TextField(
            onChanged: (value) {
              newDocumentName = value;
            },
            controller: TextEditingController(text: documentName),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  documentName = newDocumentName;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void downloadPreview() {
    // Implement download functionality here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2F3A4C),
        title: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                iconSize: 20,
                tooltip: 'Simulations',
                icon: SvgPicture.asset(
                  'lib/assets/svgs/simulation.svg',
                  width: 35,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 400),
                          child: SimulationsManagementScreen()));
                },
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(documentName,
                      style: TextStyle(color: Colors.white)),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: editDocumentName,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  icon: Icon(Icons.download),
                  onPressed: downloadPreview,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: TextButton(
                  onPressed: switchPreview,
                  child: Text(
                    isSwitchPreview ? 'Switch to Editor' : "Switch to Explanation",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF2D8C3C),
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
              leading: Icon(Icons.folder),
              title: Text('Projects'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('New Project'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          if (!isProjectHidden)
            Expanded(
              flex: 1,
              child: Container(
                color: Color(0xFF2F3A4C),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: selectedPropertyType,
                        dropdownColor: Color(0xFF2F3A4C),
                        icon: Icon(Icons.arrow_downward, color: Colors.white),
                        underline: Container(
                          height: 2,
                          color: Colors.white,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedPropertyType = newValue!;
                          });
                        },
                        items: <String>[
                          'Properties Renovation',
                          'Properties Flip',
                          'Properties Rentability'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                      ),
                    ),
                    if (selectedPropertyType == 'Properties Renovation')
                      Expanded(
                        child: StepperWidget(title: 'Properties Renovation Stepper'),
                      ),
                    if (selectedPropertyType == 'Properties Flip')
                      Expanded(
                        child: StepperWidget(title: 'Properties Flip Stepper'),
                      ),
                    if (selectedPropertyType == 'Properties Rentability')
                      Expanded(
                        child: StepperWidget(title: 'Properties Rentability Stepper'),
                      ),
                  ],
                ),
              ),
            ),
          VerticalDivider(
            width: 1,
            color: Colors.white,
            thickness: 1,
            endIndent: 0,
            indent: 0,
          ),
          GestureDetector(
            onTap: toggleProjectVisibility,
            child: Container(
              width: 50,
              color: Color(0xFF2F3A4C),
              child: Center(
                child: Icon(
                  isProjectHidden ? Icons.chevron_right : Icons.chevron_left,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          VerticalDivider(
            width: 1,
            color: Colors.white,
            thickness: 1,
            endIndent: 0,
            indent: 0,
          ),
          if (!isSwitchPreview)
            Expanded(
              flex: isPreviewHidden ? 3 : 2,
              child: Container(
                color: Color(0xFF2F3A4C),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Editor',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      AspectRatio(
                        aspectRatio: 1.7,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LineChart(LineChartData(
                            gridData: FlGridData(show: true),
                            titlesData: FlTitlesData(show: true),
                            borderData: FlBorderData(show: true),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, 1),
                                  FlSpot(1, 3),
                                  FlSpot(2, 2),
                                  FlSpot(3, 5),
                                ],
                                isCurved: true,
                                color: Colors.blue,
                                barWidth: 4,
                                isStrokeCapRound: true,
                                dotData: FlDotData(show: false),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (!isSwitchPreview)
            VerticalDivider(
              width: 1,
              color: Colors.white,
              thickness: 1,
              endIndent: 0,
              indent: 0,
            ),
          if (!isSwitchPreview)
            GestureDetector(
              onTap: togglePreview,
              child: Container(
                width: 50,
                color: Color(0xFF2F3A4C),
                child: Center(
                  child: Icon(
                    isPreviewHidden ? Icons.chevron_left : Icons.chevron_right,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          if (!isPreviewHidden || isSwitchPreview)
            Expanded(
              flex: isSwitchPreview ? 3 : 1,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Explanation',
                    style: TextStyle(color: Color(0xFF2F3A4C)),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class StepperWidget extends StatelessWidget {
  final String title;

  StepperWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Stepper(
      steps: [
        Step(
          title: Text("Step 1"),
          content: Text("Content for Step 1"),
        ),
        Step(
          title: Text("Step 2"),
          content: Text("Content for Step 2"),
        ),
        Step(
          title: Text("Step 3"),
          content: Text("Content for Step 3"),
        ),
      ],
    );
  }
}
