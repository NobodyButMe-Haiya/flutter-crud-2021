import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'list.dart';
import 'model/read_model.dart';

class FormView extends StatefulWidget {
  final Data data;
  const FormView({Key? key, required this.data}) : super(key: key);
  @override
  State<FormView> createState() => FormViewState();
}

class FormViewState extends State<FormView> {
  final String title = "This is title ?widget";
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // can we define widget value here default ?
    if (widget.data.name.isNotEmpty) {
      nameController.text = widget.data.name;
    }
    ageController.text =
        (widget.data.age == 0) ? "" : widget.data.age.toString();

    // seem static
    var scaffold = Scaffold(
        appBar: AppBar(title: const Text("Form"), actions: [
          TextButton(
              onPressed: () {
                // only assign value to object state if length more 0
                if (widget.data.name != nameController.text) {
                  widget.data.name = nameController.text;
                }
                if (widget.data.age != int.parse(ageController.text)) {
                  widget.data.age = int.parse(ageController.text);
                }
                saveRecord(context, widget.data);
              },
              child: const Text("SAVE",
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red,
                    decorationStyle: TextDecorationStyle.wavy,
                  )))
        ]),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(30, 100, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextField(
                      decoration: const InputDecoration(
                          labelText: "Name", hintText: "Mac Machon Jr"),
                      controller: nameController),
                  TextField(
                    decoration:
                        const InputDecoration(labelText: "Age", hintText: "0"),
                    keyboardType: TextInputType.number,
                    controller: ageController,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    child: const Text('Delete'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        textStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    onPressed: (widget.data.personId > 0)
                        ? () => deleteRecord(context, widget.data)
                        : null,
                  )
                ],
              ),
            )));

    return scaffold;
  }

  Future saveRecord(BuildContext context, Data data) async {
    // the problem here we still need normal  as exception how to control ?
    const String url = "http://192.168.0.154/php_tutorial/api.php";
    // seem everything default not working so dio
    String mode = (data.personId == 0) ? "create" : "update";

    try {
      var formData = (data.personId == 0)
          ? FormData.fromMap({'mode': mode, "name": data.name, "age": data.age})
          : FormData.fromMap({
              'mode': mode,
              "name": data.name,
              "age": data.age,
              "personId": data.personId
            });
      var response = await Dio().post(
        url,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      print(response.data);
      if (response.statusCode == 200) {
        // hmm .. this bad..  if error can detect ?

        if (response.data.contains("false")) {
          throw Exception("parameter not send");
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ListsView()));
        }
      } else {
        throw Exception("failure");
      }
    } catch (e) {
      print(e);
    }
  }

  Future deleteRecord(BuildContext context, Data data) async {
    // the problem here we still need normal  as exception how to control ?
    const String url = "http://192.168.0.154/php_tutorial/api.php";
    // seem everything default not working so dio

    try {
      var formData =
          FormData.fromMap({'mode': "delete", "personId": data.personId});
      var response = await Dio().post(
        url,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      print(response.data);
      if (response.statusCode == 200) {
        // hmm .. this bad..  if error can detect ?

        if (response.data.contains("false")) {
          throw Exception("parameter not send");
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ListsView()));
        }
      } else {
        throw Exception("failure");
      }
    } catch (e) {
      print(e);
    }
  }
}
