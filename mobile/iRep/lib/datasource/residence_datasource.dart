import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/models/error_model.dart';
import 'package:irep/models/residence_model.dart';
import 'package:irep/models/succes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResidenceDatasource {
  Future<Either<ErrorModel, List<ResidenceModel>>> getResidences() async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    String url = "http://$baseUrl/imovel";

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
      return Right(List<ResidenceModel>.from(response.data
          .map((residence) => ResidenceModel.fromJson(residence))
          .toList()));
    }
    return Left(
      ErrorModel(
        statusCode: response.statusCode,
        message: 'Erro ao buscar os imóveis',
      ),
    );
  }

  Future<Either<ErrorModel, ResidenceModel>> getResidenceInformation(
      String uuid) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    String url = "http://$baseUrl/imovel/$uuid";

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
        ResidenceModel.fromJson(
          response.data,
        ),
      );
    }
    return Left(
      ErrorModel(
        statusCode: response.statusCode,
        message: 'Não foi possível buscar os dados da residência.',
      ),
    );
  }

  Future<Either<ErrorModel, SuccessModel>> createResidence({
    required String nome,
    required String estado,
    required String cidade,
    required String cep,
    required String bairro,
    required String rua,
    required int numero,
    required int quartos,
    required int estacionamentos,
    required int banheiros,
    required bool gas,
    required bool internet,
  }) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    String url = "http://$baseUrl/imovel";
    String token = shared.getString('token') ?? '';
    var _body = 
      {
        "nome": nome,
        "quartos": quartos,
        "banheiros": banheiros,
        "estacionamento": estacionamentos,
        "gas": gas,
        "internet": internet,
        "endereco": {
          "estado": estado,
          "cidade": cidade,
          "bairro": bairro,
          "rua": rua,
          "numero": numero,
          "cep": cep,
        }
      };
    try {
      var response = await Dio().post(
        url,
        data: _body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return Right(
          SuccessModel(
            response: response,
            message: 'Imóvel cadastrado com sucesso!',
            statusCode: response.statusCode,
          ),
        );
      }

      return Left(
        ErrorModel(
          statusCode: response.statusCode,
          message: 'Erro ao cadastrar o imóvel!',
        ),
      );
    } catch (e) {
      return const Left(
        ErrorModel(
          statusCode: 400,
          message: 'Erro ao cadastrar o imóvel!',
        ),
      );
    }
  }
}
