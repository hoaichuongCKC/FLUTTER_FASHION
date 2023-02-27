import 'package:flutter_fashion/app/presentation/home/components/banner.dart';
import 'package:flutter_fashion/app/presentation/home/components/popular_search.dart';
import 'package:flutter_fashion/app/presentation/home/components/product_categories.dart';
import 'package:flutter_fashion/app/presentation/home/components/product_recommend.dart';
import 'package:flutter_fashion/app/presentation/home/components/top_header.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';

import 'components/promotions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          TopHeaderHome(),
          BannerHome(),
          ProductCategoriesHome(),
          PopularSearchHome(),
          ListPromotion(),
          ProductRecommend(),
        ],
      ),
    );
  }
}
