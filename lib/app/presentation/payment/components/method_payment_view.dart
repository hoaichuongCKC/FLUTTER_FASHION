// ignore_for_file: deprecated_member_use

import '../../../../export.dart';

class MethodPaymentView extends StatelessWidget {
  const MethodPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            minLeadingWidth: 0.0,
            leading: SvgPicture.asset(
              "assets/icons/wallet.svg",
              color: primaryColor,
            ),
            title: Text(
              'Phương thức thanh toán',
              style: PrimaryFont.instance.copyWith(
                fontSize: 18.0,
              ),
            ),
          ),
          DecoratedBox(
            decoration: const BoxDecoration(
              color: disablePrimaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              title: Text(
                'Phương thức COD (mặc định)',
                style: PrimaryFont.instance.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: const Icon(Icons.arrow_right_sharp),
            ),
          ),
        ],
      ),
    );
  }
}
