// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Flutter Chart Example'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: BarChart(
//             BarChartData(
//               alignment: BarChartAlignment.spaceAround,
//               maxY: 6,
//               titlesData: FlTitlesData(
//                 leftTitles: SideTitles(showTitles: true),
//                 bottomTitles: SideTitles(showTitles: true),
//               ),
//               borderData: FlBorderData(
//                 show: true,
//                 border: Border.all(
//                   color: const Color(0xff37434d),
//                   width: 1,
//                 ),
//               ),
//               barGroups: [
//                 BarChartGroupData(
//                   x: 0,
//                   barRods: [
//                     BarChartRodData(y: 3, ),
//                   ],
//                 ),
//                 BarChartGroupData(
//                   x: 1,
//                   barRods: [
//                     BarChartRodData(y: 4, ),
//                   ],
//                 ),
//                 BarChartGroupData(
//                   x: 2,
//                   barRods: [
//                     BarChartRodData(y: 2, ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
