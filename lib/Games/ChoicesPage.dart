
import 'dart:math';

import 'package:flutter/material.dart';
import '../WebSockets/wsCommunication.dart';

class ChoicePage extends StatefulWidget {

  final String monumentId;
  const ChoicePage(this.monumentId);

  @override
  _ChoicePageState createState() => _ChoicePageState();
}

class Answer {
  var reponse;
  var answer;

  Answer(String uneReponse, bool uneAnswer) {
    reponse = uneReponse;
    answer = uneAnswer;
  }
}

class Choice {
  var question;
  var comment;
  List<Answer> answers;
  Choice(String uneQuestion ,String unComment, List<Answer> lesAnswers) {
    question = uneQuestion;
    comment = unComment;
    answers = lesAnswers;
  }
}

class _ChoicePageState extends State<ChoicePage> {
  List<Choice> choices = new List();
  Choice currentChoice;

  @override
  Widget build(BuildContext context) {
    List<Answer> mesChoix = new List();
    mesChoix.add(Answer("1665", true));
    mesChoix.add(Answer("1667", false));
    mesChoix.add(Answer("1664", false));

    Choice choice1 = new Choice(
        "En quelle année Annecy a été rattaché à la savoie ?","Commentaire à faire", mesChoix);

    List<Answer> mesChoix2 = new List();
    mesChoix.add(Answer("27,59 km²", true));
    mesChoix.add(Answer("18,69 km²", false));
    mesChoix.add(Answer("55,17 km²", false));
    Choice choice2 = new Choice(
        "En quelle année la toiture du palais de l'île a été renové ?","Commentaire à faire",mesChoix2);

    List<Answer> mesChoix3 = new List();
    mesChoix.add(Answer("2017", true));
    mesChoix.add(Answer("2009", false));
    mesChoix.add(Answer("1998", false));
    Choice choice3 = new Choice(
        "En quelle année la toiture du palais de l'île a été renovée ?","Commentaire à faire", mesChoix3);

    choices.add(choice1);
    choices.add(choice2);
    choices.add(choice3);

    currentChoice = choices[Random().nextInt(choices.length)];

    return new Scaffold(
      backgroundColor: Colors.redAccent,
      body: new Center(
        child: new Container(
          decoration: BoxDecoration(
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
                child: Text(currentChoice.question,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                    )),
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [
                          0.5,
                          0.5,
                        ],
                        colors: [
                          Colors.white54,
                          Colors.white,
                        ],
                      ),
                    ),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.fromLTRB(40, 10, 40, 10)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.black),
                            ))),
                        child: new Text(
                          currentChoice.answers[0].reponse,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            fontSize: 36,
                          ),
                        ),
                        onPressed: () => answerValidation(0, true)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [
                          0.5,
                          0.5,
                        ],
                        colors: [
                          Colors.white54,
                          Colors.white,
                        ],
                      ),
                    ),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.fromLTRB(40, 10, 40, 10)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.black),
                            ))),
                        child: new Text(
                          currentChoice.answers[1].reponse,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            fontSize: 36,
                          ),
                        ),
                        onPressed: () => answerValidation(1, true)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [
                          0.5,
                          0.5,
                        ],
                        colors: [
                          Colors.white54,
                          Colors.white,
                        ],
                      ),
                    ),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.fromLTRB(40, 10, 40, 10)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.black),
                            ))),
                        child: new Text(
                          currentChoice.answers[2].reponse,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            fontSize: 36,
                          ),
                        ),
                        onPressed: () => answerValidation(2, true)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> alertResult(String title, String comment) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  comment,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
                game.send("checkEndResponse", {
                  "room": game.roomCode,
                  "id": game.playerId,
                  "monumentId": widget.monumentId
                });
              },
            ),
          ],
        );
      },
    );
  }

  void answerValidation(int i, bool userAnswer) {
    if (currentChoice.answers[i].answer == userAnswer) {
      alertResult(
          "Bravo c'est une bonne réponse", currentChoice.comment);
      game.send("newUserScore", {
        "room": game.roomCode,
        "answer": true,
        "id": game.playerId,
        "monumentId": widget.monumentId
      });
    } else {
      alertResult("C'est perdu dommage", currentChoice.comment);
      game.send("newUserScore", {
        "room": game.roomCode,
        "answer": false,
        "id": game.playerId,
        "monumentId": widget.monumentId
      });
    }
  }
}


