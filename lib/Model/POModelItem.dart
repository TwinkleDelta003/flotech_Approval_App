class POItemModel {
  String status;
  String message;
  List<Result> result;

  POItemModel({this.status, this.message, this.result});

  POItemModel.fromJson(Map<String, dynamic> json) {
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
  String lgrName;
  String companyName;
  String pDFLink;
  String dt;
  String divTextListId;
  String grandTotalAmt;
  String totalQty;
  String insertedOn;
  String disApprovedReason;
  String approvedDisapprovedOn;
  String insertedOnUserName;
  String approvedDisapprovedbyUserName;
  List<ItemDetails> itemDetails;

  Result(
      {this.pOId,
      this.no,
      this.lgrName,
      this.companyName,
      this.pDFLink,
      this.dt,
      this.divTextListId,
      this.grandTotalAmt,
      this.totalQty,
      this.insertedOn,
      this.disApprovedReason,
      this.approvedDisapprovedOn,
      this.insertedOnUserName,
      this.approvedDisapprovedbyUserName,
      this.itemDetails});

  Result.fromJson(Map<String, dynamic> json) {
    pOId = json['POId'];
    no = json['No'];
    lgrName = json['LgrName'];
    companyName = json['CompanyName'];
    pDFLink = json['PDFLink'];
    dt = json['Dt'];
    divTextListId = json['DivTextListId'];
    grandTotalAmt = json['GrandTotalAmt'];
    totalQty = json['TotalQty'];
    insertedOn = json['InsertedOn'];
    disApprovedReason = json['DisApprovedReason'];
    approvedDisapprovedOn = json['ApprovedDisapprovedOn'];
    insertedOnUserName = json['InsertedOnUserName'];
    approvedDisapprovedbyUserName = json['ApprovedDisapprovedbyUserName'];
    if (json['ItemDetails'] != null) {
      itemDetails = <ItemDetails>[];
      json['ItemDetails'].forEach((v) {
        itemDetails.add(new ItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['POId'] = this.pOId;
    data['No'] = this.no;
    data['LgrName'] = this.lgrName;
    data['CompanyName'] = this.companyName;
    data['PDFLink'] = this.pDFLink;
    data['Dt'] = this.dt;
    data['DivTextListId'] = this.divTextListId;
    data['GrandTotalAmt'] = this.grandTotalAmt;
    data['TotalQty'] = this.totalQty;
    data['InsertedOn'] = this.insertedOn;
    data['DisApprovedReason'] = this.disApprovedReason;
    data['ApprovedDisapprovedOn'] = this.approvedDisapprovedOn;
    data['InsertedOnUserName'] = this.insertedOnUserName;
    data['ApprovedDisapprovedbyUserName'] = this.approvedDisapprovedbyUserName;
    if (this.itemDetails != null) {
      data['ItemDetails'] = this.itemDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemDetails {
  String lnNo;
  String itemName;
  String qty;
  String rate;
  String amountWithGST;

  ItemDetails(
      {this.lnNo, this.itemName, this.qty, this.rate, this.amountWithGST});

  ItemDetails.fromJson(Map<String, dynamic> json) {
    lnNo = json['LnNo'];
    itemName = json['ItemName'];
    qty = json['Qty'];
    rate = json['Rate'];
    amountWithGST = json['AmountWithGST'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LnNo'] = this.lnNo;
    data['ItemName'] = this.itemName;
    data['Qty'] = this.qty;
    data['Rate'] = this.rate;
    data['AmountWithGST'] = this.amountWithGST;
    return data;
  }
}
