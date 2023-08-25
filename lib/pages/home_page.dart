import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelio_app/config/app.assets.dart';
import 'package:hotelio_app/config/app.color.dart';
import 'package:hotelio_app/controller/c_home.dart';
import 'package:hotelio_app/pages/history_page.dart';
import 'package:hotelio_app/pages/nearby_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Map> listNav = [
    {'icon': AppAssets.iconNearby, 'label': "Nearby"},
    {'icon': AppAssets.iconHistory, 'label': "History"},
    {'icon': AppAssets.iconPayment, 'label': "Payment"},
    {'icon': AppAssets.iconReward, 'label': "Reward"},
  ];

  final cHome = Get.put(CHome());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (cHome.indexPage == 1) {
          return HistoryPage();
        } else if (cHome.indexPage == 2) {
          return Center(child: const Text("payment"));
        } else if (cHome.indexPage == 3) {
          return Center(child: const Text("Reward"));
        }
        return NearbyPage();
      }),
      bottomNavigationBar: Obx(() {
        return Material(
          elevation: 8,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 8, bottom: 6),
            child: BottomNavigationBar(
              currentIndex: cHome.indexPage,
              onTap: (value) => cHome.indexPage = value,
              elevation: 0,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.black,
              selectedIconTheme: const IconThemeData(
                color: AppColor.primary,
              ),
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              selectedFontSize: 12,
              items: listNav.map((e) {
                return BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(e['icon']),
                  ),
                  label: e['label'],
                );
              }).toList(),
            ),
          ),
        );
      }),
    );
  }
}
