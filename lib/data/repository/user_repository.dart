import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:suitmedia_mobdev/data/model/user_model.dart';

class UserRepository {
  late final Dio _dio;

  // Constructor
  UserRepository() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://reqres.in",
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
    // Log Interceptor
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Future<List<UserModel>> getAllPengajuan(
      String currentPage,
      String perPage,
      int id,
      String email,
      String firstName,
      String lastName,
      String avatar,
      ) async {
    try {
      final response = await _dio.get(
          "/api/users?page=$currentPage&per_page=$perPage");
      List<UserModel> data = [];
      for (var val in response.data['data']) {
        data.add(UserModel.fromJson(val));
      }
      return data;
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.message.toString());
      rethrow;
    }
  }
}
