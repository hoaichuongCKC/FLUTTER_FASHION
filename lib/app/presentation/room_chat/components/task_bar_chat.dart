import '../../../../export.dart';

class TaskbarChatMessage extends StatelessWidget {
  const TaskbarChatMessage({
    super.key,
  });

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
          padding: const EdgeInsets.all(10.0),
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
                    style: PrimaryFont.instance.copyWith(
                      fontSize: 14.0,
                      color: darkColor.withOpacity(0.5),
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      hintText: "Nhập tin nhắn",
                      isDense: true,
                      filled: false,
                      hintStyle: PrimaryFont.instance.copyWith(
                        fontSize: 12.0,
                        color: darkColor.withOpacity(0.5),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset("assets/icons/sent-fast.svg"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
