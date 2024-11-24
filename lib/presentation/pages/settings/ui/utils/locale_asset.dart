abstract final class LocaleAsset {
  static String localeAssetFromLocalName(String localeName) {
    return switch (localeName) {
      'en' => 'assets/raw/offline_unique/flags/uk.png',
      'ru' => 'assets/raw/offline_unique/flags/russia.png',
      'es' => 'assets/raw/offline_unique/flags/spain.png',
      'de' => 'assets/raw/offline_unique/flags/germany.png',
      'hi' => 'assets/raw/offline_unique/flags/india.png',
      'zh' => 'assets/raw/offline_unique/flags/china.png',
      _ => throw UnimplementedError(),
    };
  }
}
