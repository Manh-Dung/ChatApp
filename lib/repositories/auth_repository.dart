import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:vinhcine/configs/app_config.dart';
import 'package:vinhcine/database/preferences.dart';
import 'package:vinhcine/network/constants/collection_tag.dart';
import 'package:vinhcine/repositories/storage_repository.dart';

import '../models/entities/user_model.dart';
import '../network/firebase/instance.dart';

abstract class AuthRepository {
  late final CollectionReference? _userCollection;
  final StorageRepository storageRepository = StorageRepositoryImpl();

  Future<String?> getToken();

  Future<void> saveToken(String? token);

  Future<void> savePassword(String? email, String? password);

  Future<void> removePassword();

  Future<void> removeToken();

  Future<User> signIn(String username, String password);

  Future<UserModel> signUp(
      File? file, String fullName, String email, String password);

  Future<void> signOut();
}

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl() {
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
      var res = await Instances.auth
          .signInWithEmailAndPassword(email: username, password: password);

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
      File? file, String fullName, String email, String password) async {
    try {
      var filePath;
      var res = await Instances.auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (res.user != null) {
        if (file != null) {
          filePath = await storageRepository.uploadImage(
              file: file, uid: res.user?.uid ?? "");
        }

        await createUser(
            user: UserModel(
                imageUrl: filePath ?? "",
                uid: res.user?.uid ?? "",
                name: fullName,
                email: email));
      }

      return UserModel(
          uid: res.user?.uid ?? "",
          name: res.user?.displayName ?? "",
          imageUrl: filePath ?? "",
          email: email);
    } catch (e) {
      throw (e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Instances.auth.signOut();
      await removeToken();
    } catch (e) {
      throw (e);
    }
  }

  void setUpCollectionReference() {
    _userCollection = Instances.fireStore
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

  @override
  Future<void> savePassword(String? email, String? password) async {
    final preferences = await Preferences.getInstance();
    preferences.setValue(AppConfig.EMAIL_KEY, email);
    preferences.setValue(AppConfig.PASSWORD, password);
  }

  @override
  Future<void> removePassword() async {
    final preferences = await Preferences.getInstance();
    preferences.removeValue(AppConfig.EMAIL_KEY);
    preferences.removeValue(AppConfig.PASSWORD);
  }
}
