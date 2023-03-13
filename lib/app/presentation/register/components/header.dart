import '../../../../export.dart';

class HeaderRegister extends StatelessWidget {
  const HeaderRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => AppRoutes.router.pop(),
          child: const Icon(Icons.arrow_back, size: 30.0, color: darkColor),
        ),
        const SizedBox(height: 15.0),
        Text(
          AppLocalizations.of(context)!.signUp,
          style: PrimaryFont.instance.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 25.0,
          ),
        ),
        const SizedBox(height: 25.0),
      ],
    );
  }
}
