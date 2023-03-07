import 'package:demo_bec/core/constants/my_constants.dart';
import 'package:demo_bec/core/themes/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/themes/my_textstyles.dart';

class AppliedRegistrations extends StatefulWidget {
  const AppliedRegistrations(this.docId, {super.key});

  final String docId;

  @override
  State<AppliedRegistrations> createState() => _AppliedRegistrationsState();
}

class _AppliedRegistrationsState extends State<AppliedRegistrations> {
  //
  int regCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrations made'),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: CircleAvatar(
              backgroundColor: MyColors.black,
              child: Text('$regCount', style: MyTStyles.kTS20Bold),
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: fire
            .collection('events')
            .doc(widget.docId)
            .collection('registrations')
            .snapshots(),
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
                      'currently there are no Registrations\nBe the first to register',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          Future.delayed(const Duration(milliseconds: 100)).then(
            (value) => setState(() {
              regCount = snapData.docs.length;
            }),
          );

          return Padding(
            padding: const EdgeInsets.all(15),
            child: ListView.builder(
              itemCount: snapData.docs.length,
              itemBuilder: (context, index) {
                final regData = snapData.docs[index].data();

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  color: Get.isDarkMode
                      ? MyColors.lightPurple.withAlpha(50)
                      : MyColors.pink.withAlpha(50),
                  child: ExpansionTile(
                    textColor: Colors.black,
                    // ---------------------------------- avatar
                    leading: CircleAvatar(
                      backgroundColor:
                          Get.isDarkMode ? MyColors.lightPurple : MyColors.pink,
                      child: Text(
                        regData['strength'].toString(),
                        style: MyTStyles.kTS20Bold.copyWith(
                          color: MyColors.black,
                        ),
                      ),
                    ),
                    title:
                        Text(regData['teamName'], style: MyTStyles.kTS18Medium),
                    backgroundColor:
                        Get.isDarkMode ? MyColors.lightPurple : MyColors.pink,
                    children: [
                      // ---------------------------------- leader
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        color: Get.isDarkMode
                            ? const Color.fromARGB(255, 64, 51, 72)
                            : const Color.fromARGB(255, 255, 193, 212),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.person),
                              title: Text(
                                regData['leader'],
                                style: MyTStyles.kTS15Medium,
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.email_outlined),
                              title: Text(
                                regData['email'],
                                style: MyTStyles.kTS15Medium,
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.call),
                              title: Text(
                                regData['phone'],
                                style: MyTStyles.kTS15Medium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
