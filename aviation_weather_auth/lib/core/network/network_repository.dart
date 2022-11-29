import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import './base_exception.dart';
import './network_helper.dart';
import '../../data/constants.dart';
import 'exceptions.dart';

class NetworkRepository {
  NetworkRepository({String? baseUrl}) {
    if (baseUrl != null && _networkHelper.baseUrl != baseUrl) {
      _networkHelper.baseUrl = baseUrl;
    } else {
      _networkHelper.baseUrl = AppConstants.BASE_URL;
    }
  }

  final NetworkHelper _networkHelper = GetIt.instance<NetworkHelper>();

  String? _getResponseError(dynamic e) {
    final dynamic error = jsonDecode(e.toString());
    if (error == null) {
      return null;
    }
    if (error.runtimeType == List) {
      String errorMessage = '';
      for (final Map<String, dynamic> err in error) {
        errorMessage += '${err['msg']}: ${err['param']}\n';
      }
      return errorMessage;
    }
    final Map<String, dynamic> err = error as Map<String, dynamic>;
    if (err.containsKey('message')) {
      return err['message'] as String;
    }
    return '${err['msg']}: ${err['param']}';
  }

  Future<String> request(
      {required String endpoint,
      required String httpMethod,
      Map<String, dynamic>? payload,
      Map<String, String>? headers}) async {
    try {
      final http.Response response = await _networkHelper
          .request(endpoint, httpMethod, payload: payload, headers: headers);
      return response.body;
    } on BackendException catch (e) {
      throw BackendException(_getResponseError(e.message) ?? e.message);
    } catch (e) {
      throw BaseAppException(message: e.toString());
    }
  }
}
