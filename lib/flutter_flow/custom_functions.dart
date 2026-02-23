import '/backend/supabase/supabase.dart';

List<SubjectsRow>? filterSubjects(
  List<SubjectsRow>? supabaseRow,
  String? text,
) {
  // Если список null, выходим
  if (supabaseRow == null) {
    return null;
  }

  // Если ничего не ввели — вернуть весь список
  if (text == null || text.isEmpty) {
    return supabaseRow;
  }

  // Иначе фильтруем
  return supabaseRow.where((subject) {
    final name = subject.subjectName.toLowerCase();
    return name.contains(text.toLowerCase());
  }).toList();
}

List<ResourcesRow>? filterSubjectsCopy(
  List<ResourcesRow>? supabaseRow,
  String? text,
) {
  // Если список ресурсов null, вернём null
  if (supabaseRow == null) {
    return null;
  }

  // Если текст для поиска не задан или пуст, вернём весь список
  if (text == null || text.isEmpty) {
    return supabaseRow;
  }

  // Фильтруем по полю title
  return supabaseRow.where((resource) {
    final title = resource.title.toLowerCase();
    return title.contains(text.toLowerCase());
  }).toList();
}

int? updateTotalPoints(
  int? currentPoints,
  int? increment,
) {
// Проверяем, чтобы оба значения не были null
  int safeCurrentPoints = currentPoints ?? 0;
  int safeIncrement = increment ?? 0;

  return safeCurrentPoints + safeIncrement;
}
