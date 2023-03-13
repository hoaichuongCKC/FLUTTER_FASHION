import 'package:flutter_fashion/app/blocs/search_history/search_history_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';

class SearchHistory extends StatelessWidget {
  const SearchHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ColoredBox(
        color: lightColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: horizontalPadding - 4, vertical: 8.0),
          child: Column(
            children: [
              StreamBuilder<List<String>>(
                stream: context.watch<SearchHistoryCubit>().listStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.data!.isEmpty ||
                      snapshot.data == null) {
                    return const SizedBox();
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lịch sử tìm kiếm',
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      InkWell(
                        onTap: () =>
                            context.read<SearchHistoryCubit>().clearData(),
                        child: Text(
                          'Xoá',
                          style: PrimaryFont.instance.copyWith(
                            fontSize: 14.0,
                            color: primaryColor,
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
              StreamBuilder<List<String>>(
                stream: context.watch<SearchHistoryCubit>().listStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.data!.isEmpty ||
                      snapshot.data == null) {
                    return const SizedBox();
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final data = snapshot.data![index];
                      return ListTile(
                        onTap: () {},
                        contentPadding: EdgeInsets.zero,
                        horizontalTitleGap: 0.0,
                        dense: true,
                        title: Text(
                          data,
                          style: PrimaryFont.instance.copyWith(
                            fontSize: 14.0,
                            color: darkColor.withOpacity(0.5),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              StreamBuilder<bool>(
                stream: context.watch<SearchHistoryCubit>().showMoreStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.data!) {
                    return const SizedBox();
                  }
                  return ButtonWidget(
                    animate: true,
                    btnColor: disableDarkColor.withOpacity(0.2),
                    onPressed: () =>
                        context.read<SearchHistoryCubit>().loadMoreData(),
                    height: 40,
                    radius: 5.0,
                    labelWidget: Text(
                      'Hiển thị thêm',
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
