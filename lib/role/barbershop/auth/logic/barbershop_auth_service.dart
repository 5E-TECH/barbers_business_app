import 'dart:io';

import 'package:crown_cuts/core/constance/api_constance.dart';
import 'package:crown_cuts/core/network/dio_exception.dart';
import 'package:crown_cuts/role/barbershop/auth/logic/barbershop_auth_models.dart';
import 'package:dio/dio.dart';

class BarberShopAuthService extends NetworkModule {
  Future<AuthTokens> signInOwner({
    required String username,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiEndpoints.barberShopSignIn,
        data: {
          'username': username,
          'password': password,
        },
      );

      final data = response.data as Map<String, dynamic>;
      return AuthTokens(
        accessToken: data['accessToken']?.toString() ?? '',
        refreshToken: data['refreshToken']?.toString() ?? '',
      );
    } on DioException catch (error) {
      throw DioExceptions.fromDioError(error);
    }
  }

  Future<void> signUpOwner({
    required BarberShopOwnerSignupRequest request,
    File? image,
  }) async {
    try {
      final formData = FormData.fromMap({
        'name': request.name,
        'location': request.location,
        'latitude': request.latitude,
        'longitude': request.longitude,
        'password': request.password,
        'username': request.username,
        'description': request.description,
        'phoneNumber': request.phoneNumber,
      });

      if (image != null) {
        formData.files.add(
          MapEntry(
            'img',
            await MultipartFile.fromFile(image.path),
          ),
        );
      } else {
        formData.fields.add(const MapEntry('img', ''));
      }
      print("Form date");
      print(formData);

      await dio.post(
        ApiEndpoints.barberShopSignUp,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
    } on DioException catch (error) {
      throw DioExceptions.fromDioError(error);
    }
  }

  Future<BarberShopAccount> fetchMyAccount({
    required String accessToken,
  }) async {
    try {
      final response = await dio.get(
        ApiEndpoints.barberShopMyAccount,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      final data = response.data as Map<String, dynamic>;
      final accountData = data['data'] as Map<String, dynamic>? ?? {};
      return BarberShopAccount.fromJson(accountData);
    } on DioException catch (error) {
      throw DioExceptions.fromDioError(error);
    }
  }
}
