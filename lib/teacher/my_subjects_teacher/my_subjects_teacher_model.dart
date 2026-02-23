import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/teacher/custom_nav_bar_teacher/custom_nav_bar_teacher_widget.dart';
import '/index.dart';
import 'my_subjects_teacher_widget.dart' show MySubjectsTeacherWidget;
import 'package:flutter/material.dart';

class MySubjectsTeacherModel extends FlutterFlowModel<MySubjectsTeacherWidget> {
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

  UsersRow? id;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in my_subjects_teacher widget.
  List<UsersRow>? users;
  // Stores action output result for [Backend Call - Query Rows] action in my_subjects_teacher widget.
  List<TeachersRow>? teacher;
  // Stores action output result for [Backend Call - Query Rows] action in my_subjects_teacher widget.
  List<SubjectsRow>? allsubject;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Model for CustomNavBarTeacher component.
  late CustomNavBarTeacherModel customNavBarTeacherModel;

  @override
  void initState(BuildContext context) {
    customNavBarTeacherModel =
        createModel(context, () => CustomNavBarTeacherModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    customNavBarTeacherModel.dispose();
  }
}
