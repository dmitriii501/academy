import '/backend/api_client/schedule_repository.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'schedule_student_widget.dart' show ScheduleStudentWidget;
import 'package:flutter/material.dart';

class ScheduleStudentModel extends FlutterFlowModel<ScheduleStudentWidget> {
  ///  Local state fields for this page.

  DateTime? selectedDate;

  DateTime? currentDate;
  String groupName = '';

  List<ScheduleEntry> scheduleDay = [];
  void addToScheduleDay(ScheduleEntry item) => scheduleDay.add(item);
  void removeFromScheduleDay(ScheduleEntry item) => scheduleDay.remove(item);
  void removeAtIndexFromScheduleDay(int index) => scheduleDay.removeAt(index);
  void insertAtIndexInScheduleDay(int index, ScheduleEntry item) =>
      scheduleDay.insert(index, item);
  void updateScheduleDayAtIndex(int index, Function(ScheduleEntry) updateFn) =>
      scheduleDay[index] = updateFn(scheduleDay[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in schedule_student widget.
  List<ScheduleEntry>? sch;
  DateTime? datePicked;
  // Stores action output result for [Backend Call - Query Rows] action in Icon widget.
  List<ScheduleEntry>? datepick;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
