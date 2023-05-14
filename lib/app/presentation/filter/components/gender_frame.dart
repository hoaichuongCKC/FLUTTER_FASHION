import 'package:flutter_fashion/app/presentation/filter/components/title_frame.dart';
import 'package:flutter_fashion/app/presentation/filter/cubit/filter_cubit.dart';
import 'package:flutter_fashion/export.dart';

class GenderFrame extends StatelessWidget {
  const GenderFrame({super.key});

  @override
  Widget build(BuildContext context) {
    final filterCubit = context.read<FilterCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleFilterFrame(title: AppLocalizations.of(context)!.gender),
        const SizedBox(height: 8.0),
        BlocBuilder<FilterCubit, FilterState>(
          buildWhen: (previous, current) => previous.gender != current.gender,
          builder: (context, state) {
            final gender = state.gender;
            final String maleLabel = AppLocalizations.of(context)!.male;
            final String femaleLabel = AppLocalizations.of(context)!.female;
            return Column(
              children: [
                _buildItem(
                  context,
                  title: maleLabel,
                  isSelected: gender == maleLabel,
                  onTap: () => filterCubit.changeGender(maleLabel),
                ),
                _buildItem(
                  context,
                  title: femaleLabel,
                  isSelected: gender == femaleLabel,
                  onTap: () => filterCubit.changeGender(femaleLabel),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  ListTile _buildItem(BuildContext context,
      {String title = "",
      bool isSelected = false,
      required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      leading: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: secondaryColor),
        ),
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 450),
          secondChild: const Padding(
            padding: EdgeInsets.all(5.0),
            child: SizedBox(
              width: 15,
              height: 15,
            ),
          ),
          firstChild: const Padding(
            padding: EdgeInsets.all(5.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: secondaryColor,
              ),
              child: SizedBox(
                width: 15,
                height: 15,
              ),
            ),
          ),
          firstCurve: Curves.easeIn,
          secondCurve: Curves.easeIn,
          crossFadeState:
              isSelected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      ),
      horizontalTitleGap: 0.0,
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
