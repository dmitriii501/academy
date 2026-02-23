import '/backend/supabase/supabase.dart';
import '/backend/api_client/auth_repository.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';

class PerformanceWidget extends StatefulWidget {
  const PerformanceWidget({
    super.key,
    required this.navigate,
  });

  final SubjectsRow? navigate;

  static String routeName = 'performance';
  static String routePath = '/performance';

  @override
  State<PerformanceWidget> createState() => _PerformanceWidgetState();
}

class _PerformanceWidgetState extends State<PerformanceWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<_PerformanceData> _loadData() async {
    final session = AuthRepository.instance.current;
    if (session == null) {
      return _PerformanceData(
        student: null,
        performance: const [],
        statement: null,
        assignments: const [],
      );
    }
    final userRows = await UsersTable().querySingleRow(
      queryFn: (q) => q.eqOrNull(
        'user_id',
        session.userId,
      ),
    );
    final user = userRows.firstOrNull;
    final studentRows = await StudentsTable().querySingleRow(
      queryFn: (q) => q.eqOrNull(
        'user_id',
        user?.userId,
      ),
    );
    final student = studentRows.firstOrNull;
    final performanceRows = await StudentPerformanceTable().queryRows(
      queryFn: (q) => q
          .eqOrNull(
            'student_id',
            student?.studentId,
          )
          .eqOrNull(
            'subject_id',
            widget.navigate?.subjectId,
          )
          .order('date'),
    );
    final statementRows = await GroupStatementTable().querySingleRow(
      queryFn: (q) => q
          .eqOrNull(
            'user_id',
            user?.userId,
          )
          .eqOrNull(
            'subject_id',
            widget.navigate?.subjectId,
          ),
    );
    final assignments = await AssignmentsTable().queryRows(
      queryFn: (q) => q
          .eqOrNull('subject_id', widget.navigate?.subjectId)
          .eqOrNull('userTableId', user?.userId)
          .order('created_at'),
    );
    return _PerformanceData(
      student: student,
      performance: performanceRows,
      statement: statementRows.firstOrNull,
      assignments: assignments,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_PerformanceData>(
      future: _loadData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final data = snapshot.data!;
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(120.0),
              child: AppBar(
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Color(0xFFCCAAEE)),
                automaticallyImplyLeading: false,
                actions: [],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    width: double.infinity,
                    height: 120.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: Image.asset(
                          'assets/images/0jscg_.png',
                        ).image,
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.safePop();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                size: 30.0,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                        NotificationsStudWidget.routeName);
                                  },
                                  child: Icon(
                                    Icons.notifications_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    size: 30.0,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 0.0, 5.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                          ProfileStudentWidget.routeName);
                                    },
                                    child: Icon(
                                      Icons.person,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      size: 30.0,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(MenuStudWidget.routeName);
                                  },
                                  child: Icon(
                                    Icons.menu,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    size: 30.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                centerTitle: false,
                elevation: 0.0,
              ),
            ),
            body: SafeArea(
              top: true,
              child: data.student == null
                  ? Center(
                      child: Text(
                        'Студент не найден',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 16.0, 8.0),
                            child: Text(
                              valueOrDefault<String>(
                                widget.navigate?.subjectName,
                                'Предмет',
                              ),
                              style: FlutterFlowTheme.of(context).titleMedium,
                            ),
                          ),
                          _SectionTitle(title: 'Лекции'),
                          _PerformanceTable(
                            rows: data.lectureRows,
                            pointsSelector: (row) => row.pointsOfAttended,
                          ),
                          _SectionTitle(title: 'Семинары'),
                          _PerformanceTable(
                            rows: data.seminarRows,
                            pointsSelector: (row) => row.pointsOfWork,
                          ),
                          _SectionTitle(title: 'Баллы за работы'),
                          _AssignmentsTable(assignments: data.assignments),
                          _TotalScore(
                            total: data.totalPoints,
                            attended: data.attendedCount,
                            totalLessons: data.totalCount,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}

class _PerformanceData {
  _PerformanceData({
    required this.student,
    required this.performance,
    required this.statement,
    required this.assignments,
  });

  final StudentsRow? student;
  final List<StudentPerformanceRow> performance;
  final GroupStatementRow? statement;
  final List<AssignmentsRow> assignments;

  List<StudentPerformanceRow> get lectureRows =>
      performance.where((row) => row.pointsOfWork == 0).toList();
  List<StudentPerformanceRow> get seminarRows =>
      performance.where((row) => row.pointsOfWork > 0).toList();

  int get attendedCount =>
      performance.where((row) => row.isAttended).length;
  int get totalCount => performance.length;
  int get totalPoints {
    if (statement?.totalPoints != null) {
      return statement!.totalPoints!;
    }
    final lecturePoints =
        lectureRows.fold<int>(0, (sum, row) => sum + row.pointsOfAttended);
    final seminarPoints =
        seminarRows.fold<int>(0, (sum, row) => sum + row.pointsOfWork);
    final workPoints = assignments.fold<int>(
      0,
      (sum, row) => sum + (row.grade ?? 0),
    );
    return lecturePoints + seminarPoints + workPoints;
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFB5FE82),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsetsDirectional.fromSTEB(12.0, 6.0, 12.0, 6.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).bodyMedium,
        ),
      ),
    );
  }
}

class _PerformanceTable extends StatelessWidget {
  const _PerformanceTable({
    required this.rows,
    required this.pointsSelector,
  });

  final List<StudentPerformanceRow> rows;
  final int Function(StudentPerformanceRow) pointsSelector;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 8.0),
        child: Text(
          'Нет данных',
          style: FlutterFlowTheme.of(context).bodyMedium,
        ),
      );
    }
    final attended = rows.where((row) => row.isAttended).length;
    final totalPoints =
        rows.fold<int>(0, (sum, row) => sum + pointsSelector(row));
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 8.0),
      child: Column(
        children: [
          _HeaderRow(),
          ...rows.map(
            (row) => _DataRow(
              date: row.date,
              attended: row.isAttended,
              points: pointsSelector(row),
            ),
          ),
          _SummaryRow(
            attended: attended,
            total: rows.length,
            points: totalPoints,
          ),
        ],
      ),
    );
  }
}

class _AssignmentsTable extends StatelessWidget {
  const _AssignmentsTable({required this.assignments});

  final List<AssignmentsRow> assignments;

  @override
  Widget build(BuildContext context) {
    if (assignments.isEmpty) {
      return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 8.0),
        child: Text(
          'Нет работ',
          style: FlutterFlowTheme.of(context).bodyMedium,
        ),
      );
    }
    final totalPoints =
        assignments.fold<int>(0, (sum, row) => sum + (row.grade ?? 0));
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 8.0),
      child: Column(
        children: [
          _HeaderRow(customThird: 'Баллы'),
          ...assignments.map(
            (row) => _WorkRow(
              name: row.typeOfWork ?? row.typeOFWorkSecond ?? 'Работа',
              date: row.createdAt,
              points: row.grade ?? 0,
            ),
          ),
          _SummaryRow(attended: 0, total: 0, points: totalPoints, label: 'Итог'),
        ],
      ),
    );
  }
}

class _TotalScore extends StatelessWidget {
  const _TotalScore({
    required this.total,
    required this.attended,
    required this.totalLessons,
  });

  final int total;
  final int attended;
  final int totalLessons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF5964A6),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsetsDirectional.fromSTEB(12.0, 10.0, 12.0, 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Общий итог',
              style: FlutterFlowTheme.of(context)
                  .bodyMedium
                  .override(color: Colors.white),
            ),
            Text(
              totalLessons > 0
                  ? '$total баллов (${attended}/${totalLessons})'
                  : '$total баллов',
              style: FlutterFlowTheme.of(context)
                  .bodyMedium
                  .override(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({this.customThird});

  final String? customThird;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF5964A6),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsetsDirectional.fromSTEB(8.0, 6.0, 8.0, 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'Дата',
              style: FlutterFlowTheme.of(context)
                  .bodyMedium
                  .override(color: Colors.white),
            ),
          ),
          Expanded(
            child: Text(
              'Посещение',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context)
                  .bodyMedium
                  .override(color: Colors.white),
            ),
          ),
          Expanded(
            child: Text(
              customThird ?? 'Баллы',
              textAlign: TextAlign.end,
              style: FlutterFlowTheme.of(context)
                  .bodyMedium
                  .override(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({
    required this.date,
    required this.attended,
    required this.points,
  });

  final DateTime date;
  final bool attended;
  final int points;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(8.0, 6.0, 8.0, 6.0),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: FlutterFlowTheme.of(context).alternate),
          right: BorderSide(color: FlutterFlowTheme.of(context).alternate),
          bottom: BorderSide(color: FlutterFlowTheme.of(context).alternate),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              dateTimeFormat(
                "d MMM",
                date,
                locale: FFLocalizations.of(context).languageCode,
              ),
            ),
          ),
          Expanded(
            child: Icon(
              attended ? Icons.check_box : Icons.check_box_outline_blank,
              size: 18.0,
              color: attended
                  ? FlutterFlowTheme.of(context).success
                  : FlutterFlowTheme.of(context).secondaryText,
            ),
          ),
          Expanded(
            child: Text(
              points.toString(),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkRow extends StatelessWidget {
  const _WorkRow({
    required this.name,
    required this.date,
    required this.points,
  });

  final String name;
  final DateTime? date;
  final int points;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(8.0, 6.0, 8.0, 6.0),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: FlutterFlowTheme.of(context).alternate),
          right: BorderSide(color: FlutterFlowTheme.of(context).alternate),
          bottom: BorderSide(color: FlutterFlowTheme.of(context).alternate),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(name)),
          Expanded(
            child: Text(
              date != null
                  ? dateTimeFormat(
                      "d MMM",
                      date,
                      locale: FFLocalizations.of(context).languageCode,
                    )
                  : '-',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              points.toString(),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.attended,
    required this.total,
    required this.points,
    this.label = 'Итог',
  });

  final int attended;
  final int total;
  final int points;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(8.0, 6.0, 8.0, 6.0),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        border: Border(
          left: BorderSide(color: FlutterFlowTheme.of(context).alternate),
          right: BorderSide(color: FlutterFlowTheme.of(context).alternate),
          bottom: BorderSide(color: FlutterFlowTheme.of(context).alternate),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label)),
          Expanded(
            child: Text(
              total > 0 ? '$attended/$total' : '',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              '$points баллов',
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
