import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vinhcine/network/constants/collection_tag.dart';

import '../models/entities/chat.dart';
import '../models/entities/user_model.dart';
import '../network/firebase/instance.dart';

abstract class UserRepository {
  late final CollectionReference? _chatCollection;
  late final CollectionReference? _userCollection;

  Stream<QuerySnapshot<UserModel>> getUsers();

  Stream<QuerySnapshot<UserModel>> getCurrentUser();

  Future<bool> checkChatExist({required String? uid1, required String? uid2});

  Future<void> createChat({required String? uid1, required String? uid2});
}

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl() {
    setUpCollectionReference();
  }

  void setUpCollectionReference() {
    _userCollection = Instances.fireStore
        .collection(CollectionTag.users)
        .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson());

    _chatCollection = Instances.fireStore
        .collection(CollectionTag.chats)
        .withConverter<Chat>(
            fromFirestore: (snapshot, _) => Chat.fromJson(snapshot.data()!),
            toFirestore: (chat, _) => chat.toJson());
  }

  /// [QuerySnapshot<UserModel>] is a list of [UserModel]
  @override
  Stream<QuerySnapshot<UserModel>> getUsers() {
    try {
      var res = _userCollection!
              .where("uid", isNotEqualTo: Instances.auth.currentUser?.uid)
              .snapshots(includeMetadataChanges: true)
          as Stream<QuerySnapshot<UserModel>>;
      return res;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<bool> checkChatExist(
      {required String? uid1, required String? uid2}) async {
    final snapshot = await _chatCollection!.doc("$uid1$uid2").get();
    return snapshot.exists;
  }

  @override
  Future<void> createChat(
      {required String? uid1, required String? uid2}) async {
    try {
      await _chatCollection!.doc("$uid1$uid2").set(Chat(
            id: "$uid1$uid2",
            participants: [uid1 ?? "", uid2 ?? ""],
            messages: [],
          ));
      await _chatCollection!.doc("$uid2$uid1").set(Chat(
            id: "$uid1$uid2",
            participants: [uid1 ?? "", uid2 ?? ""],
            messages: [],
          ));
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Stream<QuerySnapshot<UserModel>> getCurrentUser() {
    try {
      var res = _userCollection!
              .where("uid", isEqualTo: Instances.auth.currentUser?.uid)
              .snapshots(includeMetadataChanges: true)
          as Stream<QuerySnapshot<UserModel>>;
      return res;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
