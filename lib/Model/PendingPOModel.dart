class PendingPOModel {
  String status;
  String message;
  List<Result> result;

  PendingPOModel({this.status, this.message, this.result});

  PendingPOModel.fromJson(Map<String, dynamic> json) {
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
  String pOId;
  String no;
  String dt;
  String lgrName;
  String companyName;
  String pDFLink;
  String divTextListId;
  String grandTotalAmt;
  String totalQty;
  String itemName;
  String qty;
  String rate;
  String amt;

  Result(
      {this.pOId,
      this.no,
      this.dt,
      this.lgrName,
      this.companyName,
      this.pDFLink,
      this.divTextListId,
      this.grandTotalAmt,
      this.totalQty,
      this.qty,
      this.itemName,
      this.rate,
      this.amt});

  Result.fromJson(Map<String, dynamic> json) {
    pOId = json['POId'];
    no = json['No'];
    dt = json['Dt'];
    lgrName = json['LgrName'];
    companyName = json['CompanyName'];
    pDFLink = json['PDFLink'];
    divTextListId = json['DivTextListId'];
    grandTotalAmt = json['GrandTotalAmt'];
    totalQty = json['TotalQty'];
    itemName = json['ItemName'];
    qty = json['QTY'];
    rate = json['Rate'];
    amt = json['AmountWithGST'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['POId'] = this.pOId;
    data['No'] = this.no;
    data['Dt'] = this.dt;
    data['LgrName'] = this.lgrName;
    data['CompanyName'] = this.companyName;
    data['PDFLink'] = this.pDFLink;
    data['DivTextListId'] = this.divTextListId;
    data['GrandTotalAmt'] = this.grandTotalAmt;
    data['TotalQty'] = this.totalQty;
    data['ItemName'] = this.itemName;
    data['QTY'] = this.qty;
    data['Rate'] = this.rate;
    data['AmountWithGST'] = this.amt;
    return data;
  }
}
