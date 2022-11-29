import 'package:flutter/material.dart';

import '../../data/constants.dart';
import '../shared/widgets.dart';

class AppInput extends StatefulWidget {
  const AppInput({
    super.key,
    this.controller,
    this.header,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.isPassword = false,
    this.withBorder = true,
    this.includeHeader = false,
    this.enabled = true,
    this.initialValue,
    this.hintText,
    this.suffixWidget,
    this.prefixWidget,
    this.contentPadding,
  });

  final TextEditingController? controller;
  final String? header;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final bool isPassword;
  final bool withBorder;
  final bool includeHeader;
  final bool enabled;
  final String? hintText;
  final String? initialValue;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final EdgeInsets? contentPadding;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> with AppColors, AppGaps {
  final FocusNode _focusNode = FocusNode();
  bool _focused = false;
  late bool _obscure;
  late TextInputAction _textInputAction;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
    _textInputAction = _obscure ? TextInputAction.done : widget.textInputAction;
    _focusNode.addListener(() {
      setState(() {
        _focused = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget? suffixIcon = !widget.isPassword
        ? null
        : InkWell(
            onTap: () {
              setState(
                () {
                  _obscure = !_obscure;
                },
              );
            },
            child: SizedBox(
              width: 24,
              height: 24,
              child: AppImage(
                image: _obscure
                    ? 'assets/images/icons/eye-closed.svg'
                    : 'assets/images/icons/eye.svg',
                imageType: ImageType.asset,
                fit: BoxFit.none,
              ),
            ),
          );

    final Widget form = DecoratedBox(
      decoration: BoxDecoration(
        color: lightColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: <BoxShadow>[
          if (_focused) BoxShadow(blurRadius: 5, color: hoverColor),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.includeHeader && widget.header != null)
            Padding(
              padding: EdgeInsets.only(left: medium, top: medium),
              child: AppText(
                widget.header!,
                fontSize: 12,
                color: secondaryColor,
              ),
            ),
          Form(
            child: TextFormField(
              controller: widget.controller,
              enabled: widget.enabled,
              initialValue: widget.initialValue,
              textAlignVertical: TextAlignVertical.center,
              textCapitalization: widget.textCapitalization,
              textInputAction: _textInputAction,
              focusNode: _focusNode,
              obscureText: _obscure,
              keyboardType: widget.textInputType,
              decoration: InputDecoration(
                hintText: widget.hintText,
                contentPadding: widget.contentPadding ?? EdgeInsets.all(medium),
                border: !widget.withBorder
                    ? InputBorder.none
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                focusedBorder: !widget.withBorder
                    ? null
                    : OutlineInputBorder(
                        borderSide: BorderSide(color: dividerColor),
                      ),
                enabledBorder: !widget.withBorder
                    ? null
                    : OutlineInputBorder(
                        borderSide: BorderSide(color: dividerColor),
                      ),
                suffixIcon: widget.suffixWidget == null ? suffixIcon : null,
                suffix: _focused ? null : widget.suffixWidget,
                prefixIcon: widget.prefixWidget,
              ),
            ),
          ),
        ],
      ),
    );

    Widget field = form;

    if (widget.header != null && !widget.includeHeader) {
      field = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppText(
            widget.header!,
            fontSize: 12,
            color: secondaryColor,
          ),
          AppGap(smallest, direction: AppGapDirection.vertical),
          form,
        ],
      );
    }

    return field;
  }
}
