import 'package:flutter/material.dart';
import 'quiz.dart';

class QuizProvider extends ChangeNotifier {
  List<Quiz> _quizzes = [];
  final List<Quiz> _completedQuizzes = [];
  Quiz? _currentQuiz;

  List<Quiz> get quizzes => _quizzes;
  List<Quiz> get completedQuizzes => _completedQuizzes;
  Quiz? get currentQuiz => _currentQuiz;

  void loadQuizzes() {
    _quizzes = [
      Quiz(
        id: '1',
        title: 'Introduction to Programming',
        questions: [
          Question(
            question: 'What is the primary language used for web development?',
            options: ['JavaScript', 'Python', 'C++', 'Java'],
            correctAnswerIndex: 0,
          ),
          Question(
            question:
                'Who developed the first version of the C programming language?',
            options: [
              'Dennis Ritchie',
              'Bjarne Stroustrup',
              'James Gosling',
              'Linus Torvalds'
            ],
            correctAnswerIndex: 0,
          ),
          Question(
            question: 'What does "CPU" stand for in computer science?',
            options: [
              'Central Processing Unit',
              'Central Program Unit',
              'Computer Processing Unit',
              'Central Program Unit'
            ],
            correctAnswerIndex: 0,
          ),
          Question(
            question:
                'In which year was the first computer science department established at a university?',
            options: ['1962', '1955', '1970', '1980'],
            correctAnswerIndex: 0,
          ),
          Question(
            question:
                'What is the primary focus of Geographic Information Systems (GIS) studies?',
            options: [
              'Spatial Data Analysis',
              'Data Mining',
              'Statistical Inference',
              'Computational Theory'
            ],
            correctAnswerIndex: 0,
          ),
        ],
      ),
      Quiz(
        id: '2',
        title: 'Data Structures and Algorithms',
        questions: [
          Question(
            question:
                'What data structure uses LIFO (Last In, First Out) principle?',
            options: ['Stack', 'Queue', 'Linked List', 'Tree'],
            correctAnswerIndex: 0,
          ),
          Question(
            question:
                'Which sorting algorithm has the best average time complexity?',
            options: [
              'Quick Sort',
              'Bubble Sort',
              'Insertion Sort',
              'Merge Sort'
            ],
            correctAnswerIndex: 0,
          ),
          Question(
            question: 'What is the time complexity of binary search?',
            options: ['O(log n)', 'O(n)', 'O(n log n)', 'O(1)'],
            correctAnswerIndex: 0,
          ),
          Question(
            question: 'Which data structure is used to implement recursion?',
            options: ['Stack', 'Queue', 'Linked List', 'Hash Table'],
            correctAnswerIndex: 0,
          ),
          Question(
            question:
                'What is the space complexity of an array with n elements?',
            options: ['O(n)', 'O(log n)', 'O(1)', 'O(n^2)'],
            correctAnswerIndex: 0,
          ),
        ],
      ),
      Quiz(
        id: '3',
        title: 'Operating Systems',
        questions: [
          Question(
            question: 'What is the main function of an operating system?',
            options: [
              'Manage hardware resources',
              'Execute application software',
              'Provide internet connectivity',
              'All of the above'
            ],
            correctAnswerIndex: 0,
          ),
          Question(
            question:
                'Which operating system is known for its multitasking capabilities?',
            options: ['Linux', 'DOS', 'Windows 95', 'Mac OS 9'],
            correctAnswerIndex: 0,
          ),
          Question(
            question: 'What is virtual memory in operating systems?',
            options: [
              'A memory management technique',
              'A type of storage device',
              'A hardware component',
              'A programming language'
            ],
            correctAnswerIndex: 0,
          ),
          Question(
            question: 'What does a process scheduler do?',
            options: [
              'Manages process execution',
              'Handles file storage',
              'Allocates memory',
              'Controls network access'
            ],
            correctAnswerIndex: 0,
          ),
          Question(
            question:
                'Which system call is used to create a new process in Unix-based systems?',
            options: ['fork()', 'exec()', 'wait()', 'exit()'],
            correctAnswerIndex: 0,
          ),
        ],
      ),
      Quiz(
        id: '4',
        title: 'Database Systems',
        questions: [
          Question(
            question: 'What does SQL stand for?',
            options: [
              'Structured Query Language',
              'Simple Query Language',
              'Sequential Query Language',
              'Structured Quick Language'
            ],
            correctAnswerIndex: 0,
          ),
          Question(
            question: 'Which type of database model uses tables to store data?',
            options: [
              'Relational',
              'Hierarchical',
              'Network',
              'Object-oriented'
            ],
            correctAnswerIndex: 0,
          ),
          Question(
            question: 'What is a primary key in a database table?',
            options: [
              'A unique identifier for a record',
              'A foreign key reference',
              'An index for searching',
              'A default value'
            ],
            correctAnswerIndex: 0,
          ),
          Question(
            question: 'What is normalization in database design?',
            options: [
              'Process of organizing data to reduce redundancy',
              'Method of indexing data',
              'Technique for encrypting data',
              'Procedure for backing up data'
            ],
            correctAnswerIndex: 0,
          ),
          Question(
            question: 'Which SQL clause is used to filter records?',
            options: ['WHERE', 'ORDER BY', 'GROUP BY', 'HAVING'],
            correctAnswerIndex: 0,
          ),
        ],
      ),
      Quiz(
        id: '5',
        title: 'Computer Networks',
        questions: [
          Question(
            question: 'What is the primary function of a router?',
            options: [
              'Directs data packets between networks',
              'Provides network security',
              'Manages local network traffic',
              'Establishes internet connectivity'
            ],
            correctAnswerIndex: 0,
          ),
          Question(
            question:
                'Which protocol is used to send emails over the internet?',
            options: ['SMTP', 'HTTP', 'FTP', 'TCP'],
            correctAnswerIndex: 0,
          ),
          Question(
            question: 'What does IP stand for in networking?',
            options: [
              'Internet Protocol',
              'Internal Protocol',
              'Interface Protocol',
              'International Protocol'
            ],
            correctAnswerIndex: 0,
          ),
          Question(
            question: 'What is the purpose of a DNS server?',
            options: [
              'Translates domain names to IP addresses',
              'Stores web files',
              'Encrypts data',
              'Monitors network traffic'
            ],
            correctAnswerIndex: 0,
          ),
          Question(
            question:
                'Which layer of the OSI model is responsible for data encryption?',
            options: [
              'Presentation Layer',
              'Application Layer',
              'Transport Layer',
              'Network Layer'
            ],
            correctAnswerIndex: 0,
          ),
        ],
      ),
    ];
    notifyListeners();
  }

  void markQuizAsCompleted(Quiz quiz) {
    if (!_completedQuizzes.contains(quiz)) {
      _completedQuizzes.add(quiz);
      notifyListeners();
    }
  }

  void selectQuiz(Quiz quiz) {
    _currentQuiz = quiz;
    notifyListeners();
  }
}
