import 'package:flutter/material.dart';
import 'package:irep/models/error_model.dart';
import 'package:irep/models/succes_model.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void errorSnackbar(BuildContext context, ErrorModel error) {
  showTopSnackBar(
    context,
    CustomSnackBar.error(
      message: error.message!,
    ),
  );
}

void successSnackbar(BuildContext context, SuccessModel success) {
  showTopSnackBar(
    context,
    CustomSnackBar.success(
      message: success.message!,
    ),
  );
}
