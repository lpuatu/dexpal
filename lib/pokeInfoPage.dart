import 'package:DexPal/dexViewPage.dart';
import 'package:DexPal/pokeMon.dart';
import 'package:DexPal/statChart.dart';
import 'package:flutter/material.dart';

class PokeInfo extends StatefulWidget {
  const PokeInfo({Key? key, required this.detailPoke}) : super(key: key);

  final pokeMon detailPoke;

  @override
  State<PokeInfo> createState() => PokeInfoState();
}

class PokeInfoState extends State<PokeInfo> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool hastype2 = true;
  bool hasAB2 = true;
  bool hasHidden = true;

  void checkType() async {
    if (widget.detailPoke.type2 == 'Null') hastype2 = false;
    if (widget.detailPoke.ability2 == 'Null') hasAB2 = false;
    if (widget.detailPoke.hability == 'Null') hasHidden = false;
  }

  @override
  void initState() {
    checkType();
    super.initState();
  }

  void didChangeDependencies() {
    precacheImage(
        AssetImage('pokeSprites/homeSprite/' + widget.detailPoke.homeSprite),
        context);
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    key:
    scaffoldKey;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.09),
        // The title text which will be shown on the action bar
        child: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: true,
          title: Text(widget.detailPoke.dexName),
          actions: [],
          centerTitle: true,
          elevation: 4,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Image.asset(
                      'pokeSprites/homeSprite/' + widget.detailPoke.homeSprite,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                      child: Container(
                        child: Text(
                          widget.detailPoke.species,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.height * 0.03,
                        child: Image.asset(
                          'pokeSprites/types/' +
                              widget.detailPoke.type1 +
                              '.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      hastype2
                          ? Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.03,
                              child: Image.asset(
                                'pokeSprites/types/' +
                                    widget.detailPoke.type2 +
                                    '.png',
                                fit: BoxFit.contain,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: statChart(pokeStat: widget.detailPoke),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Abilities:'),
                          Text('1: ' + widget.detailPoke.ability1),
                          hasAB2
                              ? Text('2: ' + widget.detailPoke.ability2)
                              : Container(),
                          hasHidden
                              ? Text('Hidden: ' + widget.detailPoke.hability)
                              : Container(),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
