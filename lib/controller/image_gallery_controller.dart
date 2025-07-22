import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageGalleryController extends GetxController {
  var currentIndex = 0.obs;
  var images = <String>[].obs;
  var canEdit = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Get arguments from navigation
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      images.value = List<String>.from(args['images'] ?? []);
      currentIndex.value = args['currentIndex'] ?? 0;
      canEdit.value = args['canEdit'] ?? false;
    }
  }

  void changeImage(int index) {
    currentIndex.value = index;
  }

  void addImage() {
    // Simulate image picker
    images.add('/placeholder.svg?height=400&width=300&text=New+Photo+${images.length + 1}');
    Get.snackbar(
      'Photo Added',
      'New photo has been added',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color(0xFF4CAF50),
      colorText: Colors.white,
    );
  }

  void replaceImage(int index) {
    // Simulate image picker for replacement
    images[index] = '/placeholder.svg?height=400&width=300&text=Updated+Photo+${index + 1}';
    images.refresh();
    Get.snackbar(
      'Photo Updated',
      'Photo has been updated',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color(0xFF4CAF50),
      colorText: Colors.white,
    );
  }

  void deleteImage(int index) {
    if (images.length > 1) {
      Get.dialog(
        AlertDialog(
          title: Text('Delete Photo'),
          content: Text('Are you sure you want to delete this photo?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                images.removeAt(index);
                if (currentIndex.value >= images.length) {
                  currentIndex.value = images.length - 1;
                }
                Get.back();
                Get.snackbar(
                  'Photo Deleted',
                  'Photo has been deleted',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    } else {
      Get.snackbar(
        'Cannot Delete',
        'You must have at least one photo',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }

  void setAsMainPhoto(int index) {
    if (index != 0) {
      String mainPhoto = images[index];
      images.removeAt(index);
      images.insert(0, mainPhoto);
      currentIndex.value = 0;
      Get.snackbar(
        'Main Photo Updated',
        'This photo is now your main profile photo',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color(0xFF4CAF50),
        colorText: Colors.white,
      );
    }
  }
}
