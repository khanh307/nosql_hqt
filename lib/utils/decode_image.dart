import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';


class DecodeImage {
  static Uint8List? decodeImageFromBase64(String input) {
    try {
      input = input.replaceAll('\n', '').replaceAll('\r', '');
      Uint8List bytes = base64Decode(input);
      return bytes;
    } catch (e) {
      return null;
    }
  }

  static String? encodeImage(File? file) {
    if (file == null) return null;
    List<int> imageBytes = file.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  // static String? resizeAndEncodeImage(File? file, int width, int height) {
  //   if (file == null) return null;
  //   img.Image? src = img.decodeImage(file.readAsBytesSync());
  //   if (src == null) return null;
  //   img.Image resizedImage = img.copyResize(src,
  //       width: width, height: height, interpolation: img.Interpolation.average);
  //   Uint8List resizedImageBytes = img.encodeJpg(resizedImage);
  //   String base64Image = base64Encode(resizedImageBytes);
  //   return base64Image;
  // }

}
