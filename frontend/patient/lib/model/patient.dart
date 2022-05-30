
class Patient {
  int id;
  String username;
  String password;
  String patientName;
  String nric;
  String gender;
  String homeNo;
  String mobileNo;
  String email;
  String address;

  Patient(
      {this.id,
      this.username,
      this.password,
      this.patientName,
      this.nric,
      this.gender,
      this.homeNo,
      this.mobileNo,
      this.email,
      this.address});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    patientName = json['patientName'];
    nric = json['nric'];
    gender = json['gender'];
    homeNo = json['homeNo'];
    mobileNo = json['mobileNo'];
    email = json['email'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['patientName'] = this.patientName;
    data['nric'] = this.nric;
    data['gender'] = this.gender;
    data['homeNo'] = this.homeNo;
    data['mobileNo'] = this.mobileNo;
    data['email'] = this.email;
    data['address'] = this.address;
    return data;
  }
}
