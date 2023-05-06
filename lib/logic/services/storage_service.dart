import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class StorageService {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  late final picker = ImagePicker();
  XFile? file;

  Future<void> uploadImage(
      String userId, XFile imageFile, String fileName) async {
    try {
      final storageRef =
          storage.ref().child('user_images').child(userId).child(fileName);
      await storageRef.putFile(File(imageFile.path));
      debugPrint('Succeeded uploaded image');
    } catch (e) {
      debugPrint('Failed to upload image: $e');
    }
  }

  Future<XFile?> getImage(
      {required ImageSource source, required String userId}) async {
    final pickedFile = await picker.pickImage(source: source);
    try {
      if (pickedFile != null) {
        final fileName = path.basename(pickedFile.path);
        await uploadImage(userId, XFile(pickedFile.path), fileName);
        return XFile(pickedFile.path);
      } else {
        debugPrint('No image selected.');
        return null;
      }
    } catch (e) {
      debugPrint('Failed to get image: $e');
    }
    return null;
  }
}
