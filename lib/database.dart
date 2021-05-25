import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:idcardscanner/user.dart';
import 'package:idcardscanner/auth.dart';

class DatabaseService {
  final CollectionReference sample = Firestore.instance
      .collection("24-5-2021")
      .document("Outing")
      .collection("Out");

  _getDate() {
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    return "${dateParse.day}-${dateParse.month}-${dateParse.year}";
  }

  Future<bool> outing(String scan, String state) async {
    final CollectionReference outingOut =
        Firestore.instance.collection(_getDate());
    DocumentSnapshot snap =
        await Firestore.instance.collection('Students_Ph').document(scan).get();
    if (snap == null || !snap.exists) {
      return false;
    }
    User user = await AuthService().user.first;
    DocumentSnapshot snap2 = await Firestore.instance
        .collection('Security')
        .document(user.uid)
        .get();
    var dateTime = DateTime.now();
    var timeNow =
        "${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}:${dateTime.minute}:${dateTime.second.ceil()}";
    await outingOut.document('Outing').collection(state).document().setData({
      'Scanned': snap.data['name'],
      'OutTime': timeNow,
      'Scanned By Name': snap2.data['name']
    });
    return true;
  }

  Future leave(String scan, String state) async {
    final CollectionReference leaveOut =
        Firestore.instance.collection(_getDate());
    DocumentSnapshot snap =
        await Firestore.instance.collection('Students_Ph').document(scan).get();
    if (snap == null || !snap.exists) {
      return false;
    }
    User user = await AuthService().user.first;
    DocumentSnapshot snap2 = await Firestore.instance
        .collection('Security')
        .document(user.uid)
        .get();
    var dateTime = DateTime.now();
    var timeNow =
        "${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}:${dateTime.minute}:${dateTime.second.ceil()}";
    await leaveOut.document('Leave').collection(state).document().setData({
      'Scanned': snap.data['name'],
      'OutTime': timeNow,
      'Scanned By Name': snap2.data['name']
    });
    return true;
  }

  // ignore: missing_return
  Future<String> getName() async {
    User user = await AuthService().user.first;

    QuerySnapshot xyz =
        await Firestore.instance.collection('Admins').getDocuments();

    for (var doc in xyz.documents) {
      if (doc.documentID == user.uid) {
        return doc.data['name'];
      }
    }
    xyz = await Firestore.instance.collection('Security').getDocuments();
    for (var doc in xyz.documents) {
      if (doc.documentID == user.uid) {
        return doc.data['name'];
      }
    }
  }

  Stream<QuerySnapshot> get stud {
    return sample.snapshots();
  }
}
