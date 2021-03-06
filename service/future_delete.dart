// we will use dio because formdata not support by default
//  dart pub add dio

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hola/list.dart';
import 'package:hola/model/data_model.dart';
// but we don't want to see those annoyance underline,
import 'dart:developer' as logger;

Future<List<Data>> deletePerson(BuildContext context, Data data) async {
  List<Data> dataLists = <Data>[];
  try {
    // don't forget to use ip  not localhost
    var url = "http://192.168.0.154/php_tutorial/api.php";
    // the more proper and cleaner separete it all
    var formData =
        FormData.fromMap({'mode': 'delete', 'personId': data.personId});
    var options = Options(contentType: Headers.formUrlEncodedContentType);
    var response = await Dio().post(url, data: formData, options: options);
    if (response.statusCode == 200) {
      // okay no error
      var body = response.data;
      // wee need to check the respond what is it
      logger.log(body);

      if (body.contains("false")) {
        logger.log("something wrong.. ");
      } else {
        // send back to the page
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ListsView()));
      }
    } else {
      logger.log("something wrong network connection");
    }
  } catch (e) {
    logger.log(e.toString());
  }
  return dataLists;
}
