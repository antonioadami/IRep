import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:irep/models/create_user_response.dart';
import 'package:irep/models/error_model.dart';
import 'package:irep/models/succes_model.dart';
import 'package:irep/models/user_model.dart';
import 'package:irep/service/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  LoginService service = LoginService();
  UserModel? user;

  Future<Either<dynamic, CreatePersonResponse>> createUser({
    required String cpf,
    required String email,
    required String nome,
    required String senha,
    required String telefone,
    required String dataNascimento,
  }) async {
    return await service.createUser(
      cpf: cpf,
      email: email,
      nome: nome,
      senha: senha,
      dataNascimento: dataNascimento,
      telefone: telefone,
    );
  }

  Future<Either<ErrorModel, SuccessModel>> verifyUser({
    required String email,
    required String code,
  }) async {
    return await service.verifyUser(email: email, code: code);
  }

  Future<Either<ErrorModel, CreatePersonResponse>> resendCode({
    required String email,
  }) async {
    return await service.resendCode(email: email);
  }

  Future<Either<dynamic, dynamic>> handleLogin({
    required String email,
    required String senha,
  }) async {
    return await service.handleLogin(email: email, senha: senha);
  }

  Future<void> getUserInformation() async {
    var response = await service.getUserInformation();

    response.fold((left) {}, (right) {
      user = right;
    });
  }

  void logOut() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.remove('token');
    user = null;
    notifyListeners();
  }
}
