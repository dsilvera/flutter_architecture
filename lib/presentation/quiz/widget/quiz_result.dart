import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/common/widgets/custom_button.dart';
import 'package:flutter_architecture/presentation/quiz/viewmodel/quiz_state.dart';
import 'package:flutter_architecture/presentation/quiz/viewmodel/quiz_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizResults extends StatelessWidget {
  final QuizState state;
  final int nbQuestions;

  const QuizResults({
    required this.state,
    required this.nbQuestions,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${state.nbCorrect} / $nbQuestions',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 60.0,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          'CORRECT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40.0),
        CustomButton(
          title: 'New Quiz',
          onTap: () {
            context.refresh(questionsProvider);
            context.read(quizViewModelProvider.notifier).reset();
          },
        ),
      ],
    );
  }
}