import 'base_exception.dart';

class InternalServerException extends BaseAppException {
	InternalServerException() : super(message: 'Error while communicating to the server');
}

class BadGateWayException extends BaseAppException {
	BadGateWayException() : super(message: 'Request failed due to server-side');
}

class BadRequestException extends BaseAppException {
	BadRequestException() : super(message: 'Invalid Request');
}

class UnauthorizedException extends BaseAppException {
	UnauthorizedException() : super(message: 'Unauthorized');
}

class ConflictException extends BaseAppException {
	ConflictException() : super(message: 'Conflict error');
}

class ForbiddenException extends BaseAppException {
	ForbiddenException() : super(message: 'No Access to perform the request');
}

class NotFoundException extends BaseAppException {
	NotFoundException() : super(message: 'Resource was not found or does not exist');
}

class InvalidException extends BaseAppException {
	InvalidException({required int statusCode, String message = ''})
		: super(message: 'Reponse failed with status code $statusCode: $message');
}

class BackendException implements Exception {
	BackendException(this.message);
	final Map<String, dynamic> message;
}

class ResponseEmptyException extends BaseAppException {
	ResponseEmptyException() : super(message: 'Response is null');
}
