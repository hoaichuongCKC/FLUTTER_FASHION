import 'package:flutter_fashion/app/blocs/chat/chat_cubit.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/models/chat/chat.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';
import 'package:flutter_fashion/utils/extensions/datetime.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../export.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state.status == AppStatus.error) {
          return const Expanded(
            child: Center(
              child: Text('SERVER_ERROR'),
            ),
          );
        }
        if (state.status == AppStatus.loading) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state.chats.isEmpty) {
          return const Spacer();
        }
        return Expanded(
          child: GroupedListView<ChatModel, String>(
            elements: state.chats.reversed.toList(),
            reverse: true,
            sort: false,
            useStickyGroupSeparators: false, // optional
            floatingHeader: true, // optional
            order: GroupedListOrder.DESC,
            padding: const EdgeInsets.only(bottom: 10.0), //   optional
            groupBy: (element) {
              return element.created_at.checkChatTime();
            },
            groupSeparatorBuilder: (String groupByValue) => Align(
              alignment: const Alignment(0, 0),
              child: Text(
                groupByValue,
                style: PrimaryFont.instance.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            itemBuilder: (context, element) {
              final userId = getIt.get<UserCubit>().user.id;
              bool isSentByMe = element.sender_id == userId;
              return Align(
                alignment:
                    isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .65,
                  ),
                  child: Card(
                    surfaceTintColor: lightColor,
                    shape: isSentByMe
                        ? const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusBtn),
                              topRight: Radius.circular(radiusBtn),
                              bottomRight: Radius.circular(0.0),
                              bottomLeft: Radius.circular(radiusBtn),
                            ),
                          )
                        : const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusBtn),
                              topRight: Radius.circular(radiusBtn),
                              bottomRight: Radius.circular(radiusBtn),
                              bottomLeft: Radius.circular(0.0),
                            ),
                          ),
                    color: isSentByMe
                        ? primaryColor.withOpacity(0.5)
                        : skeletonColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text.rich(
                        TextSpan(
                          text: element.message,
                          style: PrimaryFont.instance.copyWith(
                            fontSize: 14.0,
                            color: isSentByMe ? lightColor : null,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
