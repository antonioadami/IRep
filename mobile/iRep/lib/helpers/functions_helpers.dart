import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void errorSnackbar(BuildContext context, {required String message}) {
  showTopSnackBar(
    context,
    CustomSnackBar.error(
      message: message,
    ),
  );
}

void successSnackbar(BuildContext context, {required String message}) {
  showTopSnackBar(
    context,
    CustomSnackBar.success(
      message: message,
    ),
  );
}
