import 'package:app/utils/get_auth_token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenericApiRepository<T> {
  final String baseUrl;

  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;

  GenericApiRepository({
    required this.baseUrl,
    required this.fromJson,
    required this.toJson,
  });
  Future<Map<String, String>> _headers() async {
    final token = await getAuthToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Uri _uri({String path = '', Map<String, dynamic>? queryParameters}) {
    final base = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;

    final uri = Uri.parse('$base$path');

    if (queryParameters != null) {
      return uri.replace(
        queryParameters: queryParameters.map(
          (k, v) => MapEntry(k, v.toString()),
        ),
      );
    }

    return uri;
  }
  // Uri _uri([String path = '']) => Uri.parse('$baseUrl$path');

  void _checkStatus(http.Response res, String action) {
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Ошибка $action: ${res.statusCode}, body: ${res.body}');
    }
  }

  Future<T> create(T item) async {
    final res = await http.post(
      _uri(),
      headers: await _headers(),
      body: jsonEncode(toJson(item)),
    );

    _checkStatus(res, 'CREATE');

    return item;
  }
  Future<List<T>> getAll() async {
    final res = await http.get(_uri(), headers: await _headers());

    _checkStatus(res, 'GET ALL');
    final List data = jsonDecode(res.body);
    return data.map((e) => fromJson(e)).toList();
  }

  Future<T?> get(String id) async {
    final res = await http.get(_uri(path: '/$id'), headers: await _headers());

    if (res.statusCode == 404) return null;

    _checkStatus(res, 'GET');

    return fromJson(jsonDecode(res.body));
  }

  Future<T> update(T item, String id) async {
    final res = await http.patch(
      _uri(path: '/$id'),
      headers: await _headers(),
      body: jsonEncode(toJson(item)),
    );

    //body: jsonEncode(toJson(item))
    _checkStatus(res, 'UPDATE');

    return res.body.isNotEmpty ? fromJson(jsonDecode(res.body)) : item;
  }

  Future<void> delete(String id) async {
    final res = await http.delete(
      _uri(path: '/$id'),
      headers: await _headers(),
    );

    _checkStatus(res, 'DELETE');
  }

  Future<List<T>> search(String query) async {
    if (query.trim().isEmpty) {
      return getAll();
    }

    final res = await http.get(
      _uri(queryParameters: {'search': query}),
      headers: await _headers(),
    );

    _checkStatus(res, 'SEARCH');

    final List data = jsonDecode(res.body);
    return data.map((e) => fromJson(e)).toList();
  }

  Future<List<T>> getByDate(DateTime date) async {
    final formattedDate =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    final res = await http.get(
      _uri(queryParameters: {'date': formattedDate}),
      headers: await _headers(),
    );

    _checkStatus(res, 'GET items by date');
    final List data = jsonDecode(res.body);
    return data.map((e) => fromJson(e)).toList();
  }
}
