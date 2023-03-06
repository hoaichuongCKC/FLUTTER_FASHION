import 'package:flutter_fashion/app/presentation/room_chat/components/task_bar_chat.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';

import '../../../export.dart';

enum ScreenType { titleCenter, normal }

class RoomChatMessagePage extends StatelessWidget {
  const RoomChatMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.normal(
      title: 'Tin nhắn',
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              child: Column(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: disableDarkColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage("assets/images/admin.png"),
                      ),
                    ),
                    child: const SizedBox(
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Chủ shop',
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 16.0,
                        color: darkColor.withOpacity(0.2),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding - 4),
                itemExtent: 100,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    color: primaryColor,
                    margin: const EdgeInsets.only(bottom: 15.0),
                  );
                },
              ),
            ),
            const TaskbarChatMessage(),
          ],
        ),
      ),
    );
  }
}
