import 'package:flutter_fashion/app/blocs/language/language_cubit.dart';
import 'package:flutter_fashion/app/blocs/theme/theme_cubit.dart';
import 'package:flutter_fashion/dependency_injection.dart';

Future<void> initDISetting() async {
  getIt.registerFactory(() => ThemeCubit());
  getIt.registerFactory(() => LanguageCubit());
}
