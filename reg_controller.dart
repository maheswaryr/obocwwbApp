///Updated on 19/12/2022 by Arsha

import 'dart:convert' as convert;
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/model/filter_vo.dart';
import 'package:obocwwb/model/model_class/registration_vo.dart';
import 'package:obocwwb/model/mw_services_models/filter_vo.dart';
import 'package:obocwwb/model/one_time_registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Impl{

  SharedPreferences? preferences;
  String? token;

  registrationDetailsGet() async {

    preferences = await SharedPreferences.getInstance();
    token = preferences?.getString('token');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    RegistrationVO registration = RegistrationVO();
    registration.oneTimeRegistration = OneTimeRegistration();
    registration.oneTimeRegistration!.id = preferences?.getInt('otrID');

    String encodedData = convert.jsonEncode(registration);
    return await Api.getWorkerRegistrationDetails(encodedData, headers);
  }

  villageByBlockListGet(String? dropdownValueForRegBlockPresent) async{
    preferences = await SharedPreferences.getInstance();
    token = preferences?.getString('token');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    FilterVO filterVO = FilterVO();
    filterVO.placeId = dropdownValueForRegBlockPresent != null
        ? int.parse(dropdownValueForRegBlockPresent)
        : 0;
    String encodedData = convert.jsonEncode(filterVO);
    return await Api.getVillageByBlockList(encodedData, headers);
  }
  villageByBlockListPermanentGet(String? dropdownValueForRegBlockPermanent) async {
    preferences = await SharedPreferences.getInstance();
    token = preferences?.getString('token');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'


    };
    FilterVO filterVO = FilterVO();
    filterVO.placeId = dropdownValueForRegBlockPermanent != null
        ? int.parse(dropdownValueForRegBlockPermanent)
        : 0;
    String encodedData = convert.jsonEncode(filterVO);
    return await Api.getVillageByBlockList(encodedData, headers);
  }

  districtListPresentGet() async {
    preferences = await SharedPreferences.getInstance();
    token = preferences?.getString('token');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    FilterVo filterVo = FilterVo();
    filterVo.stateId = 21;

    String encodedData = convert.jsonEncode(filterVo);

   return await Api.getDistrictList(encodedData, headers);
  }

  blockPresentGet(String? dropdownValueForRegistrationDistrictPresent) async {
    preferences = await SharedPreferences.getInstance();
    token = preferences?.getString('token');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    FilterVo filterVo = FilterVo();
    filterVo.districtId = dropdownValueForRegistrationDistrictPresent != null
        ? int.parse(dropdownValueForRegistrationDistrictPresent)
        : 0;
    String encodedData = convert.jsonEncode(filterVo);
    //api
   return await Api.getBlocks(encodedData, headers);
  }
  blockGet1 (String? districtId) async {
    preferences = await SharedPreferences.getInstance();
    token = preferences?.getString('token');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    FilterVo filterVo = FilterVo();
    filterVo.districtId = districtId != null ? int.parse(districtId) : 0;
    String encodedData = convert.jsonEncode(filterVo);
    //api
  return await Api.getBlocks(encodedData, headers);
  }

  wardListGet(String? dropdownValueForUlbPresent,String? dropdownValueForUlb) async {
    preferences = await SharedPreferences.getInstance();
    token = preferences?.getString('token');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    FilterVo filterVO = FilterVo();
    filterVO.placeId = dropdownValueForUlbPresent != null
        ? int.parse(dropdownValueForUlbPresent)
        : int.parse(dropdownValueForUlb!);

    String encodedData = convert.jsonEncode(filterVO);
   return await Api.getWardEst(encodedData, headers);
  }

getWardList(String? dropdownValueForUlb) async {
  preferences = await SharedPreferences.getInstance();
  token = preferences?.getString('token');
  Map<String, String> headers = {
    'content-type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  FilterVo filterVO = FilterVo();
  filterVO.placeId = dropdownValueForUlb != null
      ? int.parse(dropdownValueForUlb)
      : int.parse(dropdownValueForUlb!);
  String encodedData = convert.jsonEncode(filterVO);
return await Api.getWardEst(encodedData, headers);
}

  getUlbSBlocksPresent(String? districtPresentId) async {
    preferences = await SharedPreferences.getInstance();
    token = preferences?.getString('token');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    FilterVO filterVO = FilterVO();
    filterVO.districtId =
    districtPresentId != null ? int.parse(districtPresentId) : 0;
    String encodedData = convert.jsonEncode(filterVO);
   return await Api.ulbsBlocks(encodedData, headers);
  }
  getUlbSBlocks(String? districtId) async {
    preferences = await SharedPreferences.getInstance();
    token = preferences?.getString('token');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    FilterVO filterVO = FilterVO();
    filterVO.districtId = districtId != null ? int.parse(districtId) : 0;
    String encodedData = convert.jsonEncode(filterVO);
    return await Api.ulbsBlocks(encodedData, headers);
  }

}