import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? eid;
  String? title;
  String? startDate;
  String? endDate;
  List? images;
  String? noOfTeams;
  String? description;
  String? category;
  bool? completed;

  EventModel({
    required this.eid,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.images,
    required this.description,
    required this.noOfTeams,
    required this.completed,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'eid': eid,
      'title': title,
      'startDate': startDate,
      'endDate': endDate,
      'images': images,
      'noOfTeams': noOfTeams,
      'description': description,
      'completed': completed,
      'category': category,
    };
  }

  static EventModel fromSnapShot(DocumentSnapshot snapshot) {
    final snapData = snapshot.data() as Map<String, dynamic>;

    return EventModel(
      eid: snapData['eid'],
      title: snapData['title'],
      startDate: snapData['startDate'],
      endDate: snapData['endDate'],
      noOfTeams: snapData['noOfTeams'],
      images: snapData['images'],
      description: snapData['description'],
      completed: snapData['completed'],
      category: snapData['category'],
    );
  }

  EventModel.fromMap(Map<String, dynamic> map) {
    eid = map['eid'];
    title = map['title'];
    startDate = map['startDate'];
    endDate = map['endDate'];
    images = map['images'];
    noOfTeams = map['noOfTeams'];
    description = map['description'];
    completed = map['completed'];
    category = map['category'];
  }
}
