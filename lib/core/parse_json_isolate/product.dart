import 'dart:convert';

import 'package:flutter_fashion/app/models/product/product.dart';

List<ProductModel> parseProductJson(String params) {
  final dataConvert = (jsonDecode(params)["data"]) as List;

  if (dataConvert.isEmpty) {
    return [];
  }

  return ProductModel.productModelFromJson(dataConvert);
}
