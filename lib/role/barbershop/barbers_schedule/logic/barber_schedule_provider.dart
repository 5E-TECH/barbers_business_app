import 'package:crown_cuts/core/network/dio_exception.dart';
import 'package:crown_cuts/core/storage/token_storage.dart';
import 'package:crown_cuts/role/barbershop/barbers_schedule/logic/barber_schedule_models.dart';
import 'package:crown_cuts/role/barbershop/barbers_schedule/logic/barber_schedule_service.dart';
import 'package:flutter/foundation.dart';

class BarberScheduleProvider extends ChangeNotifier {
  final BarberScheduleService _service;

  BarberScheduleProvider({BarberScheduleService? service})
      : _service = service ?? BarberScheduleService();

  bool _isLoading = false;
  String? _errorMessage;
  BarberScheduleCreateResult? _lastCreated;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  BarberScheduleCreateResult? get lastCreated => _lastCreated;

  Future<bool> createSchedule({
    required BarberScheduleCreateRequest request,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final accessToken = await TokenStorage.getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        _errorMessage = 'Missing access token. Please sign in again.';
        _setLoading(false);
        return false;
      }

      _lastCreated = await _service.createSchedule(
        accessToken: accessToken,
        request: request,
      );
      _setLoading(false);
      return true;
    } on DioExceptions catch (error) {
      _errorMessage = error.message;
      _setLoading(false);
      return false;
    } catch (_) {
      _errorMessage = 'Failed to create schedule. Please try again.';
      _setLoading(false);
      return false;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
