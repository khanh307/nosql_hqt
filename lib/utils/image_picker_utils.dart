import 'dart:io';
import 'package:image_picker/image_picker.dart';


class ImagePickerUtils {
  static final ImagePicker picker = ImagePicker();

  static Future<File?> pickImageFromCamera({int quality = 100}) async {
    // final status = await Permission.camera.request();
    // if (!status.isGranted) {
    //   await Permission.camera.request();
    //   return null;
    // }
    final XFile? imagePick = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: quality,
    );
    File? image;
    if (imagePick != null) {
      image = File(imagePick.path);
    }
    return image;
  }

  static Future<File?> pickImageFromGallery({int quality = 100}) async {
    // final status = await Permission.photos.request();
    // if (!status.isGranted) {
    //   await Permission.photos.request();
    //   return null;
    // }
    final XFile? imagePick = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: quality);
    File? image;
    if (imagePick != null) {
      image = File(imagePick.path);
    }
    return image;
  }
}

