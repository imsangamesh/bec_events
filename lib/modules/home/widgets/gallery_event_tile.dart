import 'package:demo_bec/core/widgets/my_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/my_colors.dart';
import '../../../core/themes/my_textstyles.dart';
import '../../../core/widgets/my_buttons.dart';
import '../event_details.dart';

class GalleryEventTile extends StatelessWidget {
  const GalleryEventTile(
    this.eventData, {
    Key? key,
  }) : super(key: key);

  final Map<String, dynamic> eventData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      constraints: BoxConstraints(maxHeight: size.height * 0.35),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            MyColors.pink.withAlpha(60),
            MyColors.orangePink.withAlpha(200),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ------------------------------------------ title
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: MyColors.pink.withAlpha(100),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(eventData['title'],
                          style: MyTStyles.kTS18Medium),
                    ),
                    const SizedBox(width: 5),
                    if (eventData['completed'])
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: const MyVideoPlayer('assets/completed.mp4'),
                        ),
                      ),
                  ],
                ),
              ),
              // ------------------------------------------ description
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 11, top: 7),
                child: Text(
                  '${eventData['description']}',
                  style: MyTStyles.kTS15Medium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              // ------------------------------------------ image stack
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                    itemCount: eventData['images'].length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(eventData['images'][index],
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            right: 2,
            bottom: 2,
            child: MyCloseBtn(
              icon: Icons.chevron_right,
              ontap: () => Get.to(() => EventDetails(eventData)),
            ),
          )
        ],
      ),
    );
  }
}
