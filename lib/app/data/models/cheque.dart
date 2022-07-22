 

class ChequeModel {

   String? id;
  String? bankName;
  String? amount;
  String? processDate;
  int? bounce;

  ChequeModel({required this.id,required this.bankName,required amount,required this.processDate,this.bounce=0 });

  ChequeModel.fromJson(Map<String, dynamic> json){
      this.id = json['id'];
      this.bankName = json['bankName'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankName'] = this.bankName;
    return data;
  }
}