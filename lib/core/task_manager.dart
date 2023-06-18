import 'package:flutter_fashion/app/blocs/notification/notification_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/config/task.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print('task $task is running with data: $inputData');

    if (task == TaskManager.delNotification.taskName) {
      getIt.get<NotificationCubit>().delete(inputData!['id'] as int);
    }
    return Future.value(true);
  });
}
