import 'package:http/http.dart' as http;

import './exceptions.dart';
import '../../utils/utilities.dart';

class CheckResponse {
  void checkResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode <= 308) {
      return;
    }

    switch (response.statusCode) {
      case 400:
        throw BadRequestException(message: Utilities().getResponseError(response.body));
      case 401:
        throw UnauthorizedException();
      case 403:
        throw ForbiddenException();
      case 404:
        throw NotFoundException();
      case 422:
        throw BackendException(response.body);
      case 409:
        throw ConflictException();
      case 500:
        throw InternalServerException();
      case 502:
        throw BadGateWayException();
      default:
        throw InvalidException(statusCode: response.statusCode);
    }
  }

  bool checkOKStatus(http.Response response) {
    return response.statusCode == 200;
  }
}
