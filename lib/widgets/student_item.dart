import 'package:flutter/material.dart';
import 'package:flutter_lab_1/models/student.dart';
import 'package:flutter_lab_1/providers/departments_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentItem extends ConsumerWidget {
  const StudentItem({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final department = ref
        .watch(departmentsProvider)
        .firstWhere((d) => d.id == student.departmentId);
    final theme = Theme.of(context);
    return Card(
      color: student.gender == Gender.male ? const Color.fromARGB(255, 21, 67, 104) : const Color.fromARGB(255, 104, 31, 55),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "${student.firstName} ${student.lastName}",
                  style: theme.textTheme.titleLarge!
                      .copyWith(color: theme.colorScheme.primary),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      department.icon,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(student.grade.toString(),
                        style: theme.textTheme.titleSmall!
                            .copyWith(color: theme.colorScheme.primary)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
