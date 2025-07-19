import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

class ProfileDetailsController extends GetxController {
  var isLoading = false.obs;
  var profile = Rx<UserProfile?>(null);
  var currentImageIndex = 0.obs;
  var isLiked = false.obs;
  var isShortlisted = false.obs;
  var showFullBio = false.obs;

  // Sample additional data that would come from API
  var profileImages = <String>[].obs;
  var profileDetails = Rx<ProfileDetailsModel?>(null);

  @override
  void onInit() {
    super.onInit();
    // Get profile from arguments
    if (Get.arguments != null && Get.arguments is UserProfile) {
      profile.value = Get.arguments as UserProfile;
      loadProfileDetails();
    }
  }

  void loadProfileDetails() {
    isLoading.value = true;

    // Simulate API call to get detailed profile information
    Future.delayed(Duration(seconds: 1), () {
      profileImages.value = [
        profile.value?.image ?? '/placeholder.svg?height=400&width=300',
        '/placeholder.svg?height=400&width=300&text=Photo+2',
        '/placeholder.svg?height=400&width=300&text=Photo+3',
        '/placeholder.svg?height=400&width=300&text=Photo+4',
      ];

      profileDetails.value = ProfileDetailsModel(
        bio: "I am a software engineer with a passion for technology and innovation. I love traveling, reading books, and spending time with family. Looking for a life partner who shares similar values and interests.",
        familyDetails: FamilyDetails(
          fatherOccupation: "Business",
          motherOccupation: "Homemaker",
          siblings: "1 Sister (Married)",
          familyType: "Nuclear Family",
          familyValues: "Traditional",
        ),
        personalDetails: PersonalDetails(
          maritalStatus: "Never Married",
          height: profile.value?.height ?? "5'4\"",
          weight: "55 kg",
          bodyType: "Average",
          complexion: "Fair",
          physicalStatus: "Normal",
          eatingHabits: "Vegetarian",
          drinkingHabits: "Never",
          smokingHabits: "Never",
        ),
        religiousDetails: ReligiousDetails(
          religion: "Hindu",
          caste: "Brahmin",
          subCaste: "Iyer",
          motherTongue: "Tamil",
          gothra: "Bharadwaja",
        ),
        professionalDetails: ProfessionalDetails(
          education: profile.value?.education ?? "B.Tech",
          occupation: profile.value?.profession ?? "Software Engineer",
          employedIn: "Private Company",
          annualIncome: "8-12 Lakhs",
          workLocation: "Bangalore",
        ),
        locationDetails: LocationDetails(
          country: "India",
          state: "Karnataka",
          city: "Bangalore",
          residencyStatus: "Citizen",
        ),
        partnerPreferences: PartnerPreferences(
          ageRange: "24-30",
          heightRange: "5'2\" - 5'8\"",
          maritalStatus: "Never Married",
          education: "Graduate or above",
          occupation: "Any",
          location: "Bangalore, Chennai, Hyderabad",
        ),
      );

      isLoading.value = false;
    });
  }

  void changeImage(int index) {
    currentImageIndex.value = index;
  }

  void toggleLike() {
    isLiked.value = !isLiked.value;
    Get.snackbar(
      isLiked.value ? 'Liked' : 'Unliked',
      isLiked.value ? 'Profile added to your interests' : 'Profile removed from interests',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isLiked.value ? Colors.red : Colors.grey[600],
      colorText: Colors.white,
      duration: Duration(seconds: 1),
    );
  }

  void toggleShortlist() {
    isShortlisted.value = !isShortlisted.value;
    Get.snackbar(
      isShortlisted.value ? 'Shortlisted' : 'Removed',
      isShortlisted.value ? 'Profile added to shortlist' : 'Profile removed from shortlist',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isShortlisted.value ? Color(0xFF4CAF50) : Colors.grey[600],
      colorText: Colors.white,
      duration: Duration(seconds: 1),
    );
  }

  void sendMessage() {
    Get.snackbar(
      'Message',
      'Opening chat with ${profile.value?.name}...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color(0xFF4CAF50),
      colorText: Colors.white,
    );
  }

  void shareProfile() {
    Get.snackbar(
      'Share',
      'Sharing ${profile.value?.name}\'s profile...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  void reportProfile() {
    Get.dialog(
      AlertDialog(
        title: Text('Report Profile'),
        content: Text('Are you sure you want to report this profile?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Reported',
                'Profile has been reported successfully',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.orange,
                colorText: Colors.white,
              );
            },
            child: Text('Report'),
          ),
        ],
      ),
    );
  }

  void toggleBio() {
    showFullBio.value = !showFullBio.value;
  }
}

// Data Models
class ProfileDetailsModel {
  final String bio;
  final FamilyDetails familyDetails;
  final PersonalDetails personalDetails;
  final ReligiousDetails religiousDetails;
  final ProfessionalDetails professionalDetails;
  final LocationDetails locationDetails;
  final PartnerPreferences partnerPreferences;

  ProfileDetailsModel({
    required this.bio,
    required this.familyDetails,
    required this.personalDetails,
    required this.religiousDetails,
    required this.professionalDetails,
    required this.locationDetails,
    required this.partnerPreferences,
  });
}

class FamilyDetails {
  final String fatherOccupation;
  final String motherOccupation;
  final String siblings;
  final String familyType;
  final String familyValues;

  FamilyDetails({
    required this.fatherOccupation,
    required this.motherOccupation,
    required this.siblings,
    required this.familyType,
    required this.familyValues,
  });
}

class PersonalDetails {
  final String maritalStatus;
  final String height;
  final String weight;
  final String bodyType;
  final String complexion;
  final String physicalStatus;
  final String eatingHabits;
  final String drinkingHabits;
  final String smokingHabits;

  PersonalDetails({
    required this.maritalStatus,
    required this.height,
    required this.weight,
    required this.bodyType,
    required this.complexion,
    required this.physicalStatus,
    required this.eatingHabits,
    required this.drinkingHabits,
    required this.smokingHabits,
  });
}

class ReligiousDetails {
  final String religion;
  final String caste;
  final String subCaste;
  final String motherTongue;
  final String gothra;

  ReligiousDetails({
    required this.religion,
    required this.caste,
    required this.subCaste,
    required this.motherTongue,
    required this.gothra,
  });
}

class ProfessionalDetails {
  final String education;
  final String occupation;
  final String employedIn;
  final String annualIncome;
  final String workLocation;

  ProfessionalDetails({
    required this.education,
    required this.occupation,
    required this.employedIn,
    required this.annualIncome,
    required this.workLocation,
  });
}

class LocationDetails {
  final String country;
  final String state;
  final String city;
  final String residencyStatus;

  LocationDetails({
    required this.country,
    required this.state,
    required this.city,
    required this.residencyStatus,
  });
}

class PartnerPreferences {
  final String ageRange;
  final String heightRange;
  final String maritalStatus;
  final String education;
  final String occupation;
  final String location;

  PartnerPreferences({
    required this.ageRange,
    required this.heightRange,
    required this.maritalStatus,
    required this.education,
    required this.occupation,
    required this.location,
  });
}
