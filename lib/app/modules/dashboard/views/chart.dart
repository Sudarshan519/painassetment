import 'package:flutter/material.dart';
import 'package:paymentmanagement/app/data/models/sales.dart';
import 'package:syncfusion_flutter_charts/charts.dart'; 
class ChartWidget extends StatelessWidget {
  const ChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

       Row(children: [
            Expanded(
              child: const Text(
                "Transaction Payment",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const Spacer(),
            Container(
              // padding: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // boxShadow: [BoxShadow(color: Colors.grey)],
                  border: Border.all(color: Colors.grey, width: 1)),
              child: DropdownButton(
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Colors.green[100],
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.teal,
                  ),
                  underline: SizedBox(),
                  iconDisabledColor: Colors.transparent,
                  iconEnabledColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  value: '',
                  items: const [
                    DropdownMenuItem(
                      child: Text(" Monthly "),
                      value: '',
                    ),
                    DropdownMenuItem(
                      child: Text("Daily"),
                      value: 'd',
                    ),
                    DropdownMenuItem(
                      child: Text("Yearly"),
                      value: 'y',
                    ),
                    DropdownMenuItem(
                      child: Text("Monthly"),
                      value: 'm',
                    ),
                  ],
                  onChanged: (v) {}),
            ),
        
       ],),
       Container(color:Colors.white,
          height: 300,
          width: double.infinity,
          child: SfCartesianChart(  
          
          // trackballBehavior: TrackballBehavior(
            
          //       activationMode: ActivationMode.singleTap,
          //         tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
          //       enable: true,
          //     ),
            borderColor: Colors.white,

    //          crosshairBehavior:  CrosshairBehavior(
    //   enable: true,
    //   activationMode: ActivationMode.doubleTap,
    //   hideDelay: 2000,
    //   shouldAlwaysShow: false,
    //   lineType: CrosshairLineType.both,
    //   lineWidth: 1
    // ),
            plotAreaBorderWidth: 0,
            backgroundColor: Colors.transparent,
            
              primaryXAxis: CategoryAxis(
             
              interactiveTooltip: InteractiveTooltip(enable: true),
                 majorGridLines: const MajorGridLines(width: 0), 
              ),
            primaryYAxis: NumericAxis(
                axisLine: AxisLine(width: 0, color: Colors.transparent),
                interactiveTooltip: InteractiveTooltip(enable: true),
                // majorGridLines: const MajorGridLines(width: 0),
                minorGridLines: const MinorGridLines(width: 0)

            ), // Chart title
              title: ChartTitle(text: 'Transaction Analysis'),
              // Enable legend
              
              legend: Legend(isVisible: true,position: LegendPosition.bottom),
              // Enable tooltip
            
              
              series: <ChartSeries<SalesData, String>>[
                LineSeries<SalesData, String>( 
                    dataSource: data,
                    enableTooltip: true,
                    
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales,
                    name: 'Outgoing', 
                  //  dataLabelSettings: const DataLabelSettings(isVisible: true,color: Colors.red),
                    color: Colors.red),
                      LineSeries<SalesData, String>(
                    dataSource: data1,
                    enableTooltip: true,
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales,
                    name: 'Incoming', 
                  // dataLabelSettings: const DataLabelSettings(isVisible: true,color: Colors.green),
                    color: Colors.green)
              ],
            tooltipBehavior: TooltipBehavior(
              enable: true,
            ),
          ),
        ),
      ],
    );
  }
}
