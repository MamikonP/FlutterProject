import 'package:flutter/material.dart';

enum FormKey{fromAmount, toAmount}

extension TransactionConvertFormExtension on FormKey {
	GlobalKey<FormState> get key => GlobalKey<FormState>();
}
