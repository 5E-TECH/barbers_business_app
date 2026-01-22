import 'package:crown_cuts/core/constance/api_constance.dart';
import 'package:crown_cuts/core/network/dio_exception.dart';
import 'package:crown_cuts/role/barbershop/barbers_schedule/logic/barber_schedule_models.dart';
import 'package:dio/dio.dart';

class BarberScheduleService extends NetworkModule {
  Future<BarberScheduleCreateResult> createSchedule({
    required String accessToken,
    required BarberScheduleCreateRequest request,
  }) async {
    try {
      final response = await dio.post(
        ApiEndpoints.barberScheduleCreate,
        data: {
          'start_day': request.startDay,
          'end_day': request.endDay,
          'start_time': request.startTime,
          'end_time': request.endTime,
          'break_time': request.breakTime,
          'barber_id': request.barberId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      final data = response.data as Map<String, dynamic>;
      final payload = data['data'] as Map<String, dynamic>? ?? {};
      return BarberScheduleCreateResult.fromJson(payload);
    } on DioException catch (error) {
      throw DioExceptions.fromDioError(error);
    }
  }
}
