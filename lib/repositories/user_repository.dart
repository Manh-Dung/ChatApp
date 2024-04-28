import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vinhcine/network/constants/collection_tag.dart';

import '../models/entities/user_model.dart';
import '../network/firebase/instance.dart';

abstract class UserRepository {
  late final CollectionReference? _userCollection;

  Stream<QuerySnapshot<UserModel>> getUsers();
}

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl() {
    setUpCollectionReference();
  }

  void setUpCollectionReference() {
    _userCollection = Instances.firestore
        .collection(CollectionTag.users)
        .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson());
  }

  @override
  Stream<QuerySnapshot<UserModel>> getUsers() {
    return _userCollection!
        .where("uid", isNotEqualTo: Instances.auth.currentUser?.uid)
        .snapshots() as Stream<QuerySnapshot<UserModel>>;
  }
}
