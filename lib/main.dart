import 'package:demo_app/db/category.dart';
import 'package:demo_app/db/item.dart';
import 'package:demo_app/pages/add_category.dart';
import 'package:demo_app/pages/item_pages.dart';
import 'package:demo_app/utils/inventory_custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'model/items_model.dart';

void main() {
  registerAdapters();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => MyHomePage(),

          //home: MyHomePage(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ViewModel viewModel = ViewModel();
  @override
  void initState() {
    viewModel.initHive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => ViewModel(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.lightBlueAccent,
          title: new Text("Gadget Inventory",
              style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
        ),

        body: Consumer<ViewModel>(
          builder: (_, model, __) {
            model.getAllCategories();
            return Center(
                child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 1,
              children: model.categories
                  .map(
                    (category) => Container(
                      //  color: Colors.cyan[100],
                      child: GestureDetector(
                          onTap: () {
                            //Navigate to the Page you have
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ItemDetailPage(
                                  model: model,
                                  category: category,
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
                                Icon(
                                  IconData(
                                      int.parse(
                                          '0x${category.iconName ?? "e800"}'),
                                      fontFamily:
                                          InventoryCustomIcons.kFontFam),
                                  size: 90,
                                ),
                                SizedBox(height: 20),
                                Text(category.name,
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
            ));
          },
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          mini: false,
          highlightElevation: 20.0,
          //shape: BeveledRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(16.0)) ),
          onPressed: () {
            debugPrint("Add New Device Category");
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddCategory();
            })); //
          },
          tooltip: 'Add Device Cattegorry',
          child: Icon(Icons.add),
        ),

        bottomNavigationBar: new BottomAppBar(
          color: Colors.lightBlueAccent,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.menu),
                onPressed: () {},
              ),
              //new IconButton(icon: new Icon(Icons.search),onPressed:(){} ,),
            ],
          ),
        ),

        //
      ),
    );
  }
}
