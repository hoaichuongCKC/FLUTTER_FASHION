import 'package:flutter_fashion/app/presentation/room_chat/components/chat_list.dart';
import 'package:flutter_fashion/app/presentation/room_chat/components/task_bar_chat.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';
import '../../../export.dart';

enum ScreenType { titleCenter, normal }

class RoomChatMessagePage extends StatelessWidget {
  const RoomChatMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.normal(
      title: AppLocalizations.of(context)!.messenger,
      child: Column(
        children: const [
          ChatList(),
          TaskbarChatMessage(),
        ],
      ),
    );
  }
}
