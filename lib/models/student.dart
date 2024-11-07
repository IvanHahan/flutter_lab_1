import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Gender { male, female }
enum Department { finance, law, it, medical }

const categoryIcons = {
  Gender.male: Icons.male,
  Gender.female: Icons.female
};

const departmentIcons = {
  Department.finance: Icons.money,
  Department.medical: Icons.medical_information,
  Department.law: Icons.business,
  Department.it: Icons.computer
};

class Student {
  Student({
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.gender,
    required this.grade
  }) : id = uuid.v4();

  Student.withId({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.gender,
    required this.grade
  });

  final String id;
  final String firstName;
  final String lastName;
  final Department department;
  final Gender gender;
  final int grade;

}
