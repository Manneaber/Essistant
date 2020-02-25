import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class OverviewChart extends StatelessWidget {
  final List<Series> seriesList;
  final bool animate;

  OverviewChart(this.seriesList, {this.animate});

  factory OverviewChart.withSampleData() {
    return OverviewChart(
      _createSampleData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      seriesList,
      animate: animate,
      defaultRenderer: BarRendererConfig(
        cornerStrategy: const ConstCornerStrategy(30),
        strokeWidthPx: 0,
      ),
      barRendererDecorator: BarLabelDecorator<String>(),
      primaryMeasureAxis: NumericAxisSpec(renderSpec: NoneRenderSpec()),
      layoutConfig: LayoutConfig(
        leftMarginSpec: MarginSpec.fixedPixel(0),
        topMarginSpec: MarginSpec.defaultSpec,
        rightMarginSpec: MarginSpec.fixedPixel(0),
        bottomMarginSpec: MarginSpec.defaultSpec,
      ),
      domainAxis: OrdinalAxisSpec(
        showAxisLine: false,
        renderSpec: SmallTickRendererSpec(
          labelStyle: TextStyleSpec(fontSize: 14, color: MaterialPalette.white),
          lineStyle: LineStyleSpec(color: MaterialPalette.white),
        ),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<Series<LinearSales, String>> _createSampleData() {
    final data = [
      LinearSales('จ', 1),
      LinearSales('อ', 2),
      LinearSales('พ', 0),
      LinearSales('พฤ', 3),
      LinearSales('ศ', 1),
      LinearSales('ส', 0),
      LinearSales('อา', 1),
    ];

    return [
      Series<LinearSales, String>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.day,
        measureFn: (LinearSales sales, _) => sales.sales,
        colorFn: (LinearSales sales, _) => Color.white,
        labelAccessorFn: (LinearSales sales, _) => '\$${sales.sales.toString()}',
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final String day;
  final int sales;

  LinearSales(this.day, this.sales);
}
