import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vinhcine/configs/app_config.dart';
import 'package:vinhcine/database/preferences.dart';
import 'package:vinhcine/network/api_client.dart';
import 'package:vinhcine/network/constants/collection_tag.dart';

import '../models/entities/user_model.dart';
import '../network/firebase/instance.dart';

abstract class AuthRepository {
  late final CollectionReference? _userCollection;

  Future<String?> getToken();

  Future<void> saveToken(String? token);

  Future<void> removeToken();

  Future<User> signIn(String username, String password);

  Future<UserModel> signUp(String fullName, String email, String password);

  Future<void> signOut();
}

class AuthRepositoryImpl extends AuthRepository {
  ApiClient? _apiClient;

  final _authInstance = Instances.auth;
  final firestoreInstance = Instances.firestore;

  AuthRepositoryImpl(ApiClient? client) {
    _apiClient = client;
    setUpCollectionReference();
  }

  @override
  Future<String?> getToken() async {
    final preferences = await Preferences.getInstance();
    return preferences.getValue(AppConfig.ACCESS_TOKEN_KEY);
  }

  @override
  Future<void> removeToken() async {
    final preferences = await Preferences.getInstance();
    return preferences.removeValue(AppConfig.ACCESS_TOKEN_KEY);
  }

  @override
  Future<void> saveToken(String? token) async {
    final preferences = await Preferences.getInstance();
    return preferences.setValue(AppConfig.ACCESS_TOKEN_KEY, token);
  }

  @override
  Future<User> signIn(String username, String password) async {
    try {
      var res = await _authInstance.signInWithEmailAndPassword(
          email: username, password: password);

      if (res.user == null) {
        throw ('User not found');
      } else {
        await saveToken(res.user?.uid ?? "");
      }

      return res.user!;
    } catch (e) {
      throw (e);
    }
  }

  @override
  Future<UserModel> signUp(
      String fullName, String email, String password) async {
    try {
      var res = await _authInstance.createUserWithEmailAndPassword(
          email: email, password: password);

      await createUser(
          user: UserModel(
              uid: res.user?.uid ?? "", name: res.user?.displayName ?? ""));

      return UserModel(
          uid: res.user?.uid ?? "", name: res.user?.displayName ?? "");
    } catch (e) {
      throw (e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _authInstance.signOut();
      await removeToken();
    } catch (e) {
      throw (e);
    }
  }

  void setUpCollectionReference() {
    _userCollection = firestoreInstance
        .collection(CollectionTag.users)
        .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson());
  }

  Future<void> createUser({required UserModel user}) async {
    try {
      await _userCollection!.doc(user.uid).set(user);
    } catch (e) {
      throw (e);
    }
  }
}
