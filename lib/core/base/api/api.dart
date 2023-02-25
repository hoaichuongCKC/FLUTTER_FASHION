import 'package:flutter/foundation.dart';
import 'package:flutter_fashion/core/storage/key.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ApiService {
  static const String hostDomain =
      "https://50b6-2405-4802-a232-c20-c150-1c3f-8c82-cd15.ap.ngrok.io";

  static const String imageUrl = "$hostDomain/storage/";

  static const String baseUrl = "$hostDomain/api/v2.0/";

  Map<String, String> _headers = {};

  Map<String, String> get headers => _headers;

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
    _headers = {};
  }

  Future<http.Response> get(String url) async {
    return await http.get(
      Uri.parse("$baseUrl$url"),
      headers: _headers,
    );
  }

  Future<http.StreamedResponse> post(String url,
      {Map<String, String>? body,
      bool isRequestHeader = true,
      XFile? image}) async {
    if (kDebugMode) {
      if (isRequestHeader) {
        if (_headers.isEmpty) {
          print("đang khởi tạo lại header do header == null");
          _initHeader();
        }
      }
      print("endpoint: $url,header api: $_headers");
    }

    final uri = Uri.parse("$baseUrl$url");

    http.MultipartRequest request = http.MultipartRequest('POST', uri)
      ..fields.addAll(body ?? {});

    if (isRequestHeader) {
      request.headers.addAll(_headers);
    }

    if (image != null) {
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('image', image.path);
      request.files.add(multipartFile);
    }

    //send request up to server
    http.StreamedResponse response = await request.send();
    return response;
  }
}
