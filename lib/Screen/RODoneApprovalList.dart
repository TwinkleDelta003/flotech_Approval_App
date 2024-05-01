import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unnati/Contants/responsiveSize.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Controller/controller.dart';
import '../Model/ROPendingModel.dart';

class RODoneApprovalScreen extends StatefulWidget {
  const RODoneApprovalScreen({Key key}) : super(key: key);

  @override
  State<RODoneApprovalScreen> createState() => _RODoneApprovalScreenState();
}

class _RODoneApprovalScreenState extends State<RODoneApprovalScreen> {
  var data = Get.arguments;

  void launchOragamo(url) async {
    if (!await launch(url)) ;
  }

  List<ROPendingModel> itemList = [];
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            // Padding(
            //     padding: EdgeInsets.only(right: 12.0),
            //     child: IconButton(
            //       onPressed: () {},
            //       icon: CircleAvatar(
            //           radius: 22,
            //           // backgroundColor: Colors.white,
            //           child: Image.asset(
            //             "assets/images/ic_unnati_logo.png",
            //             scale: 16,
            //           )),
            //     )),
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.blue,
              )),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "RC DONE APPROVED",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              height: Get.height / 14,
              child: ListTile(
                subtitle: TextFormField(
                  // controller: _findController,
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
                      color: Color(0xff48B8E1),
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
                      color: Color(0xff48B8E1),
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.3,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder<ROPendingModel>(
                future: roDoneApprovalAPI(isAdmin: data[1], userId: data[0]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error fetching data'));
                  } else if (snapshot.data == null ||
                      snapshot.data.result.isEmpty) {
                    return Center(child: Text('No data found'));
                  } else {
                    itemList = snapshot.data.result
                        .map((e) => ROPendingModel(result: [e]))
                        .toList();
                    return Container(
                      width: Get.width / 1.1,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: itemList.length,
                        itemBuilder: (context, index) {
                          final companyName =
                              itemList[index].result[0].lgrName.toLowerCase();
                          if (companyName.contains(_searchText.toLowerCase())) {
                            return pendingModel(model: itemList[index]);
                          } else {
                            return Container(); // return an empty container if it doesn't match the search text
                          }
                        },
                      ),
                    );
                  }
                },
              ),
              // child: FutureBuilder(
              //     future: roDoneApprovalAPI(isAdmin: data[1], userId: data[0]),
              //     builder: (context, snapshot) {
              //       if (snapshot.data == null) {
              //         return Center(
              //             child: Center(
              //                 child: snapshot.connectionState !=
              //                         ConnectionState.done
              //                     ? CircularProgressIndicator()
              //                     : Text("NO Data Found!")));
              //       } else {
              //         return Container(
              //           width: Get.width / 1.1,
              //           child: ListView.builder(
              //               physics: BouncingScrollPhysics(),
              //               itemCount: snapshot.data.result.length,
              //               itemBuilder: (context, index) {
              //                 var list = snapshot.data.result[index];
              //                 return pendingModel(
              //                     model: ROPendingModel(result: [list]));
              //               }),
              //         );
              //       }
              //     }),
            ),
          ],
        ));
  }

  Widget pendingModel({ROPendingModel model}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          color: Color.fromARGB(255, 244, 251, 255),
          elevation: 3,
          child: Container(
            height: SizeConfig.screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: ListTile(
                            dense: true,
                            horizontalTitleGap: 0,
                            trailing: InkWell(
                              onTap: () {
                                launchOragamo(model.result[0].pDFLink
                                    .toString()
                                    .replaceAll(
                                        '117.218.160.54', "117.247.81.73")
                                    .replaceAll("u0026", "&"));
                              },
                              child: Image.asset(
                                'assets/images/pdf.png',
                                height: 35,
                              ),
                            ),
                            title: Text(
                              model.result[0].lgrName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff48B8E1),
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
                        title: Text("Company Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 104, 104, 104),
                                fontSize: 15)),
                        subtitle: Text(
                          model.result[0].companyName,
                          style: TextStyle(
                              color: Color(0xff48B8E1),
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
                                color: Color.fromARGB(255, 104, 104, 104),
                                fontSize: 15)),
                        subtitle: Text(
                          model.result[0].dt,
                          style: TextStyle(
                              color: Color(0xff48B8E1),
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
                        title: Text("RO Number",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 104, 104, 104),
                                fontSize: 15)),
                        subtitle: Text(
                          model.result[0].no,
                          style: TextStyle(
                              color: Color(0xff48B8E1),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    // Container(
                    //   height: MediaQuery.of(context).size.height / 15,
                    //   width: Get.width / 2,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(18),
                    //       // color: Color.fromARGB(255, 121, 225, 223),
                    //       gradient: LinearGradient(
                    //           begin: Alignment.topCenter,
                    //           end: Alignment.bottomCenter,
                    //           colors: [
                    //             Color(0xff5ec8cb),
                    //             Color(0xff8de7e4),
                    //           ])),
                    //   child: MaterialButton(
                    //       onPressed: () {
                    //         launchOragamo(model.result[0].pDFLink
                    //             .toString()
                    //             .replaceAll('117.218.160.54', "117.247.81.73")
                    //             .replaceAll("u0026", "&"));
                    //       },
                    //       child: Text("Show PDF")),
                    // ),
                  ],
                ),
              ],
            ),
          )),
    );
    // return Container(
    //   height: SizeConfig.screenHeight,
    //   child: Card(
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //     elevation: 3,
    //     child: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Column(
    //         children: <Widget>[
    //           Align(
    //               alignment: Alignment.topLeft,
    //               child: Text(
    //                 model.result[0].lgrName,
    //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    //               )),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           Row(
    //             children: [
    //               Image.asset(
    //                 "assets/images/factory.png",
    //                 height: 22,
    //               ),
    //               SizedBox(
    //                 width: 10,
    //               ),
    //               Text(
    //                 model.result[0].companyName,
    //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    //               ),
    //             ],
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           Row(
    //             children: [
    //               Image.asset(
    //                 "assets/images/calendar.png",
    //                 height: 22,
    //               ),
    //               SizedBox(
    //                 width: 10,
    //               ),
    //               Text(model.result[0].dt),
    //               VerticalDivider(),
    //               Image.asset(
    //                 "assets/images/check.png",
    //                 height: 22,
    //               ),
    //               SizedBox(
    //                 width: 10,
    //               ),
    //               Text(model.result[0].no),
    //             ],
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               // Container(
    //               //   height: MediaQuery.of(context).size.height / 22,
    //               //   width: MediaQuery.of(context).size.width / 4,
    //               //   decoration: BoxDecoration(
    //               //       borderRadius: BorderRadius.circular(18),
    //               //       // color: Color.fromARGB(255, 121, 225, 223),
    //               //       gradient: LinearGradient(
    //               //           begin: Alignment.topCenter,
    //               //           end: Alignment.bottomCenter,
    //               //           colors: [
    //               //             Color(0xff5ec8cb),
    //               //             Color(0xff8de7e4),
    //               //           ])),
    //               //   child: MaterialButton(
    //               //       onPressed: () {}, child: Text("Approve")),
    //               // ),
    //               Container(
    //                 height: MediaQuery.of(context).size.height / 22,
    //                 width: MediaQuery.of(context).size.width / 3.8,
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(18),
    //                     // color: Color.fromARGB(255, 121, 225, 223),
    //                     gradient: LinearGradient(
    //                         begin: Alignment.topCenter,
    //                         end: Alignment.bottomCenter,
    //                         colors: [
    //                           Color(0xff5ec8cb),
    //                           Color(0xff8de7e4),
    //                         ])),
    //                 child: MaterialButton(
    //                     onPressed: () {
    //                       launchOragamo(
    //                           // "http://117.247.81.73/DeltaiERP/Reports/Purchase/CRViewer.aspx?RptType=POPrint&RptId=B03B106B-9AA5-44FE-9294-47F499108394&DivTextListId=5BD6C237-6D43-4C73-A74E-1BD2763292F1",

    //                           model.result[0].pDFLink
    //                               .toString()
    //                               .replaceAll('117.218.160.54', "117.247.81.73")
    //                               .replaceAll("u0026", "&"));
    //                     },
    //                     child: Text("Show PDF")),
    //               ),
    //               // Container(
    //               //   height: MediaQuery.of(context).size.height / 22,
    //               //   width: MediaQuery.of(context).size.width / 3.6,
    //               //   decoration: BoxDecoration(
    //               //       borderRadius: BorderRadius.circular(18),
    //               //       // color: Color.fromARGB(255, 121, 225, 223),
    //               //       gradient: LinearGradient(
    //               //           begin: Alignment.topCenter,
    //               //           end: Alignment.bottomCenter,
    //               //           colors: [
    //               //             Color(0xff5ec8cb),
    //               //             Color(0xff8de7e4),
    //               //           ])),
    //               //   child: MaterialButton(
    //               //       onPressed: () {}, child: Text("DisApprove")),
    //               // ),
    //             ],
    //           ),
    //           SizedBox(
    //             height: 10,
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
