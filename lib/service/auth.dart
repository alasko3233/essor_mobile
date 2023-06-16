import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/user.dart';
import 'dio.dart';

class Auth extends ChangeNotifier {
  bool _connect = false;
  User? _user;
  String? _token;
  bool get authenticed => _connect;
  User? get user => _user;
  final storage = const FlutterSecureStorage();
  Future<void> _readAll() async {
    final all = await storage.readAll(
      aOptions: _getAndroidOptions(),
    );
  }

  Future<void> _read() async {
    final all = await storage.read(
      key: 'token',
      aOptions: _getAndroidOptions(),
    );
  }

  Future login(Map creds) async {
    try {
      final response =
          await dio.post('https://lessor.ml/api/auth/loginUser', data: creds);
      print(response.data['token'].toString());
      String tokenn = response.data['token'].toString();
      print('token : $tokenn');
      tryToken(tokenn);
      return true;
    } on DioError catch (e) {
      if (e.response != null && e.response?.statusCode == 401) {
        print('Identifiants incorrects');
        return false;
      } else {
        print('Erreur de connexion');
        print(e);
        return false;
      }
    } catch (e) {
      // Si la requête n'a pas abouti, lancer une exception
      print(e);
      return false;
      throw Exception('Failed to load journal data');
    }
  }

  tryToken(token) async {
    if (token == null) {
      print('token null : $token');
      return;
    } else {
      print('token vrai : $token');

      try {
        final response = await dio.get('https://lessor.ml/api/user',
            options: Options(headers: {'Authorization': 'Bearer $token'}));
        _connect = true;
        _user = User.fromJson(response.data);
        _token = token;
        storeToken(token);
        notifyListeners();
        print('coneccter');
        print('mon user $_user');
      } catch (e) {
        print(e);
      }
    }
  }

  void _addNewItem() {
    final String key = 'key';
    final String value = '1234';

    storage.write(
      key: key,
      value: value,
      aOptions: _getAndroidOptions(),
    );
    _readAll();
  }

  void storeToken(String token) {
    storage.write(
      key: 'token',
      value: token,
      aOptions: _getAndroidOptions(),
    );
    _readAll();
    print('token cree');
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
        // sharedPreferencesName: 'Test2',
        // preferencesKeyPrefix: 'Test'
      );
  Future logout() async {
    try {
      final response = await dio.post('https://lessor.ml/api/auth/Logoutuser',
          options: Options(headers: {'Authorization': 'Bearer $_token'}));
      cleanUp();
      return true;
    } on DioError catch (e) {
      if (e.response != null && e.response?.statusCode == 401) {
        print('Identifiants incorrects');
        return false;
      } else {
        print('Erreur de connexion');
        print(e);
        return false;
      }
    } catch (e) {
      print(e);
    }
    _connect = false;
    notifyListeners();
  }

  void cleanUp() async {
    _user = null;
    _connect = false;
    _token = null;
    await storage.delete(
      key: 'token',
      aOptions: _getAndroidOptions(),
    );
    print('token Supprimer');
  }
}
