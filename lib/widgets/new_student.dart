import 'package:flutter_lab_1/models/department.dart';
import 'package:flutter_lab_1/models/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lab_1/providers/departments_provider.dart';
import 'package:flutter_lab_1/providers/students_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewStudent extends ConsumerStatefulWidget {
  const NewStudent({super.key, this.studentIndex});

  final int? studentIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _NewStudentState();
  }
}

class _NewStudentState extends ConsumerState<NewStudent> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _gradeController = TextEditingController();

  Gender _selectedGender = Gender.male;
  late Department _selectedDepartment;

  @override
  void initState() {
    super.initState();
    _selectedDepartment = ref.read(departmentsProvider)[0];
    if (widget.studentIndex != null) {
      final student = ref.read(studentsProvider)[widget.studentIndex!];
      _firstNameController.text = student.firstName;
      _lastNameController.text = student.lastName;
      _gradeController.text = student.grade.toString();
      _selectedGender = student.gender;
      _selectedDepartment = ref
          .read(departmentsProvider)
          .firstWhere((department) => department.id == student.departmentId);
    }
  }

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

    if (widget.studentIndex != null) {
      ref.read(studentsProvider.notifier).editStudent(
          Student(
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            departmentId: _selectedDepartment.id,
            gender: _selectedGender,
            grade: entereGrade,
          ),
          widget.studentIndex!);
    } else {
      ref.read(studentsProvider.notifier).addStudent(
            Student(
                firstName: _firstNameController.text.trim(),
                lastName: _lastNameController.text.trim(),
                departmentId: _selectedDepartment.id,
                gender: _selectedGender,
                grade: entereGrade),
          );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (ctx, constraints) {
      final firstNameField = TextField(
        controller: _firstNameController,
        maxLength: 50,
        decoration: const InputDecoration(
          label: Text('First Name'),
        ),
        style: theme.textTheme.titleLarge!.copyWith(color: theme.colorScheme.inversePrimary),
      );
      final lastNameField = TextField(
        controller: _lastNameController,
        maxLength: 50,
        decoration: const InputDecoration(
          label: Text('Last Name'),
        ),
        style: theme.textTheme.titleLarge!.copyWith(color: theme.colorScheme.inversePrimary),
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
              style: theme.textTheme.titleLarge!.copyWith(color: theme.colorScheme.inversePrimary),
              decoration: const InputDecoration(
                label: Text('Grade'),
              ),
            ),
            DropdownButton(
                value: _selectedGender,
                style: theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.inversePrimary),
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
                items: ref
                    .read(departmentsProvider)
                    .map(
                      (department) => DropdownMenuItem(
                          value: department,
                          child: Row(
                            children: [
                              Icon(department.icon),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                _selectedDepartment.name,
                                style: theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.inversePrimary),
                              )
                            ],
                          )),
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
