import 'package:equatable/equatable.dart';

class ErrorModel extends Equatable {
  final int? statusCode;
  final String? message;

  const ErrorModel({this.statusCode, this.message});

  @override
  List<Object?> get props => [statusCode, message];
}
