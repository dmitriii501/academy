import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient._();

  static final ApiClient instance = ApiClient._();

  String baseUrl = const String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8000/api',
  );

  String? _accessToken;

  void setAccessToken(String? token) => _accessToken = token;

  final Map<String, _CacheEntry> _cache = {};

  Future<List<dynamic>> getList(
    String path, {
    Map<String, String>? query,
    Duration? cacheTtl,
  }) async {
    final uri = _buildUri(path, query);
    final cacheKey = uri.toString();
    if (cacheTtl != null) {
      final cached = _cache[cacheKey];
      if (cached != null && cached.isValid) {
        return cached.data as List<dynamic>;
      }
    }

    final response = await http.get(uri, headers: _headers());
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = json.decode(response.body) as List<dynamic>;
      if (cacheTtl != null) {
        _cache[cacheKey] = _CacheEntry(data, cacheTtl);
      }
      return data;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> getMap(
    String path, {
    Map<String, String>? query,
  }) async {
    final uri = _buildUri(path, query);
    final response = await http.get(uri, headers: _headers());
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, String>? query,
    Map<String, dynamic>? body,
  }) async {
    final uri = _buildUri(path, query);
    final response = await http.post(
      uri,
      headers: _headers(contentTypeJson: true),
      body: json.encode(body ?? {}),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<dynamic>> patch(
    String path, {
    Map<String, String>? query,
    Map<String, dynamic>? body,
  }) async {
    final uri = _buildUri(path, query);
    final response = await http.patch(
      uri,
      headers: _headers(contentTypeJson: true),
      body: json.encode(body ?? {}),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body) as List<dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<List<dynamic>> delete(
    String path, {
    Map<String, String>? query,
  }) async {
    final uri = _buildUri(path, query);
    final response = await http.delete(uri, headers: _headers());
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body) as List<dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }

  Uri _buildUri(String path, Map<String, String>? query) {
    final uri = Uri.parse('$baseUrl$path');
    return uri.replace(queryParameters: query ?? {});
  }

  Map<String, String> _headers({bool contentTypeJson = false}) {
    final headers = <String, String>{};
    if (_accessToken != null && _accessToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_accessToken';
    }
    if (contentTypeJson) {
      headers['Content-Type'] = 'application/json';
    }
    return headers;
  }
}

class ApiException implements Exception {
  ApiException(this.statusCode, this.body);
  final int statusCode;
  final String body;

  @override
  String toString() => 'ApiException($statusCode): $body';
}

class _CacheEntry {
  _CacheEntry(this.data, Duration ttl)
      : expiresAt = DateTime.now().add(ttl);

  final dynamic data;
  final DateTime expiresAt;

  bool get isValid => DateTime.now().isBefore(expiresAt);
}
