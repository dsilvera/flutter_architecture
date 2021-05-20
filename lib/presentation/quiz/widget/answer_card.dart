import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/common/widgets/circular_icon.dart';
import 'package:html_character_entities/html_character_entities.dart';

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final bool isCorrect;
  final bool isDisplayingAnswer;
  final VoidCallback onTap;

  const AnswerCard({
    required this.answer,
    required this.isSelected,
    required this.isCorrect,
    required this.isDisplayingAnswer,
    required this.onTap,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color(0xffCCDCE7),
          border: Border.all(
            color: isDisplayingAnswer
                ? isCorrect
                    ? Colors.green
                    : isSelected
                        ? Colors.red
                        : Color(0xffCCDCE7)
                : Color(0xffCCDCE7),
            width: 4.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                HtmlCharacterEntities.decode(answer),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: isDisplayingAnswer && isCorrect ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isDisplayingAnswer)
                isCorrect
                    ? const CircularIcon(icon: Icons.check, color: Colors.green)
                    : isSelected
                        ? const CircularIcon(
                            icon: Icons.close,
                            color: Colors.red,
                          )
                        : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
