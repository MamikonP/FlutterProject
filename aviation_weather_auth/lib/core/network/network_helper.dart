import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import './base_exception.dart';
import './check_response.dart';
import '../../data/constants.dart';
import '../../data/data_sources/local/secure_storage.dart';
import 'exceptions.dart';

class NetworkHelper {
  factory NetworkHelper({required String baseUrl}) {
    return NetworkHelper._(baseUrl);
  }

  NetworkHelper._(this.baseUrl);

  String baseUrl;

  Future<String?> get _tokenInterceptor async {
    final String? token =
        await GetIt.instance<SecureStorage>().readData('token');
    return token;
  }

  Future<Map<String, String>> get _headers async {
    final Map<String, String> headers = <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final String? token = await _tokenInterceptor;
    if (token != null) {
      headers.addAll(<String, String>{HttpHeaders.authorizationHeader: token});
    }
    return headers;
  }

  Uri _buildUri(String endpoint, [Map<String, dynamic>? queryParams]) {
    return Uri.https(baseUrl, endpoint, queryParams);
  }

  Future<Map<String, String>> _addHeadersModifier(
      Map<String, String>? headers) async {
    if (headers != null) {
      (await _headers).addAll(headers);
    }
    return _headers;
  }

  Future<http.Response> _getResponse(
    String endpoint,
    String httpMethod, {
    Map<String, dynamic>? payload,
    Map<String, String>? headers,
  }) async {
    switch (httpMethod) {
      case 'get':
        return http.get(
          _buildUri(endpoint, payload),
          headers: await _addHeadersModifier(headers),
        );
      case 'post':
        return http.post(_buildUri(endpoint),
            body: jsonEncode(payload),
            headers: await _addHeadersModifier(headers));
      case 'put':
        return http.put(
          _buildUri(endpoint),
          body: jsonEncode(payload),
          headers: await _addHeadersModifier(headers),
        );
      case 'delete':
        return http.delete(
          _buildUri(endpoint, payload),
          headers: await _addHeadersModifier(headers),
        );
      default:
        throw BaseAppException(message: 'Invalid HTTP method $httpMethod');
    }
  }

  Future<http.Response> request(
    String endpoint,
    String httpMethod, {
    Map<String, dynamic>? payload,
    Map<String, String>? headers,
  }) async {
    try {
      final http.Response response = await _getResponse(endpoint, httpMethod,
          payload: payload, headers: headers);
      CheckResponse().checkResponse(response);
      return response;
    } on SocketException {
      throw const SocketException('Network error');
    } on TimeoutException {
      throw TimeoutException('Timeout to execute $httpMethod request');
    } on BackendException catch (e) {
      throw BackendException(e.message);
    } catch (e) {
      throw BaseAppException(message: e.toString());
    }
  }
}
