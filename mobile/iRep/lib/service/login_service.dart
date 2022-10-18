import 'package:either_dart/either.dart';
import 'package:irep/datasource/login_datasource.dart';
import 'package:irep/models/create_user_response.dart';
import 'package:irep/models/error_model.dart';
import 'package:irep/models/succes_model.dart';
import 'package:irep/models/user_model.dart';

class LoginService {
  LoginDatasource datasource = LoginDatasource();
  Future<Either<dynamic, CreatePersonResponse>> createUser({
    required String cpf,
    required String email,
    required String nome,
    required String senha,
    required String telefone,
    required String dataNascimento,
  }) async {
    return await datasource.createUser(
      cpf: cpf,
      email: email,
      nome: nome,
      dataNascimento: dataNascimento,
      senha: senha,
      telefone: telefone,
    );
  }

  Future<Either<ErrorModel, SuccessModel>> verifyUser({
    required String email,
    required String code,
  }) async {
    return await datasource.verifyUser(email: email, code: code);
  }

  Future<Either<ErrorModel, CreatePersonResponse>> resendCode({
    required String email,
  }) async {
    return await datasource.resendCode(email: email);
  }

  Future<Either<dynamic, dynamic>> handleLogin({
    required String email,
    required String senha,
  }) async {
    return await datasource.handleLogin(email: email, senha: senha);
  }

  Future<Either<ErrorModel, UserModel>> getUserInformation() async {
    return await datasource.getUserInformation();
  }
}
