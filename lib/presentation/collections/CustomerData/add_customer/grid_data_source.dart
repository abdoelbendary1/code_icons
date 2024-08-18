import 'package:code_icons/data/model/response/collections/get_customer_data.dart';
import 'package:code_icons/domain/entities/Customer%20Data/customer_data_entity.dart';
import 'package:code_icons/presentation/collections/CustomerData/cubit/customers_cubit.dart';
import 'package:code_icons/presentation/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  var customersCubit = CustomersCubit.customersCubit;

  List<DataGridRow> dataGridRows = [];

  void buildDataGridRows() {
    dataGridRows = customers.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'brandNameBL', value: dataGridRow.brandNameBl),
        DataGridCell<String>(
            columnName: 'addressBL', value: dataGridRow.addressBl),
        DataGridCell<String>(
            columnName: 'nationalIdBL', value: dataGridRow.nationalIdBl),
        DataGridCell<String>(
            columnName: 'tradeRegistryBL', value: dataGridRow.tradeRegistryBl),
        DataGridCell<DateTime>(
            columnName: 'licenseDateBL',
            value: DateTime.tryParse(dataGridRow.licenseDateBl ?? "")),
        DataGridCell<String>(
            columnName: 'activityNameBL', value: dataGridRow.activityNameBl),
        DataGridCell<String>(
            columnName: 'tradeOfficeNameBL',
            value: dataGridRow.tradeOfficeNameBl),
        DataGridCell<double>(
            columnName: 'capitalBL', value: dataGridRow.capitalBl),
        DataGridCell<String>(
            columnName: 'tradeRegistryTypeBl',
            value:
                customersCubit.getTypeById(dataGridRow.tradeRegistryTypeBl!)),

        /* DataGridCell<int>(columnName: 'idBL', value: dataGridRow.idBl), */
        /*  DataGridCell<String>(
            columnName: 'brandNameBL', value: dataGridRow.brandNameBl),
        DataGridCell<String>(
            columnName: 'addressBL', value: dataGridRow.addressBl),
        DataGridCell<int>(
            columnName: 'licenseYearBL', value: dataGridRow.licenseYearBl),
        DataGridCell<String>(columnName: 'phoneBL', value: dataGridRow.phoneBl),
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
            columnName: 'stationNameBL', value: dataGridRow.stationNameBl), */
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

  String convertStringToDate({required String inputString}) {
    if (inputString.isNotEmpty) {
      DateFormat inputFormat = DateFormat('yyyy/MM/dd');
      // Parse the input string into a DateTime object
      DateTime dateTime = inputFormat.parse(inputString);

      // Define the output format
      DateFormat outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      // Format the DateTime object into the desired output format
      String formattedDate = outputFormat.format(dateTime);
      return formattedDate;
    }
    return "";
  }

  String formatDate(DateTime date) {
    return '${date.year}/${date.month}/${date.day}';
  }

  Widget buildCell(CustomerDataEnum dataEnum, DataGridCell dataGridCell) {
    switch (dataEnum) {
      case CustomerDataEnum.idBL:
        return buildIdCell(dataGridCell.value.toString());
      case CustomerDataEnum.brandNameBL:
        return buildBrandNameCell(dataGridCell.value.toString());
      case CustomerDataEnum.nationalIdBL:
        return buildNationalIdCell(dataGridCell.value.toString());
      case CustomerDataEnum.birthDayBL:
        return buildBirthDayCell(dataGridCell.value ?? DateTime.now());
      case CustomerDataEnum.tradeRegistryBL:
        return buildTradeRegistryCell(dataGridCell.value.toString());
      case CustomerDataEnum.licenseDateBL:
        return buildLicenseDateCell(dataGridCell.value ?? DateTime.now());
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
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget buildBrandNameCell(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          value,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildNationalIdCell(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          value,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildBirthDayCell(DateTime value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          formatDate(value),
          /* value.toIso8601String(), */
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildTradeRegistryCell(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          value,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildLicenseDateCell(DateTime value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          formatDate(value),
          /* value.year.toString(), */
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildLicenseYearCell(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          value,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildCapitalCell(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          value,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildCompanyTypeNameCell(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          value,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildTradeOfficeNameCell(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          value,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildActivityNameCell(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          value,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildDivisionCell(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          value,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildTradeTypeCell(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          value,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildAddressCell(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          value,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildStationNameCell(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          value,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildPhoneCell(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          value,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildDefaultCell(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          value,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
