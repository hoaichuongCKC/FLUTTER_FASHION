// ignore_for_file: use_build_context_synchronously

import 'package:flutter_fashion/app/blocs/address_user/address_user_cubit.dart';
import 'package:flutter_fashion/app/presentation/create_address/create_address_page.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';
import 'package:flutter_fashion/app/presentation/location_management/components/item_location_user.dart';
import 'package:flutter_fashion/core/models/address.dart';
import 'package:flutter_fashion/export.dart';

class LocationManagementPage extends StatelessWidget {
  const LocationManagementPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.normal(
      title: AppLocalizations.of(context)!.address_management,
      floatingActionButton: Builder(builder: (context) {
        return InkWell(
          onTap: () async {
            final result = await Navigator.of(context).push<ItemAddress?>(
              MaterialPageRoute(
                builder: (context) => const CreateAddressPage(),
              ),
            );
            if (result != null) {
              context.read<AddressUserCubit>().createNew(result);
            }
          },
          borderRadius: const BorderRadius.all(Radius.circular(radiusBtn)),
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 65,
            height: 65,
            child: Stack(
              fit: StackFit.expand,
              children: [
                SvgPicture.asset("assets/icons/profile/float_btn.svg"),
                const Align(child: Icon(Icons.add_card, color: lightColor)),
              ],
            ),
          ),
        );
      }),
      child: BlocBuilder<AddressUserCubit, AddressUserState>(
        builder: (context, state) {
          if (state.storageList.isEmpty) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.no_address,
                ),
              ),
            );
          }
          return ListView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
            itemCount: state.storageList.length,
            itemBuilder: (context, index) {
              final item = state.storageList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ItemLocationUser(
                  key: ValueKey(index),
                  item: item,
                  onDelete: () {
                    context.read<AddressUserCubit>().delete(item);
                    //turn off modal action
                    AppRoutes.router.pop();
                  },
                  onUseDefault: () {
                    context.read<AddressUserCubit>().setUseDefault(item);
                    //turn off modal action
                    AppRoutes.router.pop();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
