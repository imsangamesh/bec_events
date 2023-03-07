import 'package:demo_bec/core/constants/my_constants.dart';
import 'package:demo_bec/modules/home/widgets/gallery_event_tile.dart';
import 'package:demo_bec/modules/home/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/themes/theme_controller.dart';
import '../../utilities/utils.dart';
import '../auth/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  //
  final authController = Get.find<AuthController>();
  final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: const Text('BEC Events!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, size: 20),
            onPressed: () => Utils.confirmDialogBox(
              'Wanna logout?',
              'Hey, you would have stayed a while more & explored your college\'s Event Gallery!',
              yesFun: () => authController.logout(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.circle),
            onPressed: () => authController.checkForAdmins(),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: fire.collection('events').snapshots(),
        builder: (context, snapshot) {
          final snapData = snapshot.data;
          if (snapData == null || snapData.docs.isEmpty) {
            return SizedBox(
              height: 150,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.bubble_chart_outlined, size: 30),
                    SizedBox(height: 5),
                    Text(
                      'currently there are no Events held\nplease come back later',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          final listData = [...snapData.docs.reversed, 'dummy'];

          return Padding(
            padding: const EdgeInsets.all(12),
            child: ListView.builder(
              itemCount: listData.length,
              itemBuilder: (context, index) {
                if (listData[index] == 'dummy') {
                  return const SizedBox(
                    height: 150,
                    child: Center(
                      child: Text(
                        'Hey, you have reached the end\nPlease come after some time for new EVENT FEED!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                final data = snapData.docs[index].data();

                return GalleryEventTile(data);
              },
            ),
          );
        },
      ),
    );
  }
}
