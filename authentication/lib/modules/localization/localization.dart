import 'package:get/get.dart';

class Localization extends Translations {
	late Map<String, Map<String, String>> locales;

	@override
  Map<String, Map<String, String>> get keys => locales;
}
