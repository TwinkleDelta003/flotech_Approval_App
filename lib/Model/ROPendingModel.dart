class ROPendingModel {
  String status;
  String message;
  List<Result> result;

  ROPendingModel({this.status, this.message, this.result});

  ROPendingModel.fromJson(Map<String, dynamic> json) {
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
  String rCId;
  String no;
  String dt;
  String lgrName;
  String effectiveDt;
  String inEffectiveDt;
  String companyName;
  String pDFLink;
  String divTextListId;

  Result(
      {this.rCId,
      this.no,
      this.dt,
      this.lgrName,
      this.effectiveDt,
      this.inEffectiveDt,
      this.companyName,
      this.pDFLink,
      this.divTextListId});

  Result.fromJson(Map<String, dynamic> json) {
    rCId = json['RCId'];
    no = json['No'];
    dt = json['Dt'];
    lgrName = json['LgrName'];
    effectiveDt = json['EffectiveDt'];
    inEffectiveDt = json['InEffectiveDt'];
    companyName = json['CompanyName'];
    pDFLink = json['PDFLink'];
    divTextListId = json['DivTextListId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RCId'] = this.rCId;
    data['No'] = this.no;
    data['Dt'] = this.dt;
    data['LgrName'] = this.lgrName;
    data['EffectiveDt'] = this.effectiveDt;
    data['InEffectiveDt'] = this.inEffectiveDt;
    data['CompanyName'] = this.companyName;
    data['PDFLink'] = this.pDFLink;
    data['DivTextListId'] = this.divTextListId;
    return data;
  }
}
