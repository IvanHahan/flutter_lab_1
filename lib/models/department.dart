import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Department {
  Department({required this.name, required this.icon, required this.color})
      : id = uuid.v4();

  final String id;
  final String name;
  final IconData icon;
  final Color color;
}
