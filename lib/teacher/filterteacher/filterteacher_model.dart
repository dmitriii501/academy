import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'filterteacher_widget.dart' show FilterteacherWidget;
import 'package:flutter/material.dart';

class FilterteacherModel extends FlutterFlowModel<FilterteacherWidget> {
  ///  Local state fields for this component.

  List<int> filter = [];
  void addToFilter(int item) => filter.add(item);
  void removeFromFilter(int item) => filter.remove(item);
  void removeAtIndexFromFilter(int index) => filter.removeAt(index);
  void insertAtIndexInFilter(int index, int item) => filter.insert(index, item);
  void updateFilterAtIndex(int index, Function(int) updateFn) =>
      filter[index] = updateFn(filter[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // State field(s) for DropDown widget.
  String? dropDownValue3;
  FormFieldController<String>? dropDownValueController3;
  DateTime? datePicked;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
