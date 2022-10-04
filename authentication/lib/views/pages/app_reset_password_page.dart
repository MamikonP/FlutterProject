import 'package:flutter/material.dart';

import '../widgets.dart';

class AppResetPasswordPage extends StatelessWidget {

	const AppResetPasswordPage({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return AppPage(
			appBarTitle: '',
			body: AppResetPassword()
		);
	}
}
