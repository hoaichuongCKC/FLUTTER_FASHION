import 'package:animate_do/animate_do.dart';
import 'package:flutter_fashion/app/presentation/introduction/cubit/intro_cubit_cubit.dart';
import 'package:flutter_fashion/export.dart';

import '../../../common/components/aurora/aurora_page.dart';
import '../../../common/components/dot_page.dart';

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
                  decoration: const BoxDecoration(
                    color: lightColor,
                    borderRadius: BorderRadius.only(
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
    return Positioned.fill(
      top: size.height * .15,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: BlocBuilder<IntroCubit, IntroState>(
              builder: (context, state) {
                return PageView.builder(
                  controller: _introCubit.pageController,
                  itemCount: state.intros.length,
                  itemBuilder: (context, index) {
                    return state.intros[index].image;
                  },
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<LanguageCubit, LanguageState>(
              builder: (context, languageState) {
                final isVN = languageState.isVietnamese;
                return BlocBuilder<IntroCubit, IntroState>(
                  builder: (context, state) {
                    final intro = state.intros[state.currentIndex];

                    final title = isVN ? intro.title : intro.titleEn;

                    final subtitle = isVN ? intro.subtitle : intro.subtitleEn;

                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 24.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            subtitle,
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                                ),
                              ),
                            ),
                          ),
                    Align(
                      child: DotPage(
                        currentDot: state.currentIndex,
                        length: state.intros.length,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => _introCubit.continuePage(),
                          child: Text(text),
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
