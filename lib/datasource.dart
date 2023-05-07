import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model.dart';

class ApiDataSource {
  final String _baseUrl = "https://fakestoreapi.com";

  ApiDataSource._privateConstructor();

  static final ApiDataSource instance = ApiDataSource._privateConstructor();

  Future<List<ProductModel>> loadProducts() async {
    final response = await http.get(Uri.parse("$_baseUrl/products"));

    if (response.statusCode == 200) {
      final List<dynamic> productsJson = json.decode(response.body);
      final List<ProductModel> products = productsJson.map((product) => ProductModel.fromJson(product)).toList();
      return products;
    } else {
      throw Exception("Failed to load products");
    }
  }
}

