import 'package:flutter/material.dart';

import '../widgets.dart';

class AppRegisterPage extends StatelessWidget {

	const AppRegisterPage({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return AppPage(
			appBarTitle: '',
			body: AppRegister()
		);
	}
}
