import 'package:realopt/constants/colors.dart';
import 'package:realopt/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: AppColors.whiteColor,
        backgroundColor: AppColors.colorPrimary,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const SettingsScreen()));
            },
            icon: const Icon(Icons.settings),
          )
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Notifications", style: TextStyle(color: AppColors.whiteColor)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search notification",
                  contentPadding: const EdgeInsets.all(16.0),
                  fillColor: Colors.black12,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0)
                  )
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index){
                    return Slidable(
                        endActionPane: ActionPane(
                          motion: ScrollMotion(

                          ),
                          children: [
                            SlidableAction(
                              onPressed: (context) {},
                              icon:Icons.delete,
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red[700]!,
                            ),

                          ],
                        ),
                        child: ListTile(
                          isThreeLine: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.089),
                          leading: CircleAvatar(
                            radius: 25,
                            child: Icon(Icons.notifications),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Koati romeo", style: TextStyle(fontWeight: FontWeight.w600),),
                              Text("2h Ago", style: TextStyle(fontSize: 12),)
                            ],
                          ),
                          subtitle: Text(
                            "Plase make a presentation avec to les options de la vie.",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey[400],
                    indent: size.width * .08,
                    endIndent: size.width * .08,
                  ),
                  itemCount: 10
              )
          )
        ],
      ),
    );
  }
}
