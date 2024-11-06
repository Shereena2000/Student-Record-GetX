import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_record/constants/const.dart';
import 'package:student_record/db/model/data.dart';

void viewDialoge(context, StudentData student) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Student Details',
                    style: TextStyle(color: tealColor, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: student.imagePath != null
                            ? Image.file(
                                File(student.imagePath!),
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/avathara.jpeg',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                      ),
                      sizedboxh10,
                      Text('Name: ${student.name}',
                          style: const TextStyle(fontSize: 16)),
                      sizedboxh10,
                      Text('Age: ${student.age}',
                          style: const TextStyle(fontSize: 16)),
                      sizedboxh10,
                      Text('Admission Number: ${student.admisstionNo}',
                          style: const TextStyle(fontSize: 16)),
                      sizedboxh10,
                      Text('Place: ${student.place}',
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
