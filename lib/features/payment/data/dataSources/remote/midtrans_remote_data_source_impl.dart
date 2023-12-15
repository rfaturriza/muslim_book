import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/features/payment/data/models/transaction_request_model.codegen.dart';
import 'package:quranku/features/payment/data/models/transaction_response_model.codegen.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/utils/extension/string_ext.dart';
import 'midtrans_remote_data_source.dart';

@LazySingleton(as: MidtransRemoteDataSource)
class MidtransRemoteDataSourceImpl implements MidtransRemoteDataSource {
  final Dio _dio;

  MidtransRemoteDataSourceImpl(this._dio) : super() {
    _dio.options.baseUrl = () {
      if (kDebugMode) {
        return dotenv.env['MIDTRANS_MERCHANT_SERVER_SANDBOX_BASE_URL'] ?? '';
      } else {
        return dotenv.env['MIDTRANS_MERCHANT_SERVER_BASE_URL'] ?? '';
      }
    }();
    final key = () {
      if (kDebugMode) {
        return dotenv.env['MIDTRANS_SERVER_KEY_SANDBOX'] ?? emptyString;
      } else {
        return dotenv.env['MIDTRANS_SERVER_KEY'] ?? emptyString;
      }
    }();
    _dio.options.headers["Authorization"] = "Basic ${("$key:").toBase64()}";
  }

  @override
  Future<TransactionResponseModel> getTokenTransactionResponse({
    TransactionRequestModel? transactionRequestModel,
  }) async {
    const endpoint = 'transactions';
    try {
      final result = await _dio.post(
        endpoint,
        data: transactionRequestModel?.toJson(),
      );
      return TransactionResponseModel.fromJson(result.data);
    } on SocketException catch (e) {
      throw ServerException(e);
    } on DioException catch (e) {
      throw ServerException(e);
    } catch (e) {
      throw ServerException(e as Exception);
    }
  }
}
