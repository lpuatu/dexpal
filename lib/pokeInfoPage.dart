import 'package:DexPal/dexViewPage.dart';
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

  void checkType() async {
    if (widget.detailPoke.type2 == 'xx') hastype2 = false;
  }

  @override
  void initState() {
    super.initState();
    checkType();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(
        AssetImage('pokeSprites/homeSprite/' + widget.detailPoke.homeSprite),
        context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    key:
    scaffoldKey;
    didChangeDependencies();

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
      body: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Image.asset(
                    'pokeSprites/homeSprite/' + widget.detailPoke.homeSprite,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(widget.detailPoke.species)],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Image.asset('pokeSprites/types/' +
                        widget.detailPoke.type1 +
                        '.png'),
                  ),
                  hastype2
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Image.asset('pokeSprites/types/' +
                              widget.detailPoke.type2 +
                              '.png'),
                        )
                      : Container(),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
