import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'package:realopt/components/dashboard/app_bar_action_items.dart';
import 'package:realopt/components/dashboard/header_admin_dropdown.dart';
import 'package:realopt/components/dashboard/payment_detail_list.dart';
import 'package:realopt/components/dashboard/side_menu.dart';
import 'package:realopt/utils/responsive.dart';
import 'package:realopt/utils/size_config.dart';
import 'package:realopt/constants/colors.dart';

class AiScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AiScreen({super.key});

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
              icon: const Icon(Icons.menu, color: AppColors.blackColor)),
          actions: [
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
                          HeaderAdminDropdown(mainTitle: 'REALAOTPAI', subTitle: 'Artificial Intelligencce'),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical! * 4,
                          ),
                          const ChatScreen()
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
                        padding:EdgeInsets.symmetric(vertical: 30, horizontal: 30),
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
        )
    );
  }
}
