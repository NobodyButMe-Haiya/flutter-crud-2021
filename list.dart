import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/form.dart';

import 'model/read_model.dart';
import 'dart:developer' as devlog;
// seem we got Stateless Widget , StatefullWidget, State
// WTF all this just to run one class ?

// what this constructor ? redraw ?  no idea ?
class ListsView extends StatefulWidget {
  const ListsView({Key? key}) : super(key: key);
  @override
  State<ListsView> createState() => ListsViewState();
}

// ajax block
Future<List<Data>> fetchPerson() async {
  // the problem here we still need normal  as exception how to control ?
  List<Data> dataLists = <Data>[];
  const String url = "http://192.168.0.154/php_tutorial/api.php";
  // seem everything default not working so dio

  try {
    var formData = FormData.fromMap({'mode': 'read'});
    var response = await Dio().post(
      url,
      data: formData,
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    print(response.data);
    devlog.log("Response : "+response.data);
    if (response.statusCode == 200) {
      // hmm .. this bad..  if error can detect ?

      if (response.data.contains("false")) {
        throw Exception("parameter not send");
      } else {
        dataLists = ReadModel.fromJson(jsonDecode(response.data)).data.toList();
      }
    } else {
      throw Exception("failure");
    }
  } catch (e) {
    print(e);
  }
  return dataLists;
}

// so we only do here code ?
class ListsViewState extends State<ListsView> {
  late Future<List<Data>> dataLists;
  @override
  void initState() {
    super.initState();
    dataLists = fetchPerson();
  }

  @override
  Widget build(BuildContext context) {
    // can we define widget value here default ?

    var scaffold = Scaffold(
        appBar: AppBar(title: const Text("List"), actions: [
          TextButton(
              onPressed: () {
                // create a fake  data
                Data data = Data(personId: 0, name: "", age: 0);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FormView(data: data)));
                print("Got click but me ?");
              },
              child: const Text("CREATE",
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red,
                    decorationStyle: TextDecorationStyle.wavy,
                  )))
        ]),
        body: Center(
          child: FutureBuilder<List<Data>>(
            future: dataLists,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // hmm here should be a list
                List<Data> data = snapshot.data!;
                // return Text(data[0].name);

                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    Data dataByRow = data[index];
                    // later will using the Dismissible(
                    // Specify the direction to swipe and delete
                    //direction: DismissDirection.endToStart,

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(dataByRow.name),
                          subtitle: Text(dataByRow.age.toString()),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FormView(data: dataByRow)));
                          },
                        ),
                        const Divider(
                          height: 20,
                          thickness: 1,
                        )
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ));

    return scaffold;
  }
}
