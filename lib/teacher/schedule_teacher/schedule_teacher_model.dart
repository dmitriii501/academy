import '/backend/api_client/schedule_repository.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/teacher/custom_nav_bar_teacher/custom_nav_bar_teacher_widget.dart';
import 'schedule_teacher_widget.dart' show ScheduleTeacherWidget;
import 'package:flutter/material.dart';

class ScheduleTeacherModel extends FlutterFlowModel<ScheduleTeacherWidget> {
  ///  Local state fields for this page.

  DateTime? time;

  List<ScheduleEntry> schedule = [];
  void addToSchedule(ScheduleEntry item) => schedule.add(item);
  void removeFromSchedule(ScheduleEntry item) => schedule.remove(item);
  void removeAtIndexFromSchedule(int index) => schedule.removeAt(index);
  void insertAtIndexInSchedule(int index, ScheduleEntry item) =>
      schedule.insert(index, item);
  void updateScheduleAtIndex(int index, Function(ScheduleEntry) updateFn) =>
      schedule[index] = updateFn(schedule[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in schedule_teacher widget.
  List<ScheduleEntry>? pickDate;
  DateTime? datePicked;
  // Stores action output result for [Backend Call - Query Rows] action in Icon widget.
  List<ScheduleEntry>? datepick1;
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
