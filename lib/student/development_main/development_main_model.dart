import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'development_main_widget.dart' show DevelopmentMainWidget;
import 'package:flutter/material.dart';

class DevelopmentMainModel extends FlutterFlowModel<DevelopmentMainWidget> {
  ///  Local state fields for this page.

  List<ResourcesRow> film = [];
  void addToFilm(ResourcesRow item) => film.add(item);
  void removeFromFilm(ResourcesRow item) => film.remove(item);
  void removeAtIndexFromFilm(int index) => film.removeAt(index);
  void insertAtIndexInFilm(int index, ResourcesRow item) =>
      film.insert(index, item);
  void updateFilmAtIndex(int index, Function(ResourcesRow) updateFn) =>
      film[index] = updateFn(film[index]);

  List<ResourcesRow> searchFilm = [];
  void addToSearchFilm(ResourcesRow item) => searchFilm.add(item);
  void removeFromSearchFilm(ResourcesRow item) => searchFilm.remove(item);
  void removeAtIndexFromSearchFilm(int index) => searchFilm.removeAt(index);
  void insertAtIndexInSearchFilm(int index, ResourcesRow item) =>
      searchFilm.insert(index, item);
  void updateSearchFilmAtIndex(int index, Function(ResourcesRow) updateFn) =>
      searchFilm[index] = updateFn(searchFilm[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in development_main widget.
  List<ResourcesRow>? allFilm;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();
  }
}
