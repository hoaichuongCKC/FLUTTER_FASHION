import '../../../../export.dart';

class AwaitingConfirmationPage extends StatelessWidget {
  const AwaitingConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemExtent: 190,
      padding:
          const EdgeInsets.only(top: 15.0, right: 10, left: 10, bottom: 15),
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: lightColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: primaryColor.withOpacity(0.5), blurRadius: 8.0)
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://fashionminhthu.com.vn/wp-content/uploads/2018/11/short-sleeve-crew-neck-t-shirt-broadcast-print-1991-2-600x840.jpg',
                                fit: BoxFit.fitWidth,
                                placeholder: (context, url) {
                                  return ColoredBox(
                                    color: skeletonColor,
                                    child: const SizedBox(),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Nam Len Đen Áo Khoác Ngoài da nữ xinh việt nam sssssssss',
                                    style: PrimaryFont.instance.copyWith(
                                      fontSize: 14.0,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '190.000 VNĐ',
                                      style: PrimaryFont.instance.copyWith(
                                        fontSize: 12.0,
                                        color: const Color(0xFFFF7262),
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Text(
                                      'x2',
                                      style: PrimaryFont.instance.copyWith(
                                        fontSize: 10.0,
                                        color: disableDarkColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Phân loại: ",
                                        style: PrimaryFont.instance.copyWith(
                                          fontSize: 12.0,
                                          color: darkColor,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      const WidgetSpan(
                                          child: SizedBox(width: 5.0)),
                                      TextSpan(
                                        text: "S (40-58kg),",
                                        style: PrimaryFont.instance.copyWith(
                                          fontSize: 12.0,
                                          color: darkColor,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      const WidgetSpan(
                                          child: SizedBox(width: 5.0)),
                                      WidgetSpan(
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: primaryColor,
                                            ),
                                          ),
                                          child: const SizedBox(
                                            width: 20,
                                            height: 20,
                                          ),
                                        ),
                                      ),
                                      const WidgetSpan(
                                          child: SizedBox(width: 5.0)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Trạng thái:',
                              style: PrimaryFont.instance.copyWith(
                                fontSize: 12.0,
                                color: darkColor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            ColoredBox(
                              color: errorColor.withOpacity(0.2),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                child: Text(
                                  'awaiting_confirmation',
                                  style: PrimaryFont.instance.copyWith(
                                    fontSize: 9.0,
                                    color: errorColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        ButtonWidget(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => const ShowDialogTimer(),
                            );
                          },
                          height: 40,
                          radius: 5,
                          btnColor: primaryColor,
                          animate: true,
                          label: "Huỷ đơn hàng",
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 15.0),
        ],
      ),
    );
  }
}

class ShowDialogTimer extends StatefulWidget {
  const ShowDialogTimer({super.key});

  @override
  State<ShowDialogTimer> createState() => _ShowDialogTimerState();
}

class _ShowDialogTimerState extends State<ShowDialogTimer> {
  late Timer timer;
  int _counter = 5;
  Duration intervalDuration = const Duration(seconds: 1);
  @override
  void initState() {
    timer = Timer.periodic(intervalDuration, (timer) {
      if (_counter == 0) {
        timer.cancel();
        return;
      }
      _counter--;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: lightColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14.0),
          topRight: Radius.circular(14.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.0),
                topRight: Radius.circular(14.0),
              ),
              color: primaryColor,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              height: 14.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding - 4, vertical: verticalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Bạn muốn huỷ đơn?',
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonWidget(
                      btnColor: disableDarkColor,
                      onPressed: () => AppRoutes.router.pop(),
                      height: 30,
                      radius: 2,
                      width: 55,
                      label: "Bỏ",
                    ),
                    const SizedBox(width: 8.0),
                    ButtonWidget(
                      btnColor: primaryColor,
                      onPressed: _counter == 0 ? () {} : null,
                      height: 30,
                      radius: 2,
                      width: 55,
                      label: _counter == 0 ? "Ok" : "00:0$_counter",
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
