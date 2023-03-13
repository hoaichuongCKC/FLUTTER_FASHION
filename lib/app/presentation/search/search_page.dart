import 'package:flutter_fashion/common/components/form_search.dart';
import 'package:flutter_fashion/app/presentation/search/components/search_history.dart';
import 'package:flutter_fashion/export.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.normal(
      title: "Tìm kiếm",
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormSearch(onChanged: (value) {}),
            const SizedBox(height: 15.0),
            const SearchHistory(),
          ],
        ),
      ),
    );
  }
}
