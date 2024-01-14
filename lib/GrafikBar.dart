// import 'package:flutter/material.dart';
// import 'Sale.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// class GrafikBar extends StatelessWidget {
//   final List<Sale> data;

//   GrafikBar(this.data);

//   @override
//   Widget build(BuildContext context) {
//     var series = [
//       charts.Series<Sale, int>(
//         id: 'Grafik',
//         data: data,
//         domainFn: (Sale sales, _) => sales.day,
//         measureFn: (Sale sales, _) => sales.penjualan,
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//         labelAccessorFn: (Sale sales, _) =>
//             '\$${sales.penjualan.toStringAsFixed(2)}',
//       ),
//     ];

//     return charts.BarChart(
//       series.cast<charts.Series<dynamic, String>>(),
//       animate: true,
//       barGroupingType: charts.BarGroupingType.grouped,
//     );
//   }
// }
