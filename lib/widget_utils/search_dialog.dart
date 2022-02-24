import 'package:appsolute/view_models/article_view_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({Key? key}) : super(key: key);

  @override
  _SearchDialogState createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  // My keyword controller
  final keywordController = TextEditingController();
  // formKey
  final formKey = GlobalKey<FormState>();
  // settigns for language
  bool onLanguage = false;
  String dropDownValueLanguage = 'none';
  var itemsLanguage = ['none', 'ar', 'de', 'es', 'fr', 'it'];

  // settigns for language
  bool sortBy = false;
  String dropDownValueSort = 'none';
  var itemsSort = ['none', 'relevancy', 'popularity', 'publishedAt'];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 25.0),
                child: Text(
                  'Search in news',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill the keyword field';
                      }
                      return null;
                    },
                    controller: keywordController,
                    decoration: const InputDecoration(
                        label: Text('Keyword'), border: OutlineInputBorder()),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  children: [
                    const Text('by Language'),
                    Switch(
                      activeColor: Colors.black,
                      value: onLanguage,
                      onChanged: (value) {
                        setState(() {
                          onLanguage = value;
                          if (!onLanguage) {
                            dropDownValueLanguage = 'none';
                          }
                        });
                      },
                    ),
                    onLanguage
                        ? DropdownButton<String>(
                            value: dropDownValueLanguage,
                            items: itemsLanguage.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropDownValueLanguage = newValue!;
                              });
                            })
                        : Container()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  children: [
                    const Text('sortBy'),
                    Switch(
                      activeColor: Colors.black,
                      value: sortBy,
                      onChanged: (value) {
                        setState(() {
                          sortBy = value;
                          if (!sortBy) {
                            dropDownValueSort = 'none';
                          }
                        });
                      },
                    ),
                    sortBy
                        ? DropdownButton<String>(
                            value: dropDownValueSort,
                            items: itemsSort.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropDownValueSort = newValue!;
                              });
                            })
                        : Container()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // send the request when everything is ok !
                            Provider.of<ArticleViewModel>(context,
                                    listen: false)
                                .getSearchResponseOnList(keywordController.text,
                                    dropDownValueLanguage, dropDownValueSort);
                            // After pop and comeback to everything screen to seen the result of request
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Search'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
