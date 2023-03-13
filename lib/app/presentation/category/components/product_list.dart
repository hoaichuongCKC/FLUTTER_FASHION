import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/category/blocs/category_bloc.dart';
import 'package:flutter_fashion/common/components/item_product.dart';

import '../../../../export.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late CategoryPageBloc _bloc;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<CategoryPageBloc>();
    _scrollController = ScrollController()
      ..addListener(() {
        _bloc.loadMore(_scrollController);
      });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _scrollController.removeListener(() {
      _bloc.loadMore(_scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StreamBuilder<List<ProductModel>>(
          stream: _bloc.listProductStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData ||
                snapshot.data == null ||
                snapshot.data!.isEmpty) {
              return const SizedBox();
            }
            final list = snapshot.data;
            return Expanded(
              child: GridView.builder(
                controller: _scrollController,
                itemCount: list!.length,
                padding: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding - 4, vertical: 10.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2 / 4,
                  mainAxisExtent: 210.0,
                ),
                itemBuilder: (context, index) {
                  return ItemProduct(product: list[index]);
                },
              ),
            );
          },
        ),
        StreamBuilder(
          stream: _bloc.isLoading,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            }
            if (snapshot.data!) {
              return Center(
                child: Text(
                  'đang tải...',
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 12.0,
                    color: primaryColor,
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
