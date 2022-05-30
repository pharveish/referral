import 'package:flutter/material.dart';
import 'package:referral/app/dependencies.dart';
import 'package:referral/model/doctor.dart';
import 'package:referral/services/doctor/doctor_service.dart';
import 'package:stacked/stacked.dart';

class RegistrationViewModel extends BaseViewModel{
	int currentStep = 0;
	String name="";
	String username="";
	String password="";
	String credentials="";
	String specialty="Internal Medicine";
	String officeNo="";
	String mobileNo="";
	String fax="";
	String email="";
	String hospital="Kempas Medical Centre";
	String practiceLocation="";

	bool hidden = true;
	DoctorService get _service => dependency();

	Doctor doctor;

	List hospitalList = ['Kempas Medical Centre', 'Maria Hospital', 'Hospital Columbia Asia Tebrau', 'Hospital Columbia Asia Nusajaya', 'Hospital Pakar Puteri', 'Hospital Pakar KPJ Johor', 'Hospital Penawar', 'Hospital Gleneagles'];

	void register(String username, String password, String email, String name, String credentials, String specialty, String officePhone, String mobilePhone, String fax, String hospital)async{
		doctor = await _service.register(username, password, email, name, credentials, specialty, officePhone, mobilePhone, fax, hospital);
		notifyListeners();
	}

//	List<dynamic> specialtyList = ['Internal Medicine', 'Orthopaedics', 'Paediatrics', 'Obstetrics', 'ENT', 'Opthalmology', 'Neurosurgery', 'Radiology', 'Anaesthesiology', 'Medical Officer'];
	List<DropdownMenuItem<String>> get specialtyList {
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem(child: Text("Internal Medicine"), value: "Internal Medicine"),
      DropdownMenuItem(child: Text("Orthopaedics"), value: "Orthopaedics"),
      DropdownMenuItem(child: Text("Paediatrics"), value: "Paediatrics"),
      DropdownMenuItem(child: Text("Obstetrics"), value: "Obstetrics"),
      DropdownMenuItem(child: Text("ENT"), value: "ENT"),
      DropdownMenuItem(child: Text("Opthalmology"), value: "Opthalmology"),
      DropdownMenuItem(child: Text("Neurosurgery"), value: "Neurosurgery"),
      DropdownMenuItem(child: Text("Radiology"), value: "Radiology"),
      DropdownMenuItem(child: Text("Anaesthesiology"), value: "Anaesthesiology"),
      DropdownMenuItem(child: Text("Medical Officer"), value: "Medical Officer"),
    ];
    return items;
  }

	List<DropdownMenuItem<String>> get hospitals {
    List<DropdownMenuItem<String>> hospitalItem = [];
    //List<DropdownMenuItem<String>> hospitalItem = [
    //  DropdownMenuItem(child: Text(hospitalList[0]), value: hospitalList[0]),
    //  DropdownMenuItem(child: Text("Orthopaedics"), value: "Orthopaedics"),
    //  DropdownMenuItem(child: Text("Paediatrics"), value: "Paediatrics"),
    //  DropdownMenuItem(child: Text("Obstetrics"), value: "Obstetrics"),
    //  DropdownMenuItem(child: Text("ENT"), value: "ENT"),
    //  DropdownMenuItem(child: Text("Opthalmology"), value: "Opthalmology"),
    //  DropdownMenuItem(child: Text("Neurosurgery"), value: "Neurosurgery"),
    //  DropdownMenuItem(child: Text("Radiology"), value: "Radiology"),
    //  DropdownMenuItem(child: Text("Anaesthesiology"), value: "Anaesthesiology"),
    //  DropdownMenuItem(child: Text("Medical Officer"), value: "Medical Officer"),
    //];

			for(int i=0; i<hospitalList.length; i++){
				hospitalItem.add(
      DropdownMenuItem(child: Text(hospitalList[i]), value: hospitalList[i]),
				);
			}
    return hospitalItem;
  }
}
