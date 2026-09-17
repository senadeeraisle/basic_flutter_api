import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_flutter_api/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Product>> getAllProducts() async {
    try {
      final String url = 'https://fakestoreapi.com/products';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        List<Product> products = responseData
            .map((json) => Product.fromJson(json))
            .toList();
        return products;
      } else {
        print(
          'Failed to fetch the product the status code: ${response.statusCode}',
        );
        throw Exception('Failed to fetch products');
      }
    } on Exception catch (error) {
      print('product loading error: $error');
      throw Exception('Failed to load products');
    }
  }

  Future<Product> getSingleProduct(int id) async {
    try {
      final String url = 'https://fakestoreapi.com/products/$id';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Product product = Product.fromJson(jsonDecode(response.body));
        return product;
      } else {
        throw Exception('falid to fetch products');
      }
      ;
    } catch (error) {
      print('product loading error: $error');
      throw Exception('Failed to load products');
    }
  }

  Future<Product> addNewProduct(Product product) async {
    try {
      final String url = 'https://fakestoreapi.com/products';
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(product.toJson()),
      );
      print('response status code: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Product newProduct = Product.fromJson(json.decode(response.body));
        print(response.body);
        return newProduct;
      } else {
        print('error on adding data ${response.statusCode}');
        print('response body ${response.body}');
        throw Exception('error on adding data');
      }
    } catch (error) {
      print('error on adding the prduct $error');
      throw Exception('error on adding the prduct');
    }
  }

  // Future<void> addNewProduct(Product product) async {
  //   try {
  //     final String url = 'https://fakestoreapi.com/products';
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {"Content-Type": "application/json"},
  //       body: json.encode(product.toJson()),
  //     );
  //     print('response status code: ${response.statusCode}');
  //     print(response.body);
  //   } catch (error) {
  //     print('error on adding the prduct $error');
  //     throw Exception('error on adding the prduct');
  //   }
  // }

  //method to update a product

  Future<Product> editProduct(int id, Product product) async {
    final String url = 'https://fakestoreapi.com/products/$id';
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(product.toJson()),
      );
      print('response status code ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Product updatedProduct = Product.fromJson(
          json.decode(response.body),
        );
        print(response.body);
        return updatedProduct;
      } else {
        print('Error code ${response.statusCode}');
        throw Exception('Error updating the product');
      }
    } catch (error) {
      print('error updating product$error');
      throw Exception('Error updating the product');
    }
  }
}
