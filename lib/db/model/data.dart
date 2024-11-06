import 'package:hive_flutter/adapters.dart';
part 'data.g.dart';

@HiveType(typeId: 1)
class StudentData {
  @HiveField(0)
  String name;
  @HiveField(1)
  String age;
  @HiveField(2)
  String place;
  @HiveField(3)
  String admisstionNo;
  @HiveField(4)
  int? id;
  @HiveField(5)
  String? imagePath;
  StudentData(
      {required this.name,
      required this.age,
      required this.place,
      required this.admisstionNo,
      this.id,
      this.imagePath});
}
