import 'package:DexPal/dexViewPage.dart';
import 'package:flutter/material.dart';

class PokeInfo extends StatelessWidget {
  const PokeInfo({super.key, required this.detailPoke});

  final pokeMon detailPoke;

  Widget build(BuildContext context) {
    precacheImage(
        AssetImage('pokeSprites/homeSprite/' + detailPoke.homeSprite), context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.05),
        // The title text which will be shown on the action bar
        child: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: true,
          title: Text(detailPoke.dexName),
          actions: [],
          centerTitle: true,
          elevation: 4,
        ),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.all(10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image.asset(
                      'pokeSprites/homeSprite/' + detailPoke.homeSprite),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.all(10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Image.asset(
                      'pokeSprites/types/' + detailPoke.type1 + '.png'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
