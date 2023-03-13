// ignore_for_file: deprecated_member_use
import 'package:flutter_fashion/app/presentation/create_address/blocs/address_management.dart';
import 'package:flutter_fashion/app/presentation/create_address/components/commune_list.dart';
import 'package:flutter_fashion/app/presentation/create_address/components/desc_address.dart';
import 'package:flutter_fashion/app/presentation/create_address/components/district_list.dart';
import 'package:flutter_fashion/app/presentation/create_address/components/province_list.dart';
import 'package:flutter_fashion/app/presentation/create_address/components/view_seleted_address.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';
import '../../../export.dart';

class CreateAddressPage extends StatelessWidget {
  const CreateAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.normal(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Builder(
          builder: (context) {
            return StreamBuilder<ListBuilding>(
              stream: getIt<AddressManagementBloc>().buildingStream,
              builder: (context, snapshot) {
                if (snapshot.data == ListBuilding.desc) {
                  return ButtonWidget(
                    btnColor: primaryColor,
                    label: "Tạo mới",
                    radius: 5.0,
                    height: 45.0,
                    animate: true,
                    onPressed: () => getIt<AddressManagementBloc>()
                        .submitCreateAddress(context),
                  );
                }
                return const SizedBox();
              },
            );
          },
        ),
      ),
      title: "Tạo địa chỉ mới",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<List<String>>(
              stream: getIt<AddressManagementBloc>().seletedListStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return ButtonWidget(
                    btnColor: lightColor,
                    animate: true,
                    height: 45.0,
                    onPressed: () {},
                    boxShadow: [
                      BoxShadow(
                          color: primaryColor.withOpacity(0.2),
                          blurRadius: 8.0),
                    ],
                    labelWidget: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/location.svg",
                          color: primaryColor,
                        ),
                        const SizedBox(width: 8.0),
                        const Text('Sử dụng vị trí hiện tại'),
                      ],
                    ),
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Địa chỉ đã chọn',
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    InkWell(
                      onTap: () => getIt<AddressManagementBloc>().reset(),
                      child: Text(
                        'Xoá',
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 14.0,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 8.0),
            const ViewSelectedAddress(),
            const SizedBox(height: 15.0),
            Expanded(
              child: StreamBuilder<ListBuilding>(
                stream: getIt<AddressManagementBloc>().buildingStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: Text('ERROR'));
                  }
                  if (!(snapshot.connectionState == ConnectionState.active)) {
                    return const SizedBox();
                  }

                  if (snapshot.data! == ListBuilding.province) {
                    return const ProvinceList();
                  }

                  if (snapshot.data! == ListBuilding.district) {
                    return const DistrictList();
                  }

                  if (snapshot.data! == ListBuilding.commnue) {
                    return const CommuneList();
                  }
                  if (snapshot.data! == ListBuilding.desc) {
                    return const DescAddress();
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
