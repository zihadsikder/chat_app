import 'package:chat_app/models/message.dart';
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
      return snapshot.docs.map((doc) {
        /// go though each individual user
        final user = doc.data();

        ///return user
        return user;
      }).toList();
    });
  }

  /// send message
  Future<void> sendMessage(String receiverID, message) async {
    /// get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    /// create a new message
    Message newMessage = Message(
      senderID: currentUserEmail,
      senderEmail: currentUserId,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    /// construct chat room id for the two user (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, receiverID];
    ids.sort(); //sort the ids (this ensure the chatroomID is the same for any 2 people)
    String chatRoomID = ids.join('_');

    /// add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("message")
        .add(newMessage.toMap());
  }

  /// get message
  Stream<QuerySnapshot> getMessage(String userID, othersUserID) {
    /// construct a chatroom ID for the two users
    List<String> ids = [userID, othersUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
