import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_fashion/core/storage/key.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ApiService {
  final String baseUrl =
      "https://ab1b-2405-4802-a215-e920-6434-3fc5-2ba9-d149.ap.ngrok.io/api/v2.0/";

  Map<String, String>? _headers = {};

  ApiService() {
    _initHeader();
  }

  //call when app started
  Future _initHeader() async {
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
        if (kDebugMode) {
          print("đang khởi tạo lại header do header == null");
        }
        _initHeader();
      }
    }
    if (kDebugMode) {
      print("endpoint: $url,header api: $_headers");
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
