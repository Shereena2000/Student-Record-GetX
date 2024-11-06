import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_record/db/model/data.dart';

final ValueNotifier<List<StudentData>> studentNotifier = ValueNotifier([]);

class AddStudentData extends ChangeNotifier {
  static Future<void> addToHive(student) async {
    final box = Hive.box<StudentData>('studentBox');
    final _id = await box.add(student);
    student.id = _id;
    await box.put(_id, student);
    studentNotifier.value.add(student);
    studentNotifier.notifyListeners();
  }

  static Future<void> getAllStudent() async {
    studentNotifier.value.clear();
    final box = Hive.box<StudentData>('studentBox');
    studentNotifier.value.addAll(box.values);
    studentNotifier.notifyListeners();
  }

  static Future<void> deletData(int id) async {
    final box = await Hive.openBox<StudentData>('studentBox');
    box.delete(id);
    getAllStudent();
  }

  static Future<void> updateData(StudentData student) async {
    final box = await Hive.openBox<StudentData>('studentBox');
    await box.put(student.id, student);
    
    getAllStudent();

  }
}
