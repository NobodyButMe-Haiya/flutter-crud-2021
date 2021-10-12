import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
// seem we got Stateless Widget , StatefullWidget, State
// WTF all this just to run one class ?
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // refer like this cleaner if we cannot touch Why weird weird
    return const MaterialApp(home: MyHomePage());
  }
}
// what this constructor ? redraw ?  no idea ?
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
// so we only do here code ?
class _MyHomePageState extends State<MyHomePage> {
  // what we really wanted only code as normal ?
  //maybe we will replace by widget ? who know these thing ?
  String title = "This is title ?widget";
  String name  = "dummy ";
  int age  = 12;
  late TextField nameTextField;
  late TextField ageTextField;
  @override
  Widget build(BuildContext context) {
    // can we define widget value here default ?
    nameTextField = TextField(decoration:InputDecoration(labelText: name));
    ageTextField = TextField(decoration:InputDecoration(labelText: age.toString()));

    var scaffold = Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [nameTextField,ageTextField],
          ),
        )
      ));

    return scaffold;
  }
}
