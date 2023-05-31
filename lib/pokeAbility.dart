import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class PokeAbility extends StatefulWidget {
  final String abilityName;

  const PokeAbility({required this.abilityName});

  @override
  State<PokeAbility> createState() => PokeAbilityState();
}

class PokeAbilityState extends State<PokeAbility> {
  bool isLoading = true;
  String abilityDesc = '';

  Future<void> loadCsvData() async {
    setState(() {
      isLoading = true;
    });

    final ability = await rootBundle.loadString("assets/ability.csv");
    List<List<dynamic>> abilityCsv =
        const CsvToListConverter().convert(ability);

    for (int i = 1; i < abilityCsv.length; i++) {
      if (abilityCsv[i][0] == widget.abilityName.toLowerCase()) {
        abilityDesc = abilityCsv[i][2];
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadCsvData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PokeAbility'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              abilityDesc,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
