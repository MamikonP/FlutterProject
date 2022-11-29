enum Auth { google, facebook, apple }

enum ImageType { network, asset, file }

enum AppGapDirection { horizontal, vertical }

enum AuthType { signIn, signUp }

enum AuthPasswordType { forgot, reset }

enum SnackbarState { success, info, error }

abstract class AppConstants {
  static const String BASE_URL = 'BASE_URL';
  static const String SUPPORT_EMAIL = 'SUPPORT_EMAIL';
  static const double DEFAULT_BACKGROUND_HEIGHT = 300;
}
