import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:DexPal/pokeMon.dart';

Future<List<pokeMon>> dexTableLoad() async {
  List<pokeMon> loadTable = [];

  final myData = await rootBundle.loadString("assets/mariadex.csv");
  List<List<dynamic>> dexCsv = const CsvToListConverter().convert(myData);
  for (int i = 1; i < dexCsv.length; i++) {
    //Start at row 1 becuase row 0 is the column names
    loadTable.add(pokeMon(
        dexCsv[i][0],
        dexCsv[i][1],
        dexCsv[i][2],
        dexCsv[i][3],
        dexCsv[i][4],
        dexCsv[i][5],
        dexCsv[i][6],
        dexCsv[i][7],
        dexCsv[i][8],
        dexCsv[i][9],
        dexCsv[i][10],
        dexCsv[i][11],
        dexCsv[i][12],
        dexCsv[i][13],
        dexCsv[i][14],
        dexCsv[i][15]));
    print(dexCsv[i][0].toString());
  }
  return loadTable;
}

List<String> typeTableLoad() {
  List<String> typeTable = [];

  typeTable.add('Grass');
  typeTable.add('Bug');
  typeTable.add('Dark');
  typeTable.add('Dragon');
  typeTable.add('Electric');
  typeTable.add('Fairy');
  typeTable.add('Fighting');
  typeTable.add('Fire');
  typeTable.add('Flying');
  typeTable.add('Ghost');
  typeTable.add('Ground');
  typeTable.add('Ice');
  typeTable.add('Normal');
  typeTable.add('Poison');
  typeTable.add('Psychic');
  typeTable.add('Rock');
  typeTable.add('Steel');
  typeTable.add('Water');

  return typeTable;
}
