import 'dart:async';
import 'package:flutter/material.dart';

class Clicker extends StatefulWidget {
  const Clicker({Key? key}) : super(key: key);

  @override
  _ClickerState createState() => _ClickerState();
}

class _ClickerState extends State<Clicker> {
  var _formkey = GlobalKey<FormState>();
  var _score = 0;
  var _highScore = 0;
  String _name = "";
  String _game = "start";


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
      Timer(Duration(seconds: 10), _stopGame);
    });
  }

  _stopGame(){ 
    setState(() {
    _game = "end";
    });
  }

  _setName(value) {
    setState(() {
        _name = value;
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
    _setName(value);
    _resetGame();
    _highScore = _score;
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
        Text("Meilleur score ($_name) : $_highScore"),
      ]
    );
  }

  Widget start() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        score(),
        TextButton(onPressed: _startGame, child: Text("Démarer la partie")),
        Spacer(),
      ],
    );
  }

  Widget game(){
      return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            score(),
            ElevatedButton.icon(
              onPressed: _plusOne,
              label: Text("Ajouter 1"),
              icon: Icon(Icons.plus_one),
            ),
        ],
      );
  }

  Widget end(){
    if (_score > _highScore)
    return endHigh();
    else
    return endLow();
  }

  Widget endHigh(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        score(),
        Text("Bravo! nouveau record!!!"),
          Form(
            key: _formkey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    // controller: _controlerName,
                    initialValue: _name,
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
        ElevatedButton(onPressed: _resetGame, child: Text("retour")),
      ],
    );
  }
}
