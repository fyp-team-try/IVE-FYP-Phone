import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:flutter/material.dart';
import 'BookingWidget.dart' show BookingWidget;

class BookingModel extends FlutterFlowModel<BookingWidget> {
  final unfocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  String? dropDownValue2;
  String? dropDownValue3;

  DateTime? pickerDateValue1;
  TimeOfDay? pickerTimeValue1;
  DateTime? pickerDateValue2;
  TimeOfDay? pickerTimeValue2;



  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
