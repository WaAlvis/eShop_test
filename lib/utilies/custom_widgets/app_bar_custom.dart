import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  final bool viewList;

  AppBarCustom({Key key, this.viewList, this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
          child: viewList == false ? Icon(Icons.list) : Icon(Icons.grid_view),
          onTap: () {
            onPressed();
          }),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('e-Shop'),
          Spacer(),
          Icon(Icons.shopping_cart_rounded),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 30, bottom: 20),
              child: Text(
                'Lista de productos',
                style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
