import 'package:cloud_firestore/cloud_firestore.dart';

class DBQuery {
  static DBQuery get instanace => DBQuery();

  getLoggedInUserDetails(uid) async {
    QuerySnapshot userData = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();

    if (userData.docs.isNotEmpty) {
      return userData.docs.toList();
    } else {
      return null;
    }
  }

  getUsersByDept(deptName) async {
    QuerySnapshot usersList = await FirebaseFirestore.instance
        .collection('users')
        .where('department', isEqualTo: deptName)
        .get();

    if (usersList.docs.isNotEmpty) {
      return usersList.docs.toList();
    } else {
      return null;
    }
  }

  getTasksBySignedInUser(SignedInUserEmail) async {
    QuerySnapshot userTaskList = await FirebaseFirestore.instance
        .collection('assignedTasks')
        .where('Assigned by(email)', isEqualTo: SignedInUserEmail)
        .get();

    if (userTaskList.docs.isNotEmpty) {
      return userTaskList.docs.toList();

    } else {
      return null;
    }
  }
}