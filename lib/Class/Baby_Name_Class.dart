import 'package:cloud_firestore/cloud_firestore.dart';

class BabyName {
  String name;
  String meaning;
  String gender;
  String rashi;
  String religion;
  bool isLike;

  BabyName({
    required this.name,
    required this.meaning,
    required this.gender,
    required this.rashi,
    required this.religion,
    this.isLike = false,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "meaning": meaning,
    "gender": gender,
    "rashi": rashi,
    "religion": religion,
    "isLike": isLike,
  };

  factory BabyName.fromMap(Map<String, dynamic> json) => BabyName(
    name: json["name"] ?? '',
    meaning: json["meaning"] ?? '',
    gender: json["gender"] ?? '',
    rashi: json["rashi"] ?? '',
    religion: json["religion"] ?? '',
    isLike: json["isLike"] != null ? json["isLike"].toString().toLowerCase() == 'true' : false,
  );

  factory BabyName.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return BabyName(
      name: data['name'] ?? '',
      meaning: data['meaning'] ?? '',
      gender: data['gender'] ?? '',
      rashi: data['rashi'] ?? '',
      religion: data['religion'] ?? '',
      isLike: data['isLike'] != null ? data['isLike'].toString().toLowerCase() == 'true' : false,
    );
  }
}