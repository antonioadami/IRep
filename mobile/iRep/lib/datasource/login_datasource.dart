import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:irep/models/error_model.dart';
import 'package:irep/models/succes_model.dart';

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
}
