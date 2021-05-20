import 'package:flutter/material.dart';
import 'package:flutter_architecture/domain/entities/question.dart';
import 'package:flutter_architecture/presentation/common/widgets/custom_button.dart';
import 'package:flutter_architecture/presentation/common/widgets/error.dart';
import 'package:flutter_architecture/presentation/quiz/viewmodel/quiz_state.dart';
import 'package:flutter_architecture/presentation/quiz/viewmodel/quiz_view_model.dart';
import 'package:flutter_architecture/presentation/quiz/widget/quiz_question.dart';
import 'package:flutter_architecture/presentation/quiz/widget/quiz_result.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final viewModelState = useProvider(quizViewModelProvider);
    final questionsFuture = useProvider(questionsProvider);
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF22293E),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: questionsFuture.when(
            data: (questions) => _buildBody(context, viewModelState, pageController, questions),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Error(
                  message: error.toString(),
                  callback: () => refreshAll(context),
                )),
        bottomSheet: questionsFuture.maybeWhen(
            data: (questions) {
              if (!viewModelState.answered) return SizedBox.shrink();
              var currentIndex = pageController.page?.toInt() ?? 0;
              return CustomButton(
                  title: currentIndex + 1 < questions.length ? 'Next Question' : 'See results',
                  onTap: () {
                    context
                        .read(quizViewModelProvider.notifier)
                        .nextQuestion(questions, currentIndex);
                    if (currentIndex + 1 < questions.length) {
                      pageController.nextPage(
                          duration: const Duration(microseconds: 250), curve: Curves.linear);
                    }
                  });
            },
            orElse: () => SizedBox.shrink()),
      ),
    );
  }

  void refreshAll(BuildContext context) {
    context.refresh(questionsProvider);
    context.read(quizViewModelProvider.notifier).reset();
  }

  Widget _buildBody(
    BuildContext context,
    QuizState state,
    PageController pageController,
    List<Question> questions,
  ) {
    if (questions.isEmpty) {
      return Error(message: 'No questions found', callback: () => refreshAll(context));
    }

    return state.status == QuizStatus.complete
        ? QuizResults(state: state, nbQuestions: questions.length)
        : QuizQuestions(pageController: pageController, state: state, questions: questions);
  }
}
