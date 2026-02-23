import 'api_client.dart';

class ScheduleEntry {
  ScheduleEntry({
    required this.subjectName,
    required this.startTime,
    required this.endTime,
    required this.time,
    required this.classroom,
    required this.classType,
    required this.teacherName,
    required this.groupName,
    required this.date,
    required this.dayOfWeek,
  });

  final String subjectName;
  final String startTime;
  final String endTime;
  final String time;
  final String classroom;
  final String classType;
  final String teacherName;
  final String groupName;
  final String date;
  final String dayOfWeek;

  String get timeRange {
    if (time.isNotEmpty) {
      return time;
    }
    if (startTime.isEmpty && endTime.isEmpty) {
      return '';
    }
    return '$startTime-$endTime';
  }

  factory ScheduleEntry.fromMap(Map<String, dynamic> map) => ScheduleEntry(
        subjectName:
            (map['subject_name'] as String?) ?? (map['subject'] as String?) ?? 'Без названия',
        startTime: map['start_time'] as String? ?? '',
        endTime: map['end_time'] as String? ?? '',
        time: map['time'] as String? ?? '',
        classroom:
            (map['classroom'] as String?) ?? (map['room'] as String?) ?? '',
        classType: map['class_type'] as String? ?? '',
        teacherName:
            (map['teacher_name'] as String?) ?? (map['lecturer'] as String?) ?? '',
        groupName: map['group_name'] as String? ?? '',
        date: map['date'] as String? ?? '',
        dayOfWeek: map['day_of_week'] as String? ?? '',
      );
}

class ScheduleRepository {
  ScheduleRepository._();

  static final ScheduleRepository instance = ScheduleRepository._();

  Future<List<ScheduleEntry>> getSchedule({
    required String group,
    required String date,
  }) async {
    final data = await ApiClient.instance.getList(
      '/schedule',
      query: {
        'group': group,
        'date': date,
      },
      cacheTtl: const Duration(minutes: 10),
    );
    return data
        .whereType<Map<String, dynamic>>()
        .map(ScheduleEntry.fromMap)
        .toList();
  }
}
