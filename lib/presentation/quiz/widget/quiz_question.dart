import 'package:flutter/material.dart';
import 'package:flutter_architecture/domain/entities/question.dart';
import 'package:flutter_architecture/presentation/quiz/viewmodel/quiz_state.dart';
import 'package:flutter_architecture/presentation/quiz/viewmodel/quiz_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'answer_card.dart';

class QuizQuestions extends StatelessWidget {
  final PageController pageController;
  final QuizState state;
  final List<Question> questions;

  const QuizQuestions({
    required this.pageController,
    required this.state,
    required this.questions,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: questions.length,
        itemBuilder: (BuildContext context, int index) {
          final question = questions[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Color(0xff2E415A),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                ),
                child: Center(
                  child: Text(HtmlCharacterEntities.decode(question.category),
                      style: GoogleFonts.notoSans(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                      )
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Spacer(),
                  Padding(padding: const EdgeInsets.only(right: 10.0, bottom: 5.0),
                      child: Text(
                          '${index + 1}/${questions.length}',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          )
                      )
                  ),
                ],
              ),
              Padding(padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                child: LinearProgressIndicator(
                  value: index / questions.length,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xffE6812F)),
                  backgroundColor: Colors.white,
                ),
              ),
              Container(
                height: 150.0,
                padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                child: Center(
                  child: Text(
                    HtmlCharacterEntities.decode(question.question),
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w400,
                    )
                  ),
                ),
              ),
              Expanded(child: GridView.builder(
                itemCount: question.answers.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1.4),
                itemBuilder: (BuildContext context, int index) {
                  final answer = question.answers[index];
                  return AnswerCard(
                    answer:answer,
                    isSelected: answer == state.selectedAnswer,
                    isCorrect : answer == question.correctAnswer,
                    isDisplayingAnswer : state.answered,
                    onTap : () => context
                        .read(quizViewModelProvider.notifier)
                        .submitAnswer(question, answer)
                  );
                },
              ))

            ],
          );
        }

    );
  }

}