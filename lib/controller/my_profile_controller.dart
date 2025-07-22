import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/ui/profile/image_gallery_screen.dart';

class MyProfileController extends GetxController {
  var isLoading = false.obs;
  var isUpdating = false.obs;
  var currentImageIndex = 0.obs;

  // Profile images
  var profileImages = <String>[].obs;
  var maxImages = 6;

  // Profile data
  var myProfile = MyProfileModel().obs;

  // Form controllers
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final aboutController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadMyProfile();
  }

  @override
  void onClose() {
    emailController.dispose();
    phoneController.dispose();
    aboutController.dispose();
    super.onClose();
  }

  void loadMyProfile() {
    isLoading.value = true;

    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      profileImages.value = [
        '/placeholder.svg?height=400&width=300&text=Main+Photo',
        '/placeholder.svg?height=400&width=300&text=Photo+2',
        '/placeholder.svg?height=400&width=300&text=Photo+3',
        '/placeholder.svg?height=400&width=300&text=Photo+4',
      ];

      myProfile.value = MyProfileModel(
        id: 'MAT123456',
        name: 'Priya Sharma',
        age: 26,
        email: 'priya.sharma@email.com',
        phone: '+91 9876543210',
        about: 'I am a software engineer with a passion for technology and innovation. I love traveling, reading books, and spending time with family. Looking for a life partner who shares similar values and interests.',
        basicDetails: BasicDetails(
          height: '5\'4"',
          weight: '55 kg',
          maritalStatus: 'Never Married',
          motherTongue: 'Hindi',
          religion: 'Hindu',
          caste: 'Brahmin',
          dateOfBirth: '15/03/1998',
          timeOfBirth: '10:30 AM',
          placeOfBirth: 'Mumbai',
        ),
        educationCareer: EducationCareer(
          education: 'B.Tech Computer Science',
          occupation: 'Software Engineer',
          employedIn: 'Private Company',
          annualIncome: '8-12 Lakhs',
          workLocation: 'Bangalore',
        ),
        familyDetails: FamilyDetails(
          fatherName: 'Rajesh Sharma',
          fatherOccupation: 'Business',
          motherName: 'Sunita Sharma',
          motherOccupation: 'Homemaker',
          siblings: '1 Sister (Married)',
          familyType: 'Nuclear Family',
          familyValues: 'Traditional',
        ),
        locationDetails: LocationDetails(
          country: 'India',
          state: 'Karnataka',
          city: 'Bangalore',
          address: '123, MG Road, Bangalore',
          residencyStatus: 'Citizen',
        ),
        lifestyle: Lifestyle(
          diet: 'Vegetarian',
          smoking: 'Never',
          drinking: 'Never',
          hobbies: 'Reading, Traveling, Music, Cooking',
        ),
        partnerPreferences: PartnerPreferences(
          ageRange: '26-32',
          heightRange: '5\'6" - 6\'0"',
          maritalStatus: 'Never Married',
          education: 'Graduate or above',
          occupation: 'Any',
          location: 'Bangalore, Chennai, Hyderabad',
          diet: 'Vegetarian',
          smoking: 'Never',
          drinking: 'Occasionally',
        ),
      );

      // Initialize form controllers
      emailController.text = myProfile.value.email;
      phoneController.text = myProfile.value.phone;
      aboutController.text = myProfile.value.about;

      isLoading.value = false;
    });
  }

  void changeImage(int index) {
    currentImageIndex.value = index;
  }

  void openImageGallery() {
    Get.to(()=>ImageGalleryScreen(), arguments: {
      'images': profileImages.toList(),
      'currentIndex': currentImageIndex.value,
      'canEdit': true,
    });
  }

  void addImage() {
    if (profileImages.length < maxImages) {
      // Simulate image picker
      profileImages.add('/placeholder.svg?height=400&width=300&text=New+Photo+${profileImages.length + 1}');
      Get.snackbar(
        'Photo Added',
        'New photo has been added to your profile',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color(0xFF4CAF50),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Limit Reached',
        'You can add maximum $maxImages photos',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }

  void removeImage(int index) {
    if (profileImages.length > 1) {
      profileImages.removeAt(index);
      if (currentImageIndex.value >= profileImages.length) {
        currentImageIndex.value = profileImages.length - 1;
      }
      Get.snackbar(
        'Photo Removed',
        'Photo has been removed from your profile',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Cannot Remove',
        'You must have at least one photo',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }

  void editEmail() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Email',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: Text('Cancel'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        myProfile.value.email = emailController.text;
                        myProfile.refresh();
                        Get.back();
                        Get.snackbar(
                          'Email Updated',
                          'Your email has been updated successfully',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Color(0xFF4CAF50),
                          colorText: Colors.white,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4CAF50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Update'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void editPhone() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Phone Number',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: Text('Cancel'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        myProfile.value.phone = phoneController.text;
                        myProfile.refresh();
                        Get.back();
                        Get.snackbar(
                          'Phone Updated',
                          'Your phone number has been updated successfully',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Color(0xFF4CAF50),
                          colorText: Colors.white,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4CAF50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Update'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void editHoroscope() {
    Get.snackbar(
      'Horoscope',
      'Horoscope editing feature coming soon...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color(0xFF4CAF50),
      colorText: Colors.white,
    );
  }

  void editAbout() {
    aboutController.text = myProfile.value.about;
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit About Me',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: aboutController,
                decoration: InputDecoration(
                  labelText: 'About Me',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignLabelWithHint: true,
                ),
                maxLines: 4,
                maxLength: 500,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: Text('Cancel'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        myProfile.value.about = aboutController.text;
                        myProfile.refresh();
                        Get.back();
                        Get.snackbar(
                          'About Updated',
                          'Your about section has been updated successfully',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Color(0xFF4CAF50),
                          colorText: Colors.white,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4CAF50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Update'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void editSection(String sectionName) {
    Get.snackbar(
      'Edit $sectionName',
      '$sectionName editing feature coming soon...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color(0xFF4CAF50),
      colorText: Colors.white,
    );
  }
}

// Data Models
class MyProfileModel {
  String id;
  String name;
  int age;
  String email;
  String phone;
  String about;
  BasicDetails basicDetails;
  EducationCareer educationCareer;
  FamilyDetails familyDetails;
  LocationDetails locationDetails;
  Lifestyle lifestyle;
  PartnerPreferences partnerPreferences;

  MyProfileModel({
    this.id = '',
    this.name = '',
    this.age = 0,
    this.email = '',
    this.phone = '',
    this.about = '',
    BasicDetails? basicDetails,
    EducationCareer? educationCareer,
    FamilyDetails? familyDetails,
    LocationDetails? locationDetails,
    Lifestyle? lifestyle,
    PartnerPreferences? partnerPreferences,
  }) :
        basicDetails = basicDetails ?? BasicDetails(),
        educationCareer = educationCareer ?? EducationCareer(),
        familyDetails = familyDetails ?? FamilyDetails(),
        locationDetails = locationDetails ?? LocationDetails(),
        lifestyle = lifestyle ?? Lifestyle(),
        partnerPreferences = partnerPreferences ?? PartnerPreferences();
}

class BasicDetails {
  String height;
  String weight;
  String maritalStatus;
  String motherTongue;
  String religion;
  String caste;
  String dateOfBirth;
  String timeOfBirth;
  String placeOfBirth;

  BasicDetails({
    this.height = '',
    this.weight = '',
    this.maritalStatus = '',
    this.motherTongue = '',
    this.religion = '',
    this.caste = '',
    this.dateOfBirth = '',
    this.timeOfBirth = '',
    this.placeOfBirth = '',
  });
}

class EducationCareer {
  String education;
  String occupation;
  String employedIn;
  String annualIncome;
  String workLocation;

  EducationCareer({
    this.education = '',
    this.occupation = '',
    this.employedIn = '',
    this.annualIncome = '',
    this.workLocation = '',
  });
}

class FamilyDetails {
  String fatherName;
  String fatherOccupation;
  String motherName;
  String motherOccupation;
  String siblings;
  String familyType;
  String familyValues;

  FamilyDetails({
    this.fatherName = '',
    this.fatherOccupation = '',
    this.motherName = '',
    this.motherOccupation = '',
    this.siblings = '',
    this.familyType = '',
    this.familyValues = '',
  });
}

class LocationDetails {
  String country;
  String state;
  String city;
  String address;
  String residencyStatus;

  LocationDetails({
    this.country = '',
    this.state = '',
    this.city = '',
    this.address = '',
    this.residencyStatus = '',
  });
}

class Lifestyle {
  String diet;
  String smoking;
  String drinking;
  String hobbies;

  Lifestyle({
    this.diet = '',
    this.smoking = '',
    this.drinking = '',
    this.hobbies = '',
  });
}

class PartnerPreferences {
  String ageRange;
  String heightRange;
  String maritalStatus;
  String education;
  String occupation;
  String location;
  String diet;
  String smoking;
  String drinking;

  PartnerPreferences({
    this.ageRange = '',
    this.heightRange = '',
    this.maritalStatus = '',
    this.education = '',
    this.occupation = '',
    this.location = '',
    this.diet = '',
    this.smoking = '',
    this.drinking = '',
  });
}
