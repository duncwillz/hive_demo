import 'package:demo_app/db/category.dart';
import 'package:demo_app/model/items_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemDetailPage extends StatefulWidget {
  final ViewModel model;
  final Category category;

  ItemDetailPage({Key key, this.model, this.category}) : super(key: key);
  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  TextEditingController nameController;
  TextEditingController typeController;

  @override
  void initState() {
    nameController = TextEditingController();
    typeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
//          title: Text(widget.model.itemName),
            ),
        body: Container(
          child: Center(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.category.name.toUpperCase(),
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: "Enter category",
                        border: OutlineInputBorder())),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                    controller: typeController,
                    decoration: InputDecoration(
                        hintText: "Enter category",
                        border: OutlineInputBorder())),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Save"),
                  ),
                ),
              )
            ],
          )),
        ));
  }

//  addItem(ItemType addItem) {}
}
