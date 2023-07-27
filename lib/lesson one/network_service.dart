import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'contact_model.dart';

sealed class Network {
  static const String baseUrl = "64bd50f62320b36433c79a2c.mockapi.io";

  static const apiContacts = "kenzo/contacts";


  static const Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
  };

  static Future<String?> methodGet({required String api, Object? id, Map<String, String> headers = headers, String baseUrl = baseUrl}) async {
    try {
      Uri url = Uri.https(baseUrl, "$api${id != null ? "/$id" : ""}");
      final response = await http.get(url, headers: headers);
      if(response.statusCode == 200) {
        // return response.body;
        return utf8.decoder.convert(response.bodyBytes);
      }
    } catch(e) {
      return null;
    }
    return null;
  }

  static Future<void> methodDelete({required String api, required Object id, Map<String, String> headers = headers, String baseUrl = baseUrl}) async {
    try {
      Uri url = Uri.https(baseUrl, "$api/$id");
      final response = await http.delete(url);
      if(response.statusCode == 200) {
        debugPrint(response.body);
      }
    } catch(e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> methodPost({required String api, Map<String, String> headers = headers, String baseUrl = baseUrl, required Map<String, Object?> data}) async {
    try {
      Uri url = Uri.https(baseUrl, api);
      final response = await http.post(url, body: jsonEncode(data));
      if(response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.body);
      }
    } catch(e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> methodPut({required String api, required Object id, Map<String, String> headers = headers, String baseUrl = baseUrl, required Map<String, Object?> data}) async {
    try {
      Uri url = Uri.https(baseUrl, "$api/$id");
      final response = await http.put(url, body: jsonEncode(data));
      if(response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.body);
      }
    } catch(e) {
      debugPrint(e.toString());
    }
  }

  static List<Contact> parseContact(String body) {
    final json = jsonDecode(body) as List;
    return json.map((e) => Contact.fromJson(e as Map<String, Object?>)).toList();
  }
}