import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'menu_stud_widget.dart' show MenuStudWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class MenuStudModel extends FlutterFlowModel<MenuStudWidget> {
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

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController1;

  // Stores action output result for [Backend Call - Query Rows] action in Expandable widget.
  List<SubjectsRow>? rows;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController2;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController3;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController4;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    expandableExpandableController1.dispose();
    expandableExpandableController2.dispose();
    expandableExpandableController3.dispose();
    expandableExpandableController4.dispose();
  }
}
