import '../../../core/data/data_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: SizedBox(
        height: 220,
        child: Stack(
          children: [
            PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 60,
                startDegreeOffset: -90,
                sections: _buildPieChartSelectionData(context),
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<DataProvider>(
                    builder: (context, dataProvider, child) {
                      return Text(
                        '${0}', // TODO: should complete Make this order number dynamic by calling calculateOrdersWithStatus
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          height: 0.5,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Orders",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSelectionData(BuildContext context) {
    final DataProvider dataProvider = Provider.of<DataProvider>(context);

    // TODO: should complete Make this order number dynamic by calling calculateOrdersWithStatus
    int totalOrder = 0;
    int pendingOrder = 0;
    int processingOrder = 0;
    int cancelledOrder = 0;
    int shippedOrder = 0;
    int deliveredOrder = 0;

    return [
      PieChartSectionData(
        color: Color(0xFFB4D8F7),
        value: pendingOrder.toDouble(),
        showTitle: false,
        radius: 22,
      ),
      PieChartSectionData(
        color: Color(0xFF98C1E0),
        value: cancelledOrder.toDouble(),
        showTitle: false,
        radius: 22,
      ),
      PieChartSectionData(
        color: Color(0xFF72A7D1),
        value: shippedOrder.toDouble(),
        showTitle: false,
        radius: 22,
      ),
      PieChartSectionData(
        color: Color(0xFF4D8DC2),
        value: deliveredOrder.toDouble(),
        showTitle: false,
        radius: 22,
      ),
      PieChartSectionData(
        color: Color(0xFF2974B3),
        value: processingOrder.toDouble(),
        showTitle: false,
        radius: 22,
      ),
    ];
  }
}
