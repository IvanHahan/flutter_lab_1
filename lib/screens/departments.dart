import 'package:flutter/material.dart';
import 'package:flutter_lab_1/providers/departments_provider.dart';
import 'package:flutter_lab_1/widgets/department_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DepartmentsScreen extends ConsumerWidget {
  const DepartmentsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final departments = ref.watch(departmentsProvider);
    return GridView(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.5 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            for (final department in departments)
              DepartmentItem(
                department: department,
                onSelectDepartment: () {
                },
              )
          ],
        );
  }
}
