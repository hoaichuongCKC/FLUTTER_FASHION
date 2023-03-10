import 'package:flutter_fashion/app/presentation/create_address/blocs/address_management.dart';
import 'package:flutter_fashion/export.dart';

class DescAddress extends StatelessWidget {
  const DescAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = getIt<AddressManagementBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mô tả cụ thể',
          style: PrimaryFont.instance.copyWith(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          style: PrimaryFont.instance.copyWith(
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
            height: 1.0,
          ),
          onChanged: (value) => bloc.setDesc(value),
          maxLines: 1,
          minLines: 1,
          decoration: InputDecoration(
            hintText: "Vd: 46 Tuyên Quang...",
            hintStyle: PrimaryFont.instance.copyWith(
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
              height: 1.0,
            ),
          ),
        ),
      ],
    );
  }
}
