import 'package:flutter/material.dart';
import 'package:flutter_lab_1/models/student.dart';
import 'package:flutter_lab_1/widgets/student_item.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Students> {
  final List<Student> _students = [
    Student(
      firstName: "John",
      lastName: "Dow",
      gender: Gender.male,
      department: Department.it,
      grade: 5,
    ),
    Student(
      firstName: "Alice",
      lastName: "Cooper",
      gender: Gender.female,
      department: Department.law,
      grade: 3,
    ),
    Student(
      firstName: "Cassie",
      lastName: "Williams",
      gender: Gender.female,
      department: Department.finance,
      grade: 5,
    ),
    Student(
      firstName: "Johnny",
      lastName: "Depp",
      gender: Gender.male,
      department: Department.medical,
      grade: 8,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Students'),
        ),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) =>
                  StudentItem(student: _students[index]),
            ),
          ),
        ]));
  }
}
