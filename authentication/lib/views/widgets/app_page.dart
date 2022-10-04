import 'package:flutter/material.dart';

import '../../styles.dart';
import '../widgets.dart';

class AppPage extends StatelessWidget {

	const AppPage({
		Key? key,
		required this.body,
		this.appBarTitle,
		this.appBarActions,
		this.withHeader = false,
		this.withNav = false,
		this.scrollableBody = true,
		this.extendBody = false,
		this.theme = 'light',
		this.paddingTop,
		this.paddingRight,
		this.paddingBottom,
		this.paddingLeft
	}) : super(key: key);

	final Widget body;
	final String? appBarTitle;
	final List<Widget>? appBarActions;
	final bool withHeader;
	final bool withNav;
	final bool scrollableBody;
	final bool extendBody;
	final String? theme;
	final double? paddingTop;
	final double? paddingRight;
	final double? paddingBottom;
	final double? paddingLeft;

	@override
	Widget build(BuildContext context) {
		final Widget content = Container(
			padding: EdgeInsets.only(
				top: paddingTop ?? AppGaps.big,
				right: paddingRight ?? AppGaps.small,
				bottom: paddingBottom ?? AppGaps.big,
				left: paddingLeft ?? AppGaps.small
			),
			child: body
		);

		return Scaffold(
			extendBody: extendBody,

			backgroundColor: getBackgroundColor(),

			appBar: appBarTitle != null
				? AppBar(
					actions: appBarActions != null
						? <Widget> [
							Container(
								padding: EdgeInsets.only(right: AppGaps.small),
								child: Row(
									children: appBarActions!
								)
							)
						]
						: null,
					iconTheme: IconThemeData(
						color: getColor()
					),
					title: AppHeading(
						appBarTitle!,
						maxLines: 1,
						color: getColor()
					),
					toolbarHeight: 68,
					centerTitle: true,
					backgroundColor: getBackgroundColor(),
					elevation: 5,
					shadowColor: const Color.fromRGBO(0, 0, 0, 0.15)
				)
				: null,

			body: SafeArea(
				maintainBottomViewPadding: extendBody,
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: <Widget> [

						Expanded(
							child: scrollableBody == true
								? SingleChildScrollView(child: content)
								: content
						),
					]
				)
			),
		);
	}

	Color getIconColor() {
		switch (theme) {
			case 'dark':
				return AppColors.light;
			default:
				return AppColors.main;
		}
	}

	Color getBackgroundColor() {
		switch (theme) {
			case 'dark':
				return AppColors.main;
			default:
				return AppColors.light;
		}
	}

	Color getColor() {
		switch (theme) {
			case 'dark':
				return AppColors.light;
			default:
				return AppColors.main;
		}
	}
}
