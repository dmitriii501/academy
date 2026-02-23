import '/flutter_flow/flutter_flow_util.dart';
import '/teacher/custom_nav_bar_teacher/custom_nav_bar_teacher_widget.dart';
import 'student_works_widget.dart' show StudentWorksWidget;
import 'package:flutter/material.dart';

class StudentWorksModel extends FlutterFlowModel<StudentWorksWidget> {
  ///  Local state fields for this page.

  List<int> filter = [];
  void addToFilter(int item) => filter.add(item);
  void removeFromFilter(int item) => filter.remove(item);
  void removeAtIndexFromFilter(int index) => filter.removeAt(index);
  void insertAtIndexInFilter(int index, int item) => filter.insert(index, item);
  void updateFilterAtIndex(int index, Function(int) updateFn) =>
      filter[index] = updateFn(filter[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Model for CustomNavBarTeacher component.
  late CustomNavBarTeacherModel customNavBarTeacherModel;

  @override
  void initState(BuildContext context) {
    customNavBarTeacherModel =
        createModel(context, () => CustomNavBarTeacherModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    customNavBarTeacherModel.dispose();
  }
}
