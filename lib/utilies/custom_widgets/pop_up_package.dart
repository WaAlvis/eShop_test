import 'package:e_shop_test/screens/home_page.dart';
import 'package:e_shop_test/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

openPopup(context) {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();

  Alert(
      context: context,
      title: "Create Product",
      content: Column(
        children: <Widget>[
          TextField(
            controller: _controllerName,
            decoration: InputDecoration(
              hintText: 'Enter Name',
              icon: Icon(Icons.looks_one_outlined),
            ),
          ),
          TextField(
            controller: _controllerDescription,
            decoration: InputDecoration(
              hintText: 'Enter Description',
              icon: Icon(Icons.looks_two_outlined),
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            createProduct(nameProduct: _controllerName.text, descriptionProduct: _controllerDescription.text);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ),
            );
          },
          child: Text(
            "SEND",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
