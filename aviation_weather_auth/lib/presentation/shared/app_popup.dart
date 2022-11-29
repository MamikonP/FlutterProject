import 'package:flutter/material.dart';

Future<void> showPopup(
		BuildContext context,
		{
		required Widget title,
		required Widget content,
		required List<Widget> actions,
		Color backgroundColor = Colors.white}) async {
	await showDialog(
		context: context,
		barrierDismissible: false,
		builder: (BuildContext context) {
			return WillPopScope(
				onWillPop: () async => false,
				child: AlertDialog(
					title: title,
					content: content,
					actions: actions,
					elevation: 1,
					backgroundColor: backgroundColor,
					actionsAlignment: MainAxisAlignment.center,
				),
			);
		}
	);
}
