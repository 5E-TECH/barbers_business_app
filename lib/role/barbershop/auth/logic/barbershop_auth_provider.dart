import 'dart:io';

import 'package:crown_cuts/core/network/dio_exception.dart';
import 'package:crown_cuts/core/storage/token_storage.dart';
import 'package:crown_cuts/role/barbershop/auth/logic/barbershop_auth_models.dart';
import 'package:crown_cuts/role/barbershop/auth/logic/barbershop_auth_service.dart';
import 'package:flutter/foundation.dart';

class BarberShopAuthProvider extends ChangeNotifier {
  final BarberShopAuthService _service;

  BarberShopAuthProvider({BarberShopAuthService? service})
      : _service = service ?? BarberShopAuthService();

  bool _isLoading = false;
  bool _isAuthenticated = false;
  String? _errorMessage;
  AuthTokens? _tokens;
  BarberShopAccount? _account;

  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String? get errorMessage => _errorMessage;
  AuthTokens? get tokens => _tokens;
  BarberShopAccount? get account => _account;

  /// Check if user is already logged in (called on app start)
  Future<bool> tryAutoLogin() async {
    _setLoading(true);

    try {
      final hasTokens = await TokenStorage.hasTokens();
      if (!hasTokens) {
        _setLoading(false);
        return false;
      }

      final accessToken = await TokenStorage.getAccessToken();
      final refreshToken = await TokenStorage.getRefreshToken();

      if (accessToken == null || accessToken.isEmpty) {
        _setLoading(false);
        return false;
      }

      _tokens = AuthTokens(
        accessToken: accessToken,
        refreshToken: refreshToken ?? '',
      );

      // Fetch account data to verify token is still valid
      _account = await _service.fetchMyAccount(accessToken: accessToken);
      _isAuthenticated = true;
      _setLoading(false);
      return true;
    } catch (_) {
      // Token is invalid, clear it
      await TokenStorage.clearTokens();
      _tokens = null;
      _account = null;
      _isAuthenticated = false;
      _setLoading(false);
      return false;
    }
  }

  Future<bool> signInOwner({
    required String username,
    required String password,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      _tokens = await _service.signInOwner(
        username: username,
        password: password,
      );

      if (_tokens != null && _tokens!.accessToken.isNotEmpty) {
        // Save tokens to persistent storage
        await TokenStorage.saveTokens(
          accessToken: _tokens!.accessToken,
          refreshToken: _tokens!.refreshToken,
        );

        _account = await _service.fetchMyAccount(accessToken: _tokens!.accessToken);
        _isAuthenticated = true;
      }

      _setLoading(false);
      return true;
    } on DioExceptions catch (error) {
      _errorMessage = error.message;
      _setLoading(false);
      return false;
    } catch (_) {
      _errorMessage = 'Something went wrong. Please try again.';
      _setLoading(false);
      return false;
    }
  }

  Future<bool> signUpOwner({
    required BarberShopOwnerSignupRequest request,
    File? image,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      await _service.signUpOwner(request: request, image: image);
      _setLoading(false);
      return true;
    } on DioExceptions catch (error) {
      _errorMessage = error.message;
      _setLoading(false);
      return false;
    } catch (_) {
      _errorMessage = 'Something went wrong. Please try again.';
      _setLoading(false);
      return false;
    }
  }

  Future<void> logout() async {
    await TokenStorage.clearTokens();
    _tokens = null;
    _account = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}