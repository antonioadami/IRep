import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:irep/helpers/constants_helpers.dart';
import 'package:irep/models/error_model.dart';
import 'package:irep/models/succes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResidenceDatasource {
  Future<Either<ErrorModel, SuccessModel>> getResidences() async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    Uri url = Uri.parse("$baseUrl/imovel");

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

  Future<Either<ErrorModel, SuccessModel>> getResidenceInformation(
      String uuid) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    Uri url = Uri.parse("$baseUrl/imovel/$uuid");

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
