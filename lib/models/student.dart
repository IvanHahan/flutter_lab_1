import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Gender { male, female }

const categoryIcons = {Gender.male: Icons.male, Gender.female: Icons.female};


class Student {
  Student(
      {required this.firstName,
      required this.lastName,
      required this.departmentId,
      required this.gender,
      required this.grade})
      : id = uuid.v4();

  Student.withId(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.departmentId,
      required this.gender,
      required this.grade});

  final String id;
  final String firstName;
  final String lastName;
  final String departmentId;
  final Gender gender;
  final int grade;

  Student copyWith(firstName, lastName, departmentId, gender, grader) {
    return Student.withId(
        id: id,
        firstName: firstName,
        lastName: lastName,
        departmentId: departmentId,
        gender: gender,
        grade: grade);
  }
}
