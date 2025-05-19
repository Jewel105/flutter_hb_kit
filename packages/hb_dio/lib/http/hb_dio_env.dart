enum EnvType { development, production }

class HbDioEnv {
  final EnvType envType;
  final String baseUrl;

  HbDioEnv({required this.baseUrl, required this.envType});
}
