import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/colors.dart';
import 'package:flutter_fashion/config/font_style.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const FormSearch(),
      ),
      body: ListView(
        children: [
          ColoredBox(
            color: lightColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                5,
                (index) => ListTile(
                  title: Text('$index - data 1001000110'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          ColoredBox(
            color: lightColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ListTile(
                  title: Text('Lịch sử tìm kiếm'),
                  trailing: Icon(Icons.train_sharp),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    5,
                    (index) => ListTile(
                      title: Text('$index - data 1001000110'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FormSearch extends StatefulWidget {
  const FormSearch({
    super.key,
  });

  @override
  State<FormSearch> createState() => _FormSearchState();
}

class _FormSearchState extends State<FormSearch> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: PrimaryFont.instance.copyWith(
        fontSize: 16.0,
        color: darkColor.withOpacity(0.7),
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: "Tìm kiếm sản phẩm",
        contentPadding: EdgeInsets.zero,
        isDense: true,
        filled: false,
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.clear,
            size: 20.0,
          ),
        ),
      ),
    );
  }
}
