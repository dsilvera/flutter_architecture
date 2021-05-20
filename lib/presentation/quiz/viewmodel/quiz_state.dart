import 'package:equatable/equatable.dart';

enum QuizStatus { initial, correct, incorrect, complete }

class QuizState extends Equatable {
  final String selectedAnswer;
  final int nbCorrect;
  final QuizStatus status;

  const QuizState({
    required this.selectedAnswer,
    required this.nbCorrect,
    required this.status,
  });


  @override
  List<Object> get props => [
    selectedAnswer,
    nbCorrect,
    status,
  ];

  factory QuizState.initial() {
    return QuizState(
      selectedAnswer: '',
      nbCorrect: 0,
      status: QuizStatus.initial,
    );
  }

  bool get answered => status == QuizStatus.incorrect || status == QuizStatus.correct;

  QuizState copyWith({
    String? selectedAnswer,
    int? correct,
    QuizStatus? status,
  }) {
    return QuizState(
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      nbCorrect: correct ?? this.nbCorrect,
      status: status ?? this.status,
    );
  }
}