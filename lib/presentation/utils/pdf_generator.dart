import 'dart:io';
import 'dart:typed_data';

import 'package:code_icons/data/model/request/add_purchase_request/invoice/invoice_item_details_dm.dart';
import 'package:code_icons/presentation/Sales/Invoice/cubit/SalesInvoiceCubit_cubit.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfGenerator {
  static late pw.Font arFont;

  // Initialize the Arabic font
  static init() async {
    arFont =
        pw.Font.ttf((await rootBundle.load("assets/fonts/Cairo-Bold.ttf")));
  }

  // Create PDF and open it
  static Future<void> createPdf(
      {required List<InvoiceItemDetailsDm> selectedItemsList,
      required SalesInvoiceCubit salesInvoiceCubit}) async {
    // Get the directory path
    String path = (await getApplicationDocumentsDirectory()).path;

    // Correctly build the file path (with a / separator)
    File file = File('$path/Invoice_PDF.pdf');

    // Create the PDF document
    final pdf = pw.Document();
    pdf.addPage(_createPage(selectedItemsList, salesInvoiceCubit));

    // Save the PDF as bytes
    Uint8List bytes = await pdf.save();

    // Write the bytes to the file
    await file.writeAsBytes(bytes);

    // Open the generated PDF file
    /*  await OpenFile.open(file.path); */
  }

  // Helper method to create a page with pagination
  static pw.MultiPage _createPage(List<InvoiceItemDetailsDm> selectedItemsList,
      SalesInvoiceCubit salesInvoiceCubit) {
    return pw.MultiPage(
      textDirection: pw.TextDirection.rtl,
      theme: pw.ThemeData.withFont(
        base: arFont,
      ),
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        List<pw.Widget> itemWidgets = [];

        // Build list of invoice items in a more compact format
        for (var item in selectedItemsList) {
          itemWidgets.add(
            pw.Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                _buildCompactRow(
                  "اسم المنتج",
                  salesInvoiceCubit.itemsList
                      .firstWhere(
                          (element) => element.itemCode1 == item.itemCode1)
                      .itemNameAr
                      .toString(),
                ),
                _buildCompactRow("الكمية", "${item.qty}"),
                _buildCompactRow(
                  "وحدة القياس",
                  salesInvoiceCubit.uomlist
                      .firstWhere((element) => element.uomId == item.uom)
                      .uom
                      .toString(),
                ),
                _buildCompactRow("نسبه الخصم", "${item.precentage}"),
                _buildCompactRow("قيمة الخصم", "${item.precentagevalue}"),
                _buildCompactRow("اجمالى الكمية", "${item.allQtyValue}"),
                _buildCompactRow("الضرائب", "${item.alltaxesvalue}"),
                if (salesInvoiceCubit.settings.supportsDimensionsBl == true)
                  _buildCompactRow("الطول", "${item.length}"),
                if (salesInvoiceCubit.settings.supportsDimensionsBl == true)
                  _buildCompactRow("العرض", "${item.width}"),
                _buildCompactRow("السعر", "${item.prprice}"),
              ],
            ),
          );
        }

        // Total calculations at the bottom of the page
        itemWidgets.add(pw.Divider(thickness: 2));
        itemWidgets.add(_buildCompactRow("إجمالي السعر",
            ControllerManager().invoiceTotalPriceController.text));
        itemWidgets.add(_buildCompactRow("إجمالي الضرائب",
            ControllerManager().invoiceTotalTaxesController.text));
        itemWidgets.add(_buildCompactRow(
            "المبلغ المدفوع", ControllerManager().invoiceNetController.text));

        return [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: itemWidgets,
          ),
        ];
      },
    );
  }

  // Helper method to create a compact row in PDF
  static pw.Widget _buildCompactRow(String label, String value) {
    return pw.Row(
      children: [
        pw.Expanded(
          child: pw.Text(
            "$label: ",
            style: pw.TextStyle(
                fontSize: 10, fontWeight: pw.FontWeight.bold, font: arFont),
          ),
        ),
        pw.Expanded(
          child: pw.Text(
            value,
            style: pw.TextStyle(fontSize: 10, font: arFont),
          ),
        ),
      ],
    );
  }
}
