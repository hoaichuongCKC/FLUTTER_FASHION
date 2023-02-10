import 'package:flutter_fashion/app/presentation/introduction/export.dart';

import '../../common/components/aurora/aurora_page.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuroraBackgroundPage(child: PageViewModel());
  }
}
