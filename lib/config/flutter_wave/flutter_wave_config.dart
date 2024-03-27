
class FlutterWaveConfig{
  // Development
  static const String _testPublicKey = "FLWPUBK_TEST-895362a74986153380262d89bfdc9b8a-X";
  static const String _testEncryptionKey = "";

  // Production
  static const String _prodPublicKey = "FLWPUBK-7b6099ed229040478723735c0ec8e1ec-X";
  static const String _prodEncryptionKey = "5c86f7935b3b4596704a7520";


  // Live
  static bool isTestMode = true;
  static String publicKey = isTestMode == true ? _testPublicKey : _prodPublicKey;
  static String encryptionKey = isTestMode == true ? _testEncryptionKey : _prodEncryptionKey;
}