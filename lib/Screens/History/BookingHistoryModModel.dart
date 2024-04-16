import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'BookingHistoryModWidget.dart' show HistoryModifybookingWidget;
import 'package:flutter/material.dart';

class HistoryModifybookingModel
    extends FlutterFlowModel<HistoryModifybookingWidget> {
  ///  State fields for stateful widgets in this page.
  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  
  DateTime? datePicked1;
  TimeOfDay? pickerTimeValue1;
  DateTime? datePicked2;
  TimeOfDay? pickerTimeValue2;
  // State field(s) for DropDown widget.
  String? dropDownValue3;
  FormFieldController<String>? dropDownValueController3;

  /// Initialization and disposal methods.
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}