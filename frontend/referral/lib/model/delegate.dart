class Delegate {
  int id;
  int delegateFromId;
  String delegateFromName;
  String delegateFromSpecialty;
  String delegateFromCredentials;
  int delegateToId;
  String delegateToName;
  String delegateToSpecialty;
  String delegateToCredentials;

  Delegate(
      {this.id,
      this.delegateFromId,
      this.delegateFromName,
      this.delegateFromSpecialty,
      this.delegateFromCredentials,
      this.delegateToId,
      this.delegateToName,
      this.delegateToSpecialty,
      this.delegateToCredentials});

  Delegate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    delegateFromId = json['delegateFromId'];
    delegateFromName = json['delegateFromName'];
    delegateFromSpecialty = json['delegateFromSpecialty'];
    delegateFromCredentials = json['delegateFromCredentials'];
    delegateToId = json['delegateToId'];
    delegateToName = json['delegateToName'];
    delegateToSpecialty = json['delegateToSpecialty'];
    delegateToCredentials = json['delegateToCredentials'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['delegateFromId'] = this.delegateFromId;
    data['delegateFromName'] = this.delegateFromName;
    data['delegateFromSpecialty'] = this.delegateFromSpecialty;
    data['delegateFromCredentials'] = this.delegateFromCredentials;
    data['delegateToId'] = this.delegateToId;
    data['delegateToName'] = this.delegateToName;
    data['delegateToSpecialty'] = this.delegateToSpecialty;
    data['delegateToCredentials'] = this.delegateToCredentials;
    return data;
  }
}
