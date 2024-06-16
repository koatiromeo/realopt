import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:realopt/dashboard/documents.dart';
import 'package:realopt/dashboard/style/colors.dart';


class Document extends StatefulWidget {
  @override
  _DocumentState createState() => _DocumentState();
}

class _DocumentState extends State<Document> {
  bool isPreviewExpanded = false;
  bool isProjectHidden = false;
  bool isPreviewHidden = false;
  bool isSwitchPreview = false;

  String documentName = 'Document Name';

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
          title: Text('Edit Document Name'),
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
                  tooltip: 'Documents Automation',
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                      'lib/assets/svgs/clipboard.svg',
                      width: 35,
                      colorFilter: const ColorFilter.mode(
                        AppColors.iconGray,
                        BlendMode.srcIn,
                      )
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 400),
                            child: Documents()));
                })
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(documentName),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: editDocumentName,
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
                  )
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: TextButton(
                  onPressed: switchPreview,
                  child: Text(isSwitchPreview ? 'Switch to Editor' : "Switch to Preview", style: TextStyle(color: Colors.white)),
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
                    ListTile(
                      leading: Icon(Icons.folder, color: Colors.white),
                      title: Text('Project 1', style: TextStyle(color: Colors.white)),
                    ),
                    ListTile(
                      leading: Icon(Icons.folder, color: Colors.white),
                      title: Text('Project 2', style: TextStyle(color: Colors.white)),
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
          if(!isSwitchPreview)
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
                      Text(
                        'Avez-vous terminé votre travail ?',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('Oui'),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('Non'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if(!isSwitchPreview)
            VerticalDivider(
              width: 1,
              color: Colors.white,
              thickness: 1,
              endIndent: 0,
              indent: 0,
            ),
          if(!isSwitchPreview)
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
                    'Preview',
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

