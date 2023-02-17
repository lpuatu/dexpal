import 'package:flutter/material.dart';
import 'package:DexPal/pokeMon.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;

class specificStat {
  final String statName;
  final int statValue;
  final Color color;

  specificStat(this.statName, this.statValue, this.color);
}

Color getColor(int value) {
  Color color = Colors.pink;
  if (value <= 50) {
    return Colors.red;
  } else if (value < 100 && value > 50) {
    return Colors.orange;
  } else if (value >= 100 && value < 200) {
    return Colors.green;
  } else if (value >= 200) {
    return Colors.blue;
  }

  return color;
}

class statChart extends StatelessWidget {
  final pokeMon pokeStat;

  statChart({required this.pokeStat});

  late final List<specificStat> data = [
    specificStat('HP', pokeStat.hp, getColor(pokeStat.hp)),
    specificStat('ATK', pokeStat.atk, getColor(pokeStat.atk)),
    specificStat('DEF', pokeStat.def, getColor(pokeStat.def)),
    specificStat('SPA', pokeStat.spa, getColor(pokeStat.spa)),
    specificStat('SPD', pokeStat.spd, getColor(pokeStat.spd)),
    specificStat('SPE', pokeStat.spe, getColor(pokeStat.spe)),
  ];

  @override
  Widget build(BuildContext context) {
    List<charts.Series<specificStat, String>> series = [
      charts.Series(
        id: "Stats",
        data: data,
        domainFn: (specificStat series, _) => series.statName,
        measureFn: (specificStat series, _) => series.statValue,
        colorFn: (specificStat series, _) =>
            charts.ColorUtil.fromDartColor(series.color),
        labelAccessorFn: (specificStat series, _) =>
            series.statValue.toString(),
      )
    ];
    return charts.BarChart(
      series,
      animate: false,
      vertical: false,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.NoneRenderSpec(),
        tickProviderSpec:
            charts.BasicNumericTickProviderSpec(desiredTickCount: 10),
        viewport: charts.NumericExtents(0, 200),
      ),
    );
  }
}
