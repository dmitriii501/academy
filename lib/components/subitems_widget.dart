import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'subitems_model.dart';
export 'subitems_model.dart';

class SubitemsWidget extends StatefulWidget {
  const SubitemsWidget({super.key});

  @override
  State<SubitemsWidget> createState() => _SubitemsWidgetState();
}

class _SubitemsWidgetState extends State<SubitemsWidget> {
  late SubitemsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubitemsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330.0,
      height: 299.0,
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
      ),
      child: FutureBuilder<List<SubjectsRow>>(
        future: SubjectsTable().queryRows(
          queryFn: (q) => q,
        ),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            );
          }
          List<SubjectsRow> listViewSubjectsRowList = snapshot.data!;

          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: listViewSubjectsRowList.length,
            itemBuilder: (context, listViewIndex) {
              final listViewSubjectsRow =
                  listViewSubjectsRowList[listViewIndex];
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Divider(
                    thickness: 2.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                  Container(
                    width: 299.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F8F8),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(50.0, 0.0, 0.0, 0.0),
                      child: Text(
                        listViewSubjectsRow.subjectName,
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
