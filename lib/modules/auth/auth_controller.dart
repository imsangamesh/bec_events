import 'dart:developer';

import 'package:demo_bec/core/constants/pref_keys.dart';
import 'package:demo_bec/modules/auth/signin_screen.dart';
import 'package:demo_bec/utilities/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/constants/my_constants.dart';
import '../home/home_screen.dart';

class AuthController extends GetxController {
  //
  final _box = GetStorage();

  bool get isUserPresent => _box.read<bool>(PrefKeys.userStatus) ?? false;

  bool get isUserAnonymous => _box.read<bool>(PrefKeys.isAnonymous) ?? false;

  bool get isUserAdmin => _box.read<bool>(PrefKeys.isAdmin) ?? false;

  signInWithGoogle() async {
    try {
      /// `Trigger` the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      /// get the authentication details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      /// create a new `credential`
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      Utils.progressIndctr(label: 'loading...');

      /// once signed-in extract `UserCredentials`
      final userCredential = await auth.signInWithCredential(credential);

      /// if user `couldn't` login
      if (userCredential.user == null) {
        Utils.normalDialog();
        return;
      }

      _box.write(PrefKeys.userStatus, true);
      _box.write(PrefKeys.isAnonymous, false);

      Get.back();
      Get.offAll(() => HomeScreen());
      Utils.showSnackBar('Login Successful!', yes: true);

      /// ---------------------------------------- check for `ADMIN`
      checkForAdminAndUpdate(true);
      //
    } on FirebaseAuthException catch (e) {
      Get.back();
      Utils.showAlert('Oops', e.message.toString());
    } catch (e) {
      Get.back();

      if (e.toString() == 'Null check operator used on a null value') {
        Utils.showSnackBar('Please select your email to proceed');
      } else {
        Utils.showAlert('Oops', e.toString());
      }
    }
  }

  checkForAdminAndUpdate(bool showStatus) async {
    if (await checkForAdmins()) {
      log('======================== USER IS ADMIN ========================');
      _box.write(PrefKeys.isAdmin, true);

      if (showStatus) {
        Utils.showAlert(
          'Good News',
          'You are selected as admin from the Event Management Team!',
        );
      }
    } else {
      _box.write(PrefKeys.isAdmin, false);
    }
  }

  Future<bool> checkForAdmins() async {
    try {
      final snapshot = await fire.collection('admins').get();
      final dataList = snapshot.docs.map((echDoc) => echDoc.data()).toList();

      for (var each in dataList) {
        if (each['email'] == auth.currentUser!.email) return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  signInAnonymously() async {
    try {
      Utils.progressIndctr(label: 'loading...');
      await auth.signInAnonymously();

      _box.write(PrefKeys.userStatus, true);
      _box.write(PrefKeys.isAnonymous, true);

      Get.back();
      Get.offAll(() => HomeScreen());
      Utils.showSnackBar('Login Successful!', yes: true);
      //
    } on FirebaseAuthException catch (e) {
      Utils.showAlert('OOPS', e.message.toString());
    } catch (e) {
      Utils.normalDialog();
    }
  }

  logout() async {
    try {
      await GoogleSignIn().signOut();

      _box.write(PrefKeys.userStatus, false);

      Get.offAll(() => SigninScreen());

      if (isUserAnonymous) {
        auth.currentUser!.delete();
      }
    } catch (e) {
      log('=================== couldn\'t logout ==================');
    }
  }
}
