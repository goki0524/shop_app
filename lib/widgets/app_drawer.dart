import 'package:flutter/material.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('OneTapShop'),
            automaticallyImplyLeading: false, // 戻るボタンを表示しない
          ),
          Divider(), // 水平線
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('ショップ'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(), // 水平線
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('注文履歴'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(), // 水平線
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('商品を出品'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
