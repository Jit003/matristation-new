import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  // Basic Details
  final fullNameController = TextEditingController();

  final chestController = TextEditingController();
  final waistController = TextEditingController();
  final noOfChildrenController = TextEditingController();
  final bloodGroupController = TextEditingController();

  var selectedGender = ''.obs;
  RxDouble height = 165.0.obs;
  RxDouble weight = 60.0.obs;
  RxDouble chest = 165.0.obs;
  RxDouble waist = 150.0.obs;
  var selectedMaritalStatus = ''.obs;
  var hasChildren = ''.obs;
  var profileCreatedBy = ''.obs;
  var hasSpecs = false.obs;
  var hasDisability = false.obs;

  // Birth Details
  final birthPlaceController = TextEditingController();
  final ageController = TextEditingController();
  Rxn<DateTime> selectedBirthDate = Rxn<DateTime>();
  final nakshatraController = TextEditingController();
  final rasiController = TextEditingController();

  var isManglik = ''.obs;
  var horoscopePrivacy = ''.obs;

  // Contact Details
  final mobileController = TextEditingController();
  final alternateMobileController = TextEditingController();
  final emailController = TextEditingController();
  final facebookIdController = TextEditingController();

  var hasWhatsApp = false.obs;
  var isVerifiedOTP = false.obs;

  // Religion & Caste
  final religionController = TextEditingController();
  final casteController = TextEditingController();
  final subCasteController = TextEditingController();
  final gothraController = TextEditingController();
  final motherTongueController = TextEditingController();

  // Location
  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final pinController = TextEditingController();
  final citizenshipController = TextEditingController();
  final presentAddressController = TextEditingController();

  var willingnessToRelocate = false.obs;

  // Education & Career
  final highestQualificationController = TextEditingController();
  final institutionNameController = TextEditingController();
  final additionalDegreesController = TextEditingController();
  final organizationController = TextEditingController();
  final designationController = TextEditingController();
  final annualIncomeController = TextEditingController();

  var employedIn = ''.obs;
  var currencyType = 'INR'.obs;
  var keepIncomePrivate = false.obs;

  // Family Details
  final fatherNameController = TextEditingController();
  final motherNameController = TextEditingController();
  final noOfBrothersController = TextEditingController();
  final noOfSistersController = TextEditingController();
  final familyIncomeController = TextEditingController();

  var fatherOccupation = ''.obs;
  var motherOccupation = ''.obs;
  var brothersMaritalStatus = ''.obs;
  var sistersMaritalStatus = ''.obs;
  var familyType = ''.obs;
  var familyValues = ''.obs;

  // Lifestyle & Personal Habits
  final hobbiesController = TextEditingController();
  final interestsController = TextEditingController();
  final languagesKnownController = TextEditingController();

  var bodyType = ''.obs;
  var complexion = ''.obs;
  var eatingHabit = ''.obs;
  var smokeHabit = false.obs;
  var drinkHabit = false.obs;

  // Asset Details
  var agricultureLand = ''.obs;
  var houseBuilding = ''.obs;
  var commercialComplex = ''.obs;
  var twoWheeler = ''.obs;
  var threeWheeler = ''.obs;
  var fourWheeler = ''.obs;

  // About Yourself
  final aboutYourselfController = TextEditingController();

  // Partner Preferences - Basic Details
  final partnerAgeFromController = TextEditingController();
  final partnerAgeToController = TextEditingController();
  final partnerHeightFromController = TextEditingController();
  final partnerHeightToController = TextEditingController();
  final partnerMotherTongueController = TextEditingController();

  var partnerMaritalStatus = <String>[].obs;
  var partnerHaveChildren = ''.obs;
  var partnerPhysicalStatus = ''.obs;

  // Partner Preferences - Religion & Caste
  final partnerReligionController = TextEditingController();
  final partnerCasteController = TextEditingController();
  final partnerSubcasteController = TextEditingController();
  final partnerStarController = TextEditingController();
  var partnerDosham = ''.obs;

  // Partner Preferences - Education & Career
  final partnerEducationController = TextEditingController();
  final partnerEmploymentTypeController = TextEditingController();
  final partnerAnnualIncomeController = TextEditingController();

  // Partner Preferences - Location
  final partnerCountryController = TextEditingController();
  final partnerStateController = TextEditingController();
  final partnerCityController = TextEditingController();

  // Partner Preferences - Lifestyle
  var partnerEatingHabit = ''.obs;
  var partnerSmokingHabit = ''.obs;
  var partnerDrinkingHabit = ''.obs;
  final partnerLifestyleHabitsController = TextEditingController();

  // Partner Preferences - Expectations
  final partnerOtherExpectationsController = TextEditingController();

  // Upload Photo
  var profilePhotos = <String>[].obs;
  var allowVerifiedUsersOnly = false.obs;
  var photoVisibility = 'Public'.obs;

  // Verification
  final verificationDocumentController = TextEditingController();
  var verifiedBadgeNeeded = false.obs;
  var selectedDocumentType = 'Select Document'.obs;

  // Current step
  var currentStep = 0.obs;

  void nextStep() {
    if (currentStep.value < 4) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void updateHeight(double value) => height.value = value;
  void updateWeight(double value) => weight.value = value;
  void updateChest(double value) => chest.value = value;

  void setDateOfBirth(DateTime date) {
    selectedBirthDate.value = date;
  }

  bool validateBasicDetails() {
    return fullNameController.text.isNotEmpty;
  }

  bool validateBirthDetails() {
    return selectedBirthDate.value != null;
  }

  bool validateContactDetails() {
    return mobileController.text.isNotEmpty ;
  }

  bool validateReligionCaste() {
    return religionController.text.isNotEmpty ;
  }

  bool validateLocation() {
    return countryController.text.isNotEmpty;
  }

  bool validateEducationCareer() {
    return highestQualificationController.text.isNotEmpty ;
  }

  bool validateFamilyDetails() {
    return fatherNameController.text.isNotEmpty ;
  }

  bool validateLifestyle() {
    return bodyType.value.isNotEmpty ;
  }

  bool validateAssets() {
    return agricultureLand.value.isNotEmpty ;
  }

  bool validateAbout() {
    return aboutYourselfController.text.isNotEmpty;
  }

  bool validatePartnerPreferences() {
    return partnerAgeFromController.text.isNotEmpty ;
  }

  @override
  void onClose() {
    // Dispose all controllers
    fullNameController.dispose();
    chestController.dispose();
    waistController.dispose();
    noOfChildrenController.dispose();
    bloodGroupController.dispose();
    ageController.dispose();
    nakshatraController.dispose();
    rasiController.dispose();
    mobileController.dispose();
    alternateMobileController.dispose();
    emailController.dispose();
    facebookIdController.dispose();
    religionController.dispose();
    casteController.dispose();
    subCasteController.dispose();
    gothraController.dispose();
    motherTongueController.dispose();
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    pinController.dispose();
    citizenshipController.dispose();
    presentAddressController.dispose();

    // Education & Career
    highestQualificationController.dispose();
    institutionNameController.dispose();
    additionalDegreesController.dispose();
    organizationController.dispose();
    designationController.dispose();
    annualIncomeController.dispose();

    // Family Details
    fatherNameController.dispose();
    motherNameController.dispose();
    noOfBrothersController.dispose();
    noOfSistersController.dispose();
    familyIncomeController.dispose();

    // Lifestyle
    hobbiesController.dispose();
    interestsController.dispose();
    languagesKnownController.dispose();

    // About Yourself
    aboutYourselfController.dispose();

    // Partner Preferences
    partnerAgeFromController.dispose();
    partnerAgeToController.dispose();
    partnerHeightFromController.dispose();
    partnerHeightToController.dispose();
    partnerMotherTongueController.dispose();
    partnerReligionController.dispose();
    partnerCasteController.dispose();
    partnerSubcasteController.dispose();
    partnerStarController.dispose();
    partnerEducationController.dispose();
    partnerEmploymentTypeController.dispose();
    partnerAnnualIncomeController.dispose();
    partnerCountryController.dispose();
    partnerStateController.dispose();
    partnerCityController.dispose();
    partnerLifestyleHabitsController.dispose();
    partnerOtherExpectationsController.dispose();
    verificationDocumentController.dispose();

    super.onClose();
  }
}
