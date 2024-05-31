///Updated on 19/12/2022 by Arsha

import 'package:flutter/cupertino.dart';
import 'package:obocwwb/model/common_Models/obocwwb_ui_Models/dropdown_common_vo.dart';


import 'error_screens_widget/10_connection_lost.dart';
import 'error_screens_widget/11_broken_link.dart';
import 'error_screens_widget/12_artical_not_found.dart';
import 'error_screens_widget/13_no_space.dart';
import 'error_screens_widget/14_no_result_found.dart';
import 'error_screens_widget/15_payment_faild.dart';
import 'error_screens_widget/16_time_error.dart';
import 'error_screens_widget/17_location_error.dart';
import 'error_screens_widget/18_router_offline.dart';
import 'error_screens_widget/19_connection_faild.dart';
import 'error_screens_widget/1_no_connection.dart';
import 'error_screens_widget/20_no_file.dart';
import 'error_screens_widget/21_camera_access.dart';
import 'error_screens_widget/2_404_error.dart';
import 'error_screens_widget/3_something_went_wrong.dart';
import 'error_screens_widget/4_file_not_found.dart';
import 'error_screens_widget/5_something_wrong.dart';
import 'error_screens_widget/6_error.dart';
import 'error_screens_widget/7_error_2.dart';
import 'error_screens_widget/8_404_error_2.dart';
import 'error_screens_widget/9_location_access.dart';

class MyCustomList {
  List<Widget> screenList = [
    NoConnectionScreen(),
    Error404Screen(),
    Error404Screen2(),
    SomethingWentWrongScreen(),
    FileNotFoundScreen(),
    SomethingWrongScreen(),
    ErrorScreen(),
    Error2Screen(),
    LocationAccessScreen(),
    ConnectionLostScreen(),
    BrokenLinkScreen(),
    ArticleNotFoundScreen(),
    NoSpaceScreen(),
    NoResultFoundScreen(),
    PaymentFailedScreen(),
    TimeErrorScreen(),
    LocationErrorScreen(),
    RouterOfflineScreen(),
    ConnectionFailedScreen(),
    NoFileScreen(),
    CameraAccessScreen(),
  ];
  List<DropDownVO> sexList = [
    DropDownVO(value: "M", dropdownValue: "Male"),
    DropDownVO(value: "F", dropdownValue: "Female"),
    DropDownVO(value: "O", dropdownValue: "Other")
  ];
  List<DropDownVO> martialStatusList = [
    DropDownVO(value: "M", dropdownValue: "Married"),
    DropDownVO(value: "U", dropdownValue: "Single"),
    DropDownVO(value: "D", dropdownValue: "Divorce"),
    DropDownVO(value: "W", dropdownValue: "Widow")
  ];
  List<DropDownVO> maritalStatus = [
    DropDownVO(value: "M", dropdownValue: "Married"),
    DropDownVO(value: "U", dropdownValue: "Single"),
    DropDownVO(value: "D", dropdownValue: "Divorced"),
    DropDownVO(value: "W", dropdownValue: "Widowed")
  ];

  List<DropDownVO> typeOfDeathList = [
    DropDownVO(value: "N", dropdownValue: "Natural"),
    DropDownVO(value: "A", dropdownValue: "Accidental"),
  ];

  List<DropDownVO> relationshipList = [
    DropDownVO(value: "W", dropdownValue: "Widow"),
    DropDownVO(value: "S", dropdownValue: "Son"),
    DropDownVO(value: "M", dropdownValue: "Mother"),
    DropDownVO(value: "F", dropdownValue: "Father (in case mother deceased)"),
    DropDownVO(value: "B", dropdownValue: "Brother (dependent)"),
    DropDownVO(value: "SUD", dropdownValue: "Sister (Unmarried and dependent)"),
    DropDownVO(value: "FUD", dropdownValue: "Father (Unmarried and dependent)"),
    DropDownVO(value: "MUD", dropdownValue: "Mother (Unmarried and dependent)"),
    DropDownVO(value: "SU", dropdownValue: "Son (Unmarried )"),
  ];

  List<DropDownVO> testList = [
    DropDownVO(value: "1", dropdownValue: "PUNJAB AND SIND BANK"),
    DropDownVO(value: "2", dropdownValue: "PUNJAB NATIONAL BANK"),
    DropDownVO(value: "3", dropdownValue: "RBL Bank"),
    DropDownVO(value: "4", dropdownValue: "SOUTH INDIAN BANK"),
    DropDownVO(value: "5", dropdownValue: "STATE BANK OF INDIA"),
    DropDownVO(value: "6", dropdownValue: "TAMILNAD MERCANTILE BANK LTD"),
    DropDownVO(value: "7", dropdownValue: "THE FEDERAL BANK LTD"),
    DropDownVO(value: "8", dropdownValue: "THE LAKSHMI VILAS BANK LTD"),
    DropDownVO(value: "9", dropdownValue: "THE SARASWAT CO-OPERATIVE BANK LTD"),
    DropDownVO(value: "10", dropdownValue: "The Surat District Co-operative Bank Bank Ltd."),
    DropDownVO(value: "10", dropdownValue: "UCO BANK"),
    DropDownVO(value: "10", dropdownValue: "Ujjivan Small Finance Bank Limited"),
    DropDownVO(value: "10", dropdownValue: "UNION BANK OF INDIA"),
    DropDownVO(value: "10", dropdownValue: "UTTARBIHAR GRAMIN BANK"),
    DropDownVO(value: "10", dropdownValue: "YES BANK LTD"),
    DropDownVO(value: "10", dropdownValue: "TJSB SAHAKARI BANK LIMITED")
  ];

  List<DropDownVO> rationCardList = [
    DropDownVO(value: "NFSA", dropdownValue: "NFSA"),
    DropDownVO(value: "SFSS", dropdownValue: "SFSS"),
  ];

  List<DropDownVO> communityList = [
    DropDownVO(value: "--Please select community--", dropdownValue: "--Please select community--"),
    DropDownVO(value: "General", dropdownValue: "General"),
    DropDownVO(value: "OBC", dropdownValue: "OBC"),
    DropDownVO(value: "SC", dropdownValue: "SC"),
    DropDownVO(value: "ST", dropdownValue: "ST"),
    DropDownVO(value: "SEBC", dropdownValue: "SEBC"),
    DropDownVO(value: "Other", dropdownValue: "Other"),
  ];

  List<DropDownVO> religionList = [
    DropDownVO(value: "--Please select religion--", dropdownValue: "--Please select religion--"),
    DropDownVO(value: "Hindu", dropdownValue: "Hindu"),
    DropDownVO(value: "Muslim", dropdownValue: "Muslim"),
    DropDownVO(value: "Christian", dropdownValue: "Christian"),
    DropDownVO(value: "Sikhs", dropdownValue: "Sikhs"),
    DropDownVO(value: "Buddhist", dropdownValue: "Buddhist"),
    DropDownVO(value: "Others(Specify)", dropdownValue: "Others(Specify)"),
  ];

  List<DropDownVO> list = [
    DropDownVO(value: "--Please select--", dropdownValue: "--Please select--"),
    DropDownVO(value: "Yes", dropdownValue: "Yes"),
    DropDownVO(value: "No", dropdownValue: "No"),
  ];

  List<DropDownVO> nomineeList = [
    DropDownVO(value: "--Select Nominee--", dropdownValue: "--Select Nominee--"),
  ];
  List<DropDownVO> employmentCertificationList = [
    DropDownVO(value: "0", dropdownValue: "--Select--"),
    DropDownVO(value: "E", dropdownValue: "Employer"),
    DropDownVO(value: "I", dropdownValue: "Inspector"),
    DropDownVO(value: "T", dropdownValue: "Trade union"),
    DropDownVO(value: "S", dropdownValue: "Self certification"),
  ];
  List<DropDownVO> establishmentList = [
    DropDownVO(value: "0", dropdownValue: "--Select--"),
    DropDownVO(value: "G", dropdownValue: "Government"),
    DropDownVO(value: "P", dropdownValue: "Private"),
  ];

}
