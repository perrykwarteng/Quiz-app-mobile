import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quiz_provider.dart';
import 'quiz_screen.dart';

class QuizListScreen extends StatefulWidget {
  const QuizListScreen({super.key});

  @override
  _QuizListScreenState createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuizListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuizProvider>(context, listen: false).loadQuizzes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Quizzes'),
        backgroundColor: const Color(0xFF26436c), // Set the background color here
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quizzes to Be Taken',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF26436c), // Matching the AppBar color
              ),
            ),
            const SizedBox(height: 16), // Space between heading and list
            Expanded(
              child: quizProvider.quizzes.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: quizProvider.quizzes.length,
                      itemBuilder: (context, index) {
                        final quiz = quizProvider.quizzes[index];
                        return ListTile(
                          title: Text(quiz.title),
                          onTap: () {
                            quizProvider.selectQuiz(quiz);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizScreen(quiz: quiz),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
