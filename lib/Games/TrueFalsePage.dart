import 'dart:math';

import 'package:flutter/material.dart';

class TrueFalsePage extends StatefulWidget {
  @override
  _TrueFalsePageState createState() => _TrueFalsePageState();
}

class Question{
  var question;
  var answer;
  Question(String uneQuestion,bool uneAnswer){
    question = uneQuestion;
    answer = uneAnswer;
  }
}

class _TrueFalsePageState extends State<TrueFalsePage> {
  List<Question> questions = new List();
  Question currentQuestion;

  @override
  Widget build(BuildContext context) {


    Question question1 = new Question("le Ciel est bleu à Annecy", true);
    Question question2= new Question("le nom de la rivière qui traverse la ville est le Thiou ?", true);
    Question question3 = new Question("l'arquebuse est l'alcool local d'Annecy ?", false);
    Question question4 = new Question("au dernier recensement le nombre d'habitants d'Annecy est 52 000 habitants ?", true);


    questions.add(question1);
    questions.add(question2);
    questions.add(question3);
    currentQuestion = questions[Random().nextInt(questions.length)];

    return new Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Text("Mini-Jeux"),

      ),
      body: new Center(
      child : new Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(currentQuestion.question,
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
              )),
            RaisedButton(
              child: new Text(
                'VRAI',
                style:
                TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black45,
                  fontSize: 40,
                ),
              ),
                onPressed: () => answerValidation(true)
            ),
            RaisedButton(
                child: new Text(
                  'FAUX',
                  style:
                  TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black45,
                    fontSize: 40,
                  ),
                ),
                onPressed: () => answerValidation(false)
            ),

          ],
        ),
      ),
      ),
    );
  }

  Future<void> alertResult(String result) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fin du jeu'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(result),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

   void answerValidation(bool userAnswer){
    if(currentQuestion.answer == userAnswer){
      alertResult("Vous avez gagné");
    } else {
      alertResult("C'est perdu");

    }
  }

}

