import 'package:flutter_fashion/app/blocs/chat/chat_cubit.dart';

import '../../../../export.dart';

class TaskbarChatMessage extends StatefulWidget {
  const TaskbarChatMessage({
    super.key,
  });

  @override
  State<TaskbarChatMessage> createState() => _TaskbarChatMessageState();
}

class _TaskbarChatMessageState extends State<TaskbarChatMessage> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: lightColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -0.5),
            color: disableDarkColor.withOpacity(0.1),
            blurRadius: 7,
          )
        ],
      ),
      child: SizedBox(
        width: double.maxFinite,
        height: 60.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: darkColor.withOpacity(0.05),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(14.0),
                    ),
                  ),
                  child: TextFormField(
                    controller: _controller,
                    keyboardType: TextInputType.text,
                    style: PrimaryFont.instance.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.enter_the(
                        AppLocalizations.of(context)!.messenger,
                      ),
                      isDense: true,
                      filled: false,
                      hintStyle: PrimaryFont.instance.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_controller.text.isEmpty) return;

                  FocusScope.of(context).unfocus();
                  context.read<ChatCubit>().createChat(_controller.text);
                  _controller.text = "";
                },
                icon: SvgPicture.asset("assets/icons/sent-fast.svg"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
