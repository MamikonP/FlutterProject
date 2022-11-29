import 'package:url_launcher/url_launcher.dart';

import '../data/constants.dart';
import 'mapper_service.dart';

class EmailService {
  Future<bool> sendEmail() async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: AppConstants.SUPPORT_EMAIL,
      queryParameters: MapperService().encodeQueryParameters(
        <String, dynamic>{
          'subject': 'Feedback',
        },
      ),
    );
    if (await canLaunchUrl(uri)) {
      return launchUrl(uri);
    }
    return false;
  }
}
