import 'package:appsolute/view_models/article_view_models.dart';
import 'package:appsolute/widget_utils/articleListTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Everything extends StatefulWidget {
  const Everything({Key? key}) : super(key: key);

  @override
  _EverythingState createState() => _EverythingState();
}

class _EverythingState extends State<Everything> {
  // initial value on dropDownList
  String dropdownvalue = 'fr';
  // the dropdawnvalue item
  var items = [
    'fr',
    'us',
    'it',
  ];
  // check request on error switch screen
  bool onError = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // first call of data on API when start with 'fr' as country
    Provider.of<ArticleViewModel>(context, listen: false)
        .getArticlesFromCountryOnList(dropdownvalue);
  }

  @override
  Widget build(BuildContext context) {
    // my article view model provider
    final avm = Provider.of<ArticleViewModel>(context);
    if (avm.list.isEmpty) {
      onError = true;
    } else {
      onError = false;
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          title: const Text(
            'News',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: DropdownButton<String>(
                value: dropdownvalue,
                icon: const Icon(Icons.arrow_drop_down),
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                    avm.getArticlesFromCountryOnList(dropdownvalue);
                  });
                },
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/favorite');
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                )),
          ],
        ),
        body: onError
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(avm.error),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          onPressed: () {
                            avm.getArticlesFromCountryOnList(dropdownvalue);
                          },
                          child: (avm.error == '')
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text('Try again'))
                    ],
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                    itemCount: avm.list.length,
                    itemBuilder: (context, i) {
                      return ArticleListTile(article: avm.list[i]);
                    }),
              ),
      ),
    );
  }
}
