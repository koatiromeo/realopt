import 'dart:math';
import 'package:flutter/material.dart';
import 'package:realopt/components/dashboard/ai_floating_action_button.dart';
import 'package:realopt/components/dashboard/app_bar_action_items.dart';
import 'package:realopt/components/dashboard/header.dart';
import 'package:realopt/components/dashboard/header_admin_options.dart';
import 'package:realopt/components/dashboard/payment_detail_list.dart';
import 'package:realopt/components/dashboard/side_menu.dart';
import 'package:realopt/components/dashboard/side_menu_guest_user.dart';
import 'package:realopt/utils/responsive.dart';
import 'package:realopt/utils/size_config.dart';
import 'package:realopt/constants/colors.dart';
import 'package:realopt/models/property.dart';
import 'package:realopt/models/note.dart';
import 'dart:collection';


class PropertiesExplorationGuestUserScreen extends StatefulWidget {
  const PropertiesExplorationGuestUserScreen({super.key});

  @override
  State<PropertiesExplorationGuestUserScreen> createState() => _PropertiesExplorationGuestUserScreenState();
}

class _PropertiesExplorationGuestUserScreenState extends State<PropertiesExplorationGuestUserScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  List<Note> filteredNotes = [];
  bool sorted = false;

  @override
  void initState() {
    super.initState();
    filteredNotes = sampleNotes;
  }
  List<Note> sortNotesByModifiedTime(List<Note> notes) {
    if (sorted) {
      notes.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
    } else {
      notes.sort((b, a) => a.modifiedTime.compareTo(b.modifiedTime));
    }

    sorted = !sorted;

    return notes;
  }

  getRandomColor() {
    Random random = Random();
    return AppColors.blueDarkColor;
  }

  void onSearchTextChanged(String searchText) {
    setState(() {
      filteredNotes = sampleNotes
          .where((note) =>
      note.content.toLowerCase().contains(searchText.toLowerCase()) ||
          note.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  void deleteNote(int index) {
    setState(() {
      Note note = filteredNotes[index];
      sampleNotes.remove(note);
      filteredNotes.removeAt(index);
      index = 1;
    });
  }

  List<Property> propertyList = [
    Property("Sea View", "Sea view resort",
        "https://images.unsplash.com/photo-1589779677460-a15b5b5790ce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80"),
    Property("Awesome Nature", "Orange color fish",
        "https://images.unsplash.com/photo-1520301255226-bf5f144451c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80"),
    Property("Yellow Fish", "Yellow Fish in blue water",
        "https://images.unsplash.com/photo-1504472478235-9bc48ba4d60f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80"),
    Property("Orange Fish", "Orange Fish in blue water",
        "https://images.unsplash.com/photo-1535591273668-578e31182c4f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
    Property("Nature 1", "Nice tree in the nature",
        "https://images.unsplash.com/photo-1624964562918-0b8cf87deee6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
    Property("Sea Nature", "Nice beach nature",
        "https://images.unsplash.com/photo-1597499216184-b56bf75f84c4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
    Property("Awesome Beach", "Beach with trees",
        "https://images.unsplash.com/photo-1509057095372-215f8cc53d1a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=874&q=80"),
    Property("Blue Nature", "Beach with blue water",
        "https://images.unsplash.com/photo-1558102822-da570eb113ed?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
    Property("Sea Nature 2", "Awesome beach with trees",
        "https://images.unsplash.com/photo-1545579133-99bb5ab189bd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
  ];

  HashSet<Property> selectedItem = HashSet();
  bool isMultiSelectionEnabled = false;

  String getSelectedItemCount() {
    return selectedItem.isNotEmpty
        ? selectedItem.length.toString() + " item selected"
        : "No item selected";
  }

  void doMultiSelection(Property nature) {
    if (isMultiSelectionEnabled) {
      if (selectedItem.contains(nature)) {
        selectedItem.remove(nature);
      } else {
        selectedItem.add(nature);
      }
      setState(() {});
    } else {
      //Other logic
    }
  }

  InkWell getListItem(Property nature) {
    return InkWell(
        onTap: () {
          doMultiSelection(nature);
        },
        onLongPress: () {
          isMultiSelectionEnabled = true;
          doMultiSelection(nature);
        },
        child: Stack(alignment: Alignment.centerRight, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                nature.url,
                height: 100,
                width: 100,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 18.0,
                      child: Text(nature.name),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 14.0,
                      child: Text(nature.description),
                    ),
                  ],
                ),
              )
            ],
          ),
          Visibility(
              visible: isMultiSelectionEnabled,
              child: Icon(
                selectedItem.contains(nature)
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                size: 30,
                color: Colors.red,
              ))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      drawer: const SizedBox(width: 100, child: SideMenuGuestUser()),
      endDrawer: SizedBox(width: 300, child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight,
        decoration: const BoxDecoration(color: AppColors.secondaryBg),
        child: const SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            children: [
              PaymentDetailList(),
            ],
          ),
        ),
      ),),
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        leading: IconButton(
            onPressed: () {
              _drawerKey.currentState?.openDrawer();
            },
            icon: const Icon(Icons.menu, color: AppColors.blackColor)),
        actions:  [
          const AppBarActionItems(),
          IconButton(
              onPressed: () {
                _drawerKey.currentState?.openEndDrawer();
              },
              icon:const Icon(Icons.more_vert, color: AppColors.blackColor)
          )
        ],
      )
          : const PreferredSize(
        preferredSize: Size.zero,
        child: SizedBox(),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                flex: 1,
                child: SideMenuGuestUser(),
              ),
            Expanded(
                flex: 10,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header(mainTitle: 'Properties', subTitle: "Exploration of Real \nEstate Properties ",),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          onChanged: (val) {},
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.white,
                              contentPadding:
                              const EdgeInsets.only(left: 40.0, right: 5),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(color: AppColors.blackColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(color: AppColors.blackColor),
                              ),
                              prefixIcon: const Icon(Icons.search, color: AppColors.blackColor),
                              hintText: 'Search',
                              hintStyle: const TextStyle(color: AppColors.blackColor, fontSize: 14)
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: propertyList.length,
                          itemBuilder: (context, index) {
                            return Card(
                                elevation: 20,
                                margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  height: 70.0,
                                  child: getListItem(propertyList[index]),
                                ));
                          },
                        )
                        // ListView(
                        //   children: propertyList.map((Property nature) {
                        //     return Card(
                        //         elevation: 20,
                        //         margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(10)),
                        //         child: Container(
                        //           margin: const EdgeInsets.only(
                        //               left: 10, right: 10, top: 5, bottom: 5),
                        //           height: 70.0,
                        //           child: getListItem(nature),
                        //         ));
                        //   }).toList(),
                        // ),
                      ],
                    ),
                  ),
                )),
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 4,
                child: SafeArea(
                  child: Container(
                    width: double.infinity,
                    height: SizeConfig.screenHeight,
                    decoration: const BoxDecoration(color: AppColors.secondaryBg),
                    child: const SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                      child: Column(
                        children: [
                          AppBarActionItems(),
                          PaymentDetailList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: const AiFloatingActionButton(),
    );
  }
  Future<dynamic> confirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            icon: const Icon(
              Icons.info,
              color: Colors.grey,
            ),
            title: const Text(
              'Are you sure you want to delete?',
              style: TextStyle(color: Colors.white),
            ),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          'Yes',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          'No',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ]),
          );
        });
  }

}

