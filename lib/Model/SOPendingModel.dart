class SOPendingModel {
  String status;
  String message;
  List<Result> result;

  SOPendingModel({this.status, this.message, this.result});

  SOPendingModel.fromJson(Map<String, dynamic> json) {
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
  String sOId;
  String dt;
  String no;
  String custName;
  String grandTotalAmt;
  String remarks;
  String companyName;
  String pDFLink;
  String divTextListId;

  Result(
      {this.sOId,
      this.dt,
      this.no,
      this.custName,
      this.grandTotalAmt,
      this.remarks,
      this.companyName,
      this.pDFLink,
      this.divTextListId});

  Result.fromJson(Map<String, dynamic> json) {
    sOId = json['SOId'];
    dt = json['Dt'];
    no = json['No'];
    custName = json['CustName'];
    grandTotalAmt = json['GrandTotalAmt'];
    remarks = json['Remarks'];
    companyName = json['CompanyName'];
    pDFLink = json['PDFLink'];
    divTextListId = json['DivTextListId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SOId'] = this.sOId;
    data['Dt'] = this.dt;
    data['No'] = this.no;
    data['CustName'] = this.custName;
    data['GrandTotalAmt'] = this.grandTotalAmt;
    data['Remarks'] = this.remarks;
    data['CompanyName'] = this.companyName;
    data['PDFLink'] = this.pDFLink;
    data['DivTextListId'] = this.divTextListId;
    return data;
  }
}
