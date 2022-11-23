import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/models/create_user_response.dart';
import 'package:irep/models/error_model.dart';
import 'package:irep/models/succes_model.dart';
import 'package:irep/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDatasource {
  Future<Either<ErrorModel, CreatePersonResponse>> createUser({
    required String cpf,
    required String email,
    required String nome,
    required String senha,
    required String telefone,
    required String dataNascimento,
  }) async {
    Uri url = Uri.parse("http://$baseUrl/pessoa");
    var data = dataNascimento.split('/');
    telefone = telefone
        .replaceAll(" ", "")
        .replaceAll("-", "")
        .replaceAll("(", "")
        .replaceAll(")", "");
    var body = {
      "cpf": cpf,
      "email": email,
      "nome": nome,
      "dataNascimento": '${data[0]}-${data[1]}-${data[2]}',
      "senha": senha,
      "telefone": telefone,
    };
    try {
      var response = await http.post(url, body: body);
      if (response.statusCode == 400) {
        return Left(
          ErrorModel(
            statusCode: response.statusCode,
            message: jsonDecode(response.body)["message"],
          ),
        );
      }
      return Right(
        CreatePersonResponse.fromJson(
          jsonDecode(response.body),
        ),
      );
    } catch (e) {
      return const Left(
        ErrorModel(
          statusCode: 500,
          message: 'Erro ao cadastrar novo usuário',
        ),
      );
    }
  }

  Future<Either<ErrorModel, SuccessModel>> verifyUser({
    required String code,
    required String email,
  }) async {
    Uri url = Uri.parse("http://$baseUrl/auth/verify");
    var params = {
      "email": email,
      "code": code,
    };
    try {
      var response = await http.post(url, body: params);
      if (response.statusCode == 200) {
        return Right(SuccessModel(message: "Usuário verificado!"));
      }
      return const Left(
        ErrorModel(message: "Erro ao verificar a conta"),
      );
    } catch (e) {
      return const Left(
        ErrorModel(message: "Erro ao verificar a conta"),
      );
    }
  }

  Future<Either<ErrorModel, CreatePersonResponse>> resendCode({
    required String email,
  }) async {
    Uri url = Uri.parse("http://$baseUrl/auth/resendCode");
    var params = {
      "email": email,
    };
    try {
      var response = await http.post(url, body: params);
      if (response.statusCode == 200) {
        return Right(CreatePersonResponse.fromJson(
          jsonDecode(response.body),
        ));
      }
      return const Left(
        ErrorModel(message: "Erro ao reenviar código"),
      );
    } catch (e) {
      return const Left(
         ErrorModel(message: "Erro ao reenviar código"),
      );
    }
  }

  Future<Either<ErrorModel, String>> handleLogin({
    required String email,
    required String senha,
  }) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    Uri url = Uri.parse("http://$baseUrl/auth/login");
    var params = {
      "usuario": email,
      "senha": senha,
    };
    try {
      var response = await http.post(url, body: params);
      if (response.statusCode == 200) {
        shared.setString('token', jsonDecode(response.body)['token']);
        return const Right('');
      }
      shared.remove('token');
      if (response.statusCode == 400) {
        return Left(
          ErrorModel(
            statusCode: response.statusCode,
            message: 'Erro ao fazer login.\nEmail ou senha incorretos.',
          ),
        );
      }
      return Left(
        ErrorModel(
          statusCode: response.statusCode,
          message: 'Erro ao fazer login.',
        ),
      );
    } catch (e) {
      return const Left(
         ErrorModel(
          statusCode: 500,
          message: 'Erro inesperado ao fazer login.',
        ),
      );
    }
  }

  Future<Either<ErrorModel, UserModel>> getUserInformation() async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    Uri url = Uri.parse("http://$baseUrl/pessoa");

    String token = shared.getString('token') ?? '';
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return Right(
        UserModel.fromJson(
          jsonDecode(response.body),
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
