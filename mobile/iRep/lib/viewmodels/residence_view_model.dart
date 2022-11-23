import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:irep/models/error_model.dart';
import 'package:irep/models/residence_model.dart';
import 'package:irep/service/residence_service.dart';

class ResidenceViewModel extends ChangeNotifier {
  List<ResidenceModel> residences = [];
  ResidenceService service;

  ResidenceViewModel(this.service);

  Future<void> getResidences() async {
    var result = await service.getResidences();

    result.fold(
      (left) {
        residences = [];
      },
      (right) {
        residences = right;
      },
    );
    notifyListeners();
  }

  Future<Either<ErrorModel, ResidenceModel>> getResidenceInformation(
    String uuid,
  ) async {
    var result = await service.getResidenceInformation(uuid);
    return result;
  }
}
