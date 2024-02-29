import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:flutter/material.dart';

class FunctionPageButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final String imagePath;

  const FunctionPageButton({
    required this.onTap,
    required this.text,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Container(
          width: 170,
          height: 170,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(
                  image:AssetImage(imagePath),
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                text,
                style: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Open Sans',
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  

}
