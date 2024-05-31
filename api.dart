import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

String server80 = "http://192.168.5.22:8080/";
String server84 = "http://192.168.5.22:8084/";
String serverLocal85 = "http://192.168.5.22:8085/";
String server85 = "http://192.168.5.35:8085/";
String server82 = "http://192.168.5.22:8082/";
String server86 = "http://192.168.5.22:8086/";
String server88 = "http://192.168.5.22:8088/";
String server90 = "http://192.168.5.22:8090/";
String server81 = "http://192.168.5.22:8081/";

String obocwwbUrlNew = "http://192.168.5.35:8085/";

// http://192.168.5.22:8085/
String funeralBaseUrl = serverLocal85+"funeralassistanceservices/";
String maternitySaveBaseUrl =serverLocal85+"maternitybenefitservices/";
String marriageSaveBaseUrl =serverLocal85+"marriageassistanceservices/";
String marriageBenefitSaveBaseUrl =serverLocal85+"marriageassistanceservices/";
String deathBenefitBaseUrl =serverLocal85+"deathbenefitservices/";

//http://192.168.5.35:8085/
String educationBaseUrl= server85+"educationservices/";

//http://192.168.5.22:8084/
String loginBaseUr = /*server84*/obocwwbUrlNew +"registrationservices/";
String nomineeBaseUrl =/*server84*/obocwwbUrlNew+"registrationservices/";

//http://192.168.5.22:8082/
String schemeBaseUrl = obocwwbUrlNew+"commonservices/data/";
String loginUrl = /*server82*/obocwwbUrlNew+"commonservices/";

//http://192.168.5.22:8080/
String setupBaseUrl = /*server80*/obocwwbUrlNew+"mwservices/";
String ulbUrl =/*server80*/obocwwbUrlNew+"mwservices/";

//http://192.168.5.22:8086/

String marriageUrl = /*server86*/obocwwbUrlNew+"marriageassistanceservices/";

//http://192.168.5.22:8088/
String maternityBaseUrl =/*server88*/obocwwbUrlNew+"maternitybenefitservices/";

//http://192.168.5.22:8090/
String deathUrl =/*server90*/obocwwbUrlNew+"deathbenefitservices/";

//http://192.168.5.22:8081/
String obocwwbUrl = /*server81*/obocwwbUrlNew+"public/checkRegistrationDetails";
String obocwwbUrl1 = /*server81*/obocwwbUrlNew+"obocwwb/public/initiateDeathBenefit/";
String obocwwbUrl2 = /*server81*/obocwwbUrlNew+"obocwwb/public/initiateFuneralAssistanceSchema/";

class Api {

  //AuthService
  static Future getLoginService(String encodedData, Map<String, String> headers) {
    var url = loginUrl + "publicLogin";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }
  static Future generateOtp(String encodedData, Map<String, String> headers) {
    var url = loginBaseUr + "public/generateOtp";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  //RegistrationServices
  static getNomineeBaseUrl(){
    return nomineeBaseUrl;
  }

  static Future getWorkerNomineeDetailsProfile(String encodedData, Map<String, String> headers) {
    var url = loginBaseUr + "getWorkerNomineeDetailsProfile";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getOneTimeRegistrationDetails(String encodedData, Map<String, String> headers) {
    var url = loginBaseUr + "getOneTimeRegistrationDetails";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future saveWorkerNominee(String encodeData, Map<String, String> headers) {
    var url = nomineeBaseUrl + "saveWorkerNominee";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future deleteWorkerFamilyMember(String encodeData, Map<String, String> headers) {
    var url = nomineeBaseUrl + "deleteWorkerFamilyMember";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future deleteWorkerNominee(String encodeData, Map<String, String> headers) {
    var url = nomineeBaseUrl + "deleteWorkerNominee";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future saveWorkerFamilyMemberDetails(String encodeData, Map<String, String> headers) {
    var url = nomineeBaseUrl + "saveWorkerFamilyMemberDetails";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future initiateApplication(String encodedData, Map<String, String> headers) {
    var url = loginBaseUr + "initiateApplication";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getPaymentDetails(String encodedData, Map<String, String> headers) {
    var url = loginBaseUr + "getPaymentDetails";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future savePayment(String encodedData, Map<String, String> headers) {
    var url = loginBaseUr + "savePayment";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getWorkerNomineeDetails(String encodeData, Map<String, String> headers) {
    var url = nomineeBaseUrl + "getWorkerNomineeDetails";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future saveWorkerRegistration(String encodeData, Map<String, String> headers) {
    var url = nomineeBaseUrl + "saveWorkerRegistration";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }
  static Future getWorkerRegistrationDetails(String encodeData, Map<String, String> headers) {
    var url = nomineeBaseUrl + "getWorkerRegistrationDetails";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future getWorkerFamilyMemberDetails(String encodeData, Map<String, String> headers) {
    var url = nomineeBaseUrl + "getWorkerFamilyMemberDetails";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }
  static Future getWorkerBankDetails(String encodedData, Map<String, String> headers) {
    var url = nomineeBaseUrl + "getWorkerBankDetails";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getWorkerEstablishmentDetails(String encodedData, Map<String, String> headers) {
    var url = nomineeBaseUrl + "getWorkerEstablishmentDetails";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future saveWorkerEstablishmentForm(String encodedData, Map<String, String> headers) {
    var url = nomineeBaseUrl + "saveWorkerEstablishmentForm";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future saveWorkerBankAccountDetails(String encodedData, Map<String, String> headers) {
    var url = nomineeBaseUrl + "saveWorkerBankAccountDetails";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  // test = supporting documents save
  static Future saveWorkerAttachmentsTest(File file, String attach, String token, String filenameNew) async {
    var url = nomineeBaseUrl + "saveWorkerAttachments";
    var request = MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await MultipartFile.fromPath('file', file.path, filename: filenameNew));
    request.fields['attach'] = attach;
    return request.send();
  }

  // test = get supporting documents by workerRegId
  static Future getWorkerUploadedDocumentsTest(String encodedData, Map<String, String> headers){
    var url = nomineeBaseUrl + "getWorkerUploadedDocuments";
    return http.post(Uri.parse(url),body: encodedData,headers: headers);
  }

  // test = delete supporting documents by attachment Id
  static Future deleteWorkerAttachmentTest(String encodedData,Map<String, String> headers){
    var url = nomineeBaseUrl + "deleteWorkerAttachment";
    return http.post(Uri.parse(url),body: encodedData,headers: headers);
  }

  static Future deleteWorkerEstablishment(String encodedData,Map<String, String> headers){
    var url = nomineeBaseUrl + "deleteWorkerEstablishment";
    return http.post(Uri.parse(url),body: encodedData,headers: headers);
  }

  static Future getWorkerApplicationList(String encodeData, Map<String, String> headers) {
    var url = nomineeBaseUrl + "getWorkerApplicationList";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future submitApplication(String encodeData, Map<String, String> headers) {
    var url = nomineeBaseUrl + "submitApplication";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future checkOneTimePassword(String encodeData, Map<String, String> headers) {
    var url = nomineeBaseUrl + "public/checkOneTimePassword";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future saveOneTimeRegistration(String encodeData, Map<String, String> headers) {
    var url = nomineeBaseUrl + "public/saveOneTimeRegistration";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future createRegistrationApplicationByOtrId(String encodedData, Map<String, String> headers) {
    var url = nomineeBaseUrl + "createRegistrationApplicationByotrId";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }


  //mwServices
  static Future ulbsBlocks(String encodedData,Map<String,String> headers){
    var url = setupBaseUrl + "data/public/ulbsBlocks";
    return http.post(Uri.parse(url),body:encodedData,headers: headers);
  }

  static Future getVillageByBlockList(String encodedData,Map<String,String> headers){
    var url = setupBaseUrl + "data/public/getVillageByBlockList";
    return http.post(Uri.parse(url),body:encodedData,headers: headers);
  }

  static Future getBlockList(String encodedData, Map<String, String> headers) {
    var url = setupBaseUrl + "getBlockList";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getAllDistrictList(
      String encodedData, Map<String, String> headers) {
    var url = setupBaseUrl + "getAllDistrictList";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getAllStateList(
      String encodedData, Map<String, String> headers) {
    var url = setupBaseUrl + "getAllStateList";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getSubdivisionList(
      String encodedData, Map<String, String> headers) {
    var url = setupBaseUrl + "getSubdivisionList";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getBlocks(String encodedData, Map<String, String> headers) {
    var url = setupBaseUrl + "data/blocks";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }
  static Future getPanchaythsList(String encodedData, Map<String, String> headers) {
    var url = setupBaseUrl + "data/public/getPanchaythsList";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getCountryList(
      String encodedData, Map<String, String> headers) {
    var url = setupBaseUrl + "data/countries";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getDistrictList(
      String encodedData, Map<String, String> headers) {
    var url = setupBaseUrl + "data/districts";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getStateList(String encodedData, Map<String, String> headers) {
    var url = setupBaseUrl + "data/states";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getSubdivision(
      String encodedData, Map<String, String> headers) {
    var url = setupBaseUrl + "data/subdivisions";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getULBList(String encodedData, Map<String, String> headers) {
    var url = setupBaseUrl + "data/ulbs";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getUlbsBlocks(String encodedData, Map<String, String> headers) {
    var url = setupBaseUrl + "data/public/ulbsBlocks";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getWardEst(String encodedData, Map<String, String> headers) {
    var url = setupBaseUrl + "data/public/getWardEst";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  //commonServices

  static Future getAllAciveNatureOFWork(String encodedData, Map<String, String> headers) {
    var url = schemeBaseUrl + "getAllAciveNatureOFWork";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getAllAciveEducationSetupVO(String encodedData, Map<String, String> headers) {
    var url = schemeBaseUrl + "getAllAciveEducationSetupVO";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getAllActiveRelationSetup(String encodedData, Map<String, String> headers) {
    var url = schemeBaseUrl + "getAllAciveRelationSetup";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getNotificationsListForPublic(String encodedData, Map<String, String> headers) {
    var url = schemeBaseUrl + "common/getNotificationsListForPublic";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static fetchFamilyMemberById(Map<String, String> headers, String encodedData) {
    var url = schemeBaseUrl + "getFamilyMemberByID";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getSchemeList(String encodeData, Map<String, String> headers) {
    var url = schemeBaseUrl + "getAllScheme";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future getAllAciveReligionSetup(String encodeData, Map<String, String> headers) {
    var url = schemeBaseUrl + "getAllAciveRelegionSetup";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future getAllAciveTradeUnion(String encodeData, Map<String, String> headers) {
    var url = schemeBaseUrl + "getAllAciveTradeUnion";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future getCertifyingPerson(String encodeData, Map<String, String> headers) {
    var url = schemeBaseUrl + "getCertifyingPerson";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future saveProfileGeneralDetails(String encodeData, Map<String, String> headers) {
    var url = schemeBaseUrl + "saveProfileGeneralDetails";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future saveProfileAddressDetails(String encodeData, Map<String, String> headers) {
    var url = schemeBaseUrl + "saveProfileAddressDetails";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future saveProfileBankDetails(String encodeData, Map<String, String> headers) {
    var url = schemeBaseUrl + "saveProfileBankDetails";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future saveNomineeMember(String encodeData, Map<String, String> headers) {
    var url = schemeBaseUrl + "saveNomineeMember";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future getSchemeById(String encodedData, Map<String, String> headers) {
    var url = schemeBaseUrl + "getSchemeById";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getSchemeAttachmentList(String encodedData, Map<String, String> headers) {
    var url = schemeBaseUrl + "getSchemeAttachmentList";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future findGeneralDetailsByWorkerId(String encodedData, Map<String, String> headers) {
    var url = schemeBaseUrl + "findGeneralDetailsByWorkerId";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getProfileNomineeDetailsByWorkerId(String encodedData, Map<String, String> headers) {
    var url = schemeBaseUrl + "getProfileNomineeDetailsByWorkerId";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future getAllUsers(String encodedData, Map<String, String> headers) {
    var url = schemeBaseUrl + "getAllUsers";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }
  static Future findAddressDetailsByWorkerId(String encodedData, Map<String, String> headers) {
    var url = schemeBaseUrl + "findAddressDetailsByWorkerId";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  static Future findBankDetailsByWorkerId(String encodedData, Map<String, String> headers) {
    var url = schemeBaseUrl + "findBankDetailsByWorkerId";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }
  static Future saveProfileFamilyMember(String encodeData, Map<String, String> headers) {
    var url = schemeBaseUrl + "saveProfileFamilyMember";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future findProfileFamilyMemberById(String encodeData, Map<String, String> headers) {
    var url = schemeBaseUrl + "findProfileFamilyMemberById";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  //get registration date by worker id
  static Future getRegistrationDateByWorkerId(String encodedData,Map<String, String> headers){
    var url = loginUrl + "data/getRegistrationDateByWorkerId";
    return http.post(Uri.parse(url),body: encodedData,headers: headers);
  }

  //get all active bank details
  static Future getAllActiveBankDetails(String encodeData, Map<String, String> headers) {
    var url = schemeBaseUrl + "getAllActiveBankDetails";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }


  //educationServices
  //save attachments
  static Future saveEducationStudentDetails(String encodeData, Map<String, String> headers) {
    var url = educationBaseUrl + "saveEducationStudentDetails";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future saveEducationSchemeApplicationDetails(String encodeData, Map<String, String> headers) {
    var url = educationBaseUrl + "saveEducatonSchemeApplicationDetails";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }



  //deathBenefitServices
  //save DeathBenefits
  static Future saveDeathBenefit(String encodeData, Map<String, String> headers) {
    var url = deathBenefitBaseUrl + "saveDeathBenefit";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future checkRegistrationDetails(String encodeData, Map<String, String> headers) {
    var url = deathUrl + "public/checkRegistrationDetails";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }
  static Future initiateDeathBenefit(String regId, Map<String, String> headers) {
    var url = /*deathUrl*/obocwwbUrl1+regId;
    return http.get(Uri.parse(url), headers: headers);
  }
  static Future initiateFuneralAssistanceSchema(String regId, Map<String, String> headers) {
    var url = /*deathUrl*/obocwwbUrl2+regId;
    return http.get(Uri.parse(url), headers: headers);
  }
  static Future checkApplicantDetails(String encodeData, Map<String, String> headers) {
    var url = loginBaseUr + "public/checkApplicantDetails";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }


  //save death benefits legal heir details
  static Future saveLegalheirDetails(String encodeData, Map<String, String> headers) {
    var url = deathBenefitBaseUrl + "saveLegalheirDetails";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }

  static Future getLegalHeirDetails(String encodeData, Map<String, String> headers) {
    var url = deathBenefitBaseUrl + "getLegalHeirDetails";
    return http.post(Uri.parse(url), body: encodeData, headers: headers);
  }


  //funeralAssistanceServices
  static Future saveFuneralAssistanceForm(String encodedData, Map<String, String> headers) {
    var url = funeralBaseUrl + "saveFuneralAssistanceForm";
    return http.post(Uri.parse(url), body: encodedData, headers: headers);
  }

  //maternityBenefitServices
  static Future saveMaternityBenefitForm(String encodedData,Map<String, String> headers){
    var url = /*maternitySaveBaseUrl*/maternityBaseUrl + "saveMaternityBenefitForm";
    return http.post(Uri.parse(url),body: encodedData,headers: headers);
  }


  //marriageAssistanceServices
  static Future saveMarriageAssitanceForm(String encodedData,Map<String, String> headers){
    var url = marriageSaveBaseUrl + "saveMarriageAssistanceDetails";
    return http.post(Uri.parse(url),body: encodedData,headers: headers);
  }

  static Future saveMarriageAssistanceDetails(String encodedData,Map<String, String> headers){
    var url = marriageSaveBaseUrl + "saveMarriageAssistanceDetails";
    return http.post(Uri.parse(url),body: encodedData,headers: headers);
  }

  static Future saveMarriageAssistanceBenefit(String encodedData,Map<String,String> headers){
    var url = /*marriageBenefitSaveBaseUrl*/ /*exmarriageBenefitSaveBaseUrl*/marriageUrl+"saveMarriageAssistanceBenefit";
    return http.post(Uri.parse(url),body: encodedData,headers: headers);
  }

 //save attachments

}
