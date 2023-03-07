import 'package:demo_bec/core/themes/my_colors.dart';
import 'package:demo_bec/core/themes/my_textstyles.dart';
import 'package:demo_bec/modules/gallery/upload_events.dart';
import 'package:demo_bec/utilities/textfield_wrapper.dart';
import 'package:demo_bec/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../models/eventModel.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  //
  final _titleCntr = TextEditingController();
  final _descCntr = TextEditingController();
  final _newEventCntrl = TextEditingController();

  DateTime? _startDateCntr;
  DateTime? _endDateCntr;

  final eventCategories = ['technical', 'sports', 'cultural'].obs;
  final currentCategory = 'technical'.obs;

  final isEventCompleted = false.obs;

  passData() {
    FocusScope.of(context).unfocus();

    if (_titleCntr.text.trim() == '' ||
        _descCntr.text.trim() == '' ||
        _startDateCntr == null ||
        _endDateCntr == null) {
      Utils.showAlert(
        'Oops',
        'please fill out all the fields, then select date and then submit.',
      );
      return;
    }
    Get.to(
      () => UploadEvents(EventModel(
        eid: '${_titleCntr.text} ~~~ ${_startDateCntr!.toIso8601String()}',
        title: _titleCntr.text.trim(),
        description: _descCntr.text.trim(),
        startDate: _startDateCntr!.toIso8601String(),
        endDate: _endDateCntr!.toIso8601String(),
        images: [],
        completed: isEventCompleted.value,
        category: currentCategory.value,
        noOfTeams: noOfTeams.toString(),
      )),
    );
  }

  addNewCategory() {
    if (_newEventCntrl.text.trim() == '') {
      Utils.showAlert('Oops', 'please enter the category name to add.');
      return;
    }

    if (eventCategories.contains(_newEventCntrl.text.trim())) {
      Utils.showAlert('Hey!', 'this category is already in the list.');
    }

    eventCategories.add(_newEventCntrl.text.trim());
    _newEventCntrl.clear();
    Utils.showSnackBar('New category added', yes: true);
  }

  List<int> noOfTeamsList() {
    return List.generate(91, (index) => index + 10);
  }

  final noOfTeams = 10.obs;

  @override
  void dispose() {
    _descCntr.dispose();
    _titleCntr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Gallery Events')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tell us about your event:',
                style: GoogleFonts.berkshireSwash(
                  textStyle: MyTStyles.kTS20Bold,
                  color: MyColors.interPink,
                ),
              ),
              const SizedBox(height: 20),
              // ---------------------------------------- title
              TextFieldWrapper(
                TextField(
                  controller: _titleCntr,
                  style: MyTStyles.kTS20Medium.copyWith(
                    color: Get.isDarkMode ? MyColors.white : MyColors.black,
                  ),
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Title of event:',
                    hintStyle: MyTStyles.kTS15Medium,
                  ),
                ),
                Icons.short_text,
              ),
              // ---------------------------------------- description
              TextFieldWrapper(
                TextField(
                  controller: _descCntr,
                  maxLines: 10,
                  style: MyTStyles.kTS20Medium.copyWith(
                    color: Get.isDarkMode ? MyColors.white : MyColors.black,
                  ),
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Elaborate your event:',
                    hintStyle: MyTStyles.kTS15Medium,
                  ),
                ),
                Icons.notes_rounded,
              ),

              // ---------------------------------------- check box
              Obx(
                () => CheckboxListTile(
                  tileColor:
                      Get.isDarkMode ? MyColors.darkPurple : MyColors.lightPink,
                  value: isEventCompleted.value,
                  activeColor: MyColors.interPink,
                  onChanged: (value) => isEventCompleted(value),
                  title: const Text(
                    'Is event already conducted?',
                    style: MyTStyles.kTS16Medium,
                  ),
                ),
              ),

              const SizedBox(height: 15),
              // ---------------------------------------- category btn
              Obx(
                () => ListTile(
                  tileColor: MyColors.darkPurple,
                  title: const Text(
                    'Maximum no of Teams allowed: ',
                    style: MyTStyles.kTS16Medium,
                  ),
                  trailing: Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? MyColors.darkPurple
                          : MyColors.lightPink,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: DropdownButton<int>(
                      dropdownColor: Get.isDarkMode
                          ? MyColors.lightPurple
                          : MyColors.lightPink,
                      underline: const Divider(color: Colors.transparent),
                      value: noOfTeams.value,
                      items: noOfTeamsList()
                          .map((int items) => DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items.toString(),
                                  style: MyTStyles.kTS14Medium.copyWith(
                                    color: Get.isDarkMode
                                        ? MyColors.white
                                        : MyColors.black,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (int? newValue) {
                        noOfTeams(newValue);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // ----------------------------------------  date picker
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => startDatePicker(context),
                    icon: const Icon(Icons.date_range, size: 19),
                    label: Text(_startDateCntr == null
                        ? '  Start Date'
                        : '  ${DateFormat.yMMMd().format(_startDateCntr!)}'),
                  ),
                  const Spacer(),
                  const Text('- to -'),
                  const Spacer(),
                  OutlinedButton.icon(
                    onPressed: () => endDatePicker(context),
                    icon: const Icon(Icons.date_range, size: 19),
                    label: Text(_endDateCntr == null
                        ? '  End Date'
                        : '  ${DateFormat.yMMMd().format(_endDateCntr!)}'),
                  ),
                ],
              ),

              const SizedBox(height: 15),
              // ---------------------------------------- add category
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Container(
                      height: 50,
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? MyColors.darkPurple
                            : MyColors.lightPink,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButton<String>(
                        dropdownColor: Get.isDarkMode
                            ? MyColors.lightPurple
                            : MyColors.lightPink,
                        underline: const Divider(color: Colors.transparent),
                        value: currentCategory.value,
                        items: eventCategories
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
                          currentCategory(newValue);
                        },
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: size.width * 0.55,
                    child: Column(
                      children: [
                        TextFieldWrapper(
                          TextField(
                            controller: _newEventCntrl,
                            style: MyTStyles.kTS20Medium.copyWith(
                              color: Get.isDarkMode
                                  ? MyColors.white
                                  : MyColors.black,
                            ),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'your Category:',
                              hintStyle: MyTStyles.kTS15Medium,
                            ),
                          ),
                          Icons.short_text,
                        ),
                        // ---------------------------------------- category btn
                        InkWell(
                          onTap: addNewCategory,
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Get.isDarkMode
                                  ? MyColors.lightPurple.withAlpha(100)
                                  : MyColors.lightPink.withAlpha(100),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 7),
                            child: const Text('Add category'),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              const SizedBox(height: 150),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: passData,
        label: const Text('Next >', style: MyTStyles.kTS14Bold),
      ),
    );
  }

  void startDatePicker(context) {
    FocusScope.of(context).unfocus();
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1000)),
      lastDate: DateTime.now().add(const Duration(days: 1000)),
    ).then((selectedDate) {
      if (selectedDate == null) {
        Utils.showSnackBar('please select date');
        return;
      }
      setState(() => _startDateCntr = selectedDate);
    });
  }

  void endDatePicker(context) {
    FocusScope.of(context).unfocus();
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1000)),
      lastDate: DateTime.now().add(const Duration(days: 1000)),
    ).then((selectedDate) {
      if (selectedDate == null) {
        Utils.showSnackBar('please select date');
        return;
      }
      setState(() => _endDateCntr = selectedDate);
    });
  }
}
