import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:irep/models/error_model.dart';
import 'package:irep/models/succes_model.dart';
import 'package:irep/models/user_model.dart';
import 'package:irep/service/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  LoginService service = LoginService();
  UserModel? user;

  Future<Either<ErrorModel, SuccessModel>> registerUser({
    required String cpf,
    required String email,
    required String nome,
    required String senha,
    required String telefone,
    required String dataNascimento,
  }) async {
    return await service.registerUser(
      cpf: cpf,
      email: email,
      nome: nome,
      senha: senha,
      dataNascimento: dataNascimento,
      telefone: telefone,
    );
  }

  Future<Either<ErrorModel, SuccessModel>> handleLogin({
    required String email,
    required String senha,
  }) async {
    return await service.handleLogin(email: email, senha: senha);
  }

  Future<void> getUserInformation() async {
    var response = await service.getUserInformation();

    response.fold((left) {}, (right) {
      user = UserModel.fromJson(jsonDecode(right.response));
    });
  }

  void logOut() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.remove('token');
    user = null;
    notifyListeners();
  }
}
