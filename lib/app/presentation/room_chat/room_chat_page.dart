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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/admin.png"),
                const SizedBox(height: 5.0),
                Text(
                  "Chúng tôi trực page 24/7",
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const ChatList(),
          const TaskbarChatMessage(),
        ],
      ),
    );
  }
}
