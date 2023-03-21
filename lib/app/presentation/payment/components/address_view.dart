// ignore_for_file: deprecated_member_use

import 'package:flutter_fashion/app/blocs/address_user/address_user_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';

class AddressPaymentView extends StatefulWidget {
  const AddressPaymentView({super.key});

  @override
  State<AddressPaymentView> createState() => _AddressPaymentViewState();
}

class _AddressPaymentViewState extends State<AddressPaymentView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressUserCubit, AddressUserState>(
      builder: (context, state) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: lightColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.2),
                blurRadius: 8.0,
              )
            ],
          ),
          child: ListTile(
            leading: SvgPicture.asset(
              "assets/icons/map_address.svg",
              width: 24.0,
              height: 24.0,
              color: primaryColor,
            ),
            dense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
            minLeadingWidth: 0.0,
            title: Text(
              "Địa chỉ giao hàng",
              style: PrimaryFont.instance.copyWith(
                fontSize: 16.0,
              ),
            ),
            subtitle: Text(
              state.usingAddress.isEmpty
                  ? "Vui lòng cập nhật địa chỉ giao hàng"
                  : state.usingAddress[0].name,
              style: PrimaryFont.instance.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                color: state.usingAddress.isEmpty
                    ? errorColor
                    : darkColor.withOpacity(0.5),
              ),
            ),
            trailing: state.usingAddress.isEmpty
                ? InkWell(
                    onTap: () =>
                        AppRoutes.router.push(Routes.ADDRESS_MANAGEMENT),
                    child: const Icon(
                      Icons.add_circle_outline,
                      color: primaryColor,
                      size: 24.0,
                    ),
                  )
                : InkWell(
                    onTap: () =>
                        AppRoutes.router.push(Routes.ADDRESS_MANAGEMENT),
                    child: SvgPicture.asset(
                      "assets/icons/edit.svg",
                      color: primaryColor,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
