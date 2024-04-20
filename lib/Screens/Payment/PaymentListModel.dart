import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'PaymentListWidget.dart' show PaymentListWidget;
import 'package:flutter/material.dart';

class PaymentListModel extends FlutterFlowModel<PaymentListWidget> {
  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}