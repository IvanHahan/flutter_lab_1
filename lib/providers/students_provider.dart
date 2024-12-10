import 'package:flutter_lab_1/providers/departments_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_lab_1/models/student.dart';

class StudentsNotifier extends StateNotifier<List<Student>?> {
  StudentsNotifier(super.state);

  void loadStudents() async {
    state = await Student.remoteGetList();
  }

  Future addStudent(
    firstName,
    lastName,
    departmentId,
    gender,
    grade,
  ) async {
    final student = await Student.remoteCreate(
        firstName, lastName, departmentId, gender, grade);
    state = [...state!, student];
  }

  Future editStudent(
    index,
    firstName,
    lastName,
    departmentId,
    gender,
    grade,
  ) async {
    final student = await Student.remoteUpdate(
      state![index].id,
      firstName,
      lastName,
      departmentId,
      gender,
      grade,
    );

    final newState = [...state!];
    newState[index] = student;
    state = newState;
  }

  Future insertStudent(Student student, int index) async {
    final newState = [...state!];
    newState.insert(index, student);
    state = newState;
  }

  Future removeStudent(Student student) async {
    await Student.remoteDelete(student.id);
    state = state!.where((m) => m.id != student.id).toList();
  }
}

final studentsProvider =
    StateNotifierProvider<StudentsNotifier, List<Student>?>((ref) {
  final departments = ref.read(departmentsProvider);

  final notifier = StudentsNotifier(null);
  notifier.loadStudents();
  return notifier;
});