import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RestService {
  //static const String _baseUrl = 'http://192.168.0.16:59000';
  //static const String _baseUrl = 'http://localhost:59000';
  final String _baseUrl;
  const RestService({@required baseUrl}) : _baseUrl = baseUrl;
  // Send a GET request to retrieve data from a REST server
  Future get(String endpoint ) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
//        HttpHeaders.authorizationHeader: token,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      print(
          "================================================================================");
      print(
          "==================================UNAUTHORIZED==================================");
      print(
          "================================================================================");
    } else
      print(response.statusCode);
    throw response;
  }

  Future postCreate(String endpoint, {dynamic data}) async {
    Map<String, dynamic> unhandledNull = data.toJson(); //id: null
    unhandledNull.removeWhere((key, value) => key == null || value == null); //
    var fixedData = jsonEncode(unhandledNull);
    //var handledNull = unhandledNull.toString();
    final response = await http.post(Uri.parse('$_baseUrl/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
//          'Authorization': 'bearer {token}',
        },
        body: fixedData);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future postBook(String endpoint, String token, {dynamic data}) async {
    Map<String, dynamic> unhandledNull = data.toJson(); //id: null
    unhandledNull.removeWhere((key, value) => key == null || value == null); //
    var fixedData = jsonEncode(unhandledNull);
    //var handledNull = unhandledNull.toString();
    final response = await http.post(Uri.parse('$_baseUrl/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: token,
        },
        body: fixedData);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future post(String endpoint, {dynamic data}) async {
    final response = await http.post(Uri.parse('$_baseUrl/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
//          'Authorization': 'bearer {token}',
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      return null;
    }
    throw response;
  }

  Future put(String endpoint,  {dynamic data}) async {
    final response = await http.put(Uri.parse('$_baseUrl/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
//          HttpHeaders.authorizationHeader: token,
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future postBook2(String endpoint, String token, {dynamic data}) async {
    final response = await http.post(Uri.parse('$_baseUrl/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: token,
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future patch(String endpoint, {dynamic data}) async {
    final response = await http.patch(Uri.parse('$_baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  // Send a DELETE request to remove an existing data from the REST server.
  Future delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      return;
    }
    throw response;
  }
}
