import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_lab_1/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

const uuid = Uuid();

enum Gender { male, female }

const categoryIcons = {Gender.male: Icons.male, Gender.female: Icons.female};

class Student {
  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.departmentId,
    required this.gender,
    required this.grade,
  });

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

  static Future<List<Student>> remoteGetList() async {
    final url = Uri.https(baseUrl, "$studentsPath.json");

    final response = await http.get(
      url,
    );

    if (response.statusCode >= 400) {
      throw Exception("Failed to retrieve the data");
    }

    if (response.body == "null") {
      return [];
    }

    final Map<String, dynamic> data = json.decode(response.body);
    final List<Student> loadedItems = [];
    for (final item in data.entries) {
      loadedItems.add(
        Student(
          id: item.key,
          firstName: item.value['first_name']!,
          lastName: item.value['last_name']!,
          departmentId: item.value['department_id']!,
          gender: Gender.values.firstWhere((v) => v.toString() == item.value['gender']!),
          grade: item.value['grade']!,
        ),
      );
    }
    return loadedItems;
  }

  static Future<Student> remoteCreate(
    firstName,
    lastName,
    departmentId,
    gender,
    grade,
  ) async {
    final url = Uri.https(baseUrl, "$studentsPath.json");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'first_name': firstName!,
          'last_name': lastName,
          'department_id': departmentId,
          'gender': gender.toString(),
          'grade': grade,
        },
      ),
    );

    if (response.statusCode >= 400) {
      throw Exception("Couldn't create a student");
    }

    final Map<String, dynamic> resData = json.decode(response.body);

    return Student(
        id: resData['name'],
        firstName: firstName,
        lastName: lastName,
        departmentId: departmentId,
        gender: gender,
        grade: grade);
  }

  static Future remoteDelete(studentId) async {
    final url = Uri.https(baseUrl, "$studentsPath/$studentId.json");

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      throw Exception("Couldn't delete a student");
    }
  }

  static Future<Student> remoteUpdate(
    studentId,
    firstName,
    lastName,
    departmentId,
    gender,
    grade,
  ) async {
    final url = Uri.https(baseUrl, "$studentsPath/$studentId.json");

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'first_name': firstName!,
          'last_name': lastName,
          'department_id': departmentId,
          'gender': gender.toString(),
          'grade': grade,
        },
      ),
    );

    if (response.statusCode >= 400) {
      throw Exception("Couldn't update a student");
    }

    final Map<String, dynamic> resData = json.decode(response.body);

    return Student(
        id: studentId,
        firstName: firstName,
        lastName: lastName,
        departmentId: departmentId,
        gender: gender,
        grade: grade);
  }
}
