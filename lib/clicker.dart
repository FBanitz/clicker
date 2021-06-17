import 'dart:async';

import 'package:flutter/material.dart';

class Clicker extends StatefulWidget {
  const Clicker({Key? key}) : super(key: key);

  @override
  _ClickerState createState() => _ClickerState();
}

class _ClickerState extends State<Clicker> {
  var _score = 0;
  var _bestScore = 0;
  var _game = false;

  _plusOne() {
    setState(() {
      _score++;
    });
  }

  _startGame() {
    setState(() {
      _game = true;
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
    if (_score > _bestScore)
    _bestScore = _score;
    _game = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clicker"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Score : $_score"),
            Text("Meilleur score : $_bestScore"),
            if (!_game)
              TextButton(
                  onPressed: _startGame, child: Text("Démarer la partie")),
            Spacer(),
            if (_game)
              ElevatedButton.icon(
                onPressed: _plusOne,
                label: Text("Ajouter 1"),
                icon: Icon(Icons.plus_one),
              ),
          ],
        ),
      ),
    );
  }
}
