import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unnati/Contants/PrefsConfig.dart';
import 'package:unnati/Screen/PDFView.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Controller/controller.dart';
import '../Model/POModelItem.dart';
import '../Widgets/ColorConfig.dart';
import '../Widgets/CustomText.dart';
import 'POPendingScreen.dart';
import 'invoicepdfview.dart';

class InvoiceDoneAppSCreen extends StatefulWidget {
  // final String po;
  // PODoneAppSCreen({this.po});

  @override
  State<InvoiceDoneAppSCreen> createState() => _InvoiceDoneAppSCreenState();
}

class _InvoiceDoneAppSCreenState extends State<InvoiceDoneAppSCreen> {
  TextEditingController _findController = TextEditingController();

  void launchOragamo(url) async {
    if (!await launch(url)) ;
  }

  List<POItemModel> itemList = [];
  String _searchText = '';
  String dtText = '';

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

      setState(() {
        dtText = formattedDate;
      });
      doneApprovalList(
          isAdmin: PrefsConfig.getAdmin(),
          userId: PrefsConfig.getUserId(),
          no: "");

      print(dtText);
    }
  }

  bool isFilter = false;
  TextEditingController dtCltr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          elevation: 10,
          backgroundColor: Colors.green,
          title: Text(
            "INVOICE DONE APPROVED",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
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
                        prefixIcon: Icon(
                          Icons.search,
                          color: ColorConfig.primaryAppColor,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                        filled: true,
                        counterText: "",
                        fillColor: Color(0xffE8F0FD),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
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
                  future: doneApprovalinvoiceList(
                      isAdmin: PrefsConfig.getAdmin(),
                      userId: PrefsConfig.getUserId(),
                      no: ""),
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
                            final lgrName = result.result[0].lgrName
                                .toString()
                                .toLowerCase();
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
          ),
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
                          Get.to(() => invoicePdfViewerPage(
                                url: model.result[0].pDFLink
                                    .toString()
                                    .replaceAll("u0026", "&"),
                              ));
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
            children: [],
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
