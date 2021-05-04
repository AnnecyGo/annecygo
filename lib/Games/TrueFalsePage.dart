import 'dart:math';

import 'package:flutter/material.dart';

class TrueFalsePage extends StatefulWidget {
  @override
  _TrueFalsePageState createState() => _TrueFalsePageState();
}

class Question{
  var question;
  var answer;
  var comment;
  Question(String uneQuestion,bool uneAnswer,String unComment){
    question = uneQuestion;
    answer = uneAnswer;
    comment = unComment;
  }
}

class _TrueFalsePageState extends State<TrueFalsePage> {
  List<Question> questions = new List();
  Question currentQuestion;

  @override
  Widget build(BuildContext context) {


    Question question1 = new Question("le Ciel est bleu à Annecy", true,"Lève les yeux");
    Question question2= new Question("le nom de la rivière qui traverse la ville est le Thiou ?", true,"Le Thiou la petite rivière de 3,5 km de long qui travèrse Annecy. Elle est le déversoir naturel du lac d'Annecy dans le Fier.");
    Question question3 = new Question("l'arquebuse est l'alcool local d'Annecy ?", false,"C'est le génépi l’un des emblèmes de la Haute-Savoie, Plante rare qu’il est exclusivement possible de trouver en haute montagne (entre 2500 à 3200 mètres d’altitude)");
    Question question4 = new Question("au dernier recensement le nombre d'habitants d'Annecy est 52 000 habitants ?", true,"La population légale 2018 pour Annecy était de 131 481 habitants");


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
          decoration : BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                0.5,
                0.5,
              ],
              colors: [
                Colors.red,
                Colors.redAccent,
              ],
            ),
          ),
          margin: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(currentQuestion.question,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                    )),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration : BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [
                          0.5,
                          0.5,
                        ],
                        colors: [
                          Colors.greenAccent,
                          Colors.green,
                        ],
                      ),
                    ),
                    child : ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(40,10,40,10)),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent) ,
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.black),

                                )
                            )
                        ),

                        child: new Text(
                          'VRAI',
                          style:
                          TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            fontSize: 36,
                          ),
                        ),
                        onPressed: () => answerValidation(true)
                    ),
                  ),
                  Container(
                    decoration : BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [
                          0.5,
                          0.5,
                        ],
                        colors: [
                          Colors.redAccent,
                          Colors.red,
                        ],
                      ),
                    ),
                    child : ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(40,10,40,10)),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent) ,
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.black),

                                )
                            )
                        ),
                        child: new Text(
                          'FAUX',
                          style:
                          TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            fontSize: 36,
                          ),
                        ),
                        onPressed: () => answerValidation(false)
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> alertResult(String title,String comment) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 48)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(comment,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32),)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void answerValidation(bool userAnswer){
    if(currentQuestion.answer == userAnswer){
      alertResult("Bravo c'est une bonne réponse",currentQuestion.comment);
    } else {
      alertResult("C'est perdu dommage",currentQuestion.comment);
    }

  }

}