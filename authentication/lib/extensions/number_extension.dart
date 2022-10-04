extension NumberExtension on double {
	num removeTrailingZeros() {
		final String number = toString();
		if(number.contains('.')){
			return num.parse(number.replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), ''));
		}
		return num.parse(number);
	}
}
