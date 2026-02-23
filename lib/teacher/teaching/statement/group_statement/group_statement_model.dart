import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_data_table.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/teacher/custom_nav_bar_teacher/custom_nav_bar_teacher_widget.dart';
import '/index.dart';
import 'group_statement_widget.dart' show GroupStatementWidget;
import 'package:flutter/material.dart';

class GroupStatementModel extends FlutterFlowModel<GroupStatementWidget> {
  ///  Local state fields for this page.

  GroupsRow? onPage;

  DateTime? date;

  bool bool1 = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in groupStatement widget.
  List<CheckDisableRow>? fghkj;
  // Stores action output result for [Backend Call - Query Rows] action in groupStatement widget.
  List<GroupStatementRow>? groupStatement;
  DateTime? datePicked;
  // State field(s) for PaginatedDataTable widget.
  final paginatedDataTableController =
      FlutterFlowDataTableController<StudentPerformanceRow>();
  // Model for CustomNavBarTeacher component.
  late CustomNavBarTeacherModel customNavBarTeacherModel;

  @override
  void initState(BuildContext context) {
    customNavBarTeacherModel =
        createModel(context, () => CustomNavBarTeacherModel());
  }

  @override
  void dispose() {
    paginatedDataTableController.dispose();
    customNavBarTeacherModel.dispose();
  }
}
