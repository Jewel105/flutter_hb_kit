class Template {
  static String androidManifestAppName = 'android:label="@string/app_name"';

  static String androidDartEnv = '''
def dartEnv = [
    APP_ENV: '_uat',
    APP_NAME: '_UAT',
]

if (project.hasProperty('dart-defines')) {
    dartEnv = dartEnv + project.property('dart-defines')
        .split(',')
        .collectEntries { entry ->
            def pair = new String(entry.decodeBase64(), 'UTF-8').split('=')
            def key1 =  "KEY1"
            def value1 = "VALUE1"
            if(pair.first()=='APP_ENV'){
                key1 = "APP_NAME"
                value1 = pair.last()=='pro'?'':'_UAT'
            }
            [
                (key1): value1,
                (pair.first()): pair.last()=='pro'?'':"_\${pair.last()}"
            ]
        }
        println dartEnv
}
''';

  static String getNamespaceString(String bundleId) {
    return 'namespace = "$bundleId"';
  }

  static String getApplicationId(String bundleId) {
    return 'applicationId = "$bundleId\${dartEnv.APP_ENV}"';
  }

  static String getResValueAppName(String appName) {
    return '    resValue "string","app_name","$appName\${dartEnv.APP_NAME}"';
  }
}
