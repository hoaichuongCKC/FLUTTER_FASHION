import 'package:flutter_fashion/app/presentation/filter/components/title_frame.dart';
import 'package:flutter_fashion/export.dart';

import '../blocs/filter_bloc.dart';

class GenderFrame extends StatelessWidget {
  const GenderFrame({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = getIt<FilterBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleFilterFrame(title: "Giới tính"),
        const SizedBox(height: 8.0),
        StreamBuilder<Gender>(
          stream: bloc.genderStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            }

            return Column(
              children: [
                _buildItem(
                  title: "Nam",
                  data: snapshot.data!,
                  defaultValue: Gender.male,
                  onTap: () => bloc.selectGender(Gender.male),
                ),
                _buildItem(
                  title: "Nữ",
                  data: snapshot.data!,
                  defaultValue: Gender.female,
                  onTap: () => bloc.selectGender(Gender.female),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  ListTile _buildItem(
      {String title = "",
      Gender data = Gender.none,
      required Gender defaultValue,
      required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      leading: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: primaryColor),
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
                color: primaryColor,
              ),
              child: SizedBox(
                width: 15,
                height: 15,
              ),
            ),
          ),
          firstCurve: Curves.easeIn,
          secondCurve: Curves.easeIn,
          crossFadeState: defaultValue == data
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
      ),
      horizontalTitleGap: 0.0,
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: PrimaryFont.instance.copyWith(
          fontSize: 14.0,
        ),
      ),
    );
  }
}
