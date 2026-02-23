import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/teacher/custom_nav_bar_teacher/custom_nav_bar_teacher_widget.dart';
import '/index.dart';
import 'subject_teacher_widget.dart' show SubjectTeacherWidget;
import 'package:flutter/material.dart';

class SubjectTeacherModel extends FlutterFlowModel<SubjectTeacherWidget> {
  ///  Local state fields for this page.

  SubjectsRow? pageSelected;

  ///  State fields for stateful widgets in this page.

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
