import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/cubit/all_daily_collector_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:code_icons/domain/entities/TradeCollection/trade_collection_entity.dart';

class CollectionsDataSource extends DataGridSource {
  final List<TradeCollectionEntity> collections;
  final void Function(TradeCollectionEntity row) onRowSelected;
  AllDailyCollectorCubit allDailyCollectorCubit;
  BuildContext context;

  CollectionsDataSource({
    required this.collections,
    required this.onRowSelected,
    required this.allDailyCollectorCubit,
    required this.context,
  }) {
    _collections = collections.map<DataGridRow>((dataGridRow) {
      /*  print("id : ${dataGridRow.customerDataIdBl}"); */

      return DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'customerName',
            value: allDailyCollectorCubit
                    .getCustomerById(dataGridRow.customerDataIdBl!)
                    .brandNameBl ??
                "Unknown"),
        DataGridCell<String>(
            columnName: 'address',
            value: allDailyCollectorCubit
                    .getCustomerById(dataGridRow.customerDataIdBl!)
                    .addressBl ??
                "Unknown"),
        DataGridCell<String>(
          columnName: 'collectionDateBl',
          value: DateFormat('y/MM/dd')
              .format(DateTime.parse(dataGridRow.collectionDateBl!)),
        ),
        DataGridCell<String>(
            columnName: 'paymentReceiptNumBl',
            value: dataGridRow.paymentReceiptNumBl),
        DataGridCell<double>(
            columnName: 'compensationBl', value: dataGridRow.compensationBl),
        DataGridCell<double>(columnName: 'lateBl', value: dataGridRow.lateBl),
        DataGridCell<double>(
            columnName: 'currentBl', value: dataGridRow.currentBl),
        DataGridCell<double>(
            columnName: 'differentBl', value: dataGridRow.differentBl),
        DataGridCell<double>(columnName: 'totalBl', value: dataGridRow.totalBl),
        /*  DataGridCell<int>(
            columnName: 'customerDataIdBl',
            value: dataGridRow.customerDataIdBl), */
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
                  ? dataGridCell.value as double
                  : null,
              currentBl: dataGridCell.columnName == 'currentBl'
                  ? dataGridCell.value as double
                  : null,
              differentBl: dataGridCell.columnName == 'differentBl'
                  ? dataGridCell.value as double
                  : null,
              totalBl: dataGridCell.columnName == 'totalBl'
                  ? dataGridCell.value as double
                  : null,
              /*    customerDataIdBl: dataGridCell.columnName == 'customerDataIdBl'
                  ? dataGridCell.value as int?
                  : null, */
              cutomerName: dataGridCell.columnName == 'customerName'
                  ? dataGridCell.value as String?
                  : null,
              address: dataGridCell.columnName == 'address'
                  ? dataGridCell.value as String?
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
                style: const TextStyle(color: Colors.black87, fontSize: 15),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
