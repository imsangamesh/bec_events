import 'package:demo_bec/main.dart';
import 'package:demo_bec/modules/auth/auth_controller.dart';
import 'package:demo_bec/utilities/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/my_constants.dart';
import '../../../core/themes/my_colors.dart';
import '../../../core/themes/my_textstyles.dart';
import '../../gallery/event_fillup_screen.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({super.key});

  final authController = Get.put(AuthController());

  String get name => auth.currentUser!.displayName ?? 'Guest User';

  String get imageUrl =>
      auth.currentUser!.photoURL ??
      'https://img.freepik.com/premium-psd/3d-cartoon-avatar-smiling-man_1020-5130.jpg?size=338&ext=jpg&uid=R65626931&ga=GA1.2.1025021015.1655558182&semt=sph';

  final isDark = Get.isDarkMode.obs;

  checkForAdmin() {
    Get.back();

    if (authController.isUserAdmin) {
      Get.to(() => const Gallery());
      return;
    }

    Utils.showAlert('Alert!', 'You are not a admin to host new events.');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Drawer(
      child: Obx(
        () => SizedBox(
          height: size.height,
          width: size.width * 0.6,
          child: Column(
            children: [
              AppBar(
                leading: const SizedBox(),
                title: const Text('Bec Events'),
              ),
              // --------------------------------------------------- profile
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor:
                          isDark.value ? MyColors.lightPurple : MyColors.pink,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.network(imageUrl),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        name,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: MyTStyles.kTS18Medium,
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              // ------------------------------------- change theme
              Container(
                color: MyColors.lightPurple.withAlpha(100),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Text('light ', style: MyTStyles.kTS15Medium),
                    const Icon(Icons.light_mode_rounded, size: 30),
                    const Spacer(),
                    CupertinoSwitch(
                      thumbColor: MyColors.pink,
                      trackColor: MyColors.pink.withAlpha(60),
                      activeColor: MyColors.emerald,
                      value: isDark.value,
                      onChanged: (newVal) {
                        globalThemeContrl.toggleThemeMode();
                        isDark(newVal);
                      },
                    ),
                    const Spacer(),
                    const Icon(Icons.dark_mode_outlined, size: 30),
                    const Text(' dark', style: MyTStyles.kTS15Medium),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // ------------------------------------- Upload new events
              ListTile(
                onTap: checkForAdmin,
                leading: Icon(
                  Icons.auto_awesome,
                  color: isDark.value ? MyColors.wheat : MyColors.purple,
                ),
                tileColor: MyColors.lightPurple.withAlpha(100),
                title: const Text(
                  'Host New Events!',
                  style: MyTStyles.kTS16Medium,
                ),
                trailing: Icon(
                  Icons.keyboard_double_arrow_right_rounded,
                  color: isDark.value ? MyColors.wheat : MyColors.purple,
                ),
              ),
              const SizedBox(height: 10),
              if (!authController.isUserAdmin)
                ListTile(
                  onTap: requestForAdmin,
                  leading: Icon(
                    Icons.account_circle_rounded,
                    color: isDark.value ? MyColors.wheat : MyColors.purple,
                  ),
                  tileColor: MyColors.lightPurple.withAlpha(100),
                  title: const Text(
                    'Request to make Admin',
                    style: MyTStyles.kTS16Medium,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  requestForAdmin() {
    Get.back();
    Utils.confirmDialogBox(
      'Are you sure?',
      'Do you want to post a request to become admin for the Events?',
      yesFun: postRequestToFirestore,
    );
  }

  postRequestToFirestore() async {
    try {
      Get.back();
      fire.collection('adminRequests').doc().set({
        'name': auth.currentUser!.displayName,
        'email': auth.currentUser!.email,
      });

      Utils.showSnackBar('Request Successful');
    } catch (e) {
      Utils.normalDialog();
    }
  }
}
