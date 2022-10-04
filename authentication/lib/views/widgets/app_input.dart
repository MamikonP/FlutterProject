import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../styles.dart';

enum Type {text, password}

class AppInput extends StatefulWidget {

	const AppInput({
		Key? key,
		this.controller,
		this.placeholder = '',
		this.obscureText = false,
		this.type = Type.text,
		this.icon,
		this.onChanged,
		this.onTap,
		this.validator,
		this.formKey,
		this.suffixWidget,
		this.suffixIconConstraints,
		this.transparentBorder = false,
		this.initialValue,
		this.textInputType,
		this.maxLines = 1,
		this.errorMaxLines
	}) : super(key: key);

	final TextEditingController? controller;
	final String placeholder;
	final Type type;
	final String? icon;
	final bool obscureText;
	final void Function(String)? onChanged;
	final void Function()? onTap;
	final String? Function(String)? validator;
	final GlobalKey<FormState>? formKey;
	final Widget? suffixWidget;
	final BoxConstraints? suffixIconConstraints;
	final bool transparentBorder;
	final String? initialValue;
	final TextInputType? textInputType;
	final int? maxLines;
	final int? errorMaxLines;

	@override
	State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
	final FocusNode _focusNode = FocusNode();
	bool firstValidate = true;
	bool firstTyping = true;

	@override
	void initState() {
		super.initState();
		_focusNode.addListener(() {
			if (! _focusNode.hasFocus) {
				if (widget.formKey?.currentState != null && ! firstTyping) {
					widget.formKey?.currentState!.validate();
				}
			}
			setState(() {
			});
		});
	}

	@override
	void dispose() {
		super.dispose();
		_focusNode.dispose();
	}

	@override
	Widget build(BuildContext context) {
		final double rightPadding = widget.type == Type.password ? 8 : 16;

		final Widget? prefixIcon = widget.icon != null
			? SizedBox(
					width: 24,
					height: 24,
					child: Center(
						child: SvgPicture.asset(
							'assets/images/icons/${widget.icon}.svg',
							color: AppColors.main
						)
					)
				)
			: null;

		final Widget? suffixIcon = widget.type == Type.password
			? SizedBox(
					width: 24,
					height: 24,
					child: Center(
						child: GestureDetector(
							behavior: HitTestBehavior.translucent,
							onTap: () {
								if (widget.onTap != null) {
									widget.onTap!();
								}
								_focusNode.canRequestFocus = true;
							},
							child: SvgPicture.asset(widget.obscureText
								? 'assets/images/icons/hidden.svg'
								: 'assets/images/icons/visible.svg'
							)
						),
					)
				)
			: widget.suffixWidget;

		return Form(
			key: widget.formKey,
			child: TextFormField(
				inputFormatters: widget.textInputType == 
					const TextInputType.numberWithOptions(decimal: true)
					? <TextInputFormatter>[
						FilteringTextInputFormatter.deny(r',', replacementString: '.')
					]
					: null,
				maxLines: widget.maxLines,
				keyboardType: widget.textInputType,
				initialValue: widget.initialValue,
				focusNode: _focusNode,
				controller: widget.controller,
				obscureText: widget.obscureText,
				decoration: InputDecoration(
					errorMaxLines: widget.errorMaxLines,
					suffixIconConstraints: widget.suffixIconConstraints,
					prefixIcon: prefixIcon,
					suffixIcon: suffixIcon,
					border: OutlineInputBorder(
						borderRadius: BorderRadius.circular(8),
					),
					focusedBorder: widget.transparentBorder
						? OutlineInputBorder(
								borderSide: BorderSide(color: AppColors.transparent),
						)
						: _defaultInputBorder(),
					enabledBorder: widget.transparentBorder
						? const OutlineInputBorder(
								borderSide: BorderSide(color: Colors.transparent),
						) 
						: widget.controller?.text != '' ? _defaultInputBorder() : null,
					errorBorder: _defaultInputBorder(),
					focusedErrorBorder: _defaultInputBorder(),
					hintText: _focusNode.hasFocus ? null : widget.placeholder,
					hintStyle: _focusNode.hasFocus ? null : const TextStyle(fontSize: 14),
					contentPadding: EdgeInsets.fromLTRB(16, 12, rightPadding, 12),
				),
				style: const TextStyle(
					fontSize: 16
				),
				onChanged: (String value) {
					if (widget.onChanged != null) {
						widget.onChanged!(value);
					}
					if (widget.formKey?.currentState != null
						&& ! firstValidate && ! firstTyping) {
						widget.formKey?.currentState!.validate();
					}
					if (firstTyping) {
						setState(() => firstTyping = false);
					}
				},
				onFieldSubmitted: (String value) {
					if (widget.formKey?.currentState != null) {
						widget.formKey?.currentState!.validate();
					}
				},
				validator: (String? value) {
					if (widget.validator != null) {
						setState(() => firstValidate = false);
						return value == null ? null : widget.validator!(value);
					}
					return null;
				}
			)
		);
	}

	OutlineInputBorder _defaultInputBorder() {
		return OutlineInputBorder(
			borderRadius: BorderRadius.circular(8),
			borderSide: BorderSide(color: AppColors.main)
		);
	}
}
