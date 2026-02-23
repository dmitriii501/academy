import '../database.dart';

class EventsTable extends SupabaseTable<EventsRow> {
  @override
  String get tableName => 'events';

  @override
  EventsRow createRow(Map<String, dynamic> data) => EventsRow(data);
}

class EventsRow extends SupabaseDataRow {
  EventsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => EventsTable();

  int get eventId => getField<int>('event_id')!;
  set eventId(int value) => setField<int>('event_id', value);

  String get eventName => getField<String>('event_name')!;
  set eventName(String value) => setField<String>('event_name', value);

  String? get eventDescription => getField<String>('event_description');
  set eventDescription(String? value) =>
      setField<String>('event_description', value);

  DateTime get eventDate => getField<DateTime>('event_date')!;
  set eventDate(DateTime value) => setField<DateTime>('event_date', value);

  String get eventType => getField<String>('event_type')!;
  set eventType(String value) => setField<String>('event_type', value);

  String? get photoUrl => getField<String>('photo_url');
  set photoUrl(String? value) => setField<String>('photo_url', value);

  bool? get isMain => getField<bool>('is_main');
  set isMain(bool? value) => setField<bool>('is_main', value);

  int? get subjectIdIfEvent => getField<int>('subject_id_if_event');
  set subjectIdIfEvent(int? value) =>
      setField<int>('subject_id_if_event', value);

  bool? get isParticipated => getField<bool>('is_participated');
  set isParticipated(bool? value) => setField<bool>('is_participated', value);
}
