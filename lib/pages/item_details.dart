import 'package:demo_app/db/category.dart';
import 'package:demo_app/model/items_model.dart';
import 'package:demo_app/pages/add_item_pages.dart';
import 'package:demo_app/pages/view_items_views.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemDetailPage extends StatefulWidget {
  final Category category;
  ItemDetailPage({this.category});

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  ViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    if (viewModel == null) {
      viewModel = Provider.of<ViewModel>(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AddItem(
                              model: viewModel,
                              category: widget.category,
                            )));
              })
        ],
      ),
      body: Center(
          child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        childAspectRatio: 1,
        children: viewModel.items
            .map(
              (item) => Container(
                //  color: Colors.cyan[100],
                child: GestureDetector(
                    onTap: () {
                      //Navigate to the Page you have
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ViewItem(
                            item: item,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 2,
                      margin: EdgeInsets.all(5.0),
                      //color: Colors.cyan[100],
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.smartphone),
                          SizedBox(height: 20),
                          Text(item.modelName,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    )),
              ),
            )
            .toList(),
      )),
    );
  }
}
