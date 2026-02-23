import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/teacher/custom_nav_bar_teacher/custom_nav_bar_teacher_widget.dart';
import '/index.dart';
import 'statement_widget.dart' show StatementWidget;
import 'package:flutter/material.dart';

class StatementModel extends FlutterFlowModel<StatementWidget> {
  ///  Local state fields for this page.

  GroupsRow? onPage;

  DateTime? date;

  bool bool1 = true;

  SubjectsRow? pageSelected;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in statement widget.
  List<CheckDisableRow>? sta;
  // Stores action output result for [Backend Call - Query Rows] action in statement widget.
  List<GroupStatementRow>? statement;
  // Model for CustomNavBarTeacher component.
  late CustomNavBarTeacherModel customNavBarTeacherModel;

  @override
  void initState(BuildContext context) {
    customNavBarTeacherModel =
        createModel(context, () => CustomNavBarTeacherModel());
  }

  @override
  void dispose() {
    customNavBarTeacherModel.dispose();
  }
}
