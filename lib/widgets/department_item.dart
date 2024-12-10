import 'package:flutter/material.dart';
import 'package:flutter_lab_1/models/department.dart';
import 'package:flutter_lab_1/providers/students_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DepartmentItem extends ConsumerWidget {
  const DepartmentItem({
    super.key,
    required this.department,
    required this.onSelectDepartment,
  });

  final Department department;
  final void Function() onSelectDepartment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentsProvider);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return InkWell(
      onTap: onSelectDepartment,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              department.color.withOpacity(0.55),
              department.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            department.name,
            style: textTheme.titleLarge!
                .copyWith(color: theme.colorScheme.primary),
          ),
          Row(
            children: [
              Text(
                'Students enrolled:',
                style: textTheme.titleSmall!
                    .copyWith(color: theme.colorScheme.secondary),
              ),
              const SizedBox(
                width: 8,
              ),
              (students == null)
                  ? SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator(strokeWidth: 2,),
                    )
                  : Text(
                      students
                          .where((s) => s.departmentId == department.id)
                          .length
                          .toString(),
                      style: textTheme.titleSmall!.copyWith(
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              const Spacer(),
              Icon(
                department.icon,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
