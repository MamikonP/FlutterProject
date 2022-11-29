import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

import '../../data/constants.dart';
import '../shared/widgets.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    required this.image,
    required this.imageType,
    this.fit = BoxFit.cover,
    this.color,
    this.alignment = Alignment.center,
    super.key,
  });

  final String image;
  final ImageType imageType;
  final BoxFit fit;
  final Color? color;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    if (imageType == ImageType.network) {
      return CachedNetworkImage(
        imageUrl: image,
        progressIndicatorBuilder: (
          BuildContext context,
          String url,
          DownloadProgress progress,
        ) =>
            AppLoading(progress: progress.progress),
        errorWidget: (
          BuildContext context,
          String url,
          dynamic error,
        ) {
          return const Icon(Icons.error);
        },
        alignment: alignment,
      );
    } else if (imageType == ImageType.file) {
      return Image.file(
        File(image),
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
          return const Icon(Icons.error);
        },
        fit: fit,
        alignment: alignment,
      );
    } else {
      final String format = image.split('.')[1];
      switch (format) {
        case 'svg':
          return _svgImage();
        case 'pdf':
          return _pdfImage();
        default:
          return _pngImage();
      }
    }
  }

  Image _pngImage() => Image.asset(
        image,
        fit: fit,
        alignment: alignment,
      );

  SvgPicture _svgImage() => SvgPicture.asset(
        image,
        fit: fit,
        color: color,
        alignment: alignment,
      );

  Widget _pdfImage() {
    return PdfViewer.openAsset(
      image,
      params: const PdfViewerParams(
        panEnabled: false,
        pageDecoration: BoxDecoration(color: Colors.transparent),
        padding: 0,
        maxScale: 10,
      ),
    );
  }
}
