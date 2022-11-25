import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
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
    String url = "http://$baseUrl/pessoa";
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
      var response = await Dio().post(url, data: body);
      if (response.statusCode == 400) {
        return Left(
          ErrorModel(
            statusCode: response.statusCode,
            message: response.data["message"],
          ),
        );
      }
      return Right(
        CreatePersonResponse.fromJson(
          response.data,
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
    String url = "http://$baseUrl/auth/verify";
    var params = {
      "email": email,
      "code": code,
    };
    try {
      var response = await Dio().post(url, data: params);
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
    String url = "http://$baseUrl/auth/resendCode";
    var params = {
      "email": email,
    };
    try {
      var response = await Dio().post(url, data: params);
      if (response.statusCode == 200) {
        return Right(
          CreatePersonResponse.fromJson(
            response.data,
          ),
        );
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

    String url = "http://$baseUrl/auth/login";
    var params = {
      "usuario": email,
      "senha": senha,
    };
    try {
      var response = await Dio().post(url, data: params);
      if (response.statusCode == 200) {
        shared.setString('token', response.data['token']);
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

    String url = "http://$baseUrl/pessoa";

    String token = shared.getString('token') ?? '';
    var response = await Dio().get(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      return Right(
        UserModel.fromJson(
          response.data,
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
