import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ContactImagePicker {
  ImagePicker _imagePicker = ImagePicker();

  Future<File?> pickImage(ImageSource imageSource) async {
    try {
      final image = await _imagePicker.pickImage(source: imageSource);
      if (image == null) return null;
      final imageFile = File(image.path);
      return imageFile;
    } catch (e) {
      rethrow;
    }
  }
}
