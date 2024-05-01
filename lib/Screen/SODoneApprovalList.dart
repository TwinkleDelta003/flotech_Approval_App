import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unnati/Contants/responsiveSize.dart';
import 'package:unnati/Model/PendingPOModel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Controller/controller.dart';
import '../Model/SOPendingModel.dart';

class InvoiceDoneApprovalScreen extends StatefulWidget {
  const InvoiceDoneApprovalScreen({Key key}) : super(key: key);

  @override
  State<InvoiceDoneApprovalScreen> createState() =>
      _InvoiceDoneApprovalScreenState();
}

class _InvoiceDoneApprovalScreenState extends State<InvoiceDoneApprovalScreen> {
  var data = Get.arguments;
  void launchOragamo(url) async {
    if (!await launch(url)) ;
  }

  TextEditingController _find = TextEditingController();
  List<SOPendingModel> itemList = [];
  String _searchText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [],
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
            "Disapproved Invoice",
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
              height: Get.height / 1.1,
              child: FutureBuilder(
                  future: disPOAPIList(
                      isAdmin: "true", userId: data[0], no: _find.text),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Center(
                          child: Center(
                              child: snapshot.connectionState !=
                                      ConnectionState.done
                                  ? CircularProgressIndicator()
                                  : Text("NO Data Found!")));
                    } else {
                      return Container(
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.result.length,
                            itemBuilder: (context, index) {
                              var list = snapshot.data.result[index];
                              return pendingModel(
                                  model: PendingPOModel(result: [list]));
                            }),
                      );
                    }
                  }),
            ),
          ],
        ));
  }

  Widget pendingModel({PendingPOModel model}) {
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
                        title: Text("PO Number",
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
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )),
    );
  }
}
