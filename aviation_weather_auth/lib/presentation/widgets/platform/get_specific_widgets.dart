import '../../../utils/utilities.dart';
import 'abstract_widgets.dart';
import 'cupertino_widgets.dart';
import 'material_widgets.dart';

IWidgetsFactory getWidgetsFactory() {
  if (Utilities.isIOSPlatform) {
    return CupertinoWidgetsFactory();
  }
  return MaterialWidgetsFactory();
}
