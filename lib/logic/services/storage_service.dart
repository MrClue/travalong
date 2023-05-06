import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class StorageService {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  late final picker = ImagePicker();
  XFile? file;
  List<String> userImages = [];
  List<String> uploadedImagePaths = [];

  Future<void> uploadImage(
      String userId, XFile imageFile, String fileName) async {
    // Generate a UUID
    final uuid = Uuid();
    final String uniqueId = uuid.v4();
    // Use the UUID as the filename
    final fileName = '$uniqueId.jpg';
    try {
      // Upload the image with the unique filename
      await storage
          .ref()
          .child('user_images')
          .child('$userId/$fileName')
          .putFile(File(imageFile.path));
      debugPrint('Image uploaded: $fileName');
    } catch (e) {
      debugPrint('Failed to upload image: $e');
    }
  }

  Future<XFile?> getImage(
      {required ImageSource source, required String userId}) async {
    final pickedFile = await picker.pickImage(source: source);
    try {
      if (pickedFile != null) {
        final filePath = pickedFile.path;
        // Check if the image is already uploaded
        if (uploadedImagePaths.contains(filePath)) {
          debugPrint('Image already uploaded');
        } else {
          uploadedImagePaths.add(filePath);
        }
        return XFile(filePath);
      } else {
        debugPrint('No image selected.');
        return null;
      }
    } catch (e) {
      debugPrint('Failed');
    }
    return null;
  }

  Stream<List<String>> getUserImagesStream(String userId) {
    return storage
        .ref()
        .child('user_images')
        .child(userId)
        .listAll()
        .then((ListResult result) => result.items)
        .then((List<Reference> refs) =>
            Future.wait(refs.map((ref) => ref.getDownloadURL())))
        .asStream();
  }
}
