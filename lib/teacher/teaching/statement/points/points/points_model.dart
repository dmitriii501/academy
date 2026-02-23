import '/flutter_flow/flutter_flow_util.dart';
import '/teacher/custom_nav_bar_teacher/custom_nav_bar_teacher_widget.dart';
import '/index.dart';
import 'points_widget.dart' show PointsWidget;
import 'package:flutter/material.dart';

class PointsModel extends FlutterFlowModel<PointsWidget> {
  ///  State fields for stateful widgets in this page.

  DateTime? datePicked;
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
