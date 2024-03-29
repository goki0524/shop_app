import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;

  CartItem({
    this.id,
    this.productId,
    this.title,
    this.price,
    this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      // スワイプでアイテムを削除
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart, // 左スワイプ時のみ削除
      confirmDismiss: (direction) {
        // スワイプで削除する前に確認ダイアログを表示する
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('確認画面'),
            content: Text('商品をカートから削除してもよろしいですか?'),
            actions: <Widget>[
              FlatButton(child: Text('いいえ'), onPressed: () {
                Navigator.of(ctx).pop(false);
              },),
              FlatButton(child: Text('はい'), onPressed: () {
                Navigator.of(ctx).pop(true);
              },),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        // removeItemを使用したいだけのため,listen: falseにする
        // cart_screenでCartの状態は監視しているためlistenは不要
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  // 文字をウィジェット内に収めるように圧縮
                  child: Text('¥$price'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('合計: ¥${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
