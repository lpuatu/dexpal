import 'package:DexPal/dexViewPage.dart';
import 'package:flutter/material.dart';

class PokeInfo extends StatelessWidget {
  const PokeInfo({super.key, required this.detailPoke});

  final pokeMon detailPoke;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(detailPoke.dexName),
        actions: [],
        centerTitle: true,
        elevation: 4,
        ),
        body: Column(children: <Widget>[
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Padding(
                padding: EdgeInsetsDirectional.all(10),
                child: Image.asset(
                    'pokeSprites/homeSprite/' + detailPoke.homeSprite),
              ),
            ),
          ),
        ]));
  }
}
