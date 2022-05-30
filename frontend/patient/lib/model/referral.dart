
class Referral {
	/*
		 {
		 "id": 2,
		 "referralDate": "0001-01-01T00:00:00",
		 "reason": "string",
		 "clinicalHistory": "string",
		 "diagnosis": "string",
		 "notes": "string",
		 "doctorFromId": 2,
		 "doctorFromName": "string",
		 "doctorToId": 1,
		 "doctorToName": "Dr. Ahmad Ali",
		 "patientId": 1,
		 "referToHospital": null,
		 "patientName": "Nadia binti Ali",
		 "patientIc": "001111-01-1213",
		 "patientGender": "Female",
		 "patientHomeNo": "07-4449921",
		 "patientMobileNo": "017-4449921",
		 "patientEmail": "nadia@example.com",
		 "patientAddress": "No 5, Jalan Laksamana 1/6, Taman Sutera Utama, 81200 Johor Bahru, Johor"
		 } 
		 */

	int id;
	DateTime referralDate;
	DateTime appointmentDate;
	String reason;
	String clinicalHistory;
	String diagnosis;
	String notes;
	int doctorFromId;
	String doctorFromName;
	int doctorToId;
	String doctorToName;
	int patientId;
	String referToHospital;
	String patientName;
	String patientIc;
	String patientGender;
	String patientHomeNo;
	String patientMobileNo;
	String patientEmail;
	String patientAddress;
	String status;
	String rejectionRemark;
	String completionMessage;
	bool radiologyExam;
	bool laboratoryTest;
	bool followUp;

	Referral({
		this.id,
		this.referralDate,
		this.appointmentDate,
		this.reason,
		this.clinicalHistory,
		this.diagnosis,
		this.notes,
		this.doctorFromId,
		this.doctorFromName,
		this.doctorToId,
		this.doctorToName,
		this.patientId,
		this.referToHospital,
		this.patientName,
		this.patientIc,
		this.patientGender,
		this.patientHomeNo,
		this.patientMobileNo,
		this.patientEmail,
		this.patientAddress,
		this.status,
		this.rejectionRemark,
		this.radiologyExam,
		this.laboratoryTest,
		this.completionMessage,
		this.followUp,
	});

	Referral.fromJson(Map<String, dynamic> json) {
		id = json['id']?.toInt();
		referralDate = DateTime.tryParse(json['referralDate']);
		appointmentDate = DateTime.tryParse(json['appointmentDate']);
		reason = json['reason']?.toString();
		clinicalHistory = json['clinicalHistory']?.toString();
		diagnosis = json['diagnosis']?.toString();
		notes = json['notes']?.toString();
		doctorFromId = json['doctorFromId']?.toInt();
		doctorFromName = json['doctorFromName']?.toString();
		doctorToId = json['doctorToId']?.toInt();
		doctorToName = json['doctorToName']?.toString();
		patientId = json['patientId']?.toInt();
		referToHospital = json['referToHospital']?.toString();
		patientName = json['patientName']?.toString();
		patientIc = json['patientIc']?.toString();
		patientGender = json['patientGender']?.toString();
		patientHomeNo = json['patientHomeNo']?.toString();
		patientMobileNo = json['patientMobileNo']?.toString();
		patientEmail = json['patientEmail']?.toString();
		patientAddress = json['patientAddress']?.toString();
		status = json['status']?.toString();
		rejectionRemark = json['rejectionRemark']?.toString();
		completionMessage = json['completionMessage']?.toString();
		radiologyExam = json['radiologyExam'];
		laboratoryTest = json['laboratoryTest'];
		followUp = json['followUp'];
	}

	Map<String, dynamic> toJson() {
		final data = <String, dynamic>{};
		data['id'] = id;
		data['referralDate'] = referralDate.toIso8601String();
		data['appointmentDate'] = appointmentDate.toIso8601String();
		data['reason'] = reason;
		data['clinicalHistory'] = clinicalHistory;
		data['diagnosis'] = diagnosis;
		data['notes'] = notes;
		data['doctorFromId'] = doctorFromId;
		data['doctorFromName'] = doctorFromName;
		data['doctorToId'] = doctorToId;
		data['doctorToName'] = doctorToName;
		data['patientId'] = patientId;
		data['referToHospital'] = referToHospital;
		data['patientName'] = patientName;
		data['patientIc'] = patientIc;
		data['patientGender'] = patientGender;
		data['patientHomeNo'] = patientHomeNo;
		data['patientMobileNo'] = patientMobileNo;
		data['patientEmail'] = patientEmail;
		data['patientAddress'] = patientAddress;
		data['status'] = status;
		data['rejectionRemark'] = rejectionRemark;
		data['radiologyExam'] = radiologyExam;
		data['laboratoryTest'] = laboratoryTest;
		data['completionMessage'] = completionMessage;
		data['followUp'] = followUp;
		return data;
	}
}
