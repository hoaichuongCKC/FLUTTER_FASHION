/// Represents the app routes and their paths.
enum TaskManager {
  delNotification(
    uniqueName: 'del-notification-unique',
    taskName: 'del-notification-task',
  );

  const TaskManager({
    required this.uniqueName,
    required this.taskName,
  });

  final String uniqueName;

  final String taskName;

  @override
  String toString() => taskName;
}
