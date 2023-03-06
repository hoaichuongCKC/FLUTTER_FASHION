import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';

import '../../../export.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.titleCenter(
      title: AppLocalizations.of(context)!.notificationPage,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Today',
              style: PrimaryFont.instance.copyWith(
                fontSize: 16.0,
                color: darkColor,
              ),
            ),
            const SizedBox(height: 15.0),
            ListView.separated(
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 10.0),
              itemCount: 4,
              shrinkWrap: true,
              cacheExtent: 120.0,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: lightColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: darkColor.withOpacity(0.2),
                        blurRadius: 7.0,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: 115.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: horizontalPadding - 4,
                          vertical: verticalPadding - 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: SvgPicture.asset(
                              "assets/images/app_logo.svg",
                              fit: BoxFit.scaleDown,
                              width: 60,
                              height: 60,
                              placeholderBuilder: (context) =>
                                  ColoredBox(color: skeletonColor),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Bạn đang có đơn đang trên đường giao',
                                  style: PrimaryFont.instance.copyWith(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10.0),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Image.asset(
                                          "assets/images/loudspeaker.png",
                                          fit: BoxFit.scaleDown,
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' Nhân viên: ',
                                        style: PrimaryFont.instance.copyWith(
                                          fontSize: 12.0,
                                          color: primaryColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'đơn hàng của bạn đang vận chuyển tới địa điểm. Xin lui chú ý! nhessadasd',
                                        style: PrimaryFont.instance.copyWith(
                                          fontSize: 12.0,
                                          color: darkColor.withOpacity(0.6),
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/stopwatch-minus.svg",
                                      // ignore: deprecated_member_use
                                      color: darkColor.withOpacity(0.6),
                                    ),
                                    Text(
                                      '10:30 20-01-2023',
                                      style: PrimaryFont.instance.copyWith(
                                        fontSize: 12.0,
                                        color: darkColor.withOpacity(0.6),
                                        fontWeight: FontWeight.w300,
                                      ),
                                      softWrap: true,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
