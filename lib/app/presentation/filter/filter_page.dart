import 'package:flutter_fashion/app/presentation/filter/blocs/filter_bloc.dart';
import 'package:flutter_fashion/app/presentation/filter/components/category_frame.dart';
import 'package:flutter_fashion/app/presentation/filter/components/gender_frame.dart';
import 'package:flutter_fashion/app/presentation/filter/components/range_price_frame.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';
import 'package:flutter_fashion/routes/export.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  void dispose() {
    getIt<FilterBloc>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = getIt<FilterBloc>();
    return AppBackgroundBlur.normal(
      title: 'Bộ lọc sản phẩm',
      isHasBackground: false,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonWidget(
          btnColor: primaryColor,
          animate: true,
          height: 45.0,
          width: MediaQuery.of(context).size.width * 0.8,
          label: "Áp dụng",
          onPressed: () => bloc.reset(),
          radius: 5.0,
        ),
      ),
      leading: InkWell(
        onTap: () => GoRouter.of(context).pop(),
        child: const Icon(Icons.close),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            GenderFrame(),
            SizedBox(height: 10.0),
            CategoryFrame(),
            SizedBox(height: 10.0),
            RangePriceFrame(),
          ],
        ),
      ),
    );
  }
}
