import 'package:flutter_fashion/app/presentation/profile/export.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: verticalPadding + 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Lịch sử đơn hàng',
              style: PrimaryFont.instance.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          GridView.builder(
            itemCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              childAspectRatio: 16 / 9,
            ),
            itemBuilder: (ctx, index) {
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding - 4,
                    vertical: verticalPadding - 7),
                decoration: BoxDecoration(
                  color: lightColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(radiusBtn),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.5),
                      blurRadius: 10.0,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            color: successfullyColor,
                            shape: BoxShape.circle,
                          ),
                          child: SizedBox(
                            width: 8.0,
                            height: 8.0,
                          ),
                        ),
                        Text(
                          'Số lượng: 1',
                          style: PrimaryFont.instance.copyWith(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Đang lên đơn',
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 14.0,
                        color: primaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
