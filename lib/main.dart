import 'package:demo_app/db/category.dart';
import 'package:demo_app/db/item.dart';
import 'package:demo_app/pages/add_category.dart';
import 'package:demo_app/pages/add_item_pages.dart';
import 'package:demo_app/pages/item_details.dart';
import 'package:demo_app/utils/inventory_custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'model/items_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  registerAdapters();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ViewModel>(
          create: (context) => ViewModel(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/': (context) => MyHomePage(),

            //home: MyHomePage(),
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ViewModel viewModel;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (viewModel == null) {
      viewModel = Provider.of<ViewModel>(context);
      viewModel.getAllCategories();
    }
    // final TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        title: new Text("Gadget Inventory",
            style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
      ),

      body: Center(
          child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, item) {
          return Container(
            child: GestureDetector(
                onTap: () {
                  //Navigate to the Page you have
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ItemDetailPage(
                        category: viewModel.categories[item],
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
                        getIconData(viewModel.categories[item].iconName),
                        size: 90,
                      ),
                      SizedBox(height: 20),
                      Text(viewModel.categories[item].name,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ],
                  ),
                )),
          );
        },
        itemCount: viewModel.categories.length,
        primary: false,
        padding: const EdgeInsets.all(20),
      )),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        mini: false,
        highlightElevation: 20.0,
        //shape: BeveledRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(16.0)) ),
        onPressed: () {
          debugPrint("Add New Device Category");
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddCategory(
              viewModel: viewModel,
            );
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
    );
  }

  getIconData(String iconName) {
    try {
      return iconData[iconData.keys.firstWhere((key) => key == iconName)];
    } catch (e) {
      return Icons.star;
    }
  }
}

Map<String, IconData> iconData = {
  "Smartphone": Icons.smartphone,
  "TV": Icons.tv,
  "Computers": Icons.computer,
  "Home Appliances": Icons.home,
};
