// Automatic FlutterFlow imports
import '/backend/api_client/api_client.dart';
import 'package:flutter/foundation.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<void> incrementSupabaseField(String tableName, String rowId,
    String fieldName, int incrementValue) async {
  try {
    final response = await ApiClient.instance.getList(
      '/tables/$tableName',
      query: {'eq': 'id:$rowId', 'limit': '1'},
    );
    if (response.isNotEmpty &&
        response.first is Map<String, dynamic> &&
        (response.first as Map<String, dynamic>)[fieldName] is num) {
      final current = (response.first as Map<String, dynamic>)[fieldName] as num;
      final newValue = current + incrementValue;
      await ApiClient.instance.patch(
        '/tables/$tableName',
        query: {'eq': 'id:$rowId'},
        body: {fieldName: newValue},
      );
      if (kDebugMode) {
        debugPrint('✅ Значение обновлено: $newValue');
      }
    } else {
      if (kDebugMode) {
        debugPrint('⚠️ Ошибка: Поле не найдено или имеет неверный тип.');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint('❌ Ошибка backend: $e');
    }
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
