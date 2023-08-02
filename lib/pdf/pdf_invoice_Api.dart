// ignore: file_names
import 'dart:io';
import 'package:date_utils/date_utils.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:redefine_sales_app/model/invoice_model.dart';
import 'package:pdf/widgets.dart';
import 'package:redefine_sales_app/pdf/pdf_api.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice, String pdf_name) async {
    final pdf = Document();

    final imageByteData =
        await rootBundle.load('lib/asset/images/pdfLogo.jpeg');
    final imageUint8List = imageByteData.buffer
        .asUint8List(imageByteData.offsetInBytes, imageByteData.lengthInBytes);
    final image = MemoryImage(imageUint8List);

    pdf.addPage(MultiPage(
      margin: const EdgeInsets.all(30),
      orientation: PageOrientation.portrait,

      pageFormat: PdfPageFormat.a3,

      build: (context) => [
        buildHeader(invoice, image),
        buildInvoice(invoice),
        builBankDetails(),
        buildTnC(),
        buidFinalBill()
        // buildTotal(invoice)
      ],
      // footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocuments(name: '${pdf_name}.pdf', pdf: pdf);
  }

  static Widget buidFinalBill() {
    return Column(children: [
      SizedBox(height: 5 * PdfPageFormat.mm),
      SizedBox(
          width: 18 * PdfPageFormat.cm,
          child: Table(
            border: TableBorder.all(color: PdfColors.grey800),
            children: [
              TableRow(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text('HSN/SAC Code ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 3.4 * PdfPageFormat.mm)),
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text('Taxable',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 3.4 * PdfPageFormat.mm))),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text('CGST %',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 3.4 * PdfPageFormat.mm))),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text('CGST',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 3.4 * PdfPageFormat.mm))),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text('SGST %',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 3.4 * PdfPageFormat.mm))),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text('SGST',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 3.4 * PdfPageFormat.mm))),
              ]),
              TableRow(children: [
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text('232')),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text('1,24,000.00')),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text('9.00%')),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text('11,160.00')),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text('9.00%')),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text('11,160.00')),
              ])
            ],
          ))
    ]);
  }

  static Widget builBankDetails() {
    return Column(children: [
      SizedBox(height: 3 * PdfPageFormat.mm),
      Row(children: [
        Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 2 * PdfPageFormat.mm,
                vertical: 2 * PdfPageFormat.mm),
            height: 3 * PdfPageFormat.cm,
            width: 8.5 * PdfPageFormat.cm,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 0.4 * PdfPageFormat.mm, color: PdfColors.grey800),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Bank Details : ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 3.4 * PdfPageFormat.mm)),
              Text("Bank Name : DI Tandems",
                  style: const TextStyle(fontSize: 3.4 * PdfPageFormat.mm)),
              Text("Branch : Nellore",
                  style: const TextStyle(fontSize: 3.4 * PdfPageFormat.mm)),
              Text("Account No. : 631005501079",
                  style: const TextStyle(fontSize: 3.4 * PdfPageFormat.mm)),
              Text("IFSC : ICIC0006310",
                  style: const TextStyle(fontSize: 3.4 * PdfPageFormat.mm)),
            ])),
        Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 2 * PdfPageFormat.mm,
                vertical: 2 * PdfPageFormat.mm),
            height: 3 * PdfPageFormat.cm,
            width: 8.5 * PdfPageFormat.cm,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 0.4 * PdfPageFormat.mm, color: PdfColors.grey800),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Total Quotation Amount in Words :",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 3.4 * PdfPageFormat.mm)),
              SizedBox(height: 1 * PdfPageFormat.mm),
              Text(
                  "Rupees One Lakh Forty Six Thousand Three Hundred Twenty only",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 3.4 * PdfPageFormat.mm))
            ])),
        Container(
            height: 3 * PdfPageFormat.cm,
            width: 5.6 * PdfPageFormat.cm,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 0.4 * PdfPageFormat.mm, color: PdfColors.grey800),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              SizedBox(height: 2.3 * PdfPageFormat.mm),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 1.5 * PdfPageFormat.mm),
                child: Text("Total Amount before Tax",
                    style: const TextStyle(fontSize: 3.4 * PdfPageFormat.mm)),
              ),
              SizedBox(height: 2.3 * PdfPageFormat.mm),
              Divider(height: 0),
              SizedBox(height: 1 * PdfPageFormat.mm),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 0.9 * PdfPageFormat.mm,
                    horizontal: 0.9 * PdfPageFormat.mm),
                child: Text("Add CGST",
                    style: const TextStyle(fontSize: 3.4 * PdfPageFormat.mm)),
              ),
              SizedBox(height: 0.7 * PdfPageFormat.mm),
              Divider(height: 0),
              SizedBox(height: 1 * PdfPageFormat.mm),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 0.9 * PdfPageFormat.mm,
                    horizontal: 0.9 * PdfPageFormat.mm),
                child: Text("Add SGST",
                    style: const TextStyle(fontSize: 3.4 * PdfPageFormat.mm)),
              ),
              SizedBox(height: 0.7 * PdfPageFormat.mm),
              Divider(height: 0),
              //SizedBox(height: 0.67 * PdfPageFormat.mm),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 1 * PdfPageFormat.mm,
                    horizontal: 0.9 * PdfPageFormat.mm),
                child: Text("Grand Total",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 3.4 * PdfPageFormat.mm)),
              ),
            ])),
        Container(
            height: 3 * PdfPageFormat.cm,
            width: 5 * PdfPageFormat.cm,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 0.4 * PdfPageFormat.mm, color: PdfColors.grey800),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              SizedBox(height: 2.3 * PdfPageFormat.mm),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 1.5 * PdfPageFormat.mm),
                child: Text("1,24,000.00",
                    style: const TextStyle(fontSize: 3.4 * PdfPageFormat.mm)),
              ),
              SizedBox(height: 2.3 * PdfPageFormat.mm),
              Divider(height: 0),
              SizedBox(height: 1 * PdfPageFormat.mm),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 0.9 * PdfPageFormat.mm,
                    horizontal: 0.9 * PdfPageFormat.mm),
                child: Text("11,160.00",
                    style: const TextStyle(fontSize: 3.4 * PdfPageFormat.mm)),
              ),
              SizedBox(height: 0.7 * PdfPageFormat.mm),
              Divider(height: 0),
              SizedBox(height: 1 * PdfPageFormat.mm),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 0.9 * PdfPageFormat.mm,
                    horizontal: 0.9 * PdfPageFormat.mm),
                child: Text("11,160.00",
                    style: const TextStyle(fontSize: 3.4 * PdfPageFormat.mm)),
              ),
              SizedBox(height: 0.7 * PdfPageFormat.mm),
              Divider(height: 0),
              //SizedBox(height: 0.67 * PdfPageFormat.mm),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 1 * PdfPageFormat.mm,
                    horizontal: 0.9 * PdfPageFormat.mm),
                child: Text("1,46,320.00",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 3.4 * PdfPageFormat.mm)),
              ),
            ])),
      ])
    ]);
  }

  static Widget buildTnC() {
    return Column(children: [
      Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 2 * PdfPageFormat.mm, vertical: 1 * PdfPageFormat.mm),
        width: 40 * PdfPageFormat.cm,
        decoration: BoxDecoration(
          border: Border.all(
              width: 0.4 * PdfPageFormat.mm, color: PdfColors.grey800),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Terms & Conditions :",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 3 * PdfPageFormat.mm,
            ),
            SizedBox(
              height: 2 * PdfPageFormat.cm,
              width: 40 * PdfPageFormat.cm,
              child: Text(
                  """.TERMS & CONDITIONS:1.All Transport charges are to be paid by the customer.2.Packing charges will be extra.3.Offer valid 5days from the date of offer.4.Complimentary are not mandatory.5.After 60days after the date of receipt of confirm order with down payment.The delivery period counted is only on indication at all times subject to delay due to the cause mentioned under the headforce majeure.TERMS OF PAYMENT:50% Down payment by D/D or by bank transfer along with order and balance 50% by bank transfer after the trail and prior to dispatch. CANCELLATION OF ORDER:Subsequently once the order is placed will not be cancelled for any reason.Incase if the order being cancelled or failure from buyers side to lift the material after 10days of our intimation ,the entire amount of advance will be forfeited.""",
                  style: const TextStyle(fontSize: 3.4 * PdfPageFormat.mm)),
            ),
            SizedBox(
              height: 0.5 * PdfPageFormat.mm,
            ),
            SizedBox(
              height: 2 * PdfPageFormat.cm,
              width: 40 * PdfPageFormat.cm,
              child: Text(
                  """.TERMS & CONDITIONS:1.All Transport charges are to be paid by the customer.2.Packing charges will be extra.3.Offer valid 5days from the date of offer.4.Complimentary are not mandatory.5.After 60days after the date of receipt of confirm order with down payment.The delivery period counted is only on indication at all times subject to delay due to the cause mentioned under the headforce majeure.TERMS OF PAYMENT:50% Down payment by D/D or by bank transfer along with order and balance 50% by bank transfer after the trail and prior to dispatch. CANCELLATION OF ORDER:Subsequently once the order is placed will not be cancelled for any reason.Incase if the order being cancelled or failure from buyers side to lift the material after 10days of our intimation ,the entire amount of advance will be forfeited.""",
                  style: const TextStyle(fontSize: 3.4 * PdfPageFormat.mm)),
            ),
            SizedBox(
              height: 0.5 * PdfPageFormat.mm,
            ),
            SizedBox(
              height: 2 * PdfPageFormat.cm,
              width: 40 * PdfPageFormat.cm,
              child: Text(
                  """.TERMS & CONDITIONS:1.All Transport charges are to be paid by the customer.2.Packing charges will be extra.3.Offer valid 5days from the date of offer.4.Complimentary are not mandatory.5.After 60days after the date of receipt of confirm order with down payment.The delivery period counted is only on indication at all times subject to delay due to the cause mentioned under the headforce majeure.TERMS OF PAYMENT:50% Down payment by D/D or by bank transfer along with order and balance 50% by bank transfer after the trail and prior to dispatch. CANCELLATION OF ORDER:Subsequently once the order is placed will not be cancelled for any reason.Incase if the order being cancelled or failure from buyers side to lift the material after 10days of our intimation ,the entire amount of advance will be forfeited.""",
                  style: const TextStyle(fontSize: 3.4 * PdfPageFormat.mm)),
            ),
            SizedBox(
              height: 20 * PdfPageFormat.mm,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "Notes : ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: 'SCAFFOLDING: 20" height')
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 2 * PdfPageFormat.cm,
        width: 40 * PdfPageFormat.cm,
        decoration: BoxDecoration(
          border: Border.all(
              width: 0.4 * PdfPageFormat.mm, color: PdfColors.grey800),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 2 * PdfPageFormat.mm,
                  vertical: 1 * PdfPageFormat.mm),
              height: 2 * PdfPageFormat.cm,
              width: 18 * PdfPageFormat.cm,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 0.4 * PdfPageFormat.mm, color: PdfColors.black),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Text("This is a computer-generated quotation"),
                    Spacer(),
                    Text("E. & O. E."),
                  ],
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 2 * PdfPageFormat.mm,
                    vertical: 1 * PdfPageFormat.mm),
                height: 10 * PdfPageFormat.cm,
                width: 9.59 * PdfPageFormat.cm,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.4 * PdfPageFormat.mm, color: PdfColors.grey800),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text("For, DI-CYCLES"),
                    ),
                    Spacer(),
                    Center(
                      child: Text(
                        "Authorised Signatory",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      )
    ]);
  }

  static Widget buildHeader(Invoice invoice, MemoryImage image) {
    DateFormat dateFormat = DateFormat("dd MMM yyyy");

    String formattedDate = dateFormat.format(invoice.info.date);

    DateTime date = invoice.info.date;
    DateTime nextDate = date.add(const Duration(days: 4));
    String validTill = dateFormat.format(nextDate);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Image(image, height: 5 * PdfPageFormat.cm, width: 5 * PdfPageFormat.cm),
        Spacer(),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("DI-CYCLES",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("Nellore, Andhra Pradesh"),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Gst : ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: "37AARFD7588D1ZU")
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Phone : ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: " 9849000525")
                  ],
                ),
              )
            ])
      ]),
      SizedBox(height: 0.4 * PdfPageFormat.cm),
      Center(
        child: Text(
          "QUOTATION",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),

      SizedBox(height: 0.5 * PdfPageFormat.cm),

      Row(children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: "Gst : ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const TextSpan(text: "37AARFD7588D1ZU")
            ],
          ),
        ),
        Spacer(),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Quotation No. : ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "41",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15))
                  ],
                ),
              ),
              SizedBox(height: 3 * PdfPageFormat.mm),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Date : ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: formattedDate,
                    )
                  ],
                ),
              ),
              SizedBox(height: 3 * PdfPageFormat.mm),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Valid till : ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: validTill,
                    )
                  ],
                ),
              ),
            ])
      ]),

      SizedBox(height: 3 * PdfPageFormat.mm),

      Row(children: [
        Container(
          height: 3.2 * PdfPageFormat.cm,
          width: 13.78 * PdfPageFormat.cm,
          decoration: BoxDecoration(
            border: Border.all(
                width: 0.4 * PdfPageFormat.mm, color: PdfColors.grey800),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 2 * PdfPageFormat.mm,
                    vertical: 1 * PdfPageFormat.mm),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Billing Address ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              Divider(height: 0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 2 * PdfPageFormat.mm,
                    vertical: 1 * PdfPageFormat.mm),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 0.7 * PdfPageFormat.mm),
                    Text(invoice.customer.name),
                    SizedBox(height: 0.7 * PdfPageFormat.mm),
                    Text(invoice.customer.name),
                    SizedBox(height: 0.7 * PdfPageFormat.mm),
                    Text(invoice.customer.address),
                    SizedBox(height: 0.7 * PdfPageFormat.mm),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Phone: ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: invoice.customer.mobile)
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          height: 3.2 * PdfPageFormat.cm,
          width: 13.78 * PdfPageFormat.cm,
          decoration: BoxDecoration(
            border: Border.all(
                width: 0.4 * PdfPageFormat.mm, color: PdfColors.grey800),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 2 * PdfPageFormat.mm,
                    vertical: 1 * PdfPageFormat.mm),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Shipping Address ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              Divider(height: 0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 2 * PdfPageFormat.mm,
                    vertical: 1 * PdfPageFormat.mm),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 0.7 * PdfPageFormat.mm),
                    Text(invoice.customer.name),
                    SizedBox(height: 0.7 * PdfPageFormat.mm),
                    Text(invoice.customer.name),
                    SizedBox(height: 0.7 * PdfPageFormat.mm),
                    Text(invoice.customer.address),
                    SizedBox(height: 0.7 * PdfPageFormat.mm),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Phone: ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: invoice.customer.mobile)
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ]),

      SizedBox(height: 3 * PdfPageFormat.mm),

      // SizedBox(height: 1 * PdfPageFormat.cm),
      // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      //   buildSupilerAddress(invoice.supplier),
      //   Container(
      //       height: 50,
      //       width: 50,
      //       child: BarcodeWidget(
      //           data: invoice.info.number, barcode: Barcode.qrCode()))
      // ]),
      // SizedBox(height: 1 * PdfPageFormat.cm),
      // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      //   buildCustomerAddress(invoice.customer),
      //   buildInvoiceInfo(invoice.info),
      // ])
    ]);
  }

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    final titles = <String>[
      'Invoice number',
      'Invoice Date',
      'Due Date',
      'Description'
    ];
    final data = <String>[
      info.number,
      DateUtils.apiDayFormat(info.date),
      DateUtils.apiDayFormat(info.dueDate),
      info.description
    ];

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(titles.length, (index) {
          final title = titles[index];
          final value = data[index];
          return Container(
              width: 200,
              child: Row(children: [
                Expanded(
                    child: Text(title,
                        style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(width: 2 * PdfPageFormat.cm),
                Text(value)
              ]));
        }));
  }

  static Widget buildCustomerAddress(Customer customer) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 1 * PdfPageFormat.mm),
        Text(customer.address),
        SizedBox(height: 1 * PdfPageFormat.mm),
        Text(customer.mobile),
      ]);

  static Widget buildSupilerAddress(Supplier supplier) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 1 * PdfPageFormat.mm),
        Text(supplier.address),
        SizedBox(height: 1 * PdfPageFormat.mm),
        Text(supplier.mobile),
      ]);

  static Widget buildFooter(Invoice invoice) {
    return Column(children: [
      Text(
          'https://biziverse.com/Html/Pages/PrtDoc2.html?issupplierFK]is2nclude3eaderFJ]is2nclude:ddrFJ]is2nclude?igitalFK]2s:gency3as3eaderFJ]2?FOILIKC… ',
          maxLines: 1,
          overflow: TextOverflow.span)
    ]);
  }

  static Widget buildTotal(Invoice invoice) {
    final totalAmount = invoice.items
        .map((item) => int.parse(item.price) * int.parse(item.qty))
        .reduce((item1, item2) => item1 + item2);

    return Container(
        alignment: Alignment.centerRight,
        child: Row(children: [
          Spacer(flex: 7),
          Expanded(
              flex: 3,
              child: Text("Toal Amount : ₹ $totalAmount",
                  style: TextStyle(fontWeight: FontWeight.bold)))
        ]));
  }

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'No',
      'Item & Description ',
      'HSN / SAC',
      'Qty',
      'Unit',
      'Rate',
      'Taxable',
      'CGST',
      'SGST',
      'Amount'
    ];
    int i = 1;

    final data = invoice.items.map((item) {
      final total = int.parse(item.price) * int.parse(item.qty);
      return [
        i++,
        "${item.description} ${item.name}",
        '232',
        item.qty,
        'no.s ',
        (item.price),
        '66,000.00',
        '9.00%',
        '9.00%',
        (total.toStringAsFixed(2))
      ];
    }).toList();
    return Table.fromTextArray(
        border: TableBorder.all(color: PdfColors.grey800),
        columnWidths: {
          0: const FractionColumnWidth(0.05),
          1: const FractionColumnWidth(0.40),
          2: const FractionColumnWidth(0.15),
          3: const FractionColumnWidth(0.075),
          4: const FractionColumnWidth(0.085),
          5: const FractionColumnWidth(0.17),
          6: const FractionColumnWidth(0.17),
          7: const FractionColumnWidth(0.11),
          8: const FractionColumnWidth(0.11),
          9: const FractionColumnWidth(0.17)
        },
        headerStyle: TextStyle(
            fontSize: 3.4 * PdfPageFormat.mm, fontWeight: FontWeight.bold),
        cellHeight: 10,
        headerHeight: 6,
        // headerHeight: 1,
        cellAlignments: {
          0: Alignment.centerLeft,
          1: Alignment.centerLeft,
          2: Alignment.centerRight,
          3: Alignment.centerRight,
          4: Alignment.centerRight,
          5: Alignment.centerRight,
          6: Alignment.centerRight,
          7: Alignment.centerRight,
          8: Alignment.centerRight,
          9: Alignment.centerRight,
        },

        // border: null,
        headers: headers,
        // headerDecoration: ,
        data: data,
        cellStyle: const TextStyle(fontSize: 3.0 * PdfPageFormat.mm)
        // cellStyle: TextStyle(fontWeight: FontWeight.)
        );
  }
}
