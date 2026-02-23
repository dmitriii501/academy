// ignore_for_file: non_constant_identifier_names

import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'debts_widget.dart' show DebtsWidget;
import 'package:flutter/material.dart';

class DebtsModel extends FlutterFlowModel<DebtsWidget> {
  ///  Local state fields for this page.

  bool opt1 = false;

  bool opt2 = false;

  bool opt3 = false;

  bool opt4 = false;

  bool opt5 = false;

  bool opt6 = false;

  bool opt7 = false;

  bool opt8 = false;

  SubjectTopicsRow? sendTopic;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in debts widget.
  List<SubjectTopicsRow>? topic;
  bool isDataUploading_submissions11 = false;
  FFUploadedFile uploadedLocalFile_submissions11 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_submissions11 = '';

  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<AssignmentsRow>? refpassyes1;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<StudentsRow>? student;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<SubjectTopicsRow>? subjectTopics;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<UsersRow>? name;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<AssignmentsRow>? unsentAssignmentRefDebt;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<AssignmentsRow>? unsentAssignmentRefDebtView;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<SubjectTopicsRow>? studentTopicDebtRef;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<StudentsRow>? student1;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<SubjectTopicsRow>? subjectTopics1;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<UsersRow>? name1;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<AssignmentsRow>? unsentAssignmentDoclDebt;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<AssignmentsRow>? unsentAssignmentDoclDebtView;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<SubjectTopicsRow>? studentTopicDebtDocl;
  bool isDataUploading_submissions1 = false;
  FFUploadedFile uploadedLocalFile_submissions1 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_submissions1 = '';

  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<AssignmentsRow>? refpassyes;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
