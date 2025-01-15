import 'package:finitepay/controllers/init_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileSelector extends StatelessWidget {
  const MobileSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // width: 220,
          color: Theme.of(context).appBarTheme.backgroundColor,
          child: ListView.builder(
            itemCount: maincontroller.dashIcons.length,
            itemBuilder: (context, index) {
              return Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: maincontroller.currentTabIndex.value == index
                            ? Colors.blue
                            : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: maincontroller.currentTabIndex.value == index
                          ? Colors.blue[50]
                          : Colors.transparent,
                    ),
                    child: maincontroller.dashIcons[index],
                  ),
                ),
              );
            },
          ),
          // child: ListView(
          //   padding: const EdgeInsets.all(16),
          //   children: [
          //     .
          //   ],
          // ),
        ),
      ),
    );
  }
}
