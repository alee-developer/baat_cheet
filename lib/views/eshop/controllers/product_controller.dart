import 'dart:convert';

import 'package:baat_cheet_app/views/eshop/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductController with ChangeNotifier {
  List<ProductData> _products = <ProductData>[];

  List<ProductData> get getProducts => _products;

  Future<List<ProductData>> fetchAllProducts() async {
    var products = <ProductData>[];
    var url = Uri.parse("https://dummyjson.com/products");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.reasonPhrase);
      print(response.statusCode);
      var data = jsonDecode(response.body);
      products =  ProductModel.fromJson(data).products ?? List<ProductData>.empty();
    } else {
      products =  List<ProductData>.empty();
    }
    _products = products;
    notifyListeners();

    return products;
  }
}
