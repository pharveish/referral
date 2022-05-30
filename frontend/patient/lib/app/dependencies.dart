
import 'package:get_it/get_it.dart';
import 'package:patient/services/document/document_service.dart';
import 'package:patient/services/document/document_service_rest.dart';
import 'package:patient/services/patient/patient_service.dart';
import 'package:patient/services/patient/patient_service_rest.dart';
import 'package:patient/services/referral/referral_service.dart';
import 'package:patient/services/referral/referral_service_rest.dart';
import 'package:patient/services/rest.dart';

GetIt dependency = GetIt.instance;
void init() {
  // Services
  dependency.registerLazySingleton<RestService>(
    //() => RestService(baseUrl: 'http://192.168.118.219:5077'),
    () => RestService(baseUrl: 'http://192.168.0.16:5077'),
    //() => RestService(baseUrl: 'http://192.168.68.107:5077'),
    //() => RestService(baseUrl: 'http://localhost:5077'),
  );

  dependency.registerLazySingleton<PatientService>(
      () => PatientServiceRest());
  dependency.registerLazySingleton<ReferralService>(
      () => ReferralServiceRest());
  dependency.registerLazySingleton<DocumentService>(
      () => DocumentServiceRest());

  // Viewmodels
  //dependency.registerLazySingleton(() => LoginViewModel());
}
