import 'package:flutter/material.dart';
import 'package:quizler/quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizbrain = QuizBrain();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: QuizPage(),
        ));
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  var lst = [
    Icon(
      Icons.check,
      color: Colors.green,
    ),
  ];
  int questionnumber = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Column(
            //in order to align them and to locate them
            verticalDirection: VerticalDirection.up,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //for ticks or crosses
              Row(
                children: lst,
              ),
              //to clear the row of ticks and crosses
              Container(
                margin: EdgeInsets.all(20),
                height: 70,
                color: Colors.blue,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      lst = [];
                      questionnumber = 0;
                    });
                  },
                  child: Text(
                    "Clear",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
              // for true
              Container(
                margin: EdgeInsets.all(20),
                height: 70,
                color: Colors.green,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      bool checkanswer =
                      quizbrain.getQuestionAnswer(questionnumber);
                      if (checkanswer == true) {
                        print("user got right");
                        lst.add(Icon(
                          Icons.check,
                          color: Colors.green,
                        ));
                      } else {
                        print("user got wrong");
                        lst.add(Icon(
                          Icons.close,
                          color: Colors.red,
                        ));
                      }
                      //to make sure that app never crashes after exceeding the array size
                      if (questionnumber == 12) {
                        setState(() {
                          questionnumber = 0;
                          lst = [];
                          Alert(
                            context: context,
                            title: 'Finished!',
                            desc:
                            'You\'ve reached the end of the quiz.Now starting again',
                          ).show();
                        });
                      } else {
                        questionnumber++;
                      }
                    });
                  },
                  child: Text(
                    "True",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
              //for false
              Container(
                margin: EdgeInsets.all(20),
                height: 70,
                color: Colors.red,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      bool checkanswer =
                      quizbrain.getQuestionAnswer(questionnumber);
                      //to make sure that app never crashes after exceeding the array size

                      if (checkanswer == false) {
                        print("user got right");
                        lst.add(Icon(
                          Icons.check,
                          color: Colors.green,
                        ));
                      } else {
                        print("user got wrong");
                        lst.add(Icon(
                          Icons.close,
                          color: Colors.red,
                        ));
                      }
                      if (questionnumber == 12) {
                        setState(() {
                          questionnumber = 0;
                          lst = [];
                          Alert(
                            context: context,
                            title: 'Finished!',
                            desc:
                            'You\'ve reached the end of the quiz.Now starting again',
                          ).show();
                        });
                      } else {
                        questionnumber++;
                      }
                    });
                  },
                  child: Text(
                    "False",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
              // to show questions
              Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 120),
                    padding: EdgeInsets.all(50),
                    child: Text(
                      quizbrain.getQuestionText(questionnumber),
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
