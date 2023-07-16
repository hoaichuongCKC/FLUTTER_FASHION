import 'package:flutter_fashion/app/blocs/edit_information/edit_information_cubit.dart';
import 'package:flutter_fashion/common/widgets/text_form_field_app.dart';

import '../export.dart';

class PhoneUserEdit extends StatelessWidget {
  const PhoneUserEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final applocalizations = AppLocalizations.of(context)!;

    final bloc = context.read<EditInformationCubit>();

    final user = InheritedDataApp.of<UserModel>(context)!.data;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: verticalPadding),
      child: BlocBuilder<EditInformationCubit, EditInformationState>(
        buildWhen: (p, c) => p.phone != c.phone,
        builder: (context, state) {
          final isChanged = state.phone.isNotEmpty;
          final Widget? titleWidget = isChanged
              ? Text(
                  "(${applocalizations.changed_information})",
                  style: theme.textTheme.bodySmall!.copyWith(
                    fontSize: 10.0,
                    color: secondaryColor,
                  ),
                )
              : null;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormFieldApp(
                title: AppLocalizations.of(context)!.phoneNumber,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                onChanged: (value) => bloc.onChangedPhone(value),
                prefixIcon: const Icon(
                  Icons.phone,
                  size: 12.0,
                  color: secondaryColor,
                ),
                titleWidget: titleWidget,
                text: user.phone,
                hintText: user.phone.isEmpty
                    ? applocalizations
                        .enter_the(applocalizations.phoneNumber)
                        .toLowerCase()
                    : null,
              ),
              user.phone.isEmpty
                  ? const SizedBox(height: 5.0)
                  : const SizedBox(),
              user.phone.isEmpty
                  ? Text(
                      applocalizations.please_update_your_phone_number,
                      style: theme.textTheme.bodySmall!.copyWith(
                        fontSize: 9.0,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : const SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
