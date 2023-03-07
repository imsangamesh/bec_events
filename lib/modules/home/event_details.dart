import 'package:demo_bec/core/themes/my_colors.dart';
import 'package:demo_bec/core/themes/my_textstyles.dart';
import 'package:demo_bec/modules/home/event_registeration_view.dart';
import 'package:demo_bec/modules/home/applitd_registrations.dart';
import 'package:demo_bec/modules/home/widgets/event_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatelessWidget {
  const EventDetails(this.eventData, {Key? key}) : super(key: key);

  final Map<String, dynamic> eventData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text(eventData['title']), centerTitle: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!eventData['completed'])
              InkWell(
                onTap: () => Get.to(() => EventRegisterationView(eventData)),
                child: Ink(
                  height: 30,
                  color: MyColors.darkPink,
                  child: Center(
                    child: Text(
                      'Click here to Register!',
                      style:
                          MyTStyles.kTS15Medium.copyWith(color: MyColors.wheat),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 10),
            // ----------------------------------- start date
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 30,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 5, bottom: 5, left: 10),
                      decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? MyColors.lightPurple
                            : MyColors.pink,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Start Date: ',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.clip,
                        style: MyTStyles.kTS16Medium,
                      ),
                    ),
                    Container(
                      height: 28,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Get.isDarkMode
                              ? MyColors.lightPurple
                              : MyColors.pink,
                        ),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '  ${DateFormat.yMMMMEEEEd().format(DateTime.parse(eventData['startDate']))}   ',
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: MyTStyles.kTS14Medium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            // ----------------------------------- end date
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 30,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 5, bottom: 5, left: 10),
                      decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? MyColors.lightPurple
                            : MyColors.pink,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'End Date: ',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.clip,
                        style: MyTStyles.kTS16Medium,
                      ),
                    ),
                    Container(
                      height: 28,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Get.isDarkMode
                              ? MyColors.lightPurple
                              : MyColors.pink,
                        ),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '  ${DateFormat.yMMMMEEEEd().format(DateTime.parse(eventData['endDate']))}   ',
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: MyTStyles.kTS14Medium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            // ----------------------------------- Category
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 30,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 10),
                          decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? MyColors.lightPurple
                                : MyColors.pink,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'Category: ',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                            style: MyTStyles.kTS16Medium,
                          ),
                        ),
                        Container(
                          height: 28,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Get.isDarkMode
                                  ? MyColors.lightPurple
                                  : MyColors.pink,
                            ),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '   ${eventData['category']}   ',
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                              style: MyTStyles.kTS14Medium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 30,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 10),
                          decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? MyColors.lightPurple
                                : MyColors.pink,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'Teams: ',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                            style: MyTStyles.kTS16Medium,
                          ),
                        ),
                        Container(
                          height: 28,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Get.isDarkMode
                                  ? MyColors.lightPurple
                                  : MyColors.pink,
                            ),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              eventData['noOfTeams'] == ''
                                  ? '   0   '
                                  : '   ${eventData['noOfTeams']}   ',
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                              style: MyTStyles.kTS14Medium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // ----------------------------------- registrations made
            if (!eventData['completed'])
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: ListTile(
                  onTap: () => Get.to(
                    () => AppliedRegistrations(eventData['eid']),
                  ),
                  tileColor: Get.isDarkMode
                      ? MyColors.lightPurple.withAlpha(150)
                      : MyColors.pink.withAlpha(100),
                  title: Text(
                    'Check out the Registrations here',
                    style: MyTStyles.kTS16Medium
                        .copyWith(color: MyColors.darkScaffoldBG),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_double_arrow_right_rounded,
                  ),
                ),
              ),
            // ----------------------------------- title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        top: 6, bottom: 6, left: 10, right: 11),
                    decoration: BoxDecoration(
                      color:
                          Get.isDarkMode ? MyColors.lightPurple : MyColors.pink,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Title',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                      style: MyTStyles.kTS16Medium,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Get.isDarkMode
                            ? MyColors.lightPurple
                            : MyColors.pink,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    child: Text(
                      eventData['title'],
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                      style: MyTStyles.kTS16Medium,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            // ----------------------------------- description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        top: 6, bottom: 6, left: 10, right: 11),
                    decoration: BoxDecoration(
                      color:
                          Get.isDarkMode ? MyColors.lightPurple : MyColors.pink,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'More about the Event',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                      style: MyTStyles.kTS16Medium,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Get.isDarkMode
                            ? MyColors.lightPurple
                            : MyColors.pink,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    child: Text(
                      eventData['description'],
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                      style: MyTStyles.kTS16Medium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // ----------------------------------- image Slider
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: Get.isDarkMode
                  ? MyColors.lightPurple.withAlpha(100)
                  : MyColors.pink.withAlpha(100),
              child: MyEventSlider(eventData),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(
          () => AllGalleryImagesView(eventData['images']),
        ),
        label: const Text('Show all Images>', style: MyTStyles.kTS14Bold),
      ),
    );
  }
}

class AllGalleryImagesView extends StatelessWidget {
  const AllGalleryImagesView(this.images, {super.key});

  final List images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Memories Together!')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => Get.to(() => GalleryImageViewer(images[index])),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(images[index], fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }
}

class GalleryImageViewer extends StatelessWidget {
  const GalleryImageViewer(this.imageUrl, {super.key});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl);
  }
}
