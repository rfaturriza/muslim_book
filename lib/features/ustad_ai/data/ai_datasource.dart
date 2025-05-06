import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AiDataSource {
  final Dio dio;

  AiDataSource(
    this.dio,
  );

  Stream<String> streamAiResponse(String prompt) async* {
    try {
      final response = await dio.get<ResponseBody>(
        '/ask-ustadz-ai',
        queryParameters: {'prompt': prompt},
        options: Options(
          responseType: ResponseType.stream,
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      final stream = response.data?.stream;
      if (stream == null) {
        throw Exception('No stream data received');
      }

      await for (final chunk
          in stream.cast<List<int>>().transform(utf8.decoder)) {
        if (chunk.isEmpty) continue;
        yield chunk;
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Data format error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
