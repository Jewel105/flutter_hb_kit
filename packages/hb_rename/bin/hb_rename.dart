import 'package:args/command_runner.dart';
import 'package:hb_rename/command/hb_rename_command.dart';

void main(List<String> arguments) {
  CommandRunner('hb_rename', 'Changes name, bundle ID, etc.')
    ..addCommand(HbRenameCommand())
    ..run(arguments);
}
