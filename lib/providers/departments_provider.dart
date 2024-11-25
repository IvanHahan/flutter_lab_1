import 'package:flutter/material.dart';
import 'package:flutter_lab_1/models/department.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final departmentsProvider = Provider((ref) {
  return [
    Department(name: 'Computer Engineering', icon: Icons.computer, color: const Color.fromARGB(31, 4, 106, 195)),
    Department(name: 'Computer Science', icon: Icons.science, color: const Color.fromARGB(31, 4, 163, 195)),
    Department(name: 'Cybersecurity', icon: Icons.security, color: const Color.fromARGB(31, 106, 4, 195)),
    Department(name: 'Artificial Inteligence', icon: Icons.smart_toy, color: const Color.fromARGB(31, 179, 4, 195)),
  ];
});