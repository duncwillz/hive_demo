// Pages [NOTE]: You can use one page fpr all of them and pass the item to that page

import 'package:demo_app/db/category.dart';
import 'package:demo_app/model/items_model.dart';
import 'package:demo_app/utils/inventory_custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddCategory extends StatefulWidget {
  AddCategory({Key key}) : super(key: key);
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController controller;
  String dropdownValue;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add New Category"),
        ),
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.all(20),
            child: Center(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: "Enter category",
                          border: OutlineInputBorder())),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(
                        Icons.arrow_downward,
                        size: 16,
                      ),
                      isExpanded: true,
                      iconSize: 12,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.lightBlueAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>[
                        // You can add a lot of icon data here

                        "e800",
                        "e801"
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Icon(IconData(int.parse('0x$value'),
                              fontFamily: InventoryCustomIcons.kFontFam)),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ChangeNotifierProvider<ViewModel>(
                    create: (context) => ViewModel(),
                    child: Consumer<ViewModel>(
                      builder: (_, model, __) => RaisedButton(
                        onPressed: () {
                          if (controller.text.isNotEmpty ||
                              dropdownValue == null) {
                            setState(() {
                              var category = Category()
                                ..id = Uuid().toString()
                                ..name = controller.text.trim()
                                ..iconName = dropdownValue.toString();
                              model.addCategory(category);
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Add"),
                      ),
                    ),
                  ),
                )
              ],
            ))));
  }
}
