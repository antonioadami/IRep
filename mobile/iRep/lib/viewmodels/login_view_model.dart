import 'package:flutter/cupertino.dart';
import 'package:irep/helpers/mocks/user_mock.dart';
import 'package:irep/models/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  UserModel? user;

  registerUser(
    String cpf,
    String email,
    String nome,
    String dataNascimento,
    String senha,
    String telefone,
  ) {}

  void getInformation() {
    user = UserModel.fromJson(userMock);
  }

  void logOut() {
    user = null;
  }
}
