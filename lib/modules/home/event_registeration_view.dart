import 'package:demo_bec/core/constants/my_constants.dart';
import 'package:demo_bec/utilities/textfield_wrapper.dart';
import 'package:demo_bec/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:demo_bec/core/themes/my_colors.dart';
import 'package:demo_bec/core/themes/my_textstyles.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EventRegisterationView extends StatelessWidget {
  EventRegisterationView(this.eventData, {super.key});
  //
  final Map<String, dynamic> eventData;

  final teamNameCntrl = TextEditingController();
  final leaderNameCntrl = TextEditingController();
  final emailCntrl = TextEditingController();
  final phoneCntrl = TextEditingController();

  final count = 'team Strength   '.obs;
  final counts = ['team Strength   ', '1', '2', '3', '4'];

  submitForm(BuildContext context) {
    FocusScope.of(context).unfocus();

    // -------------------------------- empty fields
    if (teamNameCntrl.text.trim() == '' ||
        leaderNameCntrl.text.trim() == '' ||
        emailCntrl.text.trim() == '' ||
        phoneCntrl.text.trim() == '' ||
        count.value == 'team Strength   ') {
      Utils.showAlert(
        'Alert!',
        'please fill all the fields before submiting the form',
      );
      return;
    }

    // -------------------------------- email
    if (!emailCntrl.text.contains('@') || !emailCntrl.text.contains('.')) {
      Utils.showAlert(
        'Alert!',
        'please enter the valid email address.',
      );
      return;
    }

    // -------------------------------- phone
    if (phoneCntrl.text.length != 10 || int.tryParse(phoneCntrl.text) == null) {
      Utils.showAlert(
        'Alert!',
        'please enter the valid mobile number.',
      );
      return;
    }

    uploadDataToFirestore();
  }

  uploadDataToFirestore() async {
    try {
      Utils.progressIndctr(label: 'updating...');

      fire
          .collection('events')
          .doc(eventData['eid'])
          .collection('registrations')
          .doc()
          .set({
        'teamName': teamNameCntrl.text,
        'leader': leaderNameCntrl.text,
        'email': emailCntrl.text,
        'phone': phoneCntrl.text,
        'strength': count.value,
      });

      Get.back();

      teamNameCntrl.clear();
      leaderNameCntrl.clear();
      emailCntrl.clear();
      phoneCntrl.clear();

      Utils.showSnackBar('Hurray! registration successful');
    } catch (e) {
      Get.back();
      Utils.normalDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(eventData['title'])),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              'Tell us about your Team:',
              style: GoogleFonts.berkshireSwash(
                textStyle: MyTStyles.kTS20Bold,
                color: MyColors.interPink,
              ),
            ),
            const SizedBox(height: 12),
            // -------------------------------------- team name
            TextFieldWrapper(
              TextField(
                controller: teamNameCntrl,
                style: MyTStyles.kTS20Medium.copyWith(
                  color: Get.isDarkMode ? MyColors.white : MyColors.black,
                ),
                decoration: const InputDecoration.collapsed(
                  hintText: 'What\'s your team name:',
                  hintStyle: MyTStyles.kTS15Medium,
                ),
              ),
              Icons.short_text,
            ),
            // -------------------------------------- leader name
            TextFieldWrapper(
              TextField(
                controller: leaderNameCntrl,
                style: MyTStyles.kTS20Medium.copyWith(
                  color: Get.isDarkMode ? MyColors.white : MyColors.black,
                ),
                decoration: const InputDecoration.collapsed(
                  hintText: 'Who\'s leading the team:',
                  hintStyle: MyTStyles.kTS15Medium,
                ),
              ),
              Icons.person,
            ),
            // -------------------------------------- email
            TextFieldWrapper(
              TextField(
                controller: emailCntrl,
                style: MyTStyles.kTS20Medium.copyWith(
                  color: Get.isDarkMode ? MyColors.white : MyColors.black,
                ),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration.collapsed(
                  hintText: 'email for your team:',
                  hintStyle: MyTStyles.kTS15Medium,
                ),
              ),
              Icons.email,
            ),
            // -------------------------------------- phone
            TextFieldWrapper(
              TextField(
                controller: phoneCntrl,
                style: MyTStyles.kTS20Medium.copyWith(
                  color: Get.isDarkMode ? MyColors.white : MyColors.black,
                ),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Number to contact:',
                  hintStyle: MyTStyles.kTS15Medium,
                ),
              ),
              Icons.call,
            ),

            Obx(
              () => Container(
                padding: const EdgeInsets.only(left: 15, right: 10),
                decoration: BoxDecoration(
                  color:
                      Get.isDarkMode ? MyColors.darkPurple : MyColors.lightPink,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButton<String>(
                  dropdownColor: Get.isDarkMode
                      ? MyColors.lightPurple
                      : MyColors.lightPink,
                  underline: const Divider(color: Colors.transparent),
                  value: count.value,
                  items: counts
                      .map((String items) => DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: MyTStyles.kTS14Medium.copyWith(
                                color: Get.isDarkMode
                                    ? MyColors.white
                                    : MyColors.black,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    count(newValue);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => submitForm(context),
        label: const Text('    Submit Team  >   ', style: MyTStyles.kTS14Bold),
      ),
    );
  }
}
