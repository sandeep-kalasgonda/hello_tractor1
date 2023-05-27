import 'package:driver/globel/globel.dart';
import 'package:driver/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';

class AssistantMethod{
  static void readCurrentOnlineusreinfo(){
    currentFirebaseUser = fAuth.currentUser;
    DatabaseReference userRef = FirebaseDatabase.instance
    .ref()
    .child("users")
    .child(currentFirebaseUser!.uid);

    userRef.once().then((snap) {
      if(snap.snapshot.value != null){
        userModelCurrentInfo = UserModel.formSnapshot(snap.snapshot);
        print("name =" + userModelCurrentInfo!.name.toString());
        print("email =" + userModelCurrentInfo!.email.toString());
        print("phone =" + userModelCurrentInfo!.phone.toString());
      }
    });
  }
}