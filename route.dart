import 'package:flutter/material.dart';
import 'list.dart';

void main() {
  runApp(
    const MaterialApp(
        title: 'Named Routes Demo',
        // Start the app with the "/" named route. In this case, the app starts
        // on the FirstScreen widget.
        home: ListsView()),
  );
}
