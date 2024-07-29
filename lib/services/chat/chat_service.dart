import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  /// get instance of firebase & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// get user stream
 /*
 List<Map<String, dynamic> =
 [
 {
 'email' : user@gmail.com
 'id' : ..
 },
 {
 'email' : user@gmail.com
 'id' : ..
 }
 ]

 */

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc){
        /// go though each individual user
        final user = doc.data();

        ///return user
        return user;
      }).toList();
    });
  }

/// send message
Future<void> sendMessage(String receiverId, message) async {
    /// get current user info
  final String currentUserId = _auth.currentUser!.uid;
  final String currentUserEmail = _auth.currentUser!.email!;
  final Timestamp timestamp = Timestamp.now();

  /// construct chat room id for the two user (sorted to ensure uniqueness)
  /// add new message to database
}

/// get message
}