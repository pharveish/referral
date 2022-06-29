import 'package:get_it/get_it.dart';
import 'package:referral/services/delegate/delegate_service.dart';
import 'package:referral/services/delegate/delegate_service_rest.dart';
import 'package:referral/services/document/document_service.dart';
import 'package:referral/services/document/document_service_rest.dart';
import 'package:referral/services/patient/patient_service.dart';
import 'package:referral/services/patient/patient_service_rest.dart';
import 'package:referral/services/referral/referral_service_rest.dart';
import 'package:referral/services/rest.dart';

import '../services/doctor/doctor_service.dart';
import '../services/doctor/doctor_service_rest.dart';
import '../services/referral/referral_service.dart';

GetIt dependency = GetIt.instance;
void init() {
  // Services
  dependency.registerLazySingleton<RestService>(
     //=> RestService(baseUrl: 'https://referralapp.effronsoftware.com'),
    //() => RestService(baseUrl: 'http://10.211.96.111:5077'),
    () => RestService(baseUrl: 'http://192.168.68.105:5077'),
    //() => RestService(baseUrl: 'http://192.168.0.16:5077'),
    //() => RestService(baseUrl: 'http://192.168.118.219:5077'),
    //() => RestService(baseUrl: 'http://10.211.97.186:5077'),
    //() => RestService(baseUrl: 'http://10.211.103.179:5077'),
    //() => RestService(baseUrl: 'http://localhost:5077'),
  );

  dependency.registerLazySingleton<DocumentService>(
      () => DocumentServiceRest());
  dependency.registerLazySingleton<DoctorService>(
      () => DoctorServiceRest());
  dependency.registerLazySingleton<ReferralService>(
      () => ReferralServiceRest());
  dependency.registerLazySingleton<PatientService>(
      () => PatientServiceRest());
  dependency.registerLazySingleton<DelegateService>(
      () => DelegateServiceRest());
  // Viewmodels
  //dependency.registerLazySingleton(() => LoginViewModel());
}
