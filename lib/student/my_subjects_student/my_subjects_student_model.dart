import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'my_subjects_student_widget.dart' show MySubjectsStudentWidget;
import 'package:flutter/material.dart';

class MySubjectsStudentModel extends FlutterFlowModel<MySubjectsStudentWidget> {
  ///  Local state fields for this page.

  List<SubjectsRow> mysubject = [];
  void addToMysubject(SubjectsRow item) => mysubject.add(item);
  void removeFromMysubject(SubjectsRow item) => mysubject.remove(item);
  void removeAtIndexFromMysubject(int index) => mysubject.removeAt(index);
  void insertAtIndexInMysubject(int index, SubjectsRow item) =>
      mysubject.insert(index, item);
  void updateMysubjectAtIndex(int index, Function(SubjectsRow) updateFn) =>
      mysubject[index] = updateFn(mysubject[index]);

  List<SubjectsRow> searchSubject = [];
  void addToSearchSubject(SubjectsRow item) => searchSubject.add(item);
  void removeFromSearchSubject(SubjectsRow item) => searchSubject.remove(item);
  void removeAtIndexFromSearchSubject(int index) =>
      searchSubject.removeAt(index);
  void insertAtIndexInSearchSubject(int index, SubjectsRow item) =>
      searchSubject.insert(index, item);
  void updateSearchSubjectAtIndex(int index, Function(SubjectsRow) updateFn) =>
      searchSubject[index] = updateFn(searchSubject[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in my_subjects_student widget.
  List<UsersRow>? user;
  // Stores action output result for [Backend Call - Query Rows] action in my_subjects_student widget.
  List<UsersRow>? users;
  // Stores action output result for [Backend Call - Query Rows] action in my_subjects_student widget.
  List<StudentsRow>? students;
  // Stores action output result for [Backend Call - Query Rows] action in my_subjects_student widget.
  List<GroupsRow>? group;
  // Stores action output result for [Backend Call - Query Rows] action in my_subjects_student widget.
  List<SubjectsRow>? allsubject;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
