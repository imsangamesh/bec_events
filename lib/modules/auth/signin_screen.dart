import 'package:demo_bec/core/themes/my_colors.dart';
import 'package:demo_bec/core/themes/my_textstyles.dart';
import 'package:demo_bec/modules/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const imageUrl =
        'https://img.freepik.com/free-vector/access-control-system-abstract-concept-illustration-security-system-authorize-entry-login-credentials-electronic-access-password-pass-phrase-pin-verification_335657-3373.jpg?size=338&ext=jpg&uid=R65626931&ga=GA1.1.1025021015.1655558182&semt=sph';

    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(title: const Text('Let\'s get you signed!')),
      body: Column(children: [
        const SizedBox(height: 50),
        SizedBox(
          height: size.height * 0.5,
          width: size.width,
          child: Image.network(imageUrl),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => authController.signInWithGoogle(),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8),
            textStyle: MyTStyles.kTS16Medium,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: SizedBox(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.account_circle, size: 30),
                SizedBox(width: 30),
                Text('Sign up with Google'),
                SizedBox(width: 50),
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: () => authController.signInAnonymously(),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            textStyle: MyTStyles.kTS14Medium,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: const Text('anonymous sign-in'),
        ),
      ]),
    );
  }
}
