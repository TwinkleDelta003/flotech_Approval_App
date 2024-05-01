import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unnati/Contants/PrefsConfig.dart';
import 'package:unnati/Model/POModelItem.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Controller/controller.dart';
import '../Widgets/ColorConfig.dart';
import '../Widgets/CustomText.dart';
import 'PDFView.dart';
import 'POPendingScreen.dart';

class PODisAppScreen extends StatefulWidget {
  const PODisAppScreen({Key key}) : super(key: key);

  @override
  State<PODisAppScreen> createState() => _PODisAppScreenState();
}

class _PODisAppScreenState extends State<PODisAppScreen> {
  void launchOragamo(url) async {
    if (!await launch(url)) ;
  }

  TextEditingController _findController = TextEditingController();
  List<POItemModel> itemList = [];
  String _searchText = '';

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
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          elevation: 10,
          backgroundColor: Colors.red,
          title: Text(
            "Disapproved PO",
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
            // Container(
            //   height: Get.height / 1.1,
            //   child: FutureBuilder(
            //       future: disPOAPIList(
            //           isAdmin: PrefsConfig.getAdmin(),
            //           userId: PrefsConfig.getUserId(),
            //           no: ""),
            //       builder: (context, snapshot) {
            //         if (snapshot.data == null) {
            //           return Center(
            //               child: Center(
            //                   child: snapshot.connectionState !=
            //                           ConnectionState.done
            //                       ? CircularProgressIndicator()
            //                       : Text("NO Data Found!")));
            //         } else {
            //           // itemList = snapshot.data.result
            //           //     .map((e) => POItemModel(result: []))
            //           //     .toList();
            //           return Container(
            //               child: ListView.builder(
            //             physics: BouncingScrollPhysics(),
            //             itemCount: snapshot.data.result.length,
            //             itemBuilder: (context, index) {
            //               var list = snapshot.data.result[index];
            //               return pendingPOUI(
            //                   model: POItemModel(result: [list]));
            //             },
            //             //                     itemBuilder: (context, index) {
            //             //                       final itemName = itemList[index]
            //             //                           .result[0]
            //             //                           .itemName
            //             //                           .toString()
            //             //                           .toLowerCase();
            //             //                       final lgrName = itemList[index]
            //             //                           .result[0]
            //             //                           .lgrName
            //             //                           .toString()
            //             //                           .toLowerCase();
            //             //                       final dt = itemList[index]
            //             //                           .result[0]
            //             //                           .dt
            //             //                           .toString()
            //             //                           .toLowerCase();
            //             //                       final poNo = itemList[index]
            //             //                           .result[0]
            //             //                           .no
            //             //                           .toString()
            //             //                           .toLowerCase();
            //             //                       final qty = itemList[index]
            //             //                           .result[0]
            //             //                           .totalQty
            //             //                           .toString()
            //             //                           .toLowerCase();
            //             //                       final rate = itemList[index]
            //             //                           .result[0]
            //             //                           .rate
            //             //                           .toString()
            //             //                           .toLowerCase();
            //             //                       final amt = itemList[index]
            //             //                           .result[0]
            //             //                           .amt
            //             //                           .toString()
            //             //                           .toLowerCase();
            //             //  final result = snapshot.data.result[index];
            //             //                       if (lgrName.contains(_findController.text
            //             //                               .toString()
            //             //                               .toLowerCase()) ||
            //             //                           rate.contains(_findController.text
            //             //                               .toString()
            //             //                               .toLowerCase()) ||
            //             //                           itemName.contains(_findController.text
            //             //                               .toString()
            //             //                               .toLowerCase()) ||
            //             //                           amt.contains(_findController.text
            //             //                               .toString()
            //             //                               .toLowerCase()) ||
            //             //                           dt.contains(_findController.text
            //             //                               .toString()
            //             //                               .toLowerCase()) ||
            //             //                           poNo.contains(_findController.text
            //             //                               .toString()
            //             //                               .toLowerCase()) ||
            //             //                           qty.contains(_findController.text
            //             //                               .toString()
            //             //                               .toLowerCase())) {
            //             //                         return Column(
            //             //                           children: [
            //             //                             pendingPOUI(model: [result]),
            //             //                             Divider(
            //             //                               thickness: 2,
            //             //                               indent: 30,
            //             //                               endIndent: 30,
            //             //                               color: ColorConfig.redApp,
            //             //                             )
            //             //                           ],
            //             //                         );
            //             //                       } else {
            //             //                         return SizedBox.shrink();
            //             //                       }
            //             //                     }),
            //           ));
            //         }
            //       }),
            // ),

            Container(
              height: MediaQuery.of(context).size.height / 1.3,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: disPOAPIList(
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
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Color(0xff262262),
    //     title: Text("SO DONE APPROVED"),
    //     actions: [
    //       IconButton(
    //         onPressed: () {},
    //         icon: CircleAvatar(
    //             radius: 15,
    //             backgroundColor: Colors.white,
    //             child: Image.asset(
    //               "assets/images/ic_unnati_logo.png",
    //               scale: 18,
    //             )),
    //       )
    //     ],
    //   ),
    //   body: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         Container(
    //           // padding: EdgeInsets.only(left: , right: 10),
    //           height: Get.height / 16,
    //           child: ListTile(
    //             subtitle: TextFormField(
    //               // controller: _findController,
    //               maxLength: 10,

    //               style: TextStyle(fontSize: 16.0, color: Color(0xff8A8A8A)),
    //               decoration: InputDecoration(
    //                 hintText: "Search",
    //                 prefixIcon: Icon(
    //                   Icons.search,
    //                   // color: Color(0xff48B8E1),
    //                 ),
    //                 contentPadding:
    //                     EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    //                 filled: true,
    //                 counterText: "",
    //                 // fillColor: Color(0xffE8F0FD),
    //                 focusedBorder: OutlineInputBorder(
    //                     borderSide: BorderSide(width: 2),
    //                     borderRadius: BorderRadius.circular(10)),
    //                 border: OutlineInputBorder(
    //                     borderSide: BorderSide(width: 2),
    //                     borderRadius: BorderRadius.circular(10)),
    //                 hintStyle: TextStyle(
    //                   fontWeight: FontWeight.w600,
    //                   // color: Color(0xff48B8E1),
    //                   fontSize: 16.0,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Container(
    //           height: MediaQuery.of(context).size.height / 1.4,
    //           child: FutureBuilder(
    //               future: soDoneApprovalAPI(isAdmin: data[1], userId: data[0]),
    //               builder: (context, snapshot) {
    //                 if (snapshot.data == null) {
    //                   return Center(
    //                       child: Center(
    //                           child: snapshot.connectionState !=
    //                                   ConnectionState.done
    //                               ? CircularProgressIndicator()
    //                               : Text("NO Data Found!")));
    //                 } else {
    //                   return Container(
    //                     width: Get.width / 1.1,
    //                     child: ListView.builder(
    //                         physics: BouncingScrollPhysics(),
    //                         itemCount: snapshot.data.result.length,
    //                         itemBuilder: (context, index) {
    //                           var list = snapshot.data.result[index];
    //                           return pendingModel(
    //                               model: SOPendingModel(result: [list]));
    //                         }),
    //                   );
    //                 }
    //               }),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
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
                            () => PdfViewerPage(
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
          // Row(
          //   children: [
          //     Expanded(
          //       flex: 1,
          //       child: ListTile(
          //         title: Text("Company Name",
          //             style: TextStyle(
          //                 fontWeight: FontWeight.bold,
          //                 color: Color.fromARGB(255, 104, 104, 104),
          //                 fontSize: 15)),
          //         subtitle: Text(
          //           model.result[0].companyName,
          //           style: TextStyle(
          //               color: Color(0xff48B8E1),
          //               fontWeight: FontWeight.bold,
          //               fontSize: 18),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ListTile(
                  title: Text("PO Number",
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
              // Expanded(
              //   flex: 1,
              //   child: ListTile(
              //     title: Text("Total QTY",
              //         style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             color: Color.fromARGB(255, 104, 104, 104),
              //             fontSize: 15)),
              //     subtitle: Text(
              //       double.parse(model.result[0].totalQty).toStringAsFixed(0),
              //       style: TextStyle(
              //           color: ColorConfig.primaryAppColor,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 18),
              //     ),
              //   ),
              // ),
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
              // Expanded(
              //   flex: 1,
              //   child: ListTile(
              //     title: Text("Grand Total Amount",
              //         style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             color: Color.fromARGB(255, 104, 104, 104),
              //             fontSize: 15)),
              //     subtitle: Text(
              //       double.parse(model.result[0].itemDetails[0].)
              //           .toStringAsFixed(0),
              //       style: TextStyle(
              //           color: ColorConfig.primaryAppColor,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 18),
              //     ),
              //   ),
              // ),
            ],
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
