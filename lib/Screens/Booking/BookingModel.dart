import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:flutter/material.dart';
import 'BookingWidget.dart' show BookingWidget;

class BookingModel extends FlutterFlowModel<BookingWidget> {
  final unfocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  String? dropDownValue2;
  String? dropDownValue3;
  FormFieldController<String>? dropDownValueController2;
  FormFieldController<String>? dropDownValueController3;
  DateTime? datePicked1;
  DateTime? datePicked2;
  DateTime? datePicked3;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
