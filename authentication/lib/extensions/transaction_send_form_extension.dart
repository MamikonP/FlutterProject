import 'package:flutter/material.dart';

enum FormKey{toWalletAddress, amount}

extension TransactionSendFormExtension on FormKey {
	GlobalKey<FormState> get key => GlobalKey<FormState>();
}
