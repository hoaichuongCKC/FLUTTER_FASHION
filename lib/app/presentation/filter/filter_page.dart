import 'package:flutter_fashion/app/blocs/search/search_cubit.dart';
import 'package:flutter_fashion/app/presentation/filter/components/category_frame.dart';
import 'package:flutter_fashion/app/presentation/filter/components/gender_frame.dart';
import 'package:flutter_fashion/app/presentation/filter/components/range_price_frame.dart';
import 'package:flutter_fashion/app/presentation/filter/cubit/filter_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';
import 'package:flutter_fashion/routes/export.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FilterCubit>(),
      child: AppBackgroundBlur.normal(
        title: AppLocalizations.of(context)!.filter_by_search_results,
        isHasBackground: false,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Builder(
            builder: (context) {
              return ButtonWidget(
                btnColor: primaryColor,
                animate: true,
                height: 45.0,
                width: MediaQuery.of(context).size.width * 0.8,
                label: AppLocalizations.of(context)!.apply,
                onPressed: () {
                  final filterCubit = context.read<FilterCubit>();
                  filterCubit.filter();
                },
                radius: radiusBtn,
              );
            },
          ),
        ),
        leading: InkWell(
          onTap: () => GoRouter.of(context).pop(),
          child: const Icon(Icons.close),
        ),
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
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
      ),
    );
  }
}
