import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import '../data/models/user_model.dart';
import '../data/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final hashedPassword = _hashPassword(password);
      final user = await _authRepository.login(username, hashedPassword);

      if (user != null) {
        _currentUser = user;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Username atau password salah';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String username, String password, String namaLengkap) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final hashedPassword = _hashPassword(password);
      final user = await _authRepository.register(username, hashedPassword, namaLengkap);

      if (user != null) {
        _currentUser = user;
        _isLoading = false;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  Future<bool> updateProfile(String namaLengkap) async {
    if (_currentUser == null) return false;
    _isLoading = true;
    notifyListeners();

    try {
      final updatedUser = await _authRepository.updateProfile(_currentUser!.id!, namaLengkap);
      if (updatedUser != null) {
        _currentUser = updatedUser;
        _isLoading = false;
        notifyListeners();
        return true;
      }
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
