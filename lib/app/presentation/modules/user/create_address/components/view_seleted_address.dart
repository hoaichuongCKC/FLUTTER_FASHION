import 'package:flutter_fashion/app/presentation/modules/user/create_address/blocs/address_management.dart';
import 'package:flutter_fashion/export.dart';

class ViewSelectedAddress extends StatelessWidget {
  const ViewSelectedAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = getIt.get<AddressManagementBloc>();
    return StreamBuilder<List<String>>(
      stream: bloc.seletedListStream.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox();
        }
        final data = snapshot.data;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data!
                  .map(
                    (item) => BuildSelectedAddress(name: item),
                  )
                  .toList(),
            ),
            StreamBuilder<ListBuilding>(
              stream: bloc.buildingStream.stream,
              builder: (context, snapshot) {
                if (snapshot.data == ListBuilding.desc) {
                  return const SizedBox();
                }
                return const SizedBox(height: 8.0);
              },
            ),
            StreamBuilder<ListBuilding>(
              stream: bloc.buildingStream.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: Text('ERROR'));
                }
                if (!(snapshot.connectionState == ConnectionState.active)) {
                  return const SizedBox();
                }

                if (snapshot.data! == ListBuilding.province) {
                  return const BuildSelectedAddress(
                    name: "",
                    isInfoNextStep: true,
                  );
                }

                if (snapshot.data! == ListBuilding.district) {
                  return BuildSelectedAddress(
                    name: AppLocalizations.of(context)!.select_district,
                    isInfoNextStep: true,
                  );
                }

                if (snapshot.data! == ListBuilding.commnue) {
                  return BuildSelectedAddress(
                    name: AppLocalizations.of(context)!.select_commnue,
                    isInfoNextStep: true,
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        );
      },
    );
  }
}

class BuildSelectedAddress extends StatelessWidget {
  const BuildSelectedAddress({
    super.key,
    required this.name,
    this.isInfoNextStep = false,
  });
  final String name;
  final bool isInfoNextStep;
  @override
  Widget build(BuildContext context) {
    final color = ThemeDataApp.instance.isLight
        ? blackColor.withOpacity(0.5)
        : lightColor.withOpacity(0.7);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: !isInfoNextStep
            ? null
            : const BorderRadius.all(
                Radius.circular(5.0),
              ),
        border: !isInfoNextStep ? null : Border.all(color: darkColor),
      ),
      child: Padding(
        padding: !isInfoNextStep
            ? const EdgeInsets.symmetric(horizontal: 8.0)
            : const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: isInfoNextStep
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isInfoNextStep ? null : color,
                    border:
                        !isInfoNextStep ? null : Border.all(color: darkColor),
                  ),
                  child: isInfoNextStep
                      ? const Padding(
                          padding: EdgeInsets.all(2.5),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: darkColor,
                            ),
                            child: SizedBox(
                              width: 8.0,
                              height: 8.0,
                            ),
                          ),
                        )
                      : const SizedBox(
                          width: 10,
                          height: 10,
                        ),
                ),
                const SizedBox(height: 1.5),
                ColoredBox(
                  color: isInfoNextStep ? darkColor.withOpacity(0.7) : color,
                  child: const SizedBox(
                    width: 1,
                    height: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8.0),
            Text(
              name,
              style: PrimaryFont.instance.copyWith(
                fontSize: 12.0,
                height: 1.0,
                color: isInfoNextStep
                    ? darkColor
                    : ThemeDataApp.instance.isLight
                        ? disableDarkColor
                        : lightColor.withOpacity(0.7),
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
