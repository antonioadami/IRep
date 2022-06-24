import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:irep/helpers/mocks/user_ads_mock.dart';
import 'package:irep/models/error_model.dart';
import 'package:irep/models/residence_model.dart';
import 'package:irep/models/succes_model.dart';
import 'package:irep/service/residence_service.dart';

class ResidenceViewModel extends ChangeNotifier {
  List<ResidenceModel> residences = [];
  List<ResidenceModel> userAdsResidences = [];
  ResidenceService service = ResidenceService();

  void getResidences() async {
    var result = await service.getResidences();

    result.fold(
        (left) => {},
        (right) => {
              residences = List<ResidenceModel>.from(jsonDecode(right.response)
                  .map((residence) => ResidenceModel.fromJson(residence))
                  .toList())
            });
    notifyListeners();
  }

  Future<Either<ErrorModel, SuccessModel>> getResidenceInformation(
      String uuid) async {
    return await service.getResidenceInformation(uuid);
  }
}
