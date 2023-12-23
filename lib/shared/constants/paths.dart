class Paths {
  Paths._();

  static const String assets = 'lib/assets/';
  static const String images = 'lib/assets/images/';
  static const String fonts = 'lib/assets/fonts/';

  static String getAsset(String name) {
    return "$assets$name";
  }

  static String getImage(String name) {
    return "$images$name";
  }

  static String getFont(String name) {
    return "$fonts$name";
  }
}