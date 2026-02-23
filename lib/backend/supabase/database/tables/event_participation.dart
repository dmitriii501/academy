import '../database.dart';

class EventParticipationTable extends SupabaseTable<EventParticipationRow> {
  @override
  String get tableName => 'event_participation';

  @override
  EventParticipationRow createRow(Map<String, dynamic> data) =>
      EventParticipationRow(data);
}

class EventParticipationRow extends SupabaseDataRow {
  EventParticipationRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => EventParticipationTable();

  int get participationId => getField<int>('participation_id')!;
  set participationId(int value) => setField<int>('participation_id', value);

  int get eventId => getField<int>('event_id')!;
  set eventId(int value) => setField<int>('event_id', value);

  int get userId => getField<int>('user_id')!;
  set userId(int value) => setField<int>('user_id', value);

  int? get subjectId => getField<int>('subject_id');
  set subjectId(int? value) => setField<int>('subject_id', value);

  bool get participated => getField<bool>('participated')!;
  set participated(bool value) => setField<bool>('participated', value);

  bool get isAttended => getField<bool>('is_attended')!;
  set isAttended(bool value) => setField<bool>('is_attended', value);

  String? get fullName => getField<String>('fullName');
  set fullName(String? value) => setField<String>('fullName', value);

  bool? get isSubjectEvent => getField<bool>('is_subject_event');
  set isSubjectEvent(bool? value) => setField<bool>('is_subject_event', value);
}
