import 'package:code_icons/data/model/data_model/unlimited_Data_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:intl/intl.dart';
import 'package:code_icons/domain/entities/unlimited_Collection_entity/unlimited_collection_entity.dart';

class UnlimitedCollectionsDataSource extends DataGridSource {
  final List<UnRegisteredCollectionEntity> collections;
  final void Function(UnRegisteredCollectionEntity row) onRowSelected;

  UnlimitedCollectionsDataSource({
    required this.collections,
    required this.onRowSelected,
  }) {
    _collections = collections.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        /*  DataGridCell<int>(columnName: 'collectionId', value: dataGridRow.idBl), */
        DataGridCell<String>(
            columnName: 'unlimitedName', value: dataGridRow.brandNameBl),
        DataGridCell<String>(
            columnName: 'unlimitedActivity', value: dataGridRow.activityBl),
        DataGridCell<String>(
            columnName: 'unlimitedAddress', value: dataGridRow.addressBl),
        DataGridCell<String>(
            columnName: 'unlimitedPaymentReceipt',
            value: dataGridRow.receiptBl),
        DataGridCell<String>(
            columnName: 'unlimitedPaymentReceiptDate',
            value: DateFormat('y/MM/dd')
                .format(DateTime.parse(dataGridRow.receiptDateBl ?? ""))),
        DataGridCell<double>(
            columnName: 'unlimitedDivision', value: dataGridRow.divisionBl),
        DataGridCell<double>(
            columnName: 'unlimitedCurrentFinance',
            value: dataGridRow.currentBl),
        DataGridCell<double>(
            columnName: 'unlimitedTotalFinance', value: dataGridRow.totalBl),
      ]);
    }).toList();
  }

  List<DataGridRow> _collections = [];

  List<DataGridRow> get rows => _collections;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      color: Colors.transparent,
      cells: row.getCells().map<Widget>((dataGridCell) {
        return GestureDetector(
          onTap: () {
            final entity = UnRegisteredCollectionEntity(
              idBl: dataGridCell.columnName == 'collectionId'
                  ? dataGridCell.value as int
                  : 0,
              brandNameBl: dataGridCell.columnName == 'unlimitedName'
                  ? dataGridCell.value as String
                  : '',
              activityBl: dataGridCell.columnName == 'unlimitedActivity'
                  ? dataGridCell.value as String
                  : '',
              addressBl: dataGridCell.columnName == 'unlimitedAddress'
                  ? dataGridCell.value as String
                  : '',
              receiptBl: dataGridCell.columnName == 'unlimitedPaymentReceipt'
                  ? dataGridCell.value as String
                  : '',
              receiptDateBl:
                  dataGridCell.columnName == 'unlimitedPaymentReceiptDate'
                      ? dataGridCell.value.toString()
                      : '',
              divisionBl: dataGridCell.columnName == 'unlimitedDivision'
                  ? dataGridCell.value as double
                  : 0.0,
              currentBl: dataGridCell.columnName == 'unlimitedCurrentFinance'
                  ? dataGridCell.value as double
                  : 0.0,
              totalBl: dataGridCell.columnName == 'unlimitedTotalFinance'
                  ? dataGridCell.value as double
                  : 0.0,
            );
            onRowSelected(entity);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                dataGridCell.value.toString(),
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
