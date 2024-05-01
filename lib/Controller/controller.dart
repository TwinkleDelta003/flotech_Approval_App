import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:unnati/Contants/API_URL.dart';
import 'package:unnati/Contants/PrefsConfig.dart';
import 'package:unnati/Model/POModelItem.dart';

import '../Model/ProfileModel.dart';
import '../Model/ROPendingModel.dart';
import '../Model/SOPendingModel.dart';
import '../Model/UserModel.dart';
import '../Widgets/ColorConfig.dart';
import '../Widgets/Helper.dart';

Future<UserModel> loginAPI(
    {String mobileNo, String fcmid, String imei, BuildContext context}) async {
  final response = await http.post(
    Uri.parse(lOGIN),
    body: {"MobileNo": mobileNo, "FCMId": fcmid, "IMEI": imei},
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    // Helper.snackBar(context, "Login Success",
    //     color: ColorConfig.primaryAppColor);
    // Get.offAll(() => OTPSCreen());

    // saveLoginData(mobileno: mobileNo);
    return UserModel.fromJson(data);
  } else {
    Helper.snackBar(context, "No Record Found!",
        color: ColorConfig.primaryAppColor);
    return UserModel.fromJson(data);
  }
}

//FCM ID is static
Future<ProfileModel> otpVerify(
    {String mobileNo,
    BuildContext context,
    String imei,
    String FCMId,
    String otp}) async {
  final response = await http.post(
    Uri.parse(vERIFY_OTP),
    body: {'MobileNo': mobileNo, 'FCMId': FCMId, 'OTP': otp, 'IMEI': imei},
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    Helper.snackBar(context, "Login Success");

    PrefsConfig.setUserId(ProfileModel.fromJson(data).result[0].userId);
    PrefsConfig.setDivtextId(ProfileModel.fromJson(data).result[0].userId);
    PrefsConfig.setAdmin(ProfileModel.fromJson(data).result[0].isAdmin);

    // savedataDashboard(
    //   isAdmin: ProfileModel.fromJson(data).result[0].isAdmin,
    //   userId: ProfileModel.fromJson(data).result[0].userId,
    //   divTextListId: ProfileModel.fromJson(data).result[0].divTextListId,
    //   FCMId: ProfileModel.fromJson(data).result[0].fCMId,
    //   imei: ProfileModel.fromJson(data).result[0].iMEI,
    // );
    Get.offAllNamed(
      '/Dashboard',
      arguments: [
        ProfileModel.fromJson(data).result[0].userId,
        ProfileModel.fromJson(data).result[0].isAdmin,
        ProfileModel.fromJson(data).result[0].divTextListId
      ],
    );
    print(data);
    return ProfileModel.fromJson(data);
  } else {
    Helper.snackBar(context, "OTP Invalid!",
        color: ColorConfig.primaryAppColor);
    return ProfileModel.fromJson(data);
  }
}

Future pendingCountAPI({
  String userId,
  BuildContext context,
  String isAdmin,
  String divTextListId,
}) async {
  final response = await http.post(
    Uri.parse(pendingCount),
    body: {'UserId': userId, 'IsAdmin': "true", 'DivTextListId': divTextListId},
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    return data;
  } else {
    return data;
  }
}

Future disPOCountAPI({
  String userId,
  BuildContext context,
  String isAdmin,
  String divTextListId,
}) async {
  final response = await http.post(
    Uri.parse(disPOCountURL),
    body: {'UserId': userId, 'IsAdmin': "true", 'DivTextListId': divTextListId},
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    // Helper.snackBar(context, "Login ",
    //     color: ColorConfig.primaryAppColor);
    // Get.offAll(() => OTPSCreen());
    return data;
  } else {
    // Helper.snackBar(context, "OTP Invalid!",
    //     color: ColorConfig.primaryAppColor);
    return data;
  }
}

Future poDoneCountAPI({
  String userId,
  BuildContext context,
  String isAdmin,
  String divTextListId,
}) async {
  final response = await http.post(
    Uri.parse(poDoneCount),
    body: {'UserId': userId, 'IsAdmin': "true", 'DivTextListId': divTextListId},
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    // Helper.snackBar(context, "Login Success",
    //     color: ColorConfig.primaryAppColor);
    // Get.offAll(() => OTPSCreen());
    return data;
  } else {
    // Helper.snackBar(context, "OTP Invalid!",
    //     color: ColorConfig.primaryAppColor);
    return data;
  }
}

Future pendingSOCOunt({
  String userId,
  BuildContext context,
  String isAdmin,
  String divTextListId,
}) async {
  final response = await http.post(
    Uri.parse(SO_PENDING_COUNT),
    body: {
      'UserId': userId,
      'IsAdmin': isAdmin,
      'DivTextListId': divTextListId
    },
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    // Helper.snackBar(context, "Login Success",
    //     color: ColorConfig.primaryAppColor);
    // Get.offAll(() => OTPSCreen());
    return data;
  } else {
    // Helper.snackBar(context, "OTP Invalid!",
    //     color: ColorConfig.primaryAppColor);
    return data;
  }
}

Future totalSOCOunt({
  String userId,
  BuildContext context,
  String isAdmin,
  String divTextListId,
}) async {
  final response = await http.post(
    Uri.parse(SO_TOTAL_COUNT),
    body: {
      'UserId': userId,
      'IsAdmin': isAdmin,
      'DivTextListId': divTextListId
    },
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    // Helper.snackBar(context, "Login Success",
    //     color: ColorConfig.primaryAppColor);
    // Get.offAll(() => OTPSCreen());
    return data;
  } else {
    // Helper.snackBar(context, "OTP Invalid!",
    //     color: ColorConfig.primaryAppColor);
    return data;
  }
}

Future pendingROCount({
  String userId,
  BuildContext context,
  String isAdmin,
  String divTextListId,
}) async {
  final response = await http.post(
    Uri.parse(RC_PENDING_COUNT),
    body: {
      'UserId': userId,
      'IsAdmin': isAdmin,
      'DivTextListId': divTextListId
    },
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    // Helper.snackBar(context, "Login Success",
    //     color: ColorConfig.primaryAppColor);
    // Get.offAll(() => OTPSCreen());
    return data;
  } else {
    // Helper.snackBar(context, "OTP Invalid!",
    //     color: ColorConfig.primaryAppColor);
    return data;
  }
}

Future roTotalCount({
  String userId,
  BuildContext context,
  String isAdmin,
  String divTextListId,
}) async {
  final response = await http.post(
    Uri.parse(RC_TOTAL_COUNT),
    body: {
      'UserId': userId,
      'IsAdmin': isAdmin,
      'DivTextListId': divTextListId
    },
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    // Helper.snackBar(context, "Login Success",
    //     color: ColorConfig.primaryAppColor);
    // Get.offAll(() => OTPSCreen());
    return data;
  } else {
    // Helper.snackBar(context, "OTP Invalid!",
    //     color: ColorConfig.primaryAppColor);
    return data;
  }
}

Future<POItemModel> pendingPODetails({
  String userId,
  String isAdmin,
  String no,
}) async {
  final response = await http.post(
    Uri.parse(PO_PENDING_DETAIL_LIST),
    body: {
      'UserId': userId,
      'IsAdmin': "true",
      'No': "",
    },
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    // Helper.snackBar(context, "Login Success",
    //     color: ColorConfig.primaryAppColor);

    return POItemModel.fromJson(data);
  } else {
    // Helper.snackBar(context, "OTP Invalid!",
    //     color: ColorConfig.primaryAppColor);
    return POItemModel.fromJson(data);
  }
}

Future<POItemModel> pendingPOWithItem(
    {String userId, String isAdmin, String no}) async {
  final response = await http.post(
    Uri.parse(PO_PENDING_DETAIL_LIST),
    body: {
      'UserId': userId,
      'IsAdmin': "true",
      'No': "",
    },
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    return POItemModel.fromJson(data);
  } else {
    return POItemModel.fromJson(data);
  }
}

Future<POItemModel> disPOAPIList({
  String userId,
  String isAdmin,
  String no,
}) async {
  final response = await http.post(
    Uri.parse(disPOListURL),
    body: {
      'UserId': userId,
      'IsAdmin': "true",
      'No': no,
    },
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);

    return POItemModel.fromJson(data);
  } else {
    return POItemModel.fromJson(data);
  }
}

Future<POItemModel> doneApprovalList(
    {String userId, String isAdmin, String no, int page, int pageSize}) async {
  final response = await http.post(
    Uri.parse(PO_TOTAL__DETAIL_LIST),
    body: {
      'UserId': userId,
      'IsAdmin': "true",
      'No': no,
      'Page': page.toString(), // Include page parameter in the request
      'PageSize':
          pageSize.toString(), // Include pageSize parameter in the request
    },
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    return POItemModel.fromJson(data);
  } else {
    return POItemModel.fromJson(data);
  }
}

Future<SOPendingModel> soPendingList({
  String userId,
  String isAdmin,
}) async {
  final response = await http.post(
    Uri.parse(SO_PENDING_DETAIL_LIST),
    body: {
      'UserId': userId,
      'IsAdmin': isAdmin,
    },
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    return SOPendingModel.fromJson(data);
  } else {
    return SOPendingModel.fromJson(data);
  }
}

Future<SOPendingModel> soDoneApprovalAPI({
  String userId,
  String isAdmin,
}) async {
  final response = await http.post(
    Uri.parse(SO_TOTAL__DETAIL_LIST),
    body: {
      'UserId': userId,
      'IsAdmin': isAdmin,
    },
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    return SOPendingModel.fromJson(data);
  } else {
    return SOPendingModel.fromJson(data);
  }
}

Future<ROPendingModel> roPendingApprovalAPI({
  String userId,
  String isAdmin,
}) async {
  final response = await http.post(
    Uri.parse(RC_PENDING_DETAIL_LIST),
    body: {
      'UserId': userId,
      'IsAdmin': isAdmin,
    },
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    return ROPendingModel.fromJson(data);
  } else {
    return ROPendingModel.fromJson(data);
  }
}

Future<ROPendingModel> roDoneApprovalAPI({
  String userId,
  String isAdmin,
}) async {
  final response = await http.post(
    Uri.parse(RC_TOTAL__DETAIL_LIST),
    body: {
      'UserId': userId,
      'IsAdmin': isAdmin,
    },
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    return ROPendingModel.fromJson(data);
  } else {
    return ROPendingModel.fromJson(data);
  }
}

Future poApprovalStatusAPI({
  String userId,
  String divTextListId,
  String approvedDisapproved,
  String pOId,
  BuildContext context,
  String rejectedRemark,
}) async {
  final response = await http.post(
    Uri.parse(PO_APPROVAL_STATUS),
    body: {
      'UserId': userId,
      'DivTextListId': divTextListId,
      'ApprovedDisapproved': approvedDisapproved,
      'POId': pOId,
      'RejectedRemark': rejectedRemark
    },
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    return data;
  } else {
    return data;
  }
}

Future rcApprovalStatusAPI(
    {String userId,
    String divTextListId,
    String approvedDisapproved,
    String rcId,
    String rejectedRemark,
    BuildContext context}) async {
  final response = await http.post(
    Uri.parse(RC_APPROVAL_STATUS),
    body: {
      'UserId': userId,
      'DivTextListId': divTextListId,
      'ApprovedDisapproved': approvedDisapproved,
      'RCId': rcId,
      'RejectedRemark': rejectedRemark,
    },
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    Helper.snackBar(context, data["message"],
        color: ColorConfig.primaryAppColor);
    return data;
  } else {
    return data;
  }
}

Future soApprovalStatusAPI(
    {String userId,
    String divTextListId,
    String approvedDisapproved,
    String soId,
    String rejectedRemark,
    BuildContext context}) async {
  final response = await http.post(
    Uri.parse(SO_APPROVAL_STATUS),
    body: {
      'UserId': userId,
      'DivTextListId': divTextListId,
      'ApprovedDisapproved': approvedDisapproved,
      'SOId': soId,
      'RejectedRemark': rejectedRemark,
    },
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    Helper.snackBar(context, "Status Updated Successfully",
        color: ColorConfig.primaryAppColor);
    return data;
  } else {
    return data;
  }
}

//// ----  INVOICE LIST API ---- ////
Future<POItemModel> pendingInvoiceWithItem(
    {String userId, String isAdmin, String no}) async {
  final response = await http.post(
    Uri.parse(Invoice_Pending_DETAIL_LIST),
    body: {
      'UserId': userId,
      'IsAdmin': "true",
      'No': "",
    },
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    return POItemModel.fromJson(data);
  } else {
    return POItemModel.fromJson(data);
  }
}

Future invoicependingCountAPI({
  String userId,
  BuildContext context,
  String isAdmin,
  String divTextListId,
}) async {
  final response = await http.post(
    Uri.parse(invoicePendingcount),
    body: {'UserId': userId, 'IsAdmin': "true", 'DivTextListId': divTextListId},
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);

    return data;
  } else {
    return data;
  }
}

Future<POItemModel> doneApprovalinvoiceList(
    {String userId, String isAdmin, String no, int page, int pageSize}) async {
  final response = await http.post(
    Uri.parse(Invoice_TOTAL__DETAIL_LIST),
    body: {
      'UserId': userId,
      'IsAdmin': "true",
      'No': no,
      'Page': page.toString(),
      'PageSize': pageSize.toString(),
    },
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    return POItemModel.fromJson(data);
  } else {
    return POItemModel.fromJson(data);
  }
}

Future invoiceDoneCountAPI({
  String userId,
  BuildContext context,
  String isAdmin,
  String divTextListId,
}) async {
  final response = await http.post(
    Uri.parse(invoiceDoneCount),
    body: {'UserId': userId, 'IsAdmin': "true", 'DivTextListId': divTextListId},
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    return data;
  } else {
    return data;
  }
}

Future disinvoiceCountAPI({
  String userId,
  BuildContext context,
  String isAdmin,
  String divTextListId,
}) async {
  final response = await http.post(
    Uri.parse(disPOCountURL),
    body: {'UserId': userId, 'IsAdmin': "true", 'DivTextListId': divTextListId},
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);

    return data;
  } else {
    return data;
  }
}

Future<POItemModel> disInvoiceAPIList({
  String userId,
  String isAdmin,
  String no,
}) async {
  final response = await http.post(
    Uri.parse(disPOListURL),
    body: {
      'UserId': userId,
      'IsAdmin': "true",
      'No': no,
    },
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    return POItemModel.fromJson(data);
  } else {
    return POItemModel.fromJson(data);
  }
}

Future invoiceApprovalStatusAPI({
  String userId,
  String divTextListId,
  String approvedDisapproved,
  String pOId,
  BuildContext context,
  String rejectedRemark,
}) async {
  final response = await http.post(
    Uri.parse(invoice_APPROVAL_STATUS),
    body: {
      'UserId': userId,
      'DivTextListId': divTextListId,
      'ApprovedDisapproved': approvedDisapproved,
      'POId': pOId,
      'RejectedRemark': rejectedRemark
    },
  );
  var data = json.decode(response.body);

  if (data['status'] == "200") {
    print(data);
    return data;
  } else {
    return data;
  }
}
