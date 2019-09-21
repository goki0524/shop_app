import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/config/env.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final env = Env();
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final url = env.getProductsUrlId(id);
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );
      if (response.statusCode >= 400) {
        // 失敗時は値を元に戻す
        _setFavValue(oldStatus);
      }
    } catch (error) {
      // 失敗時は値を元に戻す
      _setFavValue(oldStatus);
    }
  }
}
