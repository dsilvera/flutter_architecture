import 'package:flutter_architecture/domain/entities/question.dart';

abstract class QuizRepository {
  Future<List<Question>> getQuestions({required int numQuestions, required int categoryId});
}
