import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/orders/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/utils/constants.dart';

class OrderDetailView extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          backgroundColor: Appearance.backGroundColor,
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Check out device',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order detail'),
                          Divider(),
                          Text('OrderID: ${controller.autoOrderId}'),
                          Expanded(
                              child: Container(
                            child: SingleChildScrollView(
                              child: DataTable(
                                columns: createColumn(controller.orderColumn),
                                rows: createRow(list: controller.listCartDevice),
                              ),
                            ),
                          )),
                          Divider(),
                          Container(
                            height: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    children: [Text('Total')],
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [Text('100000 Total')],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<DataColumn> createColumn(List<String> orderColumn) =>
      orderColumn.map((column) => DataColumn(label: Text(column))).toList();

  List<DataRow> createRow({required RxList<Device> list}) => list.map((device) {
        int index = list.indexOf(device);
        return DataRow(cells: [
          DataCell(Text('${index + 1}')),
          DataCell(Text(device.model.toString())),
          DataCell(Text(device.price.toString())),
          DataCell(
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {},
                ),
                Text('0'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ]);
      }).toList();
// List<DataRow> createRow() => List.generate(
//       5,
//       (index) => DataRow(
//         cells: [
//           DataCell(Text('${index + 1}')),
//           DataCell(Text('Model')),
//           DataCell(Text('Price')),
//           DataCell(
//             Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.remove),
//                   onPressed: () {},
//                 ),
//                 Text('0'),
//                 IconButton(
//                   icon: Icon(Icons.add),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
}
