import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './providers/auth.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';

// Widget (Local) State
// Affects only a widget on its own (does not affect other widgets)
// "Should a loading spinner be displayed?", From Input, Validation...etc

// App-wide State
// Affects entire app or significant parts of the app
// Authentication("is the user authenticated?"), Loaded Products,...

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Providerで全体の状態を管理.MultiProviderは複数記述できる
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        // lesson 263: Authの状態を検知してProductsを更新させる.
        // またAuthオブジェクトを受け取れる(ChangeNotifierProxyProvider)
        ChangeNotifierProxyProvider<Auth, Products>(
          builder: (ctx, auth, previousProducts) => Products(
            auth.token,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          builder: (ctx, auth, previousOrders) => Orders(
            auth.token,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      // lesson: 261 認証による初期画面の切り替え(未認証:認証画面, 認証済:商品ページ)
      // Consumer<Auth>によりAuthオブジェクトの状態を検知して,MaterialAppを再構築する
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'OneTapShop',
          theme: ThemeData(
            primarySwatch: Colors.teal,
            accentColor: Colors.deepOrange,
            fontFamily: 'MPLUSRounded1c',
          ),
          home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
