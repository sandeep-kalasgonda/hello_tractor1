import 'package:firebase_database/firebase_database.dart';
class UserModel
{
  String? phone;
  String? name;
  String? id;
  String? email;

  UserModel({this.phone,this.name,this.id,this.email,});

  UserModel.formSnapshot(DataSnapshot snap){
    phone = (snap.value as dynamic)["phone"];
    id = snap.key;
    email = (snap.value as dynamic)["email"];
    name = (snap.value as dynamic)["name"];

  }
}