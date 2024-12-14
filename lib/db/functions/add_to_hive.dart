import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_record/db/model/data.dart';

class AddStudentData extends GetxController {
  final studentList = <StudentData>[].obs;

  static Future<void> addToHive(student) async {
    try{
      final box = Hive.box<StudentData>('studentBox');
    final _id = await box.add(student);
    student.id = _id;
    await box.put(_id, student);
    final controller = Get.find<AddStudentData>();
    controller.studentList.add(student);
    } catch (e) {
      print("Error adding student: $e");
    }
  }

  static Future<void> getAllStudent() async {
   try{
     final controller = Get.find<AddStudentData>();
    controller.studentList.clear();

    final box = Hive.box<StudentData>('studentBox');
    controller.studentList.value = box.values.toList();
   }catch (e) {
      print("Error fetching students: $e");
    }
  }

  static Future<void> deletData(int id) async {
   try {
      final box = await Hive.openBox<StudentData>('studentBox');
    box.delete(id);
    getAllStudent();
   } catch (e) {
     print("Error deleting student: $e");
   }
  }

  static Future<void> updateData(StudentData student) async {
  try {
      final box = await Hive.openBox<StudentData>('studentBox');
    await box.put(student.id, student);
    getAllStudent();
  } catch (e) {
    print("Error updating student: $e");
  }
  }
}
