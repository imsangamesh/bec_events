import 'dart:io';

import 'package:demo_bec/modules/home/home_screen.dart';
import 'package:demo_bec/utilities/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../core/constants/my_constants.dart';
import '../../models/eventModel.dart';

class UploadController {
  //
  // ======================= upload event images ===================
  static Future<List<String>?> uploadNewEventImagesToCloud(
    String eventId,
    List<PlatformFile> images,
  ) async {
    try {
      List<String> imageUrls = [];
      Utils.progressIndctr(label: 'uploading...');

      for (int i = 0; i < images.length; i++) {
        TaskSnapshot taskSnapshot = await store
            .ref()
            .child('events')
            .child('$eventId _ $i')
            .putFile(File(images[i].path!));

        imageUrls.add(await taskSnapshot.ref.getDownloadURL());
      }

      Get.back();
      Utils.showSnackBar('Upload Complete!', yes: true);
      return imageUrls;
    } on FirebaseException catch (e) {
      Get.back();
      Utils.showAlert(e.code, e.message.toString());
    } catch (e) {
      Get.back();
      Utils.normalDialog();
    }
    return null;
  }

  // ======================= events firestore ===================
  static uploadEventDataToFire(EventModel em) async {
    try {
      Utils.progressIndctr(label: 'updating');
      await fire.collection('events').doc(em.eid).set(em.toMap());

      Get.offAll(() => HomeScreen());
      Utils.showSnackBar('new event updated.', yes: true);
      //
    } on FirebaseException catch (e) {
      Get.back();
      Utils.showAlert(e.code, e.message.toString());
    } catch (e) {
      Get.back();
      Utils.normalDialog();
    }
  }
}
