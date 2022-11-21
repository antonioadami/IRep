import 'package:either_dart/either.dart';
import 'package:irep/datasource/residence_datasource.dart';

class ResidenceService {
  ResidenceDatasource datasource = ResidenceDatasource();

  Future<Either<dynamic, dynamic>> getResidences() async {
    return await datasource.getResidences();
  }

  Future<Either<dynamic, dynamic>> getResidenceInformation(
    String uuid,
  ) async {
    return await datasource.getResidenceInformation(uuid);
  }
}
