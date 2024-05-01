import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unnati/Auth/LoginScreen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:unnati/Contants/PrefsConfig.dart';
import 'package:unnati/Contants/responsiveSize.dart';
import 'package:unnati/Screen/InvoiceDisAppScreen.dart';
import 'package:unnati/Screen/InvoiceDoneappScreen.dart';
import 'package:unnati/Screen/InvoicePendingScreen.dart';
import 'package:unnati/Widgets/CustomText.dart';
import '../Controller/controller.dart';
import '../Model/POModelItem.dart';
import '../Widgets/ColorConfig.dart';
import '../Widgets/Helper.dart';
import 'PDFView.dart';
import 'POPendingScreen.dart';
import 'PODoneApp.dart';
import 'PODisAppScreen.dart';

class CircleContainer extends StatelessWidget {
  final Color color;
  final String label;

  const CircleContainer({@required this.color, @required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  logoutHere() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('MobileNo');
    prefs.remove('IMEI');
    prefs.remove('FCMId');
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> refresh() async {
    // Simulate a delay to show the refresh indicator
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      pendingCount();
      disPOLoop();
      poDoneLoop();
      // getpendingSOCount();
      totalSOCOunt1();
      // pendingROCountAPI();
      invoiceDoneLoop();
      invoicependingCount();
      // roTotalCountAPI();
    });
  }

  int notificationCount = 0;

  var pDOunt = [];

  String pendingcount = '0';
  String disPOCount = '0';
  String invoicependingcount = '0';
  String doneApprov = '0';
  String disinvoiceCount = '0';

  // total sum krvaano.

  double poCount = 0;
  double soCount = 0;
  double roCount = 0;
  double totalCountList = 0;

  double poPendCount = 0;
  double disPOCountdbl = 0;
  double soPendCount = 0;
  double roPendCount = 0;
  double totalPendCountList = 0;
  double invoiceCount = 0;
  double invoicePendcount = 0;
  double disinvoiceCountdbl = 0;
  double invoicePendCount = 0;

  void sumOflist() {
    if (mounted)
      setState(() {
        totalCountList = poCount + invoiceCount;
        // poCount + soCount + roCount;
        print(totalCountList);

        totalPendCountList = poPendCount + invoicePendCount;
        // poPendCount + soPendCount + roPendCount;
        print(totalPendCountList);
        totalPendingTask = totalPendCountList.toString();
        totalDoneTask = totalCountList.toString();
        print("total number of count: ${totalPendCountList}");
      });
  }

  void pendingCount() {
    pendingCountAPI(
            userId: PrefsConfig.getUserId(),
            isAdmin: PrefsConfig.getAdmin(),
            divTextListId: "",
            context: context)
        .then((value) => {
              if (value['status'] == "200")
                {
                  if (mounted)
                    setState(() {
                      pendingcount = value['result'][0]['Cnt'].toString();
                      poPendCount = double.parse(value['result'][0]['Cnt']);
                      poPendingCount = value['result'][0]['Cnt'].toString();
                      sumOflist();
                    }),
                  print(poPendCount.toString())
                  // widgetCounts()
                  // prString(pendingcount)
                }
              else
                {print(value)}
            });
  }

  void disPOLoop() {
    disPOCountAPI(
            userId: PrefsConfig.getUserId(),
            isAdmin: PrefsConfig.getAdmin(),
            divTextListId: "",
            context: context)
        .then((value) => {
              if (value['status'] == "200")
                {
                  if (mounted)
                    setState(() {
                      disPOCount = value['result'][0]['Cnt'].toString();
                      disPOCountdbl = double.parse(value['result'][0]['Cnt']);

                      sumOflist();
                    }),
                  print(poPendCount.toString())
                  // widgetCounts()
                  // prString(pendingcount)
                }
              else
                {print(value)}
            });
  }

  void poDoneLoop() {
    poDoneCountAPI(
            userId: PrefsConfig.getUserId(),
            isAdmin: PrefsConfig.getAdmin(),
            divTextListId: "",
            context: context)
        .then((value) => {
              if (value['status'] == "200")
                {
                  if (mounted)
                    setState(() {
                      poDoneCount = value['result'][0]['Cnt'].toString();
                      poCount = double.parse(value['result'][0]['Cnt']);

                      sumOflist();
                    }),
                }
              else
                {}
            });
  }

  void invoiceDoneLoop() {
    invoiceDoneCountAPI(
            userId: PrefsConfig.getUserId(),
            isAdmin: PrefsConfig.getAdmin(),
            divTextListId: "",
            context: context)
        .then((value) => {
              if (value['status'] == "200")
                {
                  if (mounted)
                    setState(() {
                      invoiceDoneCount = value['result'][0]['Cnt'].toString();
                      invoiceCount = double.parse(value['result'][0]['Cnt']);
                      print(invoiceDoneCount);
                      sumOflist();
                    }),
                }
              else
                {}
            });
  }

  void invoicependingCount() {
    invoicependingCountAPI(
            userId: PrefsConfig.getUserId(),
            isAdmin: PrefsConfig.getAdmin(),
            divTextListId: "",
            context: context)
        .then((value) => {
              if (value['status'] == "200")
                {
                  if (mounted)
                    setState(() {
                      invoicependingcount =
                          value['result'][0]['Cnt'].toString();
                      invoicePendCount =
                          double.parse(value['result'][0]['Cnt']);
                      invoicePendingCount =
                          value['result'][0]['Cnt'].toString();
                      sumOflist();
                    }),
                  print(invoicePendCount.toString())
                }
              else
                {print(value)}
            });
  }

  void disinvoiceLoop() {
    disinvoiceCountAPI(
            userId: PrefsConfig.getUserId(),
            isAdmin: PrefsConfig.getAdmin(),
            divTextListId: "",
            context: context)
        .then((value) => {
              if (value['status'] == "200")
                {
                  if (mounted)
                    setState(() {
                      disinvoiceCount = value['result'][0]['Cnt'].toString();
                      disinvoiceCountdbl =
                          double.parse(value['result'][0]['Cnt']);

                      sumOflist();
                    }),
                  print(poPendCount.toString())
                  // widgetCounts()
                  // prString(pendingcount)
                }
              else
                {print(value)}
            });
  }

  String pendingSOCount = '';
  String totalSOCount = '';

  void totalSOCOunt1() {
    totalSOCOunt(
            userId: PrefsConfig.getUserId(),
            isAdmin: PrefsConfig.getAdmin(),
            divTextListId: "",
            context: context)
        .then((value) => {
              if (value['status'] == "200")
                {
                  if (mounted)
                    setState(() {
                      totalSOCount = value['result'][0]['Cnt'].toString();
                      soCount = double.parse(value['result'][0]['Cnt']);
                      soDoneCount = value['result'][0]['Cnt'].toString();
                      sumOflist();
                    }),
                  // widgetCounts()
                }
              else
                {
                  // Helper.snackBar(
                  //   context,
                  //   value['message'],
                  // ),
                }
            });
  }

  // void donePOAPI() {
  //   roTotalCount(
  //           userId: PrefsConfig.getUserId(),
  //           divTextListId: "",
  //           isAdmin: PrefsConfig.getAdmin(),
  //           context: context)
  //       .then((value) => {
  //             if (value['status'] == "200")
  //               {
  //                 if (mounted)
  //                   setState(() {
  //                     roTotalCount1 = value['result'][0]['Cnt'].toString();
  //                     poDoneCount = value['result'][0]['Cnt'].toString();
  //                     roCount = double.parse(value['result'][0]['Cnt']);
  //                   }),
  //                 sumOflist(),
  //                 // widgetCounts()
  //               }
  //             else
  //               {
  //                 // Helper.snackBar(
  //                 //   context,
  //                 //   value['message'],
  //                 // ),
  //               }
  //           });
  // }

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Confirm'),
        content: const Text('Are you sure want to logout?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              logoutHere();
              Get.to(() => LoginScreen());
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    poDoneLoop();
    // getCountAPI();
    // donePOAPI();
    // getpendingSOCount();
    disPOLoop();

    totalSOCOunt1();
    // pendingROCountAPI();
    invoiceDoneLoop();
    invoicependingCount();
    pendingCount();

    super.initState();
  }

  // set counts Stringo widget function

  String poPendingCount = '0';
  String poDoneCount = '0';
  String soPendingCount = '0';
  String soDoneCount = '0';
  String rcPendingCount = '';
  String rcDoneCount = '';
  String totalPendingTask = "";
  String totalDoneTask = "0";
  String invoiceDoneCount = '0';
  String invoicePendingCount = '0';

  TextEditingController remarkCtrl = TextEditingController();

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
                              ColorConfig.primaryAppColor,
                              ColorConfig.primaryAppColor,
                            ])),
                    child: MaterialButton(
                        onPressed: () {
                          if (remarkCtrl.text.isEmpty) {
                            Helper.snackBar(context, 'Remark is Empty');
                          } else {
                            poApprovalStatusAPI(
                                    approvedDisapproved: "D",
                                    pOId: pOId,
                                    divTextListId: divTextListId,
                                    userId: PrefsConfig.getUserId(),
                                    rejectedRemark: remarkCtrl.text,
                                    context: context)
                                .then((value) => {
                                      if (value['status'] == "200")
                                        {
                                          if (mounted)
                                            setState(() {
                                              pendingPODetails(
                                                  isAdmin:
                                                      PrefsConfig.getAdmin(),
                                                  userId:
                                                      PrefsConfig.getUserId());
                                            }),
                                          Get.toNamed('/success', arguments: [
                                            poNumber,
                                            "Disapproved"
                                          ]),
                                        }
                                      else
                                        {
                                          // Helper.snackBar(
                                          //     context, value['status']),
                                        }
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
                                    });
                            setState(() {
                              remarkCtrl.clear();
                            });

                            Navigator.pop(context);
                          }
                        },
                        child: CustomText(
                          data: "Submit",
                          fColor: Colors.white,
                        )),
                  ),
                ],
              ),
            );
          });
        });
  }

  // void  widgetCounts() {
  //   WidgetKit.setItem(
  //       'widgetData', //! widgetData is Key from xcode side.
  //       jsonEncode(WidgetData(
  //           poPendingCount,
  //           poDoneCount,
  //           soPendingCount,
  //           soDoneCount,
  //           rcPendingCount,
  //           rcDoneCount,
  //           totalPendingTask,
  //           totalDoneTask)),
  //       'group.unnatiwidgets'); // app grp comes from define in xcode.
  //   WidgetKit.reloadAllTimelines();
  // }

  DateTime currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      // snackBar(context, "Pres again to exit 👋");
      Helper.snackBar(context, "Press again to exit 👋",
          color: ColorConfig.primaryAppColor);
      return Future.value(false);
    }
    return Future.value(true);
  }

  // ! Carousel Slider is start from here

  final _controller = CarouselController();

  // ! this is for dot indicator

  var _totalDots = 1;
  int _currentPosition = 0;

  int _validPosition(int position) {
    if (position >= _totalDots) return 0;
    if (position < 0) return _totalDots - 1;
    return position;
  }

  void _updatePosition(int position) {
    setState(() => _currentPosition = _validPosition(position));
  }

  Widget _buildRow(List<Widget> widgets) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widgets,
      ),
    );
  }

  String getPrettyCurrPosition() {
    return (_currentPosition + 1.0).toStringAsPrecision(3);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: RefreshIndicator(
            key: _refreshIndicatorKey,
            color: Colors.white,
            backgroundColor: Colors.blue,
            strokeWidth: 4.0,
            onRefresh: refresh,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: Get.height / 8),
                        alignment: Alignment.topCenter,
                        height: Get.height / 2.7,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                color: ColorConfig.redApp,
                                spreadRadius: 3,
                                offset: Offset(2, 3)),
                            BoxShadow(
                                blurRadius: 1,
                                color: Colors.orange,
                                spreadRadius: 3,
                                offset: Offset(8, 3)),
                          ],
                          gradient: LinearGradient(colors: [
                            Color(0xff4f4f4c),
                            Color(0xff4f4f4c),
                          ]),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                          ),
                          color: Color(0xff778899),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListTile(
                              title: totalCountList != 0
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: CircularPercentIndicator(
                                        radius: 40.0,
                                        percent:
                                            totalPendCountList / totalCountList,
                                        center: Text(
                                          '${(totalPendCountList / totalCountList * 100).toStringAsFixed(0)}%',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                        progressColor: Colors.grey[300],
                                        backgroundColor: Colors.green,
                                      ),
                                    )
                                  : Text(""),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (Theme.of(context).platform ==
                                          TargetPlatform.iOS) {
                                        _showAlertDialog(context);
                                      } else {
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.warning,
                                          animType: AnimType.rightSlide,
                                          title: 'Confirm',
                                          desc:
                                              'Are you sure want to logout?'.tr,
                                          btnCancelOnPress: () {
                                            // navigator.pop(context);
                                          },
                                          btnOkOnPress: () {
                                            logoutHere();
                                            Get.offAll(() => LoginScreen());
                                          },
                                        )..show();
                                      }
                                      ;
                                    },
                                    icon: Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Clipboard.setData(
                                      //     ClipboardData(text: fcm.toString()));
                                      _refreshIndicatorKey.currentState?.show();
                                    },
                                    child: CircleAvatar(
                                        radius: 22,
                                        backgroundColor: Colors.white,
                                        child: Image.asset(
                                          "assets/images/ic_unnati_logo.png",
                                          scale: 13,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Your Approval Task",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  " ${totalPendCountList.toInt()} /" +
                                      " ${totalCountList.toInt()} " +
                                      // "${pendingcount} /" +
                                      //     "${poDoneCount}"
                                      " Task Approved",
                                  style: TextStyle(
                                      color: Colors.grey.shade300,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: Get.height / 3.3,
                            left: Get.width / 7,
                            right: Get.width / 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(() => POPendingApprovalSCreen(),
                                    arguments: [
                                      PrefsConfig.getUserId(),
                                      PrefsConfig.getAdmin()
                                    ]);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 5,
                                child: Container(
                                  height: Get.height / 5,
                                  width: Get.width / 3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      // color: Color.fromARGB(255, 121, 225, 223),
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.orange,
                                            // Color.fromARGB(221, 106, 106, 106),
                                            Color(0xff4f4f4c),
                                          ])),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        // "${pendingcount}",
                                        double.parse(
                                                totalPendCountList.toString())
                                            .toStringAsFixed(0),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 3.0,
                                                  color: Colors.grey,
                                                  offset: Offset(1.0, 1.0),
                                                ),
                                              ],
                                              fontSize: 28.0,
                                            ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Pending \nApproval",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => PODoneAppSCreen(), arguments: [
                                  PrefsConfig.getUserId(),
                                  PrefsConfig.getAdmin(),
                                ]);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 5,
                                child: Container(
                                  height: Get.height / 5,
                                  width: Get.width / 3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.lightGreen,
                                        Color(0xff4f4f4c),
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        // "${poDoneCount}",
                                        double.parse(totalCountList.toString())
                                            .toStringAsFixed(0),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 3.0,
                                                  color: Colors.grey,
                                                  offset: Offset(1.0, 1.0),
                                                ),
                                              ],
                                              fontSize: 28.0,
                                            ),
                                        // style: TextStyle(
                                        //     color: Colors.lightGreenAccent,
                                        //     fontSize: 22,
                                        //     fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Done \nApproval",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 0,
                    child: Container(
                      height: SizeConfig.screenHeight,
                      width: Get.width / 0.9,
                      decoration: BoxDecoration(
                          // color: Colors.green,
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Approval Counter".toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: ColorConfig.primaryAppColor,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 3.0,
                                          color: Colors.grey,
                                          offset: Offset(1.0, 1.0),
                                        ),
                                      ],
                                      fontSize: 28.0,
                                    ),

                                // style: TextStyle(
                                //     color: Color(0xff262262),
                                //     fontSize: 22,
                                //     fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleContainer(
                                    color: Colors.orange, label: 'Pending'),
                                CircleContainer(
                                    color: Colors.green, label: 'Done'),
                                CircleContainer(
                                    color: Colors.red, label: 'Disapproved'),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                //Demo of UI

                                Container(
                                  height: Get.height / 6,
                                  width: Get.width / 0.9,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[300],
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Container(
                                          height: Get.height / 13,
                                          // width: Get.width / 6,
                                          width: SizeConfig.screenWidth,
                                          decoration: BoxDecoration(
                                            color: Colors.purple[100],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              "assets/images/purchase.png",
                                              height: 35,
                                              // color: Colors.purple[700],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Purchase Order Approval",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.to(
                                                        () =>
                                                            POPendingApprovalSCreen(),
                                                        arguments: [
                                                          PrefsConfig
                                                              .getUserId(),
                                                          PrefsConfig
                                                              .getAdmin(),
                                                        ]);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.red[50],
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 6,
                                                            horizontal: 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(Icons.pending,
                                                                color: Colors
                                                                    .orange,
                                                                size: 25),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              "${pendingcount}",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .orange,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                decorationThickness:
                                                                    3,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                InkWell(
                                                  onTap: () {
                                                    Get.to(
                                                        () => PODoneAppSCreen(),
                                                        arguments: [
                                                          PrefsConfig
                                                              .getUserId(),
                                                          PrefsConfig
                                                              .getAdmin(),
                                                        ]);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.green[50],
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 6,
                                                            horizontal: 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .check_circle,
                                                                color: Colors
                                                                    .green[700],
                                                                size: 25),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              "${poDoneCount}",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .green[700],
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                decorationThickness:
                                                                    3,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                InkWell(
                                                  onTap: () {
                                                    Get.to(
                                                      () => PODisAppScreen(),
                                                    );
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.green[50],
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 6,
                                                            horizontal: 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Image.asset(
                                                              "assets/images/remove.png",
                                                              height: 20,
                                                            ),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              "${disPOCount}",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .red[700],
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                decorationThickness:
                                                                    3,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // ! Carousel Slider
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // totalPendCountList != 0.0
                  //     ?
                  Column(
                    children: [
                      Divider(
                        thickness: 2,
                        indent: 30,
                        endIndent: 30,
                        color: ColorConfig.primaryAppColor,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: DotsIndicator(
                            dotsCount: _totalDots,
                            position: _currentPosition,
                            reversed: true,
                            decorator: DotsDecorator(
                                activeColor: ColorConfig.primaryAppColor,
                                color: Colors.red),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: FutureBuilder<POItemModel>(
                          future: pendingPODetails(
                              isAdmin: PrefsConfig.getAdmin(),
                              userId: PrefsConfig.getUserId(),
                              no: ""),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text("Error: ${snapshot.error}"),
                              );
                            } else if (snapshot.data == null ||
                                snapshot.data.result.isEmpty) {
                              return Text("No data available");
                            } else {
                              return CarouselSlider.builder(
                                carouselController: _controller,
                                itemCount: snapshot.data.result.length,
                                itemBuilder: (context, index, realIndex) {
                                  var list = snapshot.data.result[index];
                                  _totalDots = snapshot.data.result.length;
                                  _currentPosition = index;

                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(50)),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 255, 255, 255),
                                            Color.fromARGB(255, 255, 255, 255),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        )),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // SizedBox(
                                        //   height: 10,
                                        // ),
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
                                                            url: list.pDFLink
                                                                .toString()
                                                                .replaceAll(
                                                                    "u0026",
                                                                    "&"),
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
                                                          list.lgrName
                                                              .toString()
                                                              .replaceAll(
                                                                  'u0026', "&")
                                                              .replaceAll(
                                                                  '-', ""),
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              // color: Color(0xff48B8E1),
                                                              backgroundColor:
                                                                  Colors.white),
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
                                                title: Text("PO Number",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: ColorConfig
                                                            .primaryAppColor,
                                                        fontSize: 15)),
                                                subtitle: Text(
                                                  list.no,
                                                  style: TextStyle(
                                                      color: ColorConfig
                                                          .primaryAppColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: ListTile(
                                                title: Text("Date",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: ColorConfig
                                                            .primaryAppColor,
                                                        fontSize: 15)),
                                                subtitle: Text(
                                                  list.dt,
                                                  style: TextStyle(
                                                      color: ColorConfig
                                                          .primaryAppColor,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                title: Text("Item Name",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 104, 104, 104),
                                                        fontSize: 15)),
                                                subtitle: Text(
                                                  list.itemDetails[0].itemName,
                                                  style: TextStyle(
                                                      color: ColorConfig
                                                          .primaryAppColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: ListTile(
                                                title: Text("Total QTY",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 104, 104, 104),
                                                        fontSize: 15)),
                                                subtitle: Text(
                                                  double.parse(list.totalQty)
                                                      .toStringAsFixed(0),
                                                  style: TextStyle(
                                                      color: ColorConfig
                                                          .primaryAppColor,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                title: Text("Rate",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 104, 104, 104),
                                                        fontSize: 15)),
                                                subtitle: Text(
                                                  double.parse(list
                                                          .itemDetails[0].rate)
                                                      .toStringAsFixed(0),
                                                  style: TextStyle(
                                                      color: ColorConfig
                                                          .primaryAppColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: ListTile(
                                                title: Text("Total Amount",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 104, 104, 104),
                                                        fontSize: 15)),
                                                subtitle: Text(
                                                  double.parse(list
                                                          .itemDetails[0]
                                                          .amountWithGST)
                                                      .toStringAsFixed(0),
                                                  style: TextStyle(
                                                      color: ColorConfig
                                                          .primaryAppColor,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                title: Text(
                                                    "Grand Total Amount",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 104, 104, 104),
                                                        fontSize: 15)),
                                                subtitle: Text(
                                                  double.parse(
                                                          list.grandTotalAmt)
                                                      .toStringAsFixed(0),
                                                  style: TextStyle(
                                                      color: ColorConfig
                                                          .primaryAppColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: Get.width / 2,
                                                // height: MediaQuery.of(context).size.height / 22,

                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          Colors.green,
                                                          Colors.green,
                                                        ])),
                                                child: MaterialButton(
                                                    onPressed: () {
                                                      poApprovalStatusAPI(
                                                              approvedDisapproved:
                                                                  "A",
                                                              divTextListId: list
                                                                  .divTextListId,
                                                              context: context,
                                                              pOId: list.pOId,
                                                              userId: PrefsConfig
                                                                  .getUserId(),
                                                              rejectedRemark:
                                                                  "")
                                                          .then((value) => {
                                                                if (value[
                                                                        'status'] ==
                                                                    "200")
                                                                  {
                                                                    setState(
                                                                        () {
                                                                      pendingPODetails(
                                                                          isAdmin: PrefsConfig
                                                                              .getAdmin(),
                                                                          userId:
                                                                              PrefsConfig.getUserId());
                                                                    }),
                                                                    Get.toNamed(
                                                                        '/success',
                                                                        arguments: [
                                                                          list.no,
                                                                          "Approved"
                                                                        ]),
                                                                    Helper.snackBar(
                                                                        context,
                                                                        value[
                                                                            'status']),
                                                                  }
                                                                else
                                                                  {
                                                                    Helper.snackBar(
                                                                        context,
                                                                        value[
                                                                            'status']),
                                                                  }
                                                              });
                                                    },
                                                    child: Row(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage(
                                                                  "assets/images/checked.png"),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          "Approve",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              Container(
                                                width: Get.width / 1.9,
                                                // height: MediaQuery.of(context).size.height / 22,

                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          Color(0xffD0312D),
                                                          Color(0xffD0312D),
                                                        ])),
                                                child: MaterialButton(
                                                    onPressed: () {
                                                      alertByHK(
                                                          divTextListId: list
                                                              .divTextListId,
                                                          poNumber: list.no,
                                                          pOId: list.pOId);
                                                    },
                                                    child: Row(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage(
                                                                  "assets/images/remove.png"),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          "DisApproved",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                  // pendingPOUI(
                                  //   model: POItemModel(result: [list]),
                                  // );
                                },
                                options: CarouselOptions(
                                  height: Get.height / 1.5,
                                  autoPlay: snapshot.data.result.length <= 1
                                      ? false
                                      : true,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: true,
                                  onPageChanged: (index, reason) =>
                                      // setState(() {
                                      _currentPosition == index,
                                  // }),
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 800),
                                  viewportFraction: 1,
                                ),
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //Demo of UI

                        Container(
                          height: Get.height / 6,
                          width: Get.width / 1.00,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[300],
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  height: Get.height / 13,
                                  // width: Get.width / 6,
                                  width: SizeConfig.screenWidth,
                                  decoration: BoxDecoration(
                                    color: Colors.purple[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/images/purchase.png",
                                      height: 35,
                                      // color: Colors.purple[700],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Invoice Approval",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(
                                                () =>
                                                    InvoicePendingApprovalSCreen(),
                                                arguments: [
                                                  PrefsConfig.getUserId(),
                                                  PrefsConfig.getAdmin(),
                                                ]);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.red[50],
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6, horizontal: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.pending,
                                                        color: Colors.orange,
                                                        size: 25),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      "${invoicependingcount}",
                                                      style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        decorationThickness: 3,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 30),
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => InvoiceDoneAppSCreen(),
                                                arguments: [
                                                  PrefsConfig.getUserId(),
                                                  PrefsConfig.getAdmin(),
                                                ]);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.green[50],
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6, horizontal: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.check_circle,
                                                        color:
                                                            Colors.green[700],
                                                        size: 25),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      "${invoiceDoneCount}",
                                                      style: TextStyle(
                                                        color:
                                                            Colors.green[700],
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        decorationThickness: 3,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // SizedBox(width: 10),
                                        // InkWell(
                                        //   onTap: () {
                                        //     Get.to(
                                        //       () => InvoiceDisAppScreen(),
                                        //     );
                                        //   },
                                        //   child: Container(
                                        //     decoration: BoxDecoration(
                                        //       borderRadius:
                                        //           BorderRadius.circular(20),
                                        //       color: Colors.green[50],
                                        //     ),
                                        //     padding: EdgeInsets.symmetric(
                                        //         vertical: 6, horizontal: 10),
                                        //     child: Column(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.center,
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.center,
                                        //       children: [
                                        //         SizedBox(
                                        //           height: 5,
                                        //         ),
                                        //         Row(
                                        //           children: [
                                        //             Image.asset(
                                        //               "assets/images/remove.png",
                                        //               height: 20,
                                        //             ),
                                        //             SizedBox(width: 5),
                                        //             Text(
                                        //               "${disinvoiceCount}",
                                        //               style: TextStyle(
                                        //                 color: Colors.red[700],
                                        //                 fontSize: 20,
                                        //                 fontWeight:
                                        //                     FontWeight.bold,
                                        //                 decoration:
                                        //                     TextDecoration
                                        //                         .underline,
                                        //                 decorationThickness: 3,
                                        //               ),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ! Carousel Slider
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ]),
              ),
            ),
          )),
    );
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
          // SizedBox(
          //   height: 10,
          // ),
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

          Row(
            children: [
              Expanded(
                flex: 1,
                child: ListTile(
                  title: Text("PO Number",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
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
          Row(
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
                    model.result[0].itemDetails[0].itemName,
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
                    double.parse(model.result[0].totalQty).toStringAsFixed(0),
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
                  title: Text("Rate",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 104, 104, 104),
                          fontSize: 15)),
                  subtitle: Text(
                    double.parse(model.result[0].itemDetails[0].rate)
                        .toStringAsFixed(0),
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
                  // height: MediaQuery.of(context).size.height / 22,

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
                        poApprovalStatusAPI(
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
                                        model.result[0].no,
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
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            poNumber: model.result[0].no,
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
        ],
      ),
    );
  }
}
