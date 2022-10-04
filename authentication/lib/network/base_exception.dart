class BaseAppException implements Exception {

	BaseAppException({
		this.message = ''
	});

	final String message;

	@override
	String toString() {
		return message;
	}
}
