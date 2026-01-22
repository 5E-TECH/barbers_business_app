import 'package:crown_cuts/core/network/dio_exception.dart';
import 'package:crown_cuts/core/storage/token_storage.dart';
import 'dart:io';

import 'package:crown_cuts/role/barbershop/barbers/logic/barber_create_models.dart';
import 'package:crown_cuts/role/barbershop/barbers/logic/barbers_models.dart';
import 'package:crown_cuts/role/barbershop/barbers/logic/barbers_service.dart';
import 'package:flutter/foundation.dart';

class BarbersProvider extends ChangeNotifier {
  final BarbersService _service;

  BarbersProvider({BarbersService? service})
      : _service = service ?? BarbersService();

  bool _isLoading = false;
  String? _errorMessage;
  BarbersPage? _page;
  BarberCreateResult? _lastCreated;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<BarberProfile> get barbers => _page?.data ?? [];
  int get total => _page?.total ?? 0;
  BarberCreateResult? get lastCreated => _lastCreated;

  Future<void> fetchMyBarbers({int page = 1, int limit = 10}) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final accessToken = await TokenStorage.getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        _errorMessage = 'Missing access token. Please sign in again.';
        _setLoading(false);
        return;
      }

      _page = await _service.fetchMyBarbers(
        accessToken: accessToken,
        page: page,
        limit: limit,
      );
      _setLoading(false);
    } on DioExceptions catch (error) {
      _errorMessage = error.message;
      _setLoading(false);
    } catch (_) {
      _errorMessage = 'Failed to load barbers. Please try again.';
      _setLoading(false);
    }
  }

  Future<bool> createBarber({
    required BarberCreateRequest request,
    File? image,
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

      _lastCreated = await _service.createBarber(
        accessToken: accessToken,
        request: request,
        image: image,
      );
      _setLoading(false);
      return true;
    } on DioExceptions catch (error) {
      _errorMessage = error.message;
      _setLoading(false);
      return false;
    } catch (_) {
      _errorMessage = 'Failed to create barber. Please try again.';
      _setLoading(false);
      return false;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
