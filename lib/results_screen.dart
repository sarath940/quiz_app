import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/question_summary/questions_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key, required this.chosenAnswers, required this.onRestart});

  final List<String> chosenAnswers;
  final void Function() onRestart;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i]
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numberOfQuestionsCorrect = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;
    final numberOfTotalQuestions = questions.length;

    return SizedBox(
        width: double.infinity,
        child: Container(
            margin: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Your answered $numberOfQuestionsCorrect out $numberOfTotalQuestions questions correctly!',
                    style: GoogleFonts.lato(
                        color: const Color.fromARGB(255, 203, 220, 253),
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 30,
                ),
                QuestionSummary(summaryData: summaryData),
                const SizedBox(
                  height: 30,
                ),
                TextButton.icon(
                  onPressed: onRestart,
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Restart Quiz!'),
                )
              ],
            )));
  }
}
