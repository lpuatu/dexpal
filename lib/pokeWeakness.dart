import 'package:DexPal/pokeMon.dart';
import 'package:flutter/material.dart';

class PokeWeak extends StatefulWidget {
  const PokeWeak({Key? key, required this.detailPoke}) : super(key: key);

  final pokeMon detailPoke;

  @override
  State<PokeWeak> createState() => PokeWeakState();
}

class PokeWeakState extends State<PokeWeak> {
  bool hastype2 = true;

  @override
  void initState() {
    if (widget.detailPoke.type2 == 'Null') hastype2 = false;
    super.initState();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

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
          title: Text(widget.detailPoke.type1 + '/' + widget.detailPoke.type2),
          actions: [],
          centerTitle: true,
          elevation: 4,
        ),
      ),
    );
  }
}

void getWeakness() {}
