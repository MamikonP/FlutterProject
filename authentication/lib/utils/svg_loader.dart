import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

// ignore: avoid_classes_with_only_static_members
class SvgLoader {
	static Widget withFallback(String localPath, String networkPath, {
		double? width, double? height
	}) {
		return FutureBuilder(
			future: _futureAssetWithFallback(localPath, networkPath),
			builder: (BuildContext context, snapshot) => snapshot.hasData
					? snapshot.data as Widget
					: CircularProgressIndicator(),
		);
	}

	static Future<SvgPicture> _futureAssetWithFallback(
			String localPath, String networkPath, {
				double? width, double? height
			}) async {
		if (await _isLocalAsset(localPath)) {
			return SvgPicture.asset(localPath, width: width, height: height,);
		}
		return SvgPicture.network(networkPath);
	}

	// Test if a file exists without throwing an Exception
	static Future<bool> _isLocalAsset(String assetPath) async {
		try {
			await rootBundle.loadString(assetPath);
			return true;
		} catch (_) {
			return false;
		}
	}
}
