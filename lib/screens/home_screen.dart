import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_record/components/add_detailes.dart';
import 'package:student_record/components/student_grid_tile.dart';
import 'package:student_record/components/student_tile.dart';
import 'package:student_record/constants/const.dart';
import 'package:student_record/db/functions/add_to_hive.dart';
import 'package:student_record/db/model/data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddStudentData controller = Get.find<AddStudentData>();
    final TextEditingController searchController = TextEditingController();

    Rx<bool> isGridView = false.obs;
    Rx<bool> isSearching = false.obs;
    Rx<String> searchQuery = ''.obs;

    List<StudentData> filterStudent(List<StudentData> students, String query) {
      if (query.isEmpty) {
        return students;
      }
      return students.where(
        (student) {
          return student.name.toLowerCase().contains(query.toLowerCase()) ||
              student.admisstionNo.toLowerCase().contains(query.toLowerCase());
        },
      ).toList();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Obx(()=>isSearching.value
              ? TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: whiteColor),
                  onChanged: (value) {
                    searchQuery.value = value;
                  },
                )
              : AnimatedOpacity(
                  opacity: isSearching.value ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: const Text(
                    'Student Records',
                    style: TextStyle(color: Colors.white),
                  ),
                ),),
          actions: [
            Obx(()=>IconButton(
              onPressed: () {
                if (isSearching.value) {
                  searchController.clear();
                  searchQuery.value = '';
                }
                isSearching.value = !isSearching.value;
              },
              icon: Icon(
                isSearching.value ? Icons.close : Icons.search,
                color: whiteColor,
              ),
            ),),
            const SizedBox(width: 20),
           Obx(()=> IconButton(
              onPressed: () {
                isGridView.value= !isGridView.value;
              },
              icon: Icon(
                  isGridView.value ? Icons.view_list_outlined : Icons.grid_view,
                  color: whiteColor),
            ),),
            sizedboxh10,
          ],
          backgroundColor: Colors.teal,
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
            child: Obx(() {
              final filteredStudent =
                  filterStudent(controller.studentList, searchQuery.value);
              if (filteredStudent.isEmpty) {
                return const Center(
                  child: Text(
                    "STUDENT DATA IS EMPTY!!!",
                    style: TextStyle(
                        color: tealColor, fontWeight: FontWeight.bold),
                  ),
                );
              }
              return !isGridView.value
                  ? ListView.builder(
                      itemCount: filteredStudent.length,
                      itemBuilder: (BuildContext context, int index) {
                        return StudentTile(student: filteredStudent[index]);
                      })
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      ),
                      itemCount: filteredStudent.length,
                      itemBuilder: (BuildContext context, int index) {
                        return StudentGridTile(
                          student: filteredStudent[index],
                        );
                      },
                    );
            })
            // }),
            ),
        bottomNavigationBar: Container(
          height: 60.0,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0, right: 5, top: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    showAddStudentDialog(
                      context,
                    );
                  },
                  child: Icon(
                    Icons.add,
                    color: whiteColor,
                  ),
                  backgroundColor: Colors.teal,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
