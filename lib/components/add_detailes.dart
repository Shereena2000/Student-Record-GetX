import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_record/constants/const.dart';
import 'package:student_record/db/functions/add_to_hive.dart';
import 'package:student_record/db/model/data.dart';

void showAddStudentDialog(BuildContext context, {StudentData? student}) {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: student?.name ?? '');
  final ageController = TextEditingController(text: student?.age ?? '');
  final placeController = TextEditingController(text: student?.place ?? '');
  final admissionNoController =
      TextEditingController(text: student?.admisstionNo ?? '');
  final ImagePicker _picker = ImagePicker();
  XFile? _image =
      student?.imagePath != null ? XFile(student!.imagePath!) : null;
  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _image = pickedImage;
    }
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      final screenSize = MediaQuery.of(context).size;
      return AlertDialog(
        backgroundColor: Colors.teal,
        title: Text(
          student == null ? 'ADD STUDENT' : 'EDIT STUDENT',
          style: const TextStyle(color: whiteColor),
        ),
        content: SingleChildScrollView(
          child: Container(
            width: screenSize.width * 0.7,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        child: _image == null && student?.imagePath == null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(45),
                                child: Image.asset(
                                  "assets/images/add.jpeg",
                                  fit: BoxFit.cover,
                                ),
                              )
                            : student?.imagePath != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(45),
                                    child:
                                        Image.file(File(student!.imagePath!)),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(45),
                                    child: Image.file(
                                      File(_image!.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                      ),
                      Positioned(
                          bottom: -4,
                          right: -2,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                              ),
                            ),
                          ))
                    ],
                  ),
                  sizedboxh10,
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: student?.name ?? 'Enter Name',
                      enabledBorder: customBorder,
                      filled: true,
                      fillColor: whiteColor,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Name';
                      }
                      return null;
                    },
                  ),
                  sizedboxh10,
                  TextFormField(
                    controller: ageController,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      hintText: student?.age ?? 'Enter Age',
                      enabledBorder: customBorder,
                      filled: true,
                      fillColor: whiteColor,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Age';
                      }
                      return null;
                    },
                  ),
                  sizedboxh10,
                  TextFormField(
                    controller: placeController,
                    decoration: InputDecoration(
                      labelText: 'Place',
                      hintText: student?.place ?? 'Enter Place',
                      enabledBorder: customBorder,
                      filled: true,
                      fillColor: whiteColor,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Place';
                      }
                      return null;
                    },
                  ),
                  sizedboxh10,
                  TextFormField(
                    controller: admissionNoController,
                    decoration: InputDecoration(
                      labelText: 'Admission Number',
                      hintText:
                          student?.admisstionNo ?? 'Enter Admission Number',
                      enabledBorder: customBorder,
                      filled: true,
                      fillColor: whiteColor,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Admission Number';
                      }
                      return null;
                    },
                  ),
                  sizedboxh10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (student == null) {
                              StudentData student = StudentData(
                                  name: nameController.text,
                                  age: ageController.text,
                                  place: placeController.text,
                                  admisstionNo: admissionNoController.text,
                                  imagePath: _image?.path);

                              AddStudentData.addToHive(student);
                            } else {
                              student.name = nameController.text;
                              student.age = ageController.text;
                              student.place = placeController.text;
                              student.admisstionNo = admissionNoController.text;
                              student.imagePath = _image?.path;
                              AddStudentData.updateData(student);
                            }
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Save'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
