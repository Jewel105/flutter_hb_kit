class Template {
  // android template
  static String androidManifestAppName = 'android:label="@string/app_name"';

  static String androidDartEnvGradle = '''
def dartEnv = [
    APP_ENV: '_dev',
    APP_NAME: '_DEV',
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
                value1 = pair.last()=='pro'?'':'_DEV'
            }
            [
                (key1): value1,
                (pair.first()): pair.last()=='pro'?'':"_\${pair.last()}"
            ]
        }
        println dartEnv
}
''';

  static String androidDartEnvKts = '''
import java.util.Base64

val dartEnv = mutableMapOf(
    "APP_ENV" to "_dev",
    "APP_NAME" to "_DEV"
)

if (project.hasProperty("dart-defines")) {
    val dartDefines = (project.property("dart-defines") as String)
        .split(",")
        .map { encoded ->
            val decodedBytes = Base64.getDecoder().decode(encoded)
            val decoded = String(decodedBytes, Charsets.UTF_8)
            decoded.split("=")
        }

    dartDefines.forEach { pair ->
        if (pair.size == 2) {
            val key = pair[0]
            val value = pair[1]

            if (key == "APP_ENV") {
                dartEnv["APP_NAME"] = if (value == "pro") "" else "_DEV"
            }
            dartEnv[key] = if (value == "pro") "" else "_\${value}"
        }
    }

    println(dartEnv)
}
''';

  static String getNamespaceString(String bundleId) {
    return 'namespace = "$bundleId"';
  }

  static String getApplicationId(String bundleId, bool isKts) {
    if (isKts) {
      return 'applicationId = "$bundleId\${dartEnv["APP_ENV"]}"';
    }
    return 'applicationId = "$bundleId\${dartEnv.APP_ENV}"';
  }

  static String getResValueAppName(String appName, bool isKts) {
    if (isKts) {
      return '        resValue("string", "app_name", "$appName\${dartEnv["APP_NAME"]}")';
    }
    return '        resValue "string", "app_name", "$appName\${dartEnv.APP_NAME}"';
  }

  // ios template
  static String iosDisplayName = '''
<key>CFBundleDisplayName</key>
	<string>\${APP_NAME}</string>''';

  static String xConfig = '#include "DartEnvConfig.xcconfig"';

  static String getXcScheme(String appName) {
    return '''
      <PreActions>
         <ExecutionAction
            ActionType = "Xcode.IDEStandardExecutionActionsCore.ExecutionActionType.ShellScriptAction">
            <ActionContent
               title = "Run Script"
               scriptText = "# Type a script or drag a script file from your workspace to insert its path.&#10;function entry_decode() { echo &quot;\${*}&quot; | base64 --decode; }&#10;&#x200b;&#10;IFS=&apos;,&apos; read -r -a define_items &lt;&lt;&lt; &quot;\$DART_DEFINES&quot;&#10;&#x200b;&#10;result=[]&#10;resultIndex=0&#10;result[0]=&quot;APP_NAME=${appName}_DEV&quot;&#10;result[1]=&quot;APP_SUFFIX=.dev&quot;;&#10;&#x200b;&#10;for index in &quot;\${!define_items[@]}&quot;&#10;do&#10;    if [ \$(entry_decode &quot;\${define_items[\$index]}&quot;) == &quot;APP_ENV=dev&quot; ]; then&#10;        result[\$resultIndex]=&quot;APP_NAME=${appName}_DEV&quot;;&#10;        resultIndex=\$((resultIndex+1))&#10;        result[\$resultIndex]=&quot;APP_SUFFIX=.dev&quot;;&#10;    fi&#10;&#x200b;&#10;    if [ \$(entry_decode &quot;\${define_items[\$index]}&quot;) == &quot;APP_ENV=pro&quot; ]; then&#10;        result[\$resultIndex]=&quot;APP_NAME=$appName&quot;;&#10;        resultIndex=\$((resultIndex+1))&#10;        result[\$resultIndex]=&quot;APP_SUFFIX=&quot;;&#10;    fi&#10;done&#10;&#x200b;&#10;printf &quot;%s\\n&quot; &quot;\${result[@]}&quot;|grep &apos;^APP_&apos; &gt; \${SRCROOT}/Flutter/DartEnvConfig.xcconfig&#10;">
               <EnvironmentBuildable>
                  <BuildableReference
                     BuildableIdentifier = "primary"
                     BlueprintIdentifier = "97C146ED1CF9000F007C117D"
                     BuildableName = "Runner.app"
                     BlueprintName = "Runner"
                     ReferencedContainer = "container:Runner.xcodeproj">
                  </BuildableReference>
               </EnvironmentBuildable>
            </ActionContent>
         </ExecutionAction>
      </PreActions>''';
  }

  static String getIosBundleId(String bundleId) {
    return 'PRODUCT_BUNDLE_IDENTIFIER = "$bundleId\${APP_SUFFIX}";';
  }

  static String getMainTitle(String appName) {
    return 'title: "$appName",';
  }

  // macos tempalte
  static String getMacXcScheme(String appName) {
    return '''
      <PreActions>
         <ExecutionAction
            ActionType = "Xcode.IDEStandardExecutionActionsCore.ExecutionActionType.ShellScriptAction">
            <ActionContent
               title = "Run Script"
               scriptText = "# Type a script or drag a script file from your workspace to insert its path.&#10;function entry_decode() { echo &quot;\${*}&quot; | base64 --decode; }&#10;&#x200b;&#10;IFS=&apos;,&apos; read -r -a define_items &lt;&lt;&lt; &quot;\$DART_DEFINES&quot;&#10;&#x200b;&#10;result=[]&#10;resultIndex=0&#10;result[0]=&quot;APP_NAME=${appName}_DEV&quot;&#10;result[1]=&quot;APP_SUFFIX=.dev&quot;;&#10;&#x200b;&#10;for index in &quot;\${!define_items[@]}&quot;&#10;do&#10;    if [ \$(entry_decode &quot;\${define_items[\$index]}&quot;) == &quot;APP_ENV=dev&quot; ]; then&#10;        result[\$resultIndex]=&quot;APP_NAME=${appName}_DEV&quot;;&#10;        resultIndex=\$((resultIndex+1))&#10;        result[\$resultIndex]=&quot;APP_SUFFIX=.dev&quot;;&#10;    fi&#10;&#x200b;&#10;    if [ \$(entry_decode &quot;\${define_items[\$index]}&quot;) == &quot;APP_ENV=pro&quot; ]; then&#10;        result[\$resultIndex]=&quot;APP_NAME=$appName&quot;;&#10;        resultIndex=\$((resultIndex+1))&#10;        result[\$resultIndex]=&quot;APP_SUFFIX=&quot;;&#10;    fi&#10;done&#10;&#x200b;&#10;printf &quot;%s\\n&quot; &quot;\${result[@]}&quot;|grep &apos;^APP_&apos; &gt; \${SRCROOT}/Flutter/DartEnvConfig.xcconfig&#10;">
               <EnvironmentBuildable>
                  <BuildableReference
                     BuildableIdentifier = "primary"
                     BlueprintIdentifier = "33CC10EC2044A3C60003C045"
                     BuildableName = "$appName.app"
                     BlueprintName = "Runner"
                     ReferencedContainer = "container:Runner.xcodeproj">
                  </BuildableReference>
               </EnvironmentBuildable>
            </ActionContent>
         </ExecutionAction>
      </PreActions>''';
  }
}
