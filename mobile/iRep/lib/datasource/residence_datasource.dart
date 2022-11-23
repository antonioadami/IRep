import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/models/error_model.dart';
import 'package:irep/models/residence_model.dart';
import 'package:irep/models/succes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResidenceDatasource {
  Future<Either<ErrorModel, List<ResidenceModel>>> getResidences() async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    Uri url = Uri.parse("http://$baseUrl/imovel");

    String token = shared.getString('token') ?? '';
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return Right(List<ResidenceModel>.from(jsonDecode(response.body)
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

    Uri url = Uri.parse("http://$baseUrl/imovel/$uuid");

    String token = shared.getString('token') ?? '';
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return Right(
        ResidenceModel.fromJson(
          jsonDecode(response.body),
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

  Future<Either<ErrorModel, SuccessModel>> createUser({
    required String cpf,
    required String cidade,
    required String cep,
    required String bairro,
    required String rua,
    required String numero,
    required String quartos,
    required String estacionamentos,
    required String banheiros,
    required bool gas,
    required bool internet,
  }) async {
    Uri url = Uri.parse("http://$baseUrl/pessoa");

    var body = {};
    try {
      var response = await http.post(url, body: body);

      return Right(
        SuccessModel(
            response: response,
            message: 'Imóvel cadastrado com sucesso!',
            statusCode: response.statusCode),
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
