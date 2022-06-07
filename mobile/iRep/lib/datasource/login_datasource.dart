import 'package:http/http.dart' as http;

class LoginDatasource {
  registerUser(
    String cpf,
    String email,
    String nome,
    String dataNascimento,
    String senha,
    String telefone,
  ) {
    Uri url = Uri.parse("https://irep.vercel.app/pessoa");

    var body = {
      "cpf": cpf,
      "email": email,
      "nome": nome,
      "dataNascimento": dataNascimento,
      "senha": senha,
      "telefone": telefone,
    };

    var response = http.post(url, body: body);
  }
}
