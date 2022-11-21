import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:irep/models/residence_model.dart';
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

  Future<Either<dynamic, dynamic>> getResidenceInformation(String uuid) async {
    return await service.getResidenceInformation(uuid);
  }
}
