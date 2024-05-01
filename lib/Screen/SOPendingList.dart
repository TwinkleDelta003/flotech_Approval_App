import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_notification/push_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unnati/Contants/responsiveSize.dart';
import 'package:unnati/Widgets/Helper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Controller/controller.dart';
import '../Model/SOPendingModel.dart';

class InvoicePendingScreen extends StatefulWidget {
  const InvoicePendingScreen({Key key}) : super(key: key);

  @override
  State<InvoicePendingScreen> createState() => _InvoicePendingScreenState();
}

class _InvoicePendingScreenState extends State<InvoicePendingScreen> {
  TextEditingController remarkCtrl = TextEditingController();
  Future<void> getUserId() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (mounted)
      setState(() {
        user = _prefs.getString('UserId');
      });
  }

  void launchOragamo(url) async {
    if (!await launch(url)) ;
  }

  String user = '';
  var data = Get.arguments;

  @override
  void initState() {
    getUserId();
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  List<SOPendingModel> itemList = [];
  String _searchText = '';

  void alertByHK({
    String soId,
    String divTextListId,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Remarks'),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      // height: MediaQuery.of(context).size.height / 4,
                      height: Get.height / 6,
                      // width: MediaQuery.of(context).size.width,
                      width: Get.width,
                      child: TextField(
                        controller: remarkCtrl,
                        decoration: InputDecoration(
                            hintText: 'Enter Remark',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.left,

                        // maxLength: 10,
                        // maxLengthEnforcement: MaxLengthEnforcement.none,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.width / 1.6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color: Color.fromARGB(255, 121, 225, 223),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xff5ec8cb),
                                Color(0xff8de7e4),
                              ])),
                      child: MaterialButton(
                          onPressed: () {
                            if (remarkCtrl.text.isEmpty) {
                              Helper.snackBar(context, 'Remark is Empty');
                            } else {
                              soApprovalStatusAPI(
                                      approvedDisapproved: "D",
                                      soId: soId,
                                      divTextListId: divTextListId,
                                      userId: data[0],
                                      rejectedRemark: remarkCtrl.text,
                                      context: context)
                                  .then((value) => {
                                        notification.show(
                                          1,
                                          'Data DisApproved',
                                          // 'Your Request From ${_textEditingController.text} to ${_textEditingController2.text} is Successfully Sent to Admin',
                                          'Success! The data you submitted has been DisApproved. ',
                                          data: {
                                            notificationKey:
                                                '[notification data]'
                                          },
                                          notificationSpecifics:
                                              NotificationSpecifics(
                                            AndroidNotificationSpecifics(
                                              autoCancelable: true,
                                              icon: '@mipmap/ic_launcher',
                                            ),
                                          ),
                                        )
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
              ),
              // actions: [
              //   TextButton(
              //       onPressed: () {
              //         Navigator.pop(context);
              //       },
              //       child: Text(
              //         "Done",
              //         style: TextStyle(fontSize: 20),
              //       )),
              // ],
            );
          });
        });
  }

  Notificator notification;
  String notificationKey = 'key';
  String _bodyText = 'notification text';

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
            "INVOICE PENDING APPROVED",
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
              child: FutureBuilder<SOPendingModel>(
                future: soPendingList(isAdmin: data[1], userId: data[0]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('No data found!'));
                  } else if (snapshot.data == null ||
                      snapshot.data.result.isEmpty) {
                    return Center(child: Text('No data found'));
                  } else {
                    itemList = snapshot.data.result
                        .map((e) => SOPendingModel(result: [e]))
                        .toList();
                    return Container(
                      width: Get.width / 1.1,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: itemList.length,
                        itemBuilder: (context, index) {
                          final companyName =
                              itemList[index].result[0].custName.toLowerCase();
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
              //     future: soPendingList(isAdmin: data[1], userId: data[0]),
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
              //                     model: SOPendingModel(result: [list]));
              //               }),
              //         );
              //       }
              //     }),
            ),
          ],
        ));
  }

  Widget pendingModel({SOPendingModel model}) {
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
                            // leading: Image.asset(
                            //   'assets/calendar.png',
                            //   height: 25,
                            // ),
                            title: Text(
                              model.result[0].custName,
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
                        title: Text("SO Number",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 22,
                      width: MediaQuery.of(context).size.width / 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color: Color.fromARGB(255, 121, 225, 223),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xff5ec8cb),
                                Color(0xff8de7e4),
                              ])),
                      child: MaterialButton(
                          onPressed: () {
                            soApprovalStatusAPI(
                                    approvedDisapproved: "A",
                                    soId: model.result[0].sOId,
                                    divTextListId:
                                        model.result[0].divTextListId,
                                    userId: user,
                                    rejectedRemark: "",
                                    context: context)
                                .then((val) => {
                                      notification.show(
                                        1,
                                        'Data Approved',
                                        // 'Your Request From ${_textEditingController.text} to ${_textEditingController2.text} is Successfully Sent to Admin',
                                        'Success! The data you submitted has been approved. ',
                                        data: {
                                          notificationKey: '[notification data]'
                                        },
                                        notificationSpecifics:
                                            NotificationSpecifics(
                                          AndroidNotificationSpecifics(
                                            autoCancelable: true,
                                            icon: '@mipmap/ic_launcher',
                                          ),
                                        ),
                                      )
                                    });
                          },
                          child: Text("Approve")),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 22,
                      width: MediaQuery.of(context).size.width / 3.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color: Color.fromARGB(255, 121, 225, 223),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xff5ec8cb),
                                Color(0xff8de7e4),
                              ])),
                      child: MaterialButton(
                          onPressed: () {
                            launchOragamo(
                                // "http://117.247.81.73/DeltaiERP/Reports/Purchase/CRViewer.aspx?RptType=POPrint&RptId=B03B106B-9AA5-44FE-9294-47F499108394&DivTextListId=5BD6C237-6D43-4C73-A74E-1BD2763292F1",

                                model.result[0].pDFLink
                                    .toString()
                                    .replaceAll(
                                        '117.218.160.54', "117.247.81.73")
                                    .replaceAll("u0026", "&"));
                          },
                          child: Text("Show PDF")),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 22,
                      width: MediaQuery.of(context).size.width / 3.6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color: Color.fromARGB(255, 121, 225, 223),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xff5ec8cb),
                                Color(0xff8de7e4),
                              ])),
                      child: MaterialButton(
                          onPressed: () {
                            alertByHK(
                                divTextListId: model.result[0].divTextListId,
                                soId: model.result[0].sOId);
                          },
                          child: Text("DisApprove")),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
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
    //                 model.result[0].custName,
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
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Container(
    //                 height: MediaQuery.of(context).size.height / 22,
    //                 width: MediaQuery.of(context).size.width / 4,
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
    //                       soApprovalStatusAPI(
    //                               approvedDisapproved: "A",
    //                               soId: model.result[0].sOId,
    //                               divTextListId: model.result[0].divTextListId,
    //                               userId: user,
    //                               rejectedRemark: "",
    //                               context: context)
    //                           .then((val) => {print(val)});
    //                     },
    //                     child: Text("Approve")),
    //               ),
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
    //               Container(
    //                 height: MediaQuery.of(context).size.height / 22,
    //                 width: MediaQuery.of(context).size.width / 3.6,
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
    //                       alertByHK(
    //                           divTextListId: model.result[0].divTextListId,
    //                           soId: model.result[0].sOId);
    //                     },
    //                     child: Text("DisApprove")),
    //               ),
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
