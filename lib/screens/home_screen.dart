import 'package:flutter/material.dart';
import 'package:student_record/components/add_detailes.dart';
import 'package:student_record/components/student_grid_tile.dart';
import 'package:student_record/components/student_tile.dart';
import 'package:student_record/constants/const.dart';
import 'package:student_record/db/functions/add_to_hive.dart';
import 'package:student_record/db/model/data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isGridView = false;
  bool _isSearching = false;
  String _searchQuery = '';
  List<StudentData> _filterStudent(List<StudentData> students, String query) {
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: _isSearching
              ? TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: whiteColor),
                  onChanged: (value) {
                    setState(
                      () {
                        _searchQuery = value;
                      },
                    );
                  },
                )
              : AnimatedOpacity(
                  opacity: _isSearching ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: const Text(
                    'Student Records',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (_isSearching) {
                    _searchController.clear();
                    _searchQuery = '';
                  }
                  _isSearching = !_isSearching;
                });
              },
              icon: Icon(
                _isSearching ? Icons.close : Icons.search,
                color: whiteColor,
              ),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {
                setState(() {
                  _isGridView = !_isGridView;
                });
              },
              icon: Icon(
                  _isGridView ? Icons.view_list_outlined : Icons.grid_view,
                  color: whiteColor),
            ),
            sizedboxh10,
          ],
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
          child: ValueListenableBuilder(
              valueListenable: studentNotifier,
              builder: (context, List<StudentData> value, child) {
                final filteredStudent = _filterStudent(value, _searchQuery);
                if (filteredStudent.isEmpty) {
                  return const Center(
                    child: Text(
                      "STUDENT DATA IS EMPTY!!!",
                      style: TextStyle(
                          color: tealColor, fontWeight: FontWeight.bold),
                    ),
                  );
                }
                return !_isGridView
                    ? ListView.builder(
                        itemCount: filteredStudent.length,
                        itemBuilder: (BuildContext context, int index) {
                          return StudentTile(student: filteredStudent[index]);
                        })
                    : GridView.builder(
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
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
              }),
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
