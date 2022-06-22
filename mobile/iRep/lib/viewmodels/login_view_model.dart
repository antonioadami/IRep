import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:irep/helpers/mocks/user_mock.dart';
import 'package:irep/models/error_model.dart';
import 'package:irep/models/succes_model.dart';
import 'package:irep/models/user_model.dart';
import 'package:irep/service/login_service.dart';

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

  void getInformation() {
    user = UserModel.fromJson(userMock);
  }

  void logOut() {
    user = null;
  }
}
