import 'package:crown_cuts/core/constance/api_constance.dart';
import 'package:crown_cuts/core/network/dio_exception.dart';
import 'dart:io';

import 'package:crown_cuts/role/barbershop/barbers/logic/barber_create_models.dart';
import 'package:crown_cuts/role/barbershop/barbers/logic/barbers_models.dart';
import 'package:dio/dio.dart';

class BarbersService extends NetworkModule {
  Future<BarbersPage> fetchMyBarbers({
    required String accessToken,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await dio.get(
        ApiEndpoints.barberAllMyBarbers,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      final data = response.data as Map<String, dynamic>;
      final payload = data['data'] as Map<String, dynamic>? ?? {};
      return BarbersPage.fromJson(payload);
    } on DioException catch (error) {
      throw DioExceptions.fromDioError(error);
    }
  }

  Future<BarberCreateResult> createBarber({
    required String accessToken,
    required BarberCreateRequest request,
    File? image,
  }) async {
    try {
      final formData = FormData.fromMap({
        'full_name': request.fullName,
        'phone_number': request.phoneNumber,
        'password': request.password,
        'username': request.username,
        'bio': request.bio,
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

      final response = await dio.post(
        ApiEndpoints.barberCreate,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      final data = response.data as Map<String, dynamic>;
      final payload = data['data'] as Map<String, dynamic>? ?? {};
      return BarberCreateResult.fromJson(payload);
    } on DioException catch (error) {
      throw DioExceptions.fromDioError(error);
    }
  }
}
