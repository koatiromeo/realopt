import 'package:flutter/material.dart';
import 'package:realopt/components/dashboard/ai_floating_action_button.dart';
import 'package:realopt/components/dashboard/appBarActionItems.dart';
import 'package:realopt/components/dashboard/barChartCopmponent.dart';
import 'package:realopt/components/dashboard/header_admin_add.dart';
import 'package:realopt/components/dashboard/historyTable.dart';
import 'package:realopt/components/dashboard/infoCard.dart';
import 'package:realopt/components/dashboard/paymentDetailList.dart';
import 'package:realopt/components/dashboard/sideMenu.dart';
import 'package:realopt/utils/responsive.dart';
import 'package:realopt/utils/size_config.dart';
import 'package:realopt/constant/colors.dart';
import 'package:realopt/constant/style.dart';

class Dashboard extends StatelessWidget {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final List<Map<String, String>> listItems = [
    {'title': 'Title 1', 'content': 'Content for title 1'},
    {'title': 'Title 2', 'content': 'Content for title 2'},
    {'title': 'Title 3', 'content': 'Content for title 3'},
  ];

  Dashboard({super.key});

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
          padding:
          EdgeInsets.symmetric(vertical: 30, horizontal: 30),
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
        actions: [
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
                        HeaderAdminAdd(mainTitle: 'Dashboard', subTitle: 'Investments updates'),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 4,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth,
                          child: const Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              InfoCard(
                                  icon: 'lib/assets/svgs/user.svg',
                                  label: 'Profiles',
                                  amount: '1200'),
                              InfoCard(
                                  icon: 'lib/assets/svgs/clipboard.svg',
                                  label: 'Documents',
                                  amount: '150'),
                              InfoCard(
                                  icon: 'lib/assets/svgs/bank.svg',
                                  label: 'Properties',
                                  amount: '1500'),
                              InfoCard(
                                  icon: 'lib/assets/svgs/simulation.svg',
                                  label: 'Simulations',
                                  amount: '1500'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryText(
                                  text: 'Last simulation',
                                  size: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.secondary,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                // Handle the tap event here
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Download in processs!')),
                                );
                              },
                              child: const PrimaryText(
                                text: 'Download',
                                size: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 3,
                        ),
                        Container(
                          height: 180,
                          child: const BarChartCopmponent(),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 5,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimaryText(
                                text: 'Recent activities',
                                size: 30,
                                fontWeight: FontWeight.w800),
                            PrimaryText(
                              text: 'Investors profiles of last 6 months',
                              size: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondary,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 3,
                        ),
                        const HistoryTable(),
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
}
