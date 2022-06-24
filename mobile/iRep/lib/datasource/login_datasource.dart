import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:irep/models/error_model.dart';
import 'package:irep/models/succes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDatasource {
  Future<Either<ErrorModel, SuccessModel>> registerUser({
    required String cpf,
    required String email,
    required String nome,
    required String senha,
    required String telefone,
    required String dataNascimento,
  }) async {
    Uri url = Uri.parse("https://irep.vercel.app/pessoa");
    var data = dataNascimento.split('/');
    var body = {
      "cpf": cpf,
      "email": email,
      "nome": nome,
      "dataNascimento": '${data[0]}-${data[1]}-${data[2]}',
      "senha": senha,
      "telefone": telefone,
    };

    var response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      return Right(
        SuccessModel(
          response: response.body,
          message: 'Usuário cadastrado com sucesso',
        ),
      );
    }
    return Left(
      ErrorModel(
        statusCode: response.statusCode,
        message: 'Erro ao cadastrar novo usuário',
      ),
    );
  }

  Future<Either<ErrorModel, SuccessModel>> handleLogin({
    required String email,
    required String senha,
  }) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    Uri url = Uri.parse("https://irep.vercel.app/auth/login");
    var params = {
      "usuario": email,
      "senha": senha,
    };

    var response = await http.post(url, body: params);
    if (response.statusCode == 200) {
      shared.setString('token', jsonDecode(response.body)['token']);
      return Right(
        SuccessModel(
          response: response.body,
        ),
      );
    }
    shared.remove('token');
    return Left(
      ErrorModel(
        statusCode: response.statusCode,
        message: 'Erro ao fazer login.\nEmail ou senha incorretos.',
      ),
    );
  }

  Future<Either<ErrorModel, SuccessModel>> getUserInformation() async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    Uri url = Uri.parse("https://irep.vercel.app/pessoa");

    String token = shared.getString('token') ?? '';
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return Right(
        SuccessModel(
          response: response.body,
        ),
      );
    }
    return Left(
      ErrorModel(
        statusCode: response.statusCode,
        message: 'Erro ao fazer login.\nEmail ou senha incorretos.',
      ),
    );
  }
}
