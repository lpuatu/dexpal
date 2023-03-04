import 'package:DexPal/pokeMon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

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
    getWeakness();
    super.initState();
  }

  void getWeakness() async {
    final myData = await rootBundle.loadString("typeWeak.csv");
    List<List<dynamic>> weakCsv = const CsvToListConverter().convert(myData);

    int type1index = 1;
    int type2index = 1;

    Map<String, int> typeMap = {"null": 0};

    for (int i = 1; i < weakCsv[0].length; i++) {
      if (weakCsv[0][i] == widget.detailPoke.type1) i = type1index;
      if (weakCsv[0][i] == widget.detailPoke.type2) i = type2index;
    }

    for (int j = 1; j < weakCsv.length; j++) {
      typeMap[weakCsv[j][0]] = weakCsv[j][type1index] * weakCsv[j][type2index];
    }
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
      body: Column(
        children: [
          Container(
            child: Text(''),
          ),
        ],
      ),
    );
  }
}
