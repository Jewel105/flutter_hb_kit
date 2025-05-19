enum HbEnvType { development, production }

class HbDioEnv {
  final HbEnvType envType;
  final String baseUrl;

  HbDioEnv({required this.baseUrl, required this.envType});
}
