import 'dart:async';
import 'package:flutter/material.dart';
import 'data/high_score.dart';
import 'config/gameplay.dart';


class Clicker extends StatefulWidget {
  const Clicker({Key? key}) : super(key: key);

  @override
  _ClickerState createState() => _ClickerState();
}

class _ClickerState extends State<Clicker> {
  var _formkey = GlobalKey<FormState>();
  var _score = 0;
  String _game = "start";
  var i=0;
  var _scoreRow;
  var _lastName;

  final List<HighScore> _scoreList = [];

  _plusOne() {
    setState(() {
      _score++;
    });
  }

  _resetGame(){
    setState(() {
      _game = "start";
    });
  }

  _startGame() {
    setState(() {
      _game = "game";
      _score = 0;
      _startTimer();
    });
  }

  _startTimer(){
    setState(() {
      Timer(Duration(seconds: TIME), _stopGame);
    });
  }

  _stopGame(){ 
    setState(() {
    _game = "end";
    });
  }

  _confirmName() {
    setState(() {
      if(_formkey.currentState!.validate()){
        _formkey.currentState!.save();
      }
    });
  } 
 
  _setHigh(value) {
    if (_scoreRow != null && _scoreList.length >= BESTCOUNT)
    _scoreList.removeAt(_scoreRow);
    final highScore = new HighScore(value, _score);
    _scoreList.add(highScore);
    _scoreList.sort((a, b) => a.score.compareTo(b.score));
    _lastName = value;
    _resetGame();
  }

  _checkbest(value){
    for (i=0; i<_scoreList.length; i++){
      if (_scoreList[i].score < value)
      return i;
    }
    return null;
  }

  Widget _resultRow(BuildContext context, int rowNumber) {
    final result = _scoreList[rowNumber];
    return Row(
      children: [
        Text(result.name),
        Icon(Icons.star, color: Colors.yellow),
        Text("${result.score} points")
      ],
    );
  }

  Widget results(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: _scoreList.length,
          itemBuilder: _resultRow
        ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clicker"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: body()
        ),
      );
  }

  Widget body() {
    
    if (_game == "start"){
      return start();
    }
    else if (_game == "game"){
      return game();
    }
    else if(_game == "end"){
      return end();
    }
    else {
      return Text("Erreur Interne");
    }
  }

  Widget score(){
    return Column(
      children:[
        Text("Score : $_score"),
      ]
    );
  }

  Widget start() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_scoreList.length > 0)
        Text("Les $BESTCOUNT Meilleurs joueurs : "),
        results(context),
        Spacer(),
        TextButton(onPressed: _startGame, child: Text("Démarer la partie")),
      ],
    );
  }

  Widget game(){
    return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
          score(),
          Spacer(),
          ElevatedButton.icon(
            onPressed: _plusOne,
            label: Text("Ajouter 1"),
            icon: Icon(Icons.plus_one),
          ),
      ],
    );
  }

  Widget end(){
    _scoreRow = _checkbest(_score);
    if (_scoreList.length < BESTCOUNT)
      return endHigh();
    else if (_scoreRow != null)
      return endHigh();
    else
      return endLow();
    // else
    // return endLow();
  }

  Widget endHigh(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_scoreList.length > 0)
        Text("Les $BESTCOUNT Meilleurs joueurs : "),
        results(context),
        score(),
        Text("Bravo! nouveau record!!!"),
          Form(
            key: _formkey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    // controller: _controlerName,
                    initialValue: _lastName,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                          
                        ),
                      ),
                      labelText: 'Entrez votre prénom',
                      prefixIcon: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 12.0),
                        child: Icon(Icons.account_circle),
                      )
                    ),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.words,
                    autofillHints: [AutofillHints.givenName],
                    keyboardType: TextInputType.name,
                    validator: (value) => value!.length >= 2 ? null: "Prénom trop court",
                    // onChanged: _setName,
                    onSaved: _setHigh,
                  ),
                ),
                ElevatedButton(onPressed: _confirmName, child: Text("Valider")),
              ],
            ),
          ),
      ],
    );
  }

  Widget endLow(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        score(),
        Text("Vous n'avez pas réussi à battre le record :("),
        Spacer(),
        ElevatedButton(onPressed: _resetGame, child: Text("retour")),
      ],
    );
  }
}
