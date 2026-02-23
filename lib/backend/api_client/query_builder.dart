class QueryBuilder {
  final Map<String, List<String>> _filters = {};
  String? _order;
  int? _limit;
  int? _offset;

  QueryBuilder eq(String field, dynamic value) => _add('eq', field, value);
  QueryBuilder neq(String field, dynamic value) => _add('neq', field, value);
  QueryBuilder gt(String field, dynamic value) => _add('gt', field, value);
  QueryBuilder gte(String field, dynamic value) => _add('gte', field, value);
  QueryBuilder lt(String field, dynamic value) => _add('lt', field, value);
  QueryBuilder lte(String field, dynamic value) => _add('lte', field, value);
  QueryBuilder contains(String field, dynamic value) =>
      _add('contains', field, value);
  QueryBuilder inFilter(String field, List<dynamic> values) {
    if (values.isEmpty) {
      return this;
    }
    _filters.putIfAbsent('in', () => []);
    _filters['in']!.add('$field:${values.join(",")}');
    return this;
  }

  QueryBuilder order(String field, {bool ascending = true}) {
    _order = '$field:${ascending ? "asc" : "desc"}';
    return this;
  }

  QueryBuilder limit(int value) {
    _limit = value;
    return this;
  }

  QueryBuilder offset(int value) {
    _offset = value;
    return this;
  }

  Map<String, String> toQueryParams() {
    final params = <String, String>{};
    _filters.forEach((key, values) {
      if (values.isNotEmpty) {
        params[key] = values.join('|');
      }
    });
    if (_order != null) {
      params['order'] = _order!;
    }
    if (_limit != null) {
      params['limit'] = _limit.toString();
    }
    if (_offset != null) {
      params['offset'] = _offset.toString();
    }
    return params;
  }

  QueryBuilder eqOrNull(String field, dynamic value) =>
      value == null ? this : eq(field, value);
  QueryBuilder neqOrNull(String field, dynamic value) =>
      value == null ? this : neq(field, value);
  QueryBuilder ltOrNull(String field, dynamic value) =>
      value == null ? this : lt(field, value);
  QueryBuilder lteOrNull(String field, dynamic value) =>
      value == null ? this : lte(field, value);
  QueryBuilder gtOrNull(String field, dynamic value) =>
      value == null ? this : gt(field, value);
  QueryBuilder gteOrNull(String field, dynamic value) =>
      value == null ? this : gte(field, value);

  QueryBuilder _add(String op, String field, dynamic value) {
    if (value == null) {
      return this;
    }
    _filters.putIfAbsent(op, () => []);
    _filters[op]!.add('$field:$value');
    return this;
  }
}
