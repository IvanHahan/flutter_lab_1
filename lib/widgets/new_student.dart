import 'package:flutter_lab_1/models/student.dart';
import 'package:flutter/material.dart';

class NewStudent extends StatefulWidget {
  const NewStudent({super.key, required this.onAddExpense});

  final void Function(Student expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewStudentState();
  }
}

class _NewStudentState extends State<NewStudent> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _gradeController = TextEditingController();

  Gender _selectedGender = Gender.male;
  Department _selectedDepartment = Department.finance;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _gradeController.dispose();
    super.dispose();
  }

  void _sumbitStudent() {
    final entereGrade = int.tryParse(_gradeController.text);
    final gradeIsInValid = entereGrade == null || entereGrade <= 0;
    final firstNameIsInvalid = _firstNameController.text.trim().isEmpty;
    final lastNameIsInvalid = _lastNameController.text.trim().isEmpty;

    if (gradeIsInValid || firstNameIsInvalid || lastNameIsInvalid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('OK'))
          ],
        ),
      );

      return;
    }

    widget.onAddExpense(
      Student(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          department: _selectedDepartment,
          gender: _selectedGender,
          grade: entereGrade),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {

      final firstNameField = TextField(
        controller: _firstNameController,
        maxLength: 50,
        decoration: const InputDecoration(
          label: Text('First Name'),
        ),
      );
      final lastNameField = TextField(
        controller: _lastNameController,
        maxLength: 50,
        decoration: const InputDecoration(
          label: Text('Last Name'),
        ),
      );

      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            firstNameField,
            lastNameField,
            TextField(
              controller: _gradeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text('Grade'),
              ),
            ),
            DropdownButton(
                value: _selectedGender,
                items: Gender.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedGender = value;
                  });
                }),
            DropdownButton(
                value: _selectedDepartment,
                items: Department.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedDepartment = value;
                  });
                }),
                
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: _sumbitStudent,
                        child: const Text('Save Student')),
                  ],
                ),
          ],
        ),
      );
    });
  }
}
