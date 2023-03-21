import 'package:flutter_fashion/common/components/form_search.dart';
import 'package:flutter_fashion/app/presentation/search/components/search_history.dart';
import 'package:flutter_fashion/export.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.withAppBar(
      actions: [
        Expanded(
          child: FractionallySizedBox(
            heightFactor: 0.7,
            child: FormSearch(
              onChanged: (value) {},
            ),
          ),
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SearchHistory(),
          ],
        ),
      ),
    );
  }
}
