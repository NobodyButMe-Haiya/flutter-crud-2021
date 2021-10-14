import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hola/form.dart';
import 'package:hola/service/future_read.dart';

import 'model/data_model.dart';
// as conclusion .. some thing dart is easy .. some part easy to design doesn't mean you will have 0 error ..
// we will continue at form ..
// we continue again at the form . So some part consider can copy and paste like service . We do it . no need to retype everything ..

class ListsView extends StatefulWidget {
  const ListsView({Key? key}) : super(key: key);

  @override
  State<ListsView> createState() => ListsViewState();
}

class ListsViewState extends State<ListsView> {
  late Future<List<Data>> dataLists;
  // create state constructor
  @override
  void initState() {
    super.initState();
    // okay diamond in diamond weirdness
    dataLists = fetchPerson();
  }

  @override
  Widget build(BuildContext context) {
    // wait wheres my button text?
    var appBar = AppBar(title: const Text("List"), actions: [
      TextButton(
          onPressed: () {
            Data data = Data(personId: 0, name: "", age: 0);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FormView(data: data)));
          },
          child: const Text("Create", style: TextStyle(color: Colors.white)))
    ]);

    // if you want separated the future builder your choice .. we don't like nested function
    // so we try new code if working .. form
    var layout = Scaffold(
        appBar: appBar,
        body: Center(
          child: FutureBuilder<List<Data>>(
              future: dataLists,
              builder: (context, snapshot) {
                // must return something ..
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Wait ya");
                } else if (snapshot.hasError) {
                  return const Text(
                      "Error lol. check .. this seem weird give eror  ");
                } else {
                  // okay we list data

                  List<Data> dataLists = snapshot.data!;

                  var listViewBuilder = ListView.builder(
                      itemCount: dataLists.length,
                      itemBuilder: (context, index) {
                        // must return something if not error
                        Data data = dataLists[index];
                        // oh here we missing on press on click thing  oh now call on Tap ?
                        var listsTitle = ListTile(
                          title: Text(data.name),
                          subtitle: Text(data.age.toString()),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FormView(data: data)));
                          },
                        );
                        return listsTitle;
                      });

                  return listViewBuilder;
                }
              }),
        ));
    return layout;
  }
}
