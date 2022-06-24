import 'package:either_dart/either.dart';
import 'package:irep/datasource/residence_datasource.dart';
import 'package:irep/models/error_model.dart';
import 'package:irep/models/succes_model.dart';

class ResidenceService {
  ResidenceDatasource datasource = ResidenceDatasource();

  Future<Either<ErrorModel, SuccessModel>> getResidences() async {
    return await datasource.getResidences();
  }

  Future<Either<ErrorModel, SuccessModel>> getResidenceInformation(
    String uuid,
  ) async {
    return await datasource.getResidenceInformation(uuid);
  }
}
