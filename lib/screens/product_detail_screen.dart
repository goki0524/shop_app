import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    // ナビゲーターからのパラメーターを変数に格納
    final productId = ModalRoute.of(context).settings.arguments as String;
    // Providerからデータを取得. findById関数を使用したいだけなのでlisten: falseにする
    // products_gridでProductsの状態を監視しているため,listenは不要
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
