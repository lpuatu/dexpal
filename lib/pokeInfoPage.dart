import 'package:DexPal/pokeMon.dart';
import 'package:DexPal/statChart.dart';
import 'package:DexPal/pokeWeakness.dart';
import 'package:DexPal/pokeAbility.dart';
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

  bool showAbility = false;

  void checkType() async {
    if (widget.detailPoke.type2.toLowerCase() == 'null') hastype2 = false;
    if (widget.detailPoke.ability2.toLowerCase() == 'null') hasAB2 = false;
    if (widget.detailPoke.hability.toLowerCase() == 'null') hasHidden = false;
  }

  @override
  void initState() {
    checkType();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(
        AssetImage('pokeSprites/homeSprite/' + widget.detailPoke.homeSprite),
        context);
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.09),
        // The title text which will be shown on the action bar
        child: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: true,
          title: Text('#' +
              widget.detailPoke.dexNum.toString() +
              ' ' +
              widget.detailPoke.dexName),
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
                    alignment: const AlignmentDirectional(0, 0),
                    child: Image.asset(
                      'pokeSprites/homeSprite/' +
                          widget.detailPoke.homeSprite.toLowerCase(),
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
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                      child: Container(
                        child: Text(
                          widget.detailPoke.species,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PokeWeak(detailPoke: widget.detailPoke),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
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
                          ? SizedBox(
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
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: statChart(
                          pokeStat: widget.detailPoke,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Text(
                              'Abilities',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 10, 10, 10),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PokeAbility(
                                            abilityName:
                                                widget.detailPoke.ability1),
                                  ),
                                );
                              },
                              child: Text(widget.detailPoke.ability1),
                            ),
                          ),
                          hasAB2
                              ? Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              PokeAbility(
                                                  abilityName: widget
                                                      .detailPoke.ability2),
                                        ),
                                      );
                                    },
                                    child: Text(widget.detailPoke.ability2),
                                  ),
                                )
                              : Container(),
                          hasHidden
                              ? Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              PokeAbility(
                                                  abilityName: widget
                                                      .detailPoke.hability),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                    ),
                                    child: Text(widget.detailPoke.hability),
                                  ),
                                )
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
