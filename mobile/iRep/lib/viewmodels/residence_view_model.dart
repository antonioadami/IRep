import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:irep/models/error_model.dart';
import 'package:irep/models/residence_model.dart';
import 'package:irep/models/succes_model.dart';
import 'package:irep/service/residence_service.dart';

class ResidenceViewModel extends ChangeNotifier {
  bool loadResidenceList = false;
  List<ResidenceModel> residences = [];
  ResidenceService service;

  ResidenceViewModel(this.service);

  Future<void> getResidences() async {
    loadResidenceList = true;
    var result = await service.getResidences();

    result.fold(
      (left) {
        residences = [];
      },
      (right) {
        residences = right;
      },
    );
    loadResidenceList = false;
    notifyListeners();
  }

  Future<Either<ErrorModel, ResidenceModel>> getResidenceInformation(
    String uuid,
  ) async {
    var result = await service.getResidenceInformation(uuid);
    return result;
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
    var result = await service.createResidence(
      nome: nome,
      estado: estado,
      cidade: cidade,
      cep: cep,
      bairro: bairro,
      rua: rua,
      numero: numero,
      quartos: quartos,
      estacionamentos: estacionamentos,
      banheiros: banheiros,
      gas: gas,
      internet: internet,
    );

    return result;
  }
}
