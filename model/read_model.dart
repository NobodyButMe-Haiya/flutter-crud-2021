class ReadModel {
  late bool success;
  late String message;
  late List<Data> data;

  ReadModel({required this.success, required this.message, required this.data});

  ReadModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}

class Data {
  late int personId;
  late String name;
  late int age;

  Data({required this.personId, required this.name, required this.age});
  Data.fromJson(Map<String, dynamic> json) {
    personId = int.parse(json['personId']);
    name = json['name'];
    age = int.parse(json['age']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['personId'] = personId;
    data['name'] = name;
    data['age'] = age;
    return data;
  }
}
