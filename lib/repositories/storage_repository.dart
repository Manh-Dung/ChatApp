import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import "package:path/path.dart" as Path;

import '../network/firebase/instance.dart';

abstract class StorageRepository {
  Future<File?> pickImage();

  Future<String?> uploadImage({required File file, required String uid});

  Future<String?> uploadImageToChat(
      {required File file, required String chatId});
}

class StorageRepositoryImpl extends StorageRepository {
  @override
  Future<String?> uploadImage({required File file, required String uid}) async {
    try {
      Reference ref = Instances.storage
          .ref("users/pfps")
          .child("$uid${Path.basename(file.path)}");

      UploadTask uploadTask = ref.putFile(file);
      return uploadTask.then((value) {
        if (value.state == TaskState.success) {
          return value.ref.getDownloadURL();
        } else {
          throw ('Upload failed');
        }
      });
    } catch (e) {
      throw (e);
    }
  }

  @override
  Future<File?> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  }

  @override
  Future<String?> uploadImageToChat(
      {required File file, required String chatId}) async {
    try {
      Reference ref = Instances.storage.ref("chats/$chatId").child(
          "${DateTime.now().toIso8601String()}${Path.basename(file.path)}");

      UploadTask uploadTask = ref.putFile(file);
      return uploadTask.then((value) {
        if (value.state == TaskState.success) {
          return value.ref.getDownloadURL();
        } else {
          throw ('Upload failed');
        }
      });
    } catch (e) {
      throw (e);
    }
  }
}
