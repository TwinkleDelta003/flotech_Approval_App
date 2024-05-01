class ProfileModel {
  String status;
  String message;
  List<Result> result;

  ProfileModel({this.status, this.message, this.result});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String userId;
  String firstName;
  String lastName;
  String userName;
  String password;
  String mobileno;
  String homeNo;
  String birthDate;
  String address;
  String insertedOn;
  String lastUpdatedOn;
  String isAdmin;
  String isDisabled;
  String propicsPath;
  String emailId;
  String position;
  String divTextListId;
  String isMarketingTeam;
  String team;
  String mailTo;
  String deptId;
  String pointGivenDefaultUserId;
  String projectTextListId;
  String parentUserId;
  String lastUpdatedByUserId;
  String insertedByUserId;
  String passwordUpdatedOn;
  String passwordValidDays;
  String finalApprovedUserId;
  String isAllowSMSSend;
  String defaultPage;
  String empId;
  String designation;
  String isSelfApproval;
  String perMinCost;
  String allowSendMailFromKanbnLite;
  String sMTPEmailPwd;
  String isAllGradations;
  String isDND;
  String name;
  String isEmpDisable;
  String oTP;
  String iMEI;
  String fCMId;
  String userType;
  String distributorDealerId;

  Result(
      {this.userId,
      this.firstName,
      this.lastName,
      this.userName,
      this.password,
      this.mobileno,
      this.homeNo,
      this.birthDate,
      this.address,
      this.insertedOn,
      this.lastUpdatedOn,
      this.isAdmin,
      this.isDisabled,
      this.propicsPath,
      this.emailId,
      this.position,
      this.divTextListId,
      this.isMarketingTeam,
      this.team,
      this.mailTo,
      this.deptId,
      this.pointGivenDefaultUserId,
      this.projectTextListId,
      this.parentUserId,
      this.lastUpdatedByUserId,
      this.insertedByUserId,
      this.passwordUpdatedOn,
      this.passwordValidDays,
      this.finalApprovedUserId,
      this.isAllowSMSSend,
      this.defaultPage,
      this.empId,
      this.designation,
      this.isSelfApproval,
      this.perMinCost,
      this.allowSendMailFromKanbnLite,
      this.sMTPEmailPwd,
      this.isAllGradations,
      this.isDND,
      this.name,
      this.isEmpDisable,
      this.oTP,
      this.iMEI,
      this.fCMId,
      this.userType,
      this.distributorDealerId});

  Result.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    userName = json['UserName'];
    password = json['Password'];
    mobileno = json['Mobileno'];
    homeNo = json['HomeNo'];
    birthDate = json['BirthDate'];
    address = json['Address'];
    insertedOn = json['InsertedOn'];
    lastUpdatedOn = json['LastUpdatedOn'];
    isAdmin = json['IsAdmin'];
    isDisabled = json['IsDisabled'];
    propicsPath = json['PropicsPath'];
    emailId = json['EmailId'];
    position = json['Position'];
    divTextListId = json['DivTextListId'];
    isMarketingTeam = json['IsMarketingTeam'];
    team = json['Team'];
    mailTo = json['MailTo'];
    deptId = json['DeptId'];
    pointGivenDefaultUserId = json['PointGivenDefaultUserId'];
    projectTextListId = json['ProjectTextListId'];
    parentUserId = json['ParentUserId'];
    lastUpdatedByUserId = json['LastUpdatedByUserId'];
    insertedByUserId = json['InsertedByUserId'];
    passwordUpdatedOn = json['PasswordUpdatedOn'];
    passwordValidDays = json['PasswordValidDays'];
    finalApprovedUserId = json['FinalApprovedUserId'];
    isAllowSMSSend = json['IsAllowSMSSend'];
    defaultPage = json['DefaultPage'];
    empId = json['EmpId'];
    designation = json['Designation'];
    isSelfApproval = json['IsSelfApproval'];
    perMinCost = json['PerMinCost'];
    allowSendMailFromKanbnLite = json['AllowSendMailFromKanbnLite'];
    sMTPEmailPwd = json['SMTPEmailPwd'];
    isAllGradations = json['IsAllGradations'];
    isDND = json['IsDND'];
    name = json['Name'];
    isEmpDisable = json['IsEmpDisable'];
    oTP = json['OTP'];
    iMEI = json['IMEI'];
    fCMId = json['FCMId'];
    userType = json['UserType'];
    distributorDealerId = json['DistributorDealerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['UserName'] = this.userName;
    data['Password'] = this.password;
    data['Mobileno'] = this.mobileno;
    data['HomeNo'] = this.homeNo;
    data['BirthDate'] = this.birthDate;
    data['Address'] = this.address;
    data['InsertedOn'] = this.insertedOn;
    data['LastUpdatedOn'] = this.lastUpdatedOn;
    data['IsAdmin'] = this.isAdmin;
    data['IsDisabled'] = this.isDisabled;
    data['PropicsPath'] = this.propicsPath;
    data['EmailId'] = this.emailId;
    data['Position'] = this.position;
    data['DivTextListId'] = this.divTextListId;
    data['IsMarketingTeam'] = this.isMarketingTeam;
    data['Team'] = this.team;
    data['MailTo'] = this.mailTo;
    data['DeptId'] = this.deptId;
    data['PointGivenDefaultUserId'] = this.pointGivenDefaultUserId;
    data['ProjectTextListId'] = this.projectTextListId;
    data['ParentUserId'] = this.parentUserId;
    data['LastUpdatedByUserId'] = this.lastUpdatedByUserId;
    data['InsertedByUserId'] = this.insertedByUserId;
    data['PasswordUpdatedOn'] = this.passwordUpdatedOn;
    data['PasswordValidDays'] = this.passwordValidDays;
    data['FinalApprovedUserId'] = this.finalApprovedUserId;
    data['IsAllowSMSSend'] = this.isAllowSMSSend;
    data['DefaultPage'] = this.defaultPage;
    data['EmpId'] = this.empId;
    data['Designation'] = this.designation;
    data['IsSelfApproval'] = this.isSelfApproval;
    data['PerMinCost'] = this.perMinCost;
    data['AllowSendMailFromKanbnLite'] = this.allowSendMailFromKanbnLite;
    data['SMTPEmailPwd'] = this.sMTPEmailPwd;
    data['IsAllGradations'] = this.isAllGradations;
    data['IsDND'] = this.isDND;
    data['Name'] = this.name;
    data['IsEmpDisable'] = this.isEmpDisable;
    data['OTP'] = this.oTP;
    data['IMEI'] = this.iMEI;
    data['FCMId'] = this.fCMId;
    data['UserType'] = this.userType;
    data['DistributorDealerId'] = this.distributorDealerId;
    return data;
  }
}
