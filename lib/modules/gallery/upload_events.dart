import 'dart:developer';
import 'dart:io';

import 'package:demo_bec/core/themes/my_textstyles.dart';
import 'package:demo_bec/core/widgets/my_buttons.dart';
import 'package:demo_bec/modules/gallery/upload_controller.dart';
import 'package:demo_bec/utilities/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';

import '../../core/themes/my_colors.dart';
import '../../models/eventModel.dart';

class UploadEvents extends StatefulWidget {
  const UploadEvents(this.evm, {Key? key}) : super(key: key);

  final EventModel evm;

  @override
  State<UploadEvents> createState() => _UploadEventsState();
}

class _UploadEventsState extends State<UploadEvents> {
  //
  List<PlatformFile> imageList = [];

  pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      allowCompression: true,
    );
    if (result == null) {
      Utils.showSnackBar('you didn\'t pick any images', yes: false);
      return;
    }
    setState(() => imageList = result.files);
  }

  uploadImages() async {
    List? imageUrls = await UploadController.uploadNewEventImagesToCloud(
      widget.evm.eid!,
      imageList,
    );

    if (imageUrls == null) return;

    UploadController.uploadEventDataToFire(EventModel(
      eid: widget.evm.eid,
      title: widget.evm.title,
      startDate: widget.evm.startDate,
      endDate: widget.evm.endDate,
      noOfTeams: widget.evm.noOfTeams,
      images: imageUrls,
      description: widget.evm.description,
      completed: widget.evm.completed,
      category: widget.evm.category,
    ));
  }

  popImageFromList(PlatformFile value) {
    imageList.remove(value);
    setState(() {});
    log(imageList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Event Pics')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(children: [
            const SizedBox(height: 10),
            Text(
              'It\'s Image time!',
              style: GoogleFonts.berkshireSwash(
                textStyle: MyTStyles.kTS24Bold,
                color: MyColors.interPink,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'please choose all of the Event images at once to upload.',
              style: MyTStyles.kTS15Medium,
            ),

            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: pickImages,
              icon: const Icon(Icons.add_photo_alternate_rounded),
              label: const Text(' Pick Images '),
            ),
            const SizedBox(height: 30),
            //
            if (imageList.isNotEmpty) ...[
              const Text(
                'your selected images : ',
                style: MyTStyles.kTS15Medium,
              ),
              const SizedBox(height: 10),
              Wrap(
                children: imageList
                    .map((eachPlatFile) => EventImage(
                          eachPlatFile,
                          imageList,
                          popImageFromList,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: uploadImages,
                child: const Text(' Upload '),
              ),
            ]
          ]),
        ),
      ),
    );
  }
}

class EventImage extends StatelessWidget {
  const EventImage(
    this.image,
    this.imageList,
    this.removeFunction, {
    Key? key,
  }) : super(key: key);

  final PlatformFile image;
  final List<PlatformFile> imageList;
  final dynamic removeFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => OpenFile.open(image.path!),
      child: Container(
        height: 100,
        width: 100,
        margin: const EdgeInsets.all(4),
        child: Stack(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(File(image.path!), fit: BoxFit.cover),
              ),
            ),
            Positioned(
              top: 2,
              right: 2,
              child: SizedBox(
                height: 25,
                child: MyCloseBtn(ontap: () => removeFunction(image)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
