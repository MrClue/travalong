import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerController {
  final picker = ImagePicker();
  late File _image;

  Future<File?> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      return _image;
    } else {
      print('No image selected.');
      return null;
    }
  }
}
