import 'package:flutter_fashion/app/presentation/category/blocs/category_bloc.dart';
import 'package:flutter_fashion/app/presentation/filter/blocs/filter_bloc.dart';

import '../../../export.dart';

Future<void> initDICategory() async {
  getIt.registerLazySingleton<FilterBloc>(
    () => FilterBloc(),
  );
  getIt.registerLazySingleton<CategoryPageBloc>(
    () => CategoryPageBloc(productRepository: getIt()),
  );
}
