import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  // List with five Icon Elements
  // scoreKeeper.indexOf(element);
  // scoreKeeper.add(element);
  // scoreKeeper.insert(index,element);
  List<Icon> scoreKeeper = [];

  void CheckAnswer(bool UserPickedAnswer) {
    setState(() {
      if (quizBrain.getQuestionAnswer() == UserPickedAnswer)
          scoreKeeper.add(Icon(Icons.check, color: Colors.green, size: 22,));
      else
          scoreKeeper.add(Icon(Icons.close, color: Colors.red, size: 22,));

      if( quizBrain.getQuestionNumber() == quizBrain.getQuestionBankSize()-1 ){
        Alert(
          context: context,
          title: "Quiz Ends",
          desc: "Click On start Button to start it again...",
          buttons: [
            DialogButton(
              child: Text(
                "START",
                style: TextStyle(color: Colors.white, fontSize: 23),
              ),
              onPressed: () {
                  Navigator.pop(context);
                  scoreKeeper = [];
                  quizBrain.startQuizAgain();
              },
              width: 120,
            )
          ],
        ).show();
      }
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Column/Row consists of multiple child or lists
    // SafeArea/Padding consists of single child
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                CheckAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                CheckAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

