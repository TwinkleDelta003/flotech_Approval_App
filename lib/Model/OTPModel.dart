class OTPModel {
  String status;
  String message;
  List<Result> result;

  OTPModel({this.status, this.message, this.result});

  OTPModel.fromJson(Map<String, dynamic> json) {
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
  String oTP;
  String userType;

  Result({this.oTP, this.userType});

  Result.fromJson(Map<String, dynamic> json) {
    oTP = json['OTP'];
    userType = json['UserType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OTP'] = this.oTP;
    data['UserType'] = this.userType;
    return data;
  }
}
