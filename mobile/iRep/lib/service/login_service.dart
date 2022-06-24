import 'package:either_dart/either.dart';
import 'package:irep/datasource/login_datasource.dart';
import 'package:irep/models/error_model.dart';
import 'package:irep/models/succes_model.dart';

class LoginService {
  LoginDatasource datasource = LoginDatasource();
  Future<Either<ErrorModel, SuccessModel>> registerUser({
    required String cpf,
    required String email,
    required String nome,
    required String senha,
    required String telefone,
    required String dataNascimento,
  }) async {
    return await datasource.registerUser(
      cpf: cpf,
      email: email,
      nome: nome,
      dataNascimento: dataNascimento,
      senha: senha,
      telefone: telefone,
    );
  }

  Future<Either<ErrorModel, SuccessModel>> handleLogin({
    required String email,
    required String senha,
  }) async {
    return await datasource.handleLogin(email: email, senha: senha);
  }

  Future<Either<ErrorModel, SuccessModel>> getUserInformation() async {
    return await datasource.getUserInformation();
  }
}
