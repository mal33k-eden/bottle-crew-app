import 'package:bottle_crew/models/crew.dart';
import 'package:bottle_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  String uid;

  DataBaseService({required this.uid});
  //collection reference
  final CollectionReference bottleCollection =
      FirebaseFirestore.instance.collection('bottle');

  Future updateUserDate(String _type, String name, int bottles) async {
    return await bottleCollection
        .doc(uid)
        .set({'type': _type, 'name': name, 'bottles': bottles});
  }

  Iterable<Crew> _crewListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      return Crew(
          type: data['type'], name: data['name'], bottles: data['bottles']);
    }).toList();
  }

  //get bottle crews
  Stream<Iterable<Crew>?> get bottlecrews {
    return bottleCollection.snapshots().map(_crewListFromSnapShot);
  }

  //userdata from snaptshot
  BCUserData _bcUserDataFromSnapShot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return BCUserData(
        uid: uid,
        name: data['name'],
        type: data['type'],
        bottle: data['bottles']);
  }

  //get user document
  Stream<BCUserData> get userData {
    return bottleCollection.doc(uid).snapshots().map(_bcUserDataFromSnapShot);
  }
}
