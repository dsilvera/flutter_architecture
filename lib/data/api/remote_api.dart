import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/data/models/request/question_request.dart';
import 'package:flutter_architecture/data/models/response/question_response.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final remoteApiProvider = Provider<RemoteApi>((ref) => RemoteApi());

class RemoteApi {
  static const String url = 'https://opentdb.com/api.php';

  Future<List<QuestionResponse>> getQuestions(QuestionRequest request) async {
    // Appel WS
    try {
      final response = await Dio().get(url, queryParameters: request.toMap());

      // Récupérer réponse
      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        final results = List<Map<String, dynamic>>.from(data['results']);
        if (results.isNotEmpty) {
          return results.map((e) => QuestionResponse.fromMap(e)).toList();
        }
      }
      return [];
    } on DioError catch (err) {
      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      print(err);
      throw Failure(message: 'Please check your connection.');
    }
  }
}
