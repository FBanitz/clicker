import 'package:flutter/material.dart';

class Clicker extends StatefulWidget {
  const Clicker({ Key? key }) : super(key: key);

  @override
  _ClickerState createState() => _ClickerState();
}

class _ClickerState extends State<Clicker> {
  var _score = 0;
  var _game = false;

  _plus_one(){
    setState(() {
      _score ++;
    });
  }

  _toggleGame(){
    setState(() {
      _game = ! _game;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(title: Text("Clicker"),),
      body: Column(
        children: [
          if (_game)
            Column( 
              children: [
                Text("Score : $_score"),
                ElevatedButton.icon(
                  onPressed: _plus_one, 
                  label: Text("Ajouter 1"),
                  icon: Icon(Icons.plus_one),
                ),
              ],
            ),
          if (!_game)
            TextButton(
              onPressed: _toggleGame, 
              child: Text("Démarer la partie")
            ),
        ],
      ),
    );
  }
}