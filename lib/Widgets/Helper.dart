import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unnati/Widgets/ColorConfig.dart';

import '../Contants/responsiveSize.dart';

class Helper {
  Widget customAppBarDashboard(
      {@required String title, double fontSize, List<Widget> action, lead}) {
    return AppBar(
      actions: action,
      leading: lead,
      title: Text(
        title,
        style: TextStyle(fontSize: fontSize ?? 22),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffFF8A8A), Color(0xffFFCC4A)],
          ),
        ),
      ),
    );
  }

  Widget customAppBar(
      {@required String title, double fontSize, List<Widget> action}) {
    return AppBar(
      actions: action,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: fontSize ?? 22),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffFF8A8A), Color(0xffFFCC4A)],
          ),
        ),
      ),
    );
  }

  Widget workWisecustomAppBar(
      {@required String title, double fontSize, List<Widget> action}) {
    return AppBar(
      actions: action,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 25),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffFF8A8A), Color(0xffFFCC4A)],
          ),
        ),
      ),
    );
  }

  Widget customPassTextField({
    String hintText,
    TextEditingController controller,
    BuildContext context,
    int maxLines,
    bool obscureText,
    Widget suffix,
    bool isEnabled,
    TextInputType type,
    int mLength,
    Function(String) onChange,
    Widget prefix,
    String initText,
    String lText,
    bool autoFocus,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextFormField(
        style: TextStyle(
            fontWeight: FontWeight.w600, color: Colors.grey, fontSize: 16.0),
        initialValue: initText,
        textInputAction: TextInputAction.next,
        maxLength: mLength,
        enabled: isEnabled,
        onChanged: onChange,
        controller: controller,
        obscureText: obscureText,
        keyboardType: type,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          counterText: "",
          hintText: hintText,
          filled: true,
          // fillColor: primaryColor,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(10)),
          hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
            // color: hintColor,
            fontSize: 16.0,
          ),
          labelText: lText,
          prefixIcon: prefix,
          suffixIcon: suffix,
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
          // border: UnderlineInputBorder(),
        ),
      ),
    );
  }

  static Widget customText(
      {@required String title,
      double fSize,
      Color color,
      FontWeight fW,
      TextAlign align}) {
    return Text(
      title,
      textAlign: align,
      style: TextStyle(
        fontSize: fSize ?? 16,
        color: color,
        fontWeight: fW,
      ),
    );
  }

  Widget customTextField(
      {@required String title,
      TextEditingController controller,
      int length,
      double textFieldWidth,
      bool enabled,
      TextAlign align,
      dynamic onChange,
      TextInputType type,
      String hText,
      Widget extraWidget}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Helper.customText(
            title: title,
            fW: FontWeight.w600,
          ),
          SizedBox(
            width: 20,
          ),
          extraWidget ??
              Container(
                height: 30,
                width: textFieldWidth ?? Get.width / 2,
                child: TextField(
                  textAlign: align ?? TextAlign.left,
                  controller: controller,
                  onChanged: onChange,
                  enabled: enabled,
                  keyboardType: type,
                  maxLength: length,
                  decoration: InputDecoration(
                    hintTextDirection: TextDirection.ltr,
                    hintText: hText,
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    counterText: "",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    fillColor: Color(0xffEDEDED),
                    filled: true,
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffEDEDED),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffEDEDED),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffEDEDED),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              )
        ],
      ),
    );
  }

  Widget customMaterialButton(
      {@required VoidCallback onTap, @required String bName, Widget widget}) {
    return Container(
        height: Get.height / 22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [Color(0xffFF8A8A), Color(0xffFFCC4A)],
          ),
        ),
        width: Get.width / 1.1,
        child: MaterialButton(
                onPressed: onTap,
                child: Helper.customText(
                    title: bName,
                    color: Colors.white,
                    fSize: 20,
                    fW: FontWeight.w600)) ??
            widget);
  }

  Future<void> selectPhoto(
      ImageSource source, StateSetter setState, XFile image) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          image = pickedImage;
        });
      }
    } catch (e) {
      image = null;

      setState(() {});
    }
  }

  Widget customReportWidget(
      {@required String title,
      Widget extraWidget,
      String data1,
      String data2,
      String data3}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Helper.customText(
            title: title,
            fW: FontWeight.w600,
          ),
          SizedBox(
            width: 20,
          ),
          Container(
              width: Get.width / 9,
              child: Helper.customText(title: data1, color: Color(0xff8F8F8F))),
          Container(
              width: Get.width / 9,
              child: Helper.customText(title: data2, color: Color(0xff8F8F8F))),
          Container(
              width: Get.width / 9,
              child: Helper.customText(title: data3, color: Color(0xff8F8F8F))),
        ],
      ),
    );
  }

  Widget customContractReport(
      {String title,
      String name,
      String uname,
      String qty,
      String rate,
      String total}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: SizeConfig.screenHeight,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Helper.customText(
                    title: title,
                    color: Color(0xffFF8B88),
                    fW: FontWeight.w700,
                    fSize: 24),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Helper.customText(
                      title: "Contractor Name",
                      fSize: 18,
                      fW: FontWeight.w700,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Helper.customText(
                        title: name,
                        fW: FontWeight.w400,
                        fSize: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Helper.customText(
                      title: "Unique Name",
                      fSize: 18,
                      fW: FontWeight.w700,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60),
                      child: Helper.customText(
                        title: uname,
                        fW: FontWeight.w400,
                        fSize: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Helper.customText(
                      title: "Qty",
                      fSize: 18,
                      fW: FontWeight.w700,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 135),
                      child: Helper.customText(
                        title: qty,
                        fW: FontWeight.w400,
                        fSize: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Helper.customText(
                      title: "Rate",
                      fSize: 18,
                      fW: FontWeight.w700,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 130),
                      child: Helper.customText(
                        title: rate,
                        fW: FontWeight.w400,
                        fSize: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Helper.customText(
                      title: "Total",
                      fSize: 18,
                      fW: FontWeight.w700,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 128),
                      child: Helper.customText(
                        title: total,
                        fW: FontWeight.w400,
                        fSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget customProductReport({
    String title,
    String id,
    String pName,
    String cName,
    String jName,
    String deduct,
    String qty,
    String pValue,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: SizeConfig.screenHeight,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Helper.customText(
                    title: title,
                    color: Color(0xffFF8B88),
                    fW: FontWeight.w700,
                    fSize: 24),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Helper.customText(
                      title: "ID",
                      fSize: 18,
                      fW: FontWeight.w700,
                    ),
                    Container(
                      width: Get.width / 3,
                      child: Helper.customText(
                        title: id,
                        fW: FontWeight.w400,
                        fSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Helper.customText(
                      title: "Product Name",
                      fSize: 18,
                      fW: FontWeight.w700,
                    ),
                    Container(
                      width: Get.width / 3,
                      child: Helper.customText(
                        title: pName,
                        fW: FontWeight.w400,
                        fSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Helper.customText(
                      title: "Contractor Name",
                      fSize: 18,
                      fW: FontWeight.w700,
                    ),
                    Container(
                      width: Get.width / 3,
                      child: Helper.customText(
                        title: cName,
                        fW: FontWeight.w400,
                        fSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Helper.customText(
                      title: "Job Name",
                      fSize: 18,
                      fW: FontWeight.w700,
                    ),
                    Container(
                      width: Get.width / 3,
                      child: Helper.customText(
                        title: jName,
                        fW: FontWeight.w400,
                        fSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Helper.customText(
                      title: "Type Of Deduction",
                      fSize: 18,
                      fW: FontWeight.w700,
                    ),
                    Container(
                      width: Get.width / 3,
                      child: Helper.customText(
                        title: deduct,
                        fW: FontWeight.w400,
                        fSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Helper.customText(
                      title: "Production Qty",
                      fSize: 18,
                      fW: FontWeight.w700,
                    ),
                    Container(
                      width: Get.width / 3,
                      child: Helper.customText(
                        title: qty,
                        fW: FontWeight.w400,
                        fSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Helper.customText(
                      title: "Production Value",
                      fSize: 18,
                      fW: FontWeight.w700,
                    ),
                    Container(
                      width: Get.width / 3,
                      child: Helper.customText(
                        title: pValue,
                        fW: FontWeight.w400,
                        fSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget customCostingReport({
    String title,
    String id,
    String pName,
    String cName,
    String jName,
    String deduct,
    String qty,
    String pValue,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: SizeConfig.screenHeight,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Helper.customText(
                    title: title,
                    color: Color(0xffFF8B88),
                    fW: FontWeight.w700,
                    fSize: 24),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Helper.customText(
                      title: "Cost ID",
                      fSize: 18,
                      fW: FontWeight.w700,
                    ),
                    Container(
                      width: Get.width / 3,
                      child: Helper.customText(
                        title: id,
                        fW: FontWeight.w400,
                        fSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Helper.customText(
                      title: "Type of Cost",
                      fSize: 18,
                      fW: FontWeight.w700,
                    ),
                    Container(
                      width: Get.width / 3,
                      child: Helper.customText(
                        title: pName,
                        fW: FontWeight.w400,
                        fSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Helper.customText(
                      title: "Contractor Name",
                      fSize: 18,
                      fW: FontWeight.w700,
                    ),
                    Container(
                      width: Get.width / 3,
                      child: Helper.customText(
                        title: cName,
                        fW: FontWeight.w400,
                        fSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Helper.customText(
                      title: "Job Name",
                      fSize: 18,
                      fW: FontWeight.w700,
                    ),
                    Container(
                      width: Get.width / 3,
                      child: Helper.customText(
                        title: jName,
                        fW: FontWeight.w400,
                        fSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Helper.customText(
                      title: "Type Of Deduction",
                      fSize: 18,
                      fW: FontWeight.w700,
                    ),
                    Container(
                      width: Get.width / 3,
                      child: Helper.customText(
                        title: deduct,
                        fW: FontWeight.w400,
                        fSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Helper.customText(
                      title: "Production Qty",
                      fSize: 18,
                      fW: FontWeight.w700,
                    ),
                    Container(
                      width: Get.width / 3,
                      child: Helper.customText(
                        title: qty,
                        fW: FontWeight.w400,
                        fSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Helper.customText(
                      title: "Production Value",
                      fSize: 18,
                      fW: FontWeight.w700,
                    ),
                    Container(
                      width: Get.width / 3,
                      child: Helper.customText(
                        title: pValue,
                        fW: FontWeight.w400,
                        fSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  static snackBar(BuildContext context, String text, {Color color}) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,

      content: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 12, color: Colors.white),
      ),
      //width: 10,
      elevation: 6.0,
      duration: const Duration(seconds: 3),
      backgroundColor: color ?? ColorConfig.primaryAppColor,
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
