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
                    color: successfullyColor,
                  ),
                )
              : null;
          return TextFormFieldApp(
            title: AppLocalizations.of(context)!.phoneNumber,
            onChanged: (value) => bloc.onChangedUsername(value),
            prefixIcon: const Icon(
              Icons.phone_outlined,
              size: 12.0,
              color: secondaryColor,
            ),
            titleWidget: titleWidget,
            text: user.phone,
          );
        },
      ),
    );
  }
}
