import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/shopping_cart.dart';
import '../../models/shopping_catalog.dart';
import 'cart_route.dart';
import 'theme.dart';

class MyCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appTheme,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.shopping_cart),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => MyCart())),
        ),
        body: CustomScrollView(
          slivers: [
            _MyAppBar(),
            SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MyListItem(index)),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The context.select() method will let you listen to changes to
    // a *part* of a model. You define a function that "selects" (i.e. returns)
    // the part you're interested in, and the provider package will not rebuild
    // this widget unless that particular part of the model changes.
    //
    // This can lead to significant performance improvements.
    var isInCart = context.select<ShoppingCartModel, bool>(
      // Here, we are only interested whether [item] is inside the cart.
      (cart) => cart.items.contains(item),
    );

    return FlatButton(
      onPressed: isInCart
          ? () => context.read<ShoppingCartModel>().remove(item)
          : () => context.read<ShoppingCartModel>().add(item),
      splashColor: Theme.of(context).primaryColor,
      child: isInCart
          ? Icon(Icons.check, semanticLabel: 'ADDED')
          : Icon(Icons.add),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context)),
      title: Text('游戏商城', style: Theme.of(context).textTheme.headline1),
      floating: true,
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  _MyListItem(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = context.select<ShoppingCatalogModel, Item>(
      // Here, we are only interested in the item at [index]. We don't care
      // about any other change.
      (catalog) => catalog.getByPosition(index),
    );
    var textTheme = Theme.of(context).textTheme.headline6;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: textTheme),
            ),
            SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}
