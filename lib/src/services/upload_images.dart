import 'package:dio/dio.dart';

class UploadImage {
  static var dio = Dio();

  static Future<int?> uploadFile(file) async {
    var response = await dio.post(
      "https://aqui.city/api/public/miordenqr/api/users/upload",
      data: {
        'image': file,
      },
    );

    return response.statusCode;
  }
}
