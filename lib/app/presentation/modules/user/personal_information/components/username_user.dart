import 'package:flutter_fashion/app/blocs/edit_information/edit_information_cubit.dart';
import 'package:flutter_fashion/common/widgets/text_form_field_app.dart';
import '../export.dart';

class UsernameUserEdit extends StatelessWidget {
  const UsernameUserEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final applocalizations = AppLocalizations.of(context)!;

    final bloc = context.read<EditInformationCubit>();

    final user = InheritedDataApp.of<UserModel>(context)!.data;

    return BlocBuilder<EditInformationCubit, EditInformationState>(
      buildWhen: (p, c) => p.username != c.username,
      builder: (context, state) {
        final isChanged = state.username.isNotEmpty;
        final Widget? titleWidget = isChanged
            ? Text(
                "(${applocalizations.changed_information})",
                style: theme.textTheme.bodySmall!.copyWith(
                  fontSize: 10.0,
                  color: secondaryColor,
                ),
              )
            : null;
        return TextFormFieldApp(
          title: AppLocalizations.of(context)!.username,
          onChanged: (value) => bloc.onChangedUsername(value),
          prefixIcon: SvgPicture.asset(
            Assets.userSVG,
            width: 12.0,
            height: 12.0,
            fit: BoxFit.scaleDown,
            colorFilter: const ColorFilter.mode(
              secondaryColor,
              BlendMode.srcIn,
            ),
          ),
          titleWidget: titleWidget,
          text: user.username,
        );
      },
    );
  }
}
