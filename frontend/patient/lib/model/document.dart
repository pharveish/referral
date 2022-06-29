class Document {
  String id;
  String fileName;
  String contentType;
  String fileSize;
  int referralId;

  Document(
      {this.id,
      this.fileName,
      this.contentType,
      this.fileSize,
      this.referralId});

  Document.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['fileName'];
    contentType = json['contentType'];
    fileSize = json['fileSize'];
    referralId = json['referralId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fileName'] = this.fileName;
    data['contentType'] = this.contentType;
    data['fileSize'] = this.fileSize;
    data['referralId'] = this.referralId;
    return data;
  }
}
