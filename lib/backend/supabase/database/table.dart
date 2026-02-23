import '/backend/api_client/api_client.dart';
import '/backend/api_client/query_builder.dart';
import 'database.dart';

abstract class SupabaseTable<T extends SupabaseDataRow> {
  String get tableName;
  T createRow(Map<String, dynamic> data);

  Future<List<T>> queryRows({
    required QueryBuilder Function(QueryBuilder) queryFn,
    int? limit,
  }) async {
    final builder = queryFn(QueryBuilder());
    if (limit != null) {
      builder.limit(limit);
    }
    final rows = await ApiClient.instance.getList(
      '/tables/$tableName',
      query: builder.toQueryParams(),
      cacheTtl: const Duration(seconds: 10),
    );
    return rows.map((row) => createRow(row as Map<String, dynamic>)).toList();
  }

  Future<List<T>> querySingleRow({
    required QueryBuilder Function(QueryBuilder) queryFn,
  }) async {
    final builder = queryFn(QueryBuilder());
    builder.limit(1);
    try {
      final rows = await ApiClient.instance.getList(
        '/tables/$tableName',
        query: builder.toQueryParams(),
        cacheTtl: const Duration(seconds: 10),
      );
      if (rows.isEmpty) {
        return [];
      }
      return [createRow(rows.first as Map<String, dynamic>)];
    } catch (e) {
      print('Error querying row: $e');
      return [];
    }
  }

  Future<T> insert(Map<String, dynamic> data) async {
    final row = await ApiClient.instance.post(
      '/tables/$tableName',
      body: data,
    );
    return createRow(row);
  }

  Future<List<T>> update({
    required Map<String, dynamic> data,
    required QueryBuilder Function(QueryBuilder) matchingRows,
    bool returnRows = false,
  }) async {
    final builder = matchingRows(QueryBuilder());
    final rows = await ApiClient.instance.patch(
      '/tables/$tableName',
      query: builder.toQueryParams(),
      body: data,
    );
    if (!returnRows) {
      return [];
    }
    return rows.map((row) => createRow(row as Map<String, dynamic>)).toList();
  }

  Future<List<T>> delete({
    required QueryBuilder Function(QueryBuilder) matchingRows,
    bool returnRows = false,
  }) async {
    final builder = matchingRows(QueryBuilder());
    final rows = await ApiClient.instance.delete(
      '/tables/$tableName',
      query: builder.toQueryParams(),
    );
    if (!returnRows) {
      return [];
    }
    return rows.map((row) => createRow(row as Map<String, dynamic>)).toList();
  }
}

extension NullSafeQueryFilters on QueryBuilder {
  QueryBuilder containsOrNull(String column, dynamic value) =>
      value != null ? contains(column, value) : this;
  QueryBuilder inFilterOrNull(String column, List<dynamic>? values) =>
      values != null ? inFilter(column, values) : this;
}

class PostgresTime {
  PostgresTime(this.time);
  DateTime? time;

  static PostgresTime? tryParse(String formattedString) {
    final datePrefix = DateTime.now().toIso8601String().split('T').first;
    return PostgresTime(
        DateTime.tryParse('${datePrefix}T$formattedString')?.toLocal());
  }

  String? toIso8601String() {
    return time?.toIso8601String().split('T').last;
  }

  @override
  String toString() {
    return toIso8601String() ?? '';
  }
}
