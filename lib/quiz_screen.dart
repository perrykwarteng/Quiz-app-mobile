import 'package:flutter/material.dart';
import 'dart:async'; // Import for Timer
import 'quiz.dart';

class QuizScreen extends StatefulWidget {
  final Quiz quiz;

  const QuizScreen({super.key, required this.quiz});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  List<int?> selectedAnswers = [];
  late Timer _timer;
  int _remainingTime = 120; // 2 minutes in seconds

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime == 0) {
        _timer.cancel();
        _submitQuiz();
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  void _answerQuestion(int selectedAnswerIndex) {
    if (widget.quiz.questions[_currentQuestionIndex]
        .isAnswerCorrect(selectedAnswerIndex)) {
      _score++;
    }
    selectedAnswers.add(selectedAnswerIndex);

    setState(() {
      _currentQuestionIndex++;
    });

    if (_currentQuestionIndex >= widget.quiz.questions.length) {
      _submitQuiz();
    }
  }

  void _submitQuiz() {
    _timer.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Quiz Results'),
            backgroundColor: const Color(0xFF26436c),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Quiz Completed!',
                  style: TextStyle(color: Color(0xFF26436c)),
                ),
                Text(
                  'Your score: $_score/${widget.quiz.questions.length}',
                  style: const TextStyle(color: Color(0xFF26436c)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE9B26E),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back to Quizzes',
                      style: TextStyle(color: Color(0xFF26436c))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex >= widget.quiz.questions.length) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Results'),
          backgroundColor: const Color(0xFF26436c),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Quiz Completed!',
                style: TextStyle(color: Color(0xFF26436c)),
              ),
              Text(
                'Your score: $_score/${widget.quiz.questions.length}',
                style: const TextStyle(color: Color(0xFF26436c)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE9B26E),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Quizzes',
                    style: TextStyle(color: Color(0xFF26436c))),
              ),
            ],
          ),
        ),
      );
    }

    final question = widget.quiz.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.title),
        backgroundColor: const Color(0xFF26436c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Time Remaining: ${_remainingTime ~/ 60}:${_remainingTime % 60}',
              style: const TextStyle(fontSize: 18.0, color: Color(0xFF26436c)),
            ),
            const SizedBox(height: 16.0),
            Text(
              question.question,
              style: const TextStyle(fontSize: 18.0, color: Color(0xFF26436c)),
            ),
            const SizedBox(height: 16.0),
            ...question.options.asMap().entries.map((entry) {
              int index = entry.key;
              String option = entry.value;
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE9B26E),
                ),
                onPressed: () {
                  _answerQuestion(index);
                },
                child: Text(
                  option,
                  style: const TextStyle(color: Color(0xFF26436c)),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
