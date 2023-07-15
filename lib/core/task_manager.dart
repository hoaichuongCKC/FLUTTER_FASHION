import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/config/task.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print('task $task is running with data: $inputData');

    if (task == TaskManager.updateBadgeNoti.taskName) {}
    return Future.value(true);
  });
}
