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
  bool isLoading = true;

  bool hastype2 = true;
  Map<String, dynamic> typeMap = {};
  List<String> superEffective = [];
  List<String> normalEffective = [];
  List<String> resist = [];

  @override
  void initState() {
    if (widget.detailPoke.type2 == 'Null') hastype2 = false;
    getWeakness();
    super.initState();
  }

  void getWeakness() async {
    setState(() {
      isLoading = true;
    });

    final myData = await rootBundle.loadString("assets/typeWeak.csv");
    List<List<dynamic>> weakCsv = const CsvToListConverter().convert(myData);
    int type2index = 1;

    int type1index = weakCsv[0].indexOf(widget.detailPoke.type1);
    if (hastype2) {
      type2index = weakCsv[0].indexOf(widget.detailPoke.type2);
    }

    for (int j = 1; j < weakCsv[0].length; j++) {
      typeMap[weakCsv[j][0]] = weakCsv[j][type1index] * weakCsv[j][type2index];
    }

    superEffective = typeMap.entries
        .where((entry) => entry.value >= 2)
        .map((entry) => entry.key)
        .toList();

    normalEffective = typeMap.entries
        .where((entry) => entry.value == 1)
        .map((entry) => entry.key)
        .toList();

    resist = typeMap.entries
        .where((entry) => entry.value < 1)
        .map((entry) => entry.key)
        .toList();

    setState(() {
      isLoading = false;
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
        // The title text which will be shown on the action bar
        child: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: true,
          /*title: hastype2
              ? Text(widget.detailPoke.type1 + '/' + widget.detailPoke.type2)
              : Text(widget.detailPoke.type1),*/
          actions: const [],
          centerTitle: true,
          elevation: 4,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.grey,
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Center(
                      child: Text(
                        'Super Effective!',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: (1 / .4),
                    ), // 3 buttons in a row
                    itemCount: superEffective.length,
                    itemBuilder: (BuildContext context, int index) {
                      final key = superEffective[index];
                      return Center(
                        child: Image.asset(
                          'pokeSprites/types/' + key + '.png',
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey,
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Center(
                      child: Text(
                        'Normal Effective',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: (1 / .4),
                    ), // 3 buttons in a row
                    itemCount: normalEffective.length,
                    itemBuilder: (BuildContext context, int index) {
                      final key = normalEffective[index];
                      return Center(
                        child: Image.asset(
                          'pokeSprites/types/' + key + '.png',
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey,
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Center(
                      child: Text(
                        'Not Very Effective',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: (1 / .4),
                    ), // 3 buttons in a row
                    itemCount: resist.length,
                    itemBuilder: (BuildContext context, int index) {
                      final key = resist[index];
                      return Center(
                        child: Image.asset(
                          'pokeSprites/types/' + key + '.png',
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
