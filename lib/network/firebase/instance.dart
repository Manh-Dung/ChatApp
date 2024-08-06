import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

class Instances {
  Instances();

  static final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;
}
