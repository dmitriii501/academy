// ignore_for_file: non_constant_identifier_names
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'extra_poin_widget.dart' show ExtraPoinWidget;
import 'package:flutter/material.dart';

class ExtraPoinModel extends FlutterFlowModel<ExtraPoinWidget> {
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

  // Stores action output result for [Backend Call - Query Rows] action in extraPoin widget.
  List<SubjectTopicsRow>? topic;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<StudentsRow>? student;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<SubjectTopicsRow>? subjectTopics;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<UsersRow>? name;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<AssignmentsRow>? unsentAssignmentRefDop;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<AssignmentsRow>? unsentAssignmentRefDopView;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<SubjectTopicsRow>? studentTopicDopRef;
  bool isDataUploading_submissions = false;
  FFUploadedFile uploadedLocalFile_submissions =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_submissions = '';

  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<AssignmentsRow>? refpassyes;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<StudentsRow>? student1;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<SubjectTopicsRow>? subjectTopics1;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<UsersRow>? name1;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<AssignmentsRow>? unsentAssignmentDoclDop;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<AssignmentsRow>? unsentAssignmentDoclDopView;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<SubjectTopicsRow>? studentTopicDoclDop;
  bool isDataUploading_submissions2 = false;
  FFUploadedFile uploadedLocalFile_submissions2 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_submissions2 = '';

  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<AssignmentsRow>? refpassyes1;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
