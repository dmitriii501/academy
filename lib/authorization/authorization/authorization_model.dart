import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'authorization_widget.dart' show AuthorizationWidget;
import 'package:flutter/material.dart';

class AuthorizationModel extends FlutterFlowModel<AuthorizationWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for TextFieldLogTeach widget.
  FocusNode? textFieldLogTeachFocusNode;
  TextEditingController? textFieldLogTeachTextController;
  String? Function(BuildContext, String?)?
      textFieldLogTeachTextControllerValidator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  // State field(s) for TextFieldLogStud widget.
  FocusNode? textFieldLogStudFocusNode;
  TextEditingController? textFieldLogStudTextController;
  String? Function(BuildContext, String?)?
      textFieldLogStudTextControllerValidator;
  // State field(s) for TextFieldPasswStud widget.
  FocusNode? textFieldPasswStudFocusNode;
  TextEditingController? textFieldPasswStudTextController;
  late bool textFieldPasswStudVisibility;
  String? Function(BuildContext, String?)?
      textFieldPasswStudTextControllerValidator;
  // State field(s) for TextFieldStudName widget.
  FocusNode? textFieldStudNameFocusNode;
  TextEditingController? textFieldStudNameTextController;
  String? Function(BuildContext, String?)?
      textFieldStudNameTextControllerValidator;
  // State field(s) for TextFieldStudGroup widget.
  FocusNode? textFieldStudGroupFocusNode;
  TextEditingController? textFieldStudGroupTextController;
  String? Function(BuildContext, String?)?
      textFieldStudGroupTextControllerValidator;

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
    textFieldPasswStudVisibility = false;
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    textFieldLogTeachFocusNode?.dispose();
    textFieldLogTeachTextController?.dispose();

    textFieldFocusNode?.dispose();
    passwordTextController?.dispose();

    textFieldLogStudFocusNode?.dispose();
    textFieldLogStudTextController?.dispose();

    textFieldPasswStudFocusNode?.dispose();
    textFieldPasswStudTextController?.dispose();
    textFieldStudNameFocusNode?.dispose();
    textFieldStudNameTextController?.dispose();
    textFieldStudGroupFocusNode?.dispose();
    textFieldStudGroupTextController?.dispose();
  }
}
