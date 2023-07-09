/// Represents the app routes and their paths.
enum TaskManager {
  updateBadgeNoti(
    uniqueName: 'update-badge-noti-unique',
    taskName: 'update-badge-noti-task',
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
