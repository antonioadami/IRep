import 'package:flutter/cupertino.dart';
import 'package:irep/helpers/mocks/residences_mock.dart';
import 'package:irep/helpers/mocks/user_ads_mock.dart';
import 'package:irep/models/residence_model.dart';

class ResidenceViewModel extends ChangeNotifier {
  List<ResidenceModel> residences = [];
  List<ResidenceModel> userAdsResidences = [];

  void getResidences() {
    residencesMock
        .map((json) => residences.add(
              ResidenceModel.fromJson(json),
            ))
        .toList();
  }

  void getAdsResidences() {
    userAdsMock
        .map((json) => userAdsResidences.add(
              ResidenceModel.fromJson(json),
            ))
        .toList();
  }
}
