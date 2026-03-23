import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isLoggedIn = false;
  String? _userEmail;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;

  Future<bool> login({
    required String email,
    required String senha,
  }) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;

    if (email == 'teste@teste.com' && senha == '123456') {
      _isLoggedIn = true;
      _userEmail = email;
      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }

  Future<bool> cadastrar({
    required String nome,
    required String email,
    required String telefone,
    required String senha,
  }) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;
    _isLoggedIn = true;
    _userEmail = email;
    notifyListeners();

    return true;
  }

  Future<bool> recuperarSenha(String email) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();
    return true;
  }

  void logout() {
    _isLoggedIn = false;
    _userEmail = null;
    notifyListeners();
  }
}