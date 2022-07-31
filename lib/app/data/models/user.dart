import 'package:paymentmanagement/app/data/models/company.dart';

class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? createdAt;
  Role? role;
  Company? company;
  String? username;
  String? updateAt;
  UserModel(
      {this.id,
      this.username,
      this.lastName,
      this.role,
      this.createdAt,
      this.updateAt,
      this.company,
      this.firstName});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    return data;
  }
}

enum Role { USER, ADMIN }
