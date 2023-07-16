import 'package:flutter_fashion/app/presentation/modules/user/create_address/blocs/address_management.dart';
import 'package:flutter_fashion/export.dart';

class DescAddress extends StatelessWidget {
  const DescAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = getIt.get<AddressManagementBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.description,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14.0,
              ),
          onChanged: (value) => bloc.setDesc(value),
          maxLines: 1,
          minLines: 1,
          decoration: InputDecoration(
            hintText: "Vd: 46 Tuyên Quang...",
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
          ),
        ),
      ],
    );
  }
}
