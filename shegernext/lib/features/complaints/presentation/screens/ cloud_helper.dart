import 'dart:io';
import 'package:dio/dio.dart';

class CloudinaryHelper {
  static Future<String?> uploadImage(File imageFile) async {
    final dio = Dio();
    const cloudName = 'dvnfo8tdq';
    const uploadPreset = 'shegernext';

    final url = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imageFile.path),
      'upload_preset': uploadPreset,
    });

    try {
      final response = await dio.post(url, data: formData);
      return response.data['secure_url'] as String?;
    } catch (e) {
      return null;
    }
  }
}