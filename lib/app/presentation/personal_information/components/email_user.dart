import 'package:flutter_fashion/app/blocs/edit_information/edit_information_cubit.dart';
import 'package:flutter_fashion/common/widgets/text_form_field_app.dart';

import '../export.dart';

class EmailUserEdit extends StatelessWidget {
  const EmailUserEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final applocalizations = AppLocalizations.of(context)!;

    final bloc = context.read<EditInformationCubit>();

    final user = InheritedDataApp.of<UserModel>(context)!.data;
    return BlocBuilder<EditInformationCubit, EditInformationState>(
      buildWhen: (p, c) => p.email != c.email,
      builder: (context, state) {
        final isChanged = state.email.isNotEmpty;

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
          title: "Email",
          onChanged: (value) => bloc.onChangedEmail(value),
          titleWidget: titleWidget,
          prefixIcon: const Icon(
            Icons.email_outlined,
            size: 12.0,
            color: secondaryColor,
          ),
          text: user.email,
        );
      },
    );
  }
}
