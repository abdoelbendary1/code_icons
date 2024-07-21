import 'package:code_icons/data/model/response/get_customer_data.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

enum CustomerDataEnum {
  idBL,
  brandNameBL,
  nationalIdBL,
  birthDayBL,
  tradeRegistryBL,
  licenseDateBL,
  licenseYearBL,
  capitalBL,
  companyTypeNameBL,
  tradeOfficeNameBL,
  activityNameBL,
  divisionBL,
  tradeTypeBL,
  addressBL,
  stationNameBL,
  phoneBL,
}

class CustomerDataSource extends DataGridSource {
  List<CustomerDataEntity> customers;

  CustomerDataSource(this.customers) {
    buildDataGridRows();
  }

  List<DataGridRow> dataGridRows = [];

  void buildDataGridRows() {
    dataGridRows = customers.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        /* DataGridCell<int>(columnName: 'idBL', value: dataGridRow.idBl), */
        DataGridCell<String>(
            columnName: 'brandNameBL', value: dataGridRow.brandNameBl),
        DataGridCell<String>(
            columnName: 'nationalIdBL', value: dataGridRow.nationalIdBl),
        DataGridCell<DateTime>(
            columnName: 'birthDayBL',
            value: DateTime.tryParse(dataGridRow.birthDayBl ?? "")),
        DataGridCell<String>(
            columnName: 'tradeRegistryBL', value: dataGridRow.tradeRegistryBl),
        DataGridCell<DateTime>(
            columnName: 'licenseDateBL',
            value: DateTime.tryParse(dataGridRow.licenseDateBl ?? "")),
        DataGridCell<int>(
            columnName: 'licenseYearBL', value: dataGridRow.licenseYearBl),
        DataGridCell<double>(
            columnName: 'capitalBL', value: dataGridRow.capitalBl),
        DataGridCell<int>(columnName: 'validBL', value: dataGridRow.validBl),
        DataGridCell<String>(
            columnName: 'companyTypeNameBL',
            value: dataGridRow.companyTypeNameBl),
        DataGridCell<String>(
            columnName: 'tradeOfficeNameBL',
            value: dataGridRow.tradeOfficeNameBl),
        DataGridCell<String>(
            columnName: 'activityNameBL', value: dataGridRow.activityNameBl),
        DataGridCell<String>(
            columnName: 'divisionBL', value: dataGridRow.divisionBl),
        DataGridCell<String>(
            columnName: 'tradeTypeBL', value: dataGridRow.tradeTypeBl),
        DataGridCell<String>(columnName: 'ownerBL', value: dataGridRow.ownerBl),
        DataGridCell<String>(
            columnName: 'addressBL', value: dataGridRow.addressBl),
        DataGridCell<String>(
            columnName: 'stationNameBL', value: dataGridRow.stationNameBl),
        DataGridCell<String>(columnName: 'phoneBL', value: dataGridRow.phoneBl),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        CustomerDataEnum? dataEnum = CustomerDataEnum.values.firstWhere(
          (e) => e.toString().split('.').last == dataGridCell.columnName,
          orElse: () => CustomerDataEnum.values.last,
        );

        return buildCell(dataEnum, dataGridCell);
      }).toList(),
    );
  }

  Widget buildCell(CustomerDataEnum dataEnum, DataGridCell dataGridCell) {
    switch (dataEnum) {
      case CustomerDataEnum.idBL:
        return buildIdCell(dataGridCell.value.toString());
      case CustomerDataEnum.brandNameBL:
        return buildBrandNameCell(dataGridCell.value.toString());
      case CustomerDataEnum.nationalIdBL:
        return buildNationalIdCell(dataGridCell.value.toString());
      /* case CustomerDataEnum.birthDayBL:
        return buildBirthDayCell(dataGridCell.value ?? DateTime.now()); */
      case CustomerDataEnum.tradeRegistryBL:
        return buildTradeRegistryCell(dataGridCell.value.toString());
      /* case CustomerDataEnum.licenseDateBL:
        return buildLicenseDateCell(dataGridCell.value ?? DateTime.now()); */
      case CustomerDataEnum.licenseYearBL:
        return buildLicenseYearCell(dataGridCell.value.toString());
      case CustomerDataEnum.capitalBL:
        return buildCapitalCell(dataGridCell.value.toString());
      case CustomerDataEnum.companyTypeNameBL:
        return buildCompanyTypeNameCell(dataGridCell.value.toString());
      case CustomerDataEnum.tradeOfficeNameBL:
        return buildTradeOfficeNameCell(dataGridCell.value.toString());
      case CustomerDataEnum.activityNameBL:
        return buildActivityNameCell(dataGridCell.value.toString());
      case CustomerDataEnum.divisionBL:
        return buildDivisionCell(dataGridCell.value.toString());
      case CustomerDataEnum.tradeTypeBL:
        return buildTradeTypeCell(dataGridCell.value.toString());
      case CustomerDataEnum.addressBL:
        return buildAddressCell(dataGridCell.value.toString());
      case CustomerDataEnum.stationNameBL:
        return buildStationNameCell(dataGridCell.value.toString());
      case CustomerDataEnum.phoneBL:
        return buildPhoneCell(dataGridCell.value.toString());
      default:
        return buildDefaultCell(dataGridCell.value.toString());
    }
  }

  Widget buildIdCell(String value) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8.0),
      child: Text(
        value,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget buildBrandNameCell(String value) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8.0),
      child: Text(
        value,
        style: TextStyle(color: Colors.yellow),
      ),
    );
  }

  Widget buildNationalIdCell(String value) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8.0),
      child: Text(
        value,
        style: TextStyle(color: Colors.green),
      ),
    );
  }

  Widget buildBirthDayCell(DateTime value) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8.0),
      child: Text(
        value.toIso8601String(),
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  Widget buildTradeRegistryCell(String value) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8.0),
      child: Text(
        value,
        style: TextStyle(color: Colors.purple),
      ),
    );
  }

  Widget buildLicenseDateCell(DateTime value) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8.0),
      child: Text(
        value.toIso8601String(),
        style: TextStyle(color: Colors.orange),
      ),
    );
  }

  Widget buildLicenseYearCell(String value) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8.0),
      child: Text(
        value,
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget buildCapitalCell(String value) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8.0),
      child: Text(
        value,
        style: TextStyle(color: Colors.cyan),
      ),
    );
  }

  Widget buildCompanyTypeNameCell(String value) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8.0),
      child: Text(
        value,
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  Widget buildTradeOfficeNameCell(String value) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8.0),
      child: Text(
        value,
        style: TextStyle(color: Colors.brown),
      ),
    );
  }

  Widget buildActivityNameCell(String value) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8.0),
      child: Text(
        value,
        style: TextStyle(color: Colors.lime),
      ),
    );
  }

  Widget buildDivisionCell(String value) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8.0),
      child: Text(
        value,
        style: TextStyle(color: Colors.indigo),
      ),
    );
  }

  Widget buildTradeTypeCell(String value) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8.0),
      child: Text(
        value,
        style: TextStyle(color: Colors.teal),
      ),
    );
  }

  Widget buildAddressCell(String value) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8.0),
      child: Text(
        value,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget buildStationNameCell(String value) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8.0),
      child: Text(
        value,
        style: TextStyle(color: Colors.blueGrey),
      ),
    );
  }

  Widget buildPhoneCell(String value) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8.0),
      child: Text(
        value,
        style: TextStyle(color: Colors.lightGreen),
      ),
    );
  }

  Widget buildDefaultCell(String value) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8.0),
      child: Text(
        value,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
