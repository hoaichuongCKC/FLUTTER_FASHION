import 'package:flutter_fashion/app/blocs/notification/notification_cubit.dart';
import 'package:flutter_fashion/app/models/notification/notification_model.dart';
import 'package:flutter_fashion/export.dart';

import '../../../common/components/app/background_app.dart';

class NotificationDetailPage extends StatelessWidget {
  const NotificationDetailPage({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    late List<NotificationModel> notifications;
    if (name == "chat") {
      notifications =
          context.watch<NotificationCubit>().state.notificationsChat;
    } else if (name == "order") {
      notifications =
          context.watch<NotificationCubit>().state.notificationsChat;
    }
    notifications = context.watch<NotificationCubit>().state.notificationsChat;
    return AppBackgroundBlur.normal(
      child: Column(
        children: [],
      ),
    );
  }
}
