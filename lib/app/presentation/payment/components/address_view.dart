// ignore_for_file: deprecated_member_use

import 'package:flutter_fashion/app/blocs/address_user/address_user_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';

class AddressPaymentView extends StatelessWidget {
  const AddressPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressUserCubit, AddressUserState>(
      builder: (context, state) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: !ThemeDataApp.instance.isLight
                ? Theme.of(context).cardColor
                : lightColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
            boxShadow: !ThemeDataApp.instance.isLight
                ? null
                : [
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
                AppLocalizations.of(context)!.shipping_address,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              subtitle: Text(
                state.usingAddress.isEmpty
                    ? AppLocalizations.of(context)!.please_set_up_your_address
                    : state.usingAddress[0].name,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: state.usingAddress.isEmpty ? errorColor : null,
                    ),
              ),
              trailing: InkWell(
                onTap: () => AppRoutes.router
                    .push("${Routes.PROFILE}/${Routes.ADDRESS_MANAGEMENT}"),
                child: state.usingAddress.isEmpty
                    ? const Icon(
                        Icons.add_circle_outline,
                        color: primaryColor,
                        size: 24.0,
                      )
                    : SvgPicture.asset(
                        "assets/icons/edit.svg",
                        color: primaryColor,
                      ),
              )),
        );
      },
    );
  }
}
