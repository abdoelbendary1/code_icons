import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/cubit/all_daily_collector_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';

class CollectionsDataSource extends DataGridSource {
  final List<TradeCollectionEntity> collections;
  final void Function(int skip, int take)
      onPageChange; // Callback for pagination
  final void Function(TradeCollectionEntity row) onRowSelected;
  AllDailyCollectorCubit allDailyCollectorCubit;
  BuildContext context;

  CollectionsDataSource({
    required this.collections,
    required this.onPageChange,
    required this.onRowSelected,
    required this.allDailyCollectorCubit,
    required this.context,
  }) {
    _collections = collections.map<DataGridRow>((dataGridRow) {
      /*  print("id : ${dataGridRow.customerDataIdBl}"); */

      return DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'brandNameBl',
            value: dataGridRow.brandNameBl ?? "Unknown"),
      // Assuming "address" is not available
        DataGridCell<String>(
          columnName: 'collectionDateBl',
          value: dataGridRow.collectionDateBl != null
              ? DateFormat('y/MM/dd')
                  .format(DateTime.parse(dataGridRow.collectionDateBl!))
              : "N/A",
        ),
        DataGridCell<String>(
            columnName: 'paymentReceiptNumBl',
            value: dataGridRow.paymentReceiptNumBl ?? "N/A"),
        DataGridCell<double>(
            columnName: 'compensationBl',
            value: _convertToDouble(dataGridRow.compensationBl)),
        DataGridCell<double>(
            columnName: 'lateBl', value: _convertToDouble(dataGridRow.lateBl)),
        DataGridCell<double>(
            columnName: 'currentBl',
            value: _convertToDouble(dataGridRow.currentBl)),
        const DataGridCell<String>(
            columnName: 'activityBl',
            value: "N/A"), // Assuming activityBl is not available
        const DataGridCell<String>(
            columnName: 'tradeRegistryTypeBl',
            value: "N/A"), // Assuming tradeRegistryTypeBl is not available
        DataGridCell<double>(
            columnName: 'differentBl',
            value: _convertToDouble(dataGridRow.differentBl)),
        DataGridCell<double>(
            columnName: 'totalBl',
            value: _convertToDouble(dataGridRow.totalBl)),
       
        DataGridCell<double>(
            columnName: 'customerDataIdBl',
            value: _convertToDouble(dataGridRow.customerDataIdBl)),
        DataGridCell<double>(
            columnName: 'lastPaidYearBl',
            value: _convertToDouble(dataGridRow.lastPaidYearBl)),
        DataGridCell<double>(
            columnName: 'capitalBl',
            value: _convertToDouble(dataGridRow.capitalBl)),
        DataGridCell<String>(
            columnName: 'collectorNameBl',
            value: dataGridRow.collectorNameBl?.toString() ?? "N/A"),
        DataGridCell<String>(
            columnName: 'brandNameBl',
            value: dataGridRow.brandNameBl ?? "Unknown"),
        DataGridCell<String>(
            columnName: 'tradeRegistryBl',
            value: dataGridRow.tradeRegistryBl ?? "Unknown"),
      ]);
    }).toList();
  }

  List<DataGridRow> _collections = [];

  List<DataGridRow> get rows => _collections;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    bool isSelected = rows.contains(row);
    return DataGridRowAdapter(
      color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
      cells: row.getCells().map<Widget>((dataGridCell) {
        return GestureDetector(
          onTap: () {
            final entity = TradeCollectionEntity(
              collectionDateBl: dataGridCell.columnName == 'collectionDateBl'
                  ? dataGridCell.value.toString()
                  : null,
              paymentReceiptNumBl:
                  dataGridCell.columnName == 'paymentReceiptNumBl'
                      ? dataGridCell.value.toString()
                      : null,
              compensationBl: dataGridCell.columnName == 'compensationBl'
                  ? dataGridCell.value
                  : null,
              lateBl: dataGridCell.columnName == 'lateBl'
                  ? dataGridCell.value
                  : null,
              currentBl: dataGridCell.columnName == 'currentBl'
                  ? dataGridCell.value
                  : null,
              differentBl: dataGridCell.columnName == 'differentBl'
                  ? dataGridCell.value
                  : null,
              totalBl: dataGridCell.columnName == 'totalBl'
                  ? dataGridCell.value
                  : null,
              brandNameBl: dataGridCell.columnName == 'customerName'
                  ? dataGridCell.value
                  : null,
            );
            onRowSelected(entity);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              /* decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ), */
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Text(
                dataGridCell.value.toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }).toList(),
    );
  } // Helper function to convert int or null to double

  double? _convertToDouble(dynamic value) {
    if (value == null) {
      return null;
    }
    return value is int ? value.toDouble() : value as double?;
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int skip = newPageIndex * 20;
    onPageChange(skip, 20); // Trigger loading more data
    return true;
  }
}
