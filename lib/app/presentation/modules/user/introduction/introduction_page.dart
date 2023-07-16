
import 'package:flutter_fashion/app/presentation/modules/user/introduction/cubit/intro_cubit_cubit.dart';
import 'package:flutter_fashion/common/components/aurora/aurora_page.dart';
import 'package:flutter_fashion/export.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => IntroCubit(),
      child: AuroraBackgroundPage(
        child: Positioned.fill(
          child: Stack(
            children: [
              Positioned(
                bottom: 0.0,
                right: 0.0,
                left: 0.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(radiusBtn * 3),
                      topRight: Radius.circular(radiusBtn * 3),
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: size.height * .65,
                  ),
                ),
              ),
              const BodyIntro(),
            ],
          ),
        ),
      ),
    );
  }
}

class BodyIntro extends StatefulWidget {
  const BodyIntro({super.key});

  @override
  State<BodyIntro> createState() => _BodyIntroState();
}

class _BodyIntroState extends State<BodyIntro> {
  late IntroCubit _introCubit;
  @override
  void initState() {
    super.initState();
    _introCubit = BlocProvider.of<IntroCubit>(context)..init();
  }

  @override
  void dispose() {
    _introCubit.dipose();
    _introCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Positioned.fill(
      top: size.height * .15,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, languageState) {
                final isVN = languageState.isVietnamese;
                return BlocBuilder<IntroCubit, IntroState>(
                  builder: (context, state) {
                    return PageView.builder(
                      controller: _introCubit.pageController,
                      itemCount: state.intros.length,
                      itemBuilder: (context, index) {
                        final intro = state.intros[state.currentIndex];

                        final title = isVN ? intro.title : intro.titleEn;

                        final subtitle =
                            isVN ? intro.subtitle : intro.subtitleEn;
                        return Column(
                          children: [
                            Flexible(
                              flex: 5,
                              fit: FlexFit.tight,
                              child: state.intros[index].image,
                            ),
                            const Spacer(),
                            Flexible(
                              flex: 4,
                              fit: FlexFit.tight,
                              child: Column(
                                children: [
                                  Text(
                                    title,
                                    style: PrimaryFont.instance.copyWith(
                                      fontSize: 24,
                                      color: theme.textTheme.bodySmall!.color,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    subtitle,
                                    style: PrimaryFont.instance.copyWith(
                                      fontSize: 20,
                                      color: theme.textTheme.bodySmall!.color,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10.0, horizontal: horizontalPadding - 4),
            child: BlocBuilder<IntroCubit, IntroState>(
              builder: (context, state) {
                final isLastPage =
                    state.currentIndex == state.intros.length - 1;
                final text = isLastPage
                    ? AppLocalizations.of(context)!.login
                    : AppLocalizations.of(context)!.continue_r;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isLastPage
                        ? const Spacer()
                        : Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () => _introCubit.skipPage(),
                                child: Text(
                                  AppLocalizations.of(context)!.skip,
                                  style: PrimaryFont.instance.copyWith(
                                    fontSize: 14,
                                    color: theme.textTheme.bodySmall!.color,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    Align(
                      child: DotPage(
                        currentDot: state.currentIndex,
                        length: state.intros.length,
                        disableDot: theme.brightness == Brightness.dark
                            ? theme.indicatorColor
                            : secondaryColor,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => isLastPage
                              ? AppRoutes.router.go(Routes.LOGIN)
                              : _introCubit.continuePage(),
                          child: Text(
                            text,
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 14,
                              color: theme.textTheme.bodySmall!.color,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
