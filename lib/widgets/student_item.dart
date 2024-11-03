import 'package:flutter/material.dart';
import 'package:flutter_lab_1/models/student.dart';

class StudentItem extends StatelessWidget {
  const StudentItem({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: student.gender == Gender.male ? Colors.blue : Colors.pink,
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
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(departmentIcons[student.department]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(student.grade.toString()),
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
