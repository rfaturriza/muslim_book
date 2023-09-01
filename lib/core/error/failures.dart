import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../../generated/locale_keys.g.dart';
import '../utils/extension/string_ext.dart';

abstract class Failure extends Equatable {
  final String? message;
  const Failure({this.message});
  @override
  List<Object> get props => [message ?? emptyString];
}

class ServerFailure extends Failure {
  const ServerFailure({String? message}) : super(message: message);
}

class CacheFailure extends Failure {
  const CacheFailure({String? message}) : super(message: message);
}

class GeneralFailure extends Failure {
  const GeneralFailure({String? message}) : super(message: message);
}

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return failure.message ?? LocaleKeys.defaultErrorMessage.tr();
    case CacheFailure:
      return failure.message ?? LocaleKeys.defaultErrorMessage.tr();
    default:
      return 'Unexpected error';
  }
}