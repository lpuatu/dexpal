import 'package:flutter/material.dart';
import 'package:DexPal/pokeMon.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;

class specificStat {
  final String statName;
  final int statValue;

  specificStat(this.statName, this.statValue);
}

class statChart extends StatelessWidget {
  final pokeMon pokeStat;

  statChart({required this.pokeStat});

  late final List<specificStat> data = [
    specificStat('HP', pokeStat.hp),
    specificStat('ATK', pokeStat.atk),
    specificStat('DEF', pokeStat.def),
    specificStat('SPA', pokeStat.spa),
    specificStat('SPD', pokeStat.spd),
    specificStat('SPE', pokeStat.spe),
  ];

  @override
  Widget build(BuildContext context) {
    List<charts.Series<specificStat, String>> series = [
      charts.Series(
        id: "Stats",
        data: data,
        domainFn: (specificStat series, _) => series.statName,
        measureFn: (specificStat series, _) => series.statValue,
      )
    ];
    return charts.BarChart(
      series,
      animate: false,
      vertical: false,
    );
  }
}
