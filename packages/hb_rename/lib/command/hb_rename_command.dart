import 'package:args/command_runner.dart';
import 'package:hb_rename/util/_android_tool.dart';

// dart run hb_rename all -a MyApp -b com.example.myapp
class HbRenameCommand extends Command {
  @override
  String get description => "Rename package name, app name, and bundle ID.";

  @override
  String get name => "all";

  /// 添加参数解析
  /// add arguments to the command
  HbRenameCommand() {
    /// -a or --app-name 新应用名
    argParser.addOption(
      'app-name',
      abbr: 'a',
      help: 'New app name to apply in the project (e.g., My Awesome App).',
    );

    /// -b or --blundle-id 新应用名
    argParser.addOption(
      'blundle-id',
      abbr: 'b',
      help:
          'New bundle identifier and application Id (e.g., com.example.myapp). Applies to Android and iOS.',
    );
  }

  @override
  Future<void> run() async {
    // 解析命令行参数
    // parse command line arguments
    String? appName = argResults?['app-name'];
    String? bundleId = argResults?['blundle-id'];

    AndroidTool.resetApp(appName, bundleId);
  }
}
