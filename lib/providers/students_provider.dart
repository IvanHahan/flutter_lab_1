import 'package:flutter_lab_1/providers/departments_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_lab_1/models/student.dart';

class StudentsNotifier extends StateNotifier<List<Student>> {
  StudentsNotifier(super.state);


  void addStudent(Student student) {
    state = [...state, student];
  }

  void editStudent(Student student, int index) {
    final newState = [...state];
    newState[index] = newState[index].copyWith(
      student.firstName,
      student.lastName,
      student.departmentId,
      student.gender,
      student.grade,
    );
    state = newState;
  }

  void insertStudent(Student student, int index) {
    final newState = [...state];
    newState.insert(index, student);
    state = newState;
  }

  void removeStudent(Student student) {
    state = state.where((m) => m.id != student.id).toList();
  }
}

final studentsProvider =
    StateNotifierProvider<StudentsNotifier, List<Student>>((ref) {
      final departments = ref.read(departmentsProvider);

  return StudentsNotifier([
    Student(firstName: 'John', lastName: 'Smith', departmentId: departments[0].id, gender: Gender.male, grade: 75),
    Student(firstName: 'Ana', lastName: 'De Armas', departmentId: departments[1].id, gender: Gender.female, grade: 80),
    Student(firstName: 'Will', lastName: 'Smith', departmentId: departments[3].id, gender: Gender.male, grade: 95),
    Student(firstName: 'Jack', lastName: 'Rassel', departmentId: departments[2].id, gender: Gender.male, grade: 60),
    Student(firstName: 'Megan', lastName: 'Fox', departmentId: departments[0].id, gender: Gender.female, grade: 80),
  ]);
});
