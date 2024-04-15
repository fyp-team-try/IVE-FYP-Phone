import 'dart:ui';

import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:user_app/Components/LocationListItem.dart';
import 'package:user_app/Models/Api/ApiResponse.dart';
import 'package:user_app/Models/Api/ResponseModels/ParkingLotInfo.dart';
import 'package:user_app/Services/ApiRequest.dart';

import 'searchLocationModel.dart';
export 'searchLocationModel.dart';

class SearchLocationWidget extends StatefulWidget {
  const SearchLocationWidget({super.key});

  @override
  State<SearchLocationWidget> createState() => _SearchLocationWidgetState();
}

class _SearchLocationWidgetState extends State<SearchLocationWidget> {
  late SearchLocationModel _model;

  List<ParkingLotInfo>? items = <ParkingLotInfo>[];
  List<ParkingLotInfo>? displayItems = <ParkingLotInfo>[];
  List<ChipData>? chipsDataList;
  

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchLocationModel());
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    GetParkingLots();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void GetParkingLots() async {
    try {
      ApiRequest api = ApiRequest();
      ApiResponse<List<ParkingLotInfo>> response = await api.get(
          'parkinglots',
          (json) => (json as List<dynamic>).map<ParkingLotInfo>((dynamic item) {
                return ParkingLotInfo.fromJson(item);
              }).toList());
              

      if (response.statusCode == 200) {
        setState(() {
          items = response.data;
          displayItems = items;
          chipsDataList = items?.map((obj) => obj.district).toSet().toList().map((e) => ChipData(e)).toList();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Data Fetch failed'),
          duration: Duration(seconds: 5),
        ));
      }
    } catch (e) {}
  }

  void search(){
    String searchBarText = _model.textController.text;
    String? chipsValue = _model.choiceChipsValue;

    print(searchBarText);
    print(chipsValue);

    if(searchBarText!=""){
      setState(() {
        displayItems=items?.where((parkingLot) => parkingLot.name.toLowerCase().contains(searchBarText.toLowerCase())).toList();
      });
    }else if(searchBarText!=""&&chipsValue!=null){
        displayItems=items?.where((parkingLot) => parkingLot.name.toLowerCase().contains(searchBarText.toLowerCase())&&parkingLot.district == chipsValue).toList();    
    }else if(searchBarText=="" && chipsValue!=null){
      displayItems=items?.where((parkingLot) => parkingLot.district == chipsValue).toList();
    }else{
      setState(() {
        displayItems = items;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'Search Location',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                  child: Text(
                    'Enter address to search for parking lot.',
                    style: FlutterFlowTheme.of(context).labelMedium,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 8),
                  child: TextFormField(
                    controller: _model.textController,
                    focusNode: _model.textFieldFocusNode,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Search location...',
                      labelStyle: FlutterFlowTheme.of(context).labelMedium,
                      hintStyle: FlutterFlowTheme.of(context).labelMedium,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      suffixIcon: Icon(
                        Icons.search_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium,
                    cursorColor: FlutterFlowTheme.of(context).primary,
                    validator:
                        _model.textControllerValidator.asValidator(context),
                      onChanged: (value)=>search(),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                        child: FlutterFlowChoiceChips(
                          options: chipsDataList??[],
                          onChanged: (val) => setState(
                              () {                          
                                 _model.choiceChipsValue = val?.firstOrNull;
                                 search();
                              }),
                          selectedChipStyle: ChipStyle(
                            backgroundColor:
                                FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).info,
                                ),
                            iconColor: FlutterFlowTheme.of(context).info,
                            iconSize: 18,
                            elevation: 2,
                            borderColor: FlutterFlowTheme.of(context).accent1,
                            borderWidth: 1,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          unselectedChipStyle: ChipStyle(
                            backgroundColor:
                                FlutterFlowTheme.of(context).alternate,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                ),
                            iconColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            iconSize: 18,
                            elevation: 0,
                            borderColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderWidth: 1,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          chipSpacing: 8,
                          rowSpacing: 12,
                          multiselect: false,
                          initialized: _model.choiceChipsValue != null,
                          alignment: WrapAlignment.start,
                          controller: _model.choiceChipsValueController ??=
                              FormFieldController<List<String>>(
                            ['For You'],
                          ),
                        ),
                      ),
                    ]
                        .addToStart(SizedBox(width: 16))
                        .addToEnd(SizedBox(width: 16)),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: FlutterFlowTheme.of(context).alternate,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                  child: Text(
                    'Popular Today',
                    style: FlutterFlowTheme.of(context).labelMedium,
                  ),
                ),
                displayItems!.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        padding: EdgeInsets.fromLTRB(
                          0,
                          8,
                          0,
                          44,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: displayItems?.length,
                        itemBuilder: (context, index) {
                          ParkingLotInfo currItem = displayItems![index];
                          return LocationListItem(parkingLotInfo: currItem);
                        }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
