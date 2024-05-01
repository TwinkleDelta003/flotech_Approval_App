import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:push_notification/push_notification.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Contants/PrefsConfig.dart';
import '../Controller/controller.dart';
import '../Model/POModelItem.dart';
import '../Widgets/ColorConfig.dart';
import '../Widgets/CustomText.dart';
import '../Widgets/Helper.dart';
import 'package:pdf/widgets.dart' as pw;
import 'PDFView.dart';
import 'invoicepdfview.dart';

class PaddedText extends pw.StatelessWidget {
  final String text;
  final pw.TextAlign align;

  PaddedText(this.text, {this.align = pw.TextAlign.left});

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: pw.EdgeInsets.all(10),
      child: pw.Text(
        text,
        textAlign: align,
      ),
    );
  }
}

class InvoicePendingApprovalSCreen extends StatefulWidget {
  final String invoice;

  const InvoicePendingApprovalSCreen({Key key, this.invoice}) : super(key: key);
  @override
  State<InvoicePendingApprovalSCreen> createState() =>
      _InvoicePendingApprovalSCreenState();
}

class _InvoicePendingApprovalSCreenState
    extends State<InvoicePendingApprovalSCreen> {
  void launchOragamo(url) async {
    if (!await launch(url)) ;
  }

  List<POItemModel> itemList = [];
  String _searchText = '';

  TextEditingController remarkCtrl = TextEditingController();
  TextEditingController _findController = TextEditingController();
  TextEditingController dtCltr = TextEditingController();

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  bool isExpanded = false;

  void alertByHK({String pOId, String divTextListId, String poNumber}) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Column(
                children: [
                  Text('Remarks'),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: Get.height / 6,
                    width: Get.width,
                    child: TextField(
                      controller: remarkCtrl,
                      decoration: InputDecoration(
                          hintText: 'Enter Remark',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 20,
                    width: MediaQuery.of(context).size.width / 1.6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              // Color(0xff5ec8cb),
                              // Color(0xff8de7e4),
                              ColorConfig.primaryAppColor
                            ])),
                    child: MaterialButton(
                        onPressed: () {
                          if (remarkCtrl.text.isEmpty) {
                            Helper.snackBar(context, 'Remark is Empty');
                          } else {
                            invoiceApprovalStatusAPI(
                                    approvedDisapproved: "D",
                                    pOId: pOId,
                                    divTextListId: divTextListId,
                                    userId: PrefsConfig.getUserId(),
                                    rejectedRemark: remarkCtrl.text,
                                    context: context)
                                .then((value) => {
                                      // notification.show(
                                      //   1,
                                      //   'Data DisApproved',
                                      //   'Success! The data you submitted has been DisApproved. ',
                                      //   data: {
                                      //     notificationKey: '[notification data]'
                                      //   },
                                      //   notificationSpecifics:
                                      //       NotificationSpecifics(
                                      //     AndroidNotificationSpecifics(
                                      //       autoCancelable: true,
                                      //       icon: '@mipmap/ic_launcher',
                                      //     ),
                                      //   ),
                                      // )
                                      if (value['status'] == "200")
                                        {
                                          pendingPODetails(
                                              isAdmin: PrefsConfig.getAdmin(),
                                              userId: PrefsConfig.getUserId()),
                                          Get.toNamed('/success', arguments: [
                                            poNumber,
                                            "Disapproved"
                                          ]),
                                          Helper.snackBar(
                                              context, value['message']),
                                        }
                                      else
                                        {
                                          Helper.snackBar(
                                              context, value['message'])
                                        }
                                    });
                            setState(() {
                              remarkCtrl.clear();
                            });

                            Navigator.pop(context);
                          }
                        },
                        child: Text("Submit")),
                  ),
                ],
              ),
            );
          });
        });
  }

  Notificator notification;
  String notificationKey = 'key';
  String _bodyText = 'notification';

  @override
  void initState() {
    if (widget.invoice != "") _findController.text = widget.invoice;
    _searchText = widget.invoice;
    notification = Notificator(
      onPermissionDecline: () {
        print('permission decline');
      },
      onNotificationTapCallback: (notificationData) {
        setState(
          () {
            _bodyText = 'notification open: '
                '${notificationData[notificationKey].toString()}';
          },
        );
      },
    )..requestPermissions(
        requestSoundPermission: true,
        requestAlertPermission: true,
      );
    super.initState();
  }

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          PaddedText('Company Name: ${"invoice.result[0].companyName"}'),
          PaddedText('Date: ${"invoice.result[0].dt"}'),
          PaddedText('PO Number: ${"invoice.result[0].no"}'),
          PaddedText(
              'PO Value: ${double.parse("invoice.result[0].value").toStringAsFixed(0)}'),
        ],
      ),
    );
    return pdf.save();
  }

  Future<void> pickDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              onPrimary: Colors.white, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(),
            ),
          ),
          child: child,
        );
      },
    );

    // Check if the user selected a date
    if (selected != null) {
      // Format the selected date as "dd-mm-yyyy"
      String formattedDate = DateFormat('dd-MMM-yyyy').format(selected);

      // Set the formatted date as the text in the controller
      controller.text = formattedDate;
    }
  }

  bool isFilter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isFilter = !isFilter;
                  });
                },
                icon: Icon(
                  Icons.filter_alt,
                  size: 35,
                  color: Colors.white,
                ))
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.white)),
          elevation: 10,
          backgroundColor: Colors.orange,
          shadowColor: Colors.orange,
          title: Text(
            "INVOICE PENDING APPROVED",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Visibility(
              visible: isFilter,
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(left: 10, right: 10),
                height: Get.height / 10,
                child: ListTile(
                  subtitle: TextFormField(
                    controller: _findController,
                    onChanged: (text) {
                      setState(() {
                        _searchText = text;
                      });
                    },
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search,
                          color: ColorConfig.primaryAppColor),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                      filled: true,
                      counterText: "",
                      fillColor: Color(0xffE8F0FD),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: ColorConfig.primaryAppColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.3,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: pendingInvoiceWithItem(
                  isAdmin: "true",
                  userId: PrefsConfig.getUserId(),
                  no: "",
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: InkWell(
                            onTap: () {
                              print(snapshot.error);
                            },
                            child: Text("Error: ${snapshot.error}")));
                  } else if (snapshot.data == null ||
                      snapshot.data.result == null ||
                      snapshot.data.result.isEmpty) {
                    return Center(child: Text("NO Data Found!"));
                  } else {
                    itemList = (snapshot.data.result as List<dynamic>)
                        .map((e) => POItemModel(result: [e]))
                        .toList();
                    return Container(
                      width: Get.width / 1.1,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: itemList.length,
                        itemBuilder: (context, index) {
                          final result = itemList[index];
                          final lgrName =
                              result.result[0].lgrName.toString().toLowerCase();
                          final dt =
                              result.result[0].dt.toString().toLowerCase();
                          final poNo =
                              result.result[0].no.toString().toLowerCase();
                          final qty = result.result[0].totalQty
                              .toString()
                              .toLowerCase();
                          final grandQty = result.result[0].grandTotalAmt
                              .toString()
                              .toLowerCase();
                          final itemName = result
                              .result[0].itemDetails[0].itemName
                              .toString()
                              .toLowerCase();

                          if (lgrName.contains(_findController.text
                                  .toString()
                                  .toLowerCase()) ||
                              dt.contains(_findController.text
                                  .toString()
                                  .toLowerCase()) ||
                              poNo.contains(_findController.text
                                  .toString()
                                  .toLowerCase()) ||
                              qty.contains(_findController.text
                                  .toString()
                                  .toLowerCase()) ||
                              itemName.contains(_findController.text
                                  .toString()
                                  .toLowerCase()) ||
                              grandQty.contains(_findController.text
                                  .toString()
                                  .toLowerCase())) {
                            return Column(
                              children: [
                                pendingPOUI(model: result),
                                Divider(
                                  thickness: 2,
                                  indent: 30,
                                  endIndent: 30,
                                  color: Colors.orange,
                                )
                              ],
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ));
  }

  Widget pendingPOUI({POItemModel model}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: ListTile(
                      trailing: InkWell(
                        onTap: () {
                          Get.to(
                            () => invoicePdfViewerPage(
                              url: model.result[0].pDFLink
                                  .toString()
                                  .replaceAll("u0026", "&"),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/pdf.png',
                          height: 35,
                        ),
                      ),
                      dense: true,
                      horizontalTitleGap: 0,
                      title: Center(
                        child: Container(
                          child: Text(
                            model.result[0].lgrName
                                .toString()
                                .replaceAll('u0026', "&")
                                .replaceAll('-', ""),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                // color: Color(0xff48B8E1),
                                backgroundColor: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            color: Colors.grey,
            endIndent: 10,
            indent: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ListTile(
                  title: Text("Invoice Number",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // color: Color.fromARGB(255, 104, 104, 104),
                          color: ColorConfig.primaryAppColor,
                          fontSize: 15)),
                  subtitle: Text(
                    model.result[0].no,
                    style: TextStyle(
                        // color: Color(0xff48B8E1),
                        color: ColorConfig.primaryAppColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text("Date",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorConfig.primaryAppColor,
                          fontSize: 15)),
                  subtitle: Text(
                    model.result[0].dt,
                    style: TextStyle(
                        color: ColorConfig.primaryAppColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ListTile(
                  title: Text("Total QTY",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 104, 104, 104),
                          fontSize: 15)),
                  subtitle: Text(
                    double.parse(model.result[0].totalQty).toStringAsFixed(0),
                    style: TextStyle(
                        color: ColorConfig.primaryAppColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ListTile(
                  title: Text("Total Amount",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 104, 104, 104),
                          fontSize: 15)),
                  subtitle: Text(
                    double.parse(model.result[0].itemDetails[0].amountWithGST)
                        .toStringAsFixed(0),
                    style: TextStyle(
                        color: ColorConfig.primaryAppColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ListTile(
                  title: Text("Grand Total Amount",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 104, 104, 104),
                          fontSize: 15)),
                  subtitle: Text(
                    double.parse(model.result[0].grandTotalAmt)
                        .toStringAsFixed(0),
                    style: TextStyle(
                        color: ColorConfig.primaryAppColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.green,
                            Colors.green,
                          ])),
                  child: MaterialButton(
                      onPressed: () {
                        invoiceApprovalStatusAPI(
                                approvedDisapproved: "A",
                                divTextListId: model.result[0].divTextListId,
                                context: context,
                                pOId: model.result[0].pOId,
                                userId: PrefsConfig.getUserId(),
                                rejectedRemark: "")
                            .then((value) => {
                                  if (value['status'] == "200")
                                    {
                                      setState(() {
                                        pendingPODetails(
                                            isAdmin: PrefsConfig.getAdmin(),
                                            userId: PrefsConfig.getUserId());
                                      }),
                                      Get.toNamed('/success', arguments: [
                                        model.result[0].pOId,
                                        "Approved"
                                      ]),
                                      Helper.snackBar(context, value['status']),
                                    }
                                  else
                                    {
                                      Helper.snackBar(context, value['status']),
                                    }
                                });
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/checked.png"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Approve",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      )),
                ),
                Container(
                  width: Get.width / 1.9,
                  // height: MediaQuery.of(context).size.height / 22,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xffD0312D),
                            Color(0xffD0312D),
                          ])),
                  child: MaterialButton(
                      onPressed: () {
                        alertByHK(
                            divTextListId: model.result[0].divTextListId,
                            poNumber: model.result[0].pOId,
                            pOId: model.result[0].pOId);
                      },
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/remove.png"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "DisApproved",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
          ExpansionTile(title: CustomText(data: "See More"), children: [
            Container(
              // height: MediaQuery.of(context).size.height / 1.3,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: model.result[0].itemDetails.length,
                itemBuilder: (context, index) {
                  final item = model.result[0].itemDetails[index];
                  return ItemDetailUI(
                    itemName: item.itemName,
                    qty: item.qty,
                    rate: item.rate,
                  );
                },
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

class ItemDetailUI extends StatelessWidget {
  final String itemName;
  final String qty;
  final String rate;
  final String totalAmt;

  const ItemDetailUI(
      {Key key, this.itemName, this.qty, this.rate, this.totalAmt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: ListTile(
            title: Text("Item Name",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 104, 104, 104),
                    fontSize: 15)),
            subtitle: Text(
              itemName,
              style: TextStyle(
                  color: ColorConfig.primaryAppColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ListTile(
            title: Text("Total QTY",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 104, 104, 104),
                    fontSize: 15)),
            subtitle: Text(
              double.parse(qty).toStringAsFixed(0),
              style: TextStyle(
                  color: ColorConfig.primaryAppColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ListTile(
            title: Text("Rate",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 104, 104, 104),
                    fontSize: 15)),
            subtitle: Text(
              double.parse(rate).toStringAsFixed(0),
              style: TextStyle(
                  color: ColorConfig.primaryAppColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
