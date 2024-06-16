import 'dart:math';
import 'package:flutter/material.dart';
import 'package:realopt/dashboard/component/ai_floating_action_button.dart';
import 'package:realopt/dashboard/component/appBarActionItems.dart';
import 'package:realopt/dashboard/component/header_admin_add.dart';
import 'package:realopt/dashboard/component/paymentDetailList.dart';
import 'package:realopt/dashboard/component/sideMenu.dart';
import 'package:realopt/dashboard/config/responsive.dart';
import 'package:realopt/dashboard/config/size_config.dart';
import 'package:realopt/dashboard/constant/colors.dart';
import 'package:realopt/dashboard/style/colors.dart';
import '../model/note.dart';
import 'package:intl/intl.dart';

class Recommendations extends StatefulWidget {
  const Recommendations({super.key});

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
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
    return backgroundColors[random.nextInt(backgroundColors.length)];
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      drawer: const SizedBox(width: 100, child: SideMenu()),
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
            icon: const Icon(Icons.menu, color: AppColors.black)),
        actions:  [
          const AppBarActionItems(),
          IconButton(
              onPressed: () {
                _drawerKey.currentState?.openEndDrawer();
              },
              icon:const Icon(Icons.more_vert, color: AppColors.black)
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
                child: SideMenu(),
              ),
            Expanded(
                flex: 10,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderAdminAdd(mainTitle: 'Advices', subTitle: "Add, Edit, Remove",),
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
                                borderSide: const BorderSide(color: AppColors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(color: AppColors.white),
                              ),
                              prefixIcon: const Icon(Icons.search, color: AppColors.black),
                              hintText: 'Search',
                              hintStyle: const TextStyle(color: AppColors.secondary, fontSize: 14)
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: filteredNotes.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 3,
                              child: ListTile(
                                title: RichText(
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text: '${filteredNotes[index].title} \n',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        height: 1.5
                                    ),
                                    children: [
                                      TextSpan(
                                        text: filteredNotes[index].content,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            height: 1.5
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Edited: ${DateFormat('EEE MMM d, yyyy h:mm a').format(filteredNotes[index].modifiedTime)}',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey.shade800
                                    ),
                                  ),
                                ),
                                trailing: Wrap(children: [
                                  IconButton(
                                      onPressed: () async {
                                        final result = await confirmDialog(context);
                                        if (result != null && result) {
                                          deleteNote(index);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                      )
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        final result = await confirmDialog(context);
                                        if (result != null && result) {
                                          deleteNote(index);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                      )
                                  ),
                                ]),
                              ),
                            );
                          },
                        ),
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

