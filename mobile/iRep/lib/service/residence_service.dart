import 'package:either_dart/either.dart';
import 'package:irep/datasource/residence_datasource.dart';
import 'package:irep/models/error_model.dart';
import 'package:irep/models/residence_model.dart';
import 'package:irep/models/succes_model.dart';

class ResidenceService {
  ResidenceDatasource datasource = ResidenceDatasource();

  Future<Either<ErrorModel, List<ResidenceModel>>> getResidences() async {
    return await datasource.getResidences();
  }

  Future<Either<ErrorModel, ResidenceModel>> getResidenceInformation(
    String uuid,
  ) async {
    return await datasource.getResidenceInformation(uuid);
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
  }) {
    return datasource.createResidence(
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
  }
}
