// ignore_for_file: deprecated_member_use

import 'package:flutter_fashion/app/blocs/search/search_cubit.dart';
import 'package:flutter_fashion/export.dart';

class FormSearch extends StatefulWidget {
  const FormSearch({
    super.key,
    required this.onFieldSubmitted,
  });
  final void Function(String) onFieldSubmitted;

  @override
  State<FormSearch> createState() => _FormSearchState();
}

class _FormSearchState extends State<FormSearch> {
  late final TextEditingController _controller;
  late ValueNotifier<bool> _notifier;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    _notifier = ValueNotifier(false);
  }

  @override
  void dispose() {
    _notifier.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state.keyword.isNotEmpty) {
          _controller.text = state.keyword;
          _notifier.value = false;
        }
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: _notifier,
        builder: (context, isCheck, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DecoratedBox(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(color: disablePrimaryColor, blurRadius: 7.0),
              ]),
              child: TextFormField(
                controller: _controller,
                autofocus: true,
                style: PrimaryFont.instance.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                onChanged: (value) {
                  if (!isCheck && _controller.text.isNotEmpty) {
                    _notifier.value = !isCheck;
                  } else if (isCheck && _controller.text.isEmpty) {
                    _notifier.value = !isCheck;
                  }
                },
                onFieldSubmitted: (value) {
                  widget.onFieldSubmitted(value);
                  getIt.get<SearchCubit>().changedKeyword(value);
                  _controller.text = "";
                },
                decoration: InputDecoration(
                    prefixIcon: Hero(
                      tag: "icon-search",
                      transitionOnUserGestures: true,
                      child: SvgPicture.asset(
                        "assets/icons/search.svg",
                        fit: BoxFit.scaleDown,
                        width: 20.0,
                        height: 20.0,
                        color: darkColor.withOpacity(0.4),
                      ),
                    ),
                    hintText: "vd: Quần jean",
                    fillColor: lightColor,
                    hintStyle: PrimaryFont.instance.copyWith(
                      fontSize: 10.0,
                      color: darkColor.withOpacity(0.4),
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: horizontalPadding - 4),
                    isDense: true,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(radiusBtn / 2),
                      ),
                    ),
                    suffixIcon: (isCheck)
                        ? IconButton(
                            onPressed: () {
                              _notifier.value = false;
                              _controller.clear();
                            },
                            icon: const Icon(
                              Icons.clear,
                              size: 18.0,
                            ),
                          )
                        : InkWell(
                            onTap: () =>
                                AppRoutes.router.pushNamed(Names.FILTER),
                            child: SvgPicture.asset(
                              "assets/icons/filter.svg",
                              fit: BoxFit.scaleDown,
                            ),
                          )),
              ),
            ),
          );
        },
      ),
    );
  }
}
