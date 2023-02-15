import 'dart:convert';
import 'package:flutter_fashion/core/storage/key.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:8000/api/v2.0/";

  Map<String, String>? _headers = {};

  ApiService() {
    _initHeader();
  }

  //call when app started
  void _initHeader() async {
    final token = HydratedBloc.storage.read(KeyStorage.token);
    //get token

    if (token != null) {
      _headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };
    }
  }

  void clearHeader() {
    _headers = null;
  }

  Future<http.Response> get(String url) async {
    return await http.get(
      Uri.parse("$baseUrl$url"),
      headers: _headers,
    );
  }

  Future<http.Response> post(String url, dynamic body,
      {bool isRequestHeader = true}) async {
    if (isRequestHeader) {
      if (_headers == null) {
        _initHeader();
      }
    }
    return await http.post(
      Uri.parse("$baseUrl$url"),
      headers: isRequestHeader ? _headers : null,
      body: body,
    );
  }

  Future<http.Response> put(String url, dynamic body) async {
    return await http.put(
      Uri.parse("$baseUrl$url"),
      headers: _headers,
      body: json.encode(body),
    );
  }

  Future<http.Response> delete(String url) async {
    return await http.delete(
      Uri.parse("$baseUrl$url"),
      headers: _headers,
    );
  }
}
