import 'package:flutter/material.dart';
import 'package:flutter_lab_1/models/student.dart';
import 'package:flutter_lab_1/widgets/new_student.dart';
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

  void _addStudent(Student expense) {
    setState(() {
      _students.add(expense);
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewStudent(onAddExpense: _addStudent));
  }

  void _removeStudent(Student student) {
    final studentIndex = _students.indexOf(student);
    setState(() {
      _students.remove(student);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _students.insert(studentIndex, student);
              });
            }),
      ),
    );
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Students'),
          actions: [
            IconButton(
                onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
          ],
        ),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) => Dismissible(
                key: ValueKey(_students[index]),
                background: Container(
                  color: Theme.of(context).colorScheme.error.withOpacity(0.75),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                ),
                onDismissed: (direction) {
                  _removeStudent(_students[index]);
                },
                child: StudentItem(student: _students[index]),
              ),
            ),
          ),
        ]));
  }
}
