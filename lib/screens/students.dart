import 'package:flutter/material.dart';
import 'package:flutter_lab_1/providers/students_provider.dart';
import 'package:flutter_lab_1/widgets/new_student.dart';
import 'package:flutter_lab_1/widgets/student_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentsScreen extends ConsumerWidget {
  const StudentsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentsProvider);
    Widget mainContent = Center(
      child: CircularProgressIndicator(),
    );

    if (students != null) {
      mainContent = ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(students[index]),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          onDismissed: (direction) {
            final studentToDelete = students[index];
            final notifier = ref.read(studentsProvider.notifier);
            notifier.removeStudent(studentToDelete);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 3),
                content: const Text('Student deleted'),
                action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      notifier.insertStudent(studentToDelete, index);
                    }),
              ),
            );
          },
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (ctx) => NewStudent(
                        studentIndex: index,
                      ));
            },
            child: StudentItem(student: students[index]),
          ),
        ),
      );
    }

    return mainContent;
  }
}
