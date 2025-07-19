import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matri_station/ui/home/service/service_form_screen.dart';

class ServiceController extends GetxController {
  // Service categories and items
  var serviceCategories = <ServiceCategory>[].obs;
  var selectedCategory = 0.obs;
  var isLoading = false.obs;

  // Form data
  var selectedService = Rx<ServiceItem?>(null);
  var formData = ServiceFormData().obs;

  // Form controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final businessNameController = TextEditingController();
  final experienceController = TextEditingController();
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();
  final priceController = TextEditingController();
  final websiteController = TextEditingController();

  // Form validation
  var formKey = GlobalKey<FormState>();
  var selectedImages = <String>[].obs;
  var selectedAvailability = <String>[].obs;
  var selectedAreas = <String>[].obs;

  final availabilityOptions = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday',
    'Friday', 'Saturday', 'Sunday'
  ].obs;

  final serviceAreas = [
    'Mumbai', 'Delhi', 'Bangalore', 'Chennai', 'Kolkata',
    'Hyderabad', 'Pune', 'Ahmedabad', 'Jaipur', 'Lucknow'
  ].obs;

  @override
  void onInit() {
    super.onInit();
    loadServiceCategories();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    businessNameController.dispose();
    experienceController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    priceController.dispose();
    websiteController.dispose();
    super.onClose();
  }

  void loadServiceCategories() {
    serviceCategories.value = [
      ServiceCategory(
        name: 'Beauty & Makeup',
        icon: Icons.face_retouching_natural,
        color: Color(0xFFE91E63),
        services: [
          ServiceItem(
            id: '1',
            name: 'Bridal Makeup Artist',
            description: 'Professional bridal makeup services',
            icon: Icons.face_retouching_natural,
            image: '/placeholder.svg?height=200&width=200&text=Bridal+Makeup',
            basePrice: '₹15,000 - ₹50,000',
            rating: 4.8,
            category: 'Beauty & Makeup',
          ),
          ServiceItem(
            id: '2',
            name: 'Hair Stylist',
            description: 'Bridal and party hair styling',
            icon: Icons.content_cut,
            image: '/placeholder.svg?height=200&width=200&text=Hair+Styling',
            basePrice: '₹8,000 - ₹25,000',
            rating: 4.7,
            category: 'Beauty & Makeup',
          ),
          ServiceItem(
            id: '3',
            name: 'Mehendi Artist',
            description: 'Traditional and modern mehendi designs',
            icon: Icons.brush,
            image: '/placeholder.svg?height=200&width=200&text=Mehendi+Art',
            basePrice: '₹5,000 - ₹20,000',
            rating: 4.9,
            category: 'Beauty & Makeup',
          ),
        ],
      ),
      ServiceCategory(
        name: 'Photography',
        icon: Icons.camera_alt,
        color: Color(0xFF2196F3),
        services: [
          ServiceItem(
            id: '4',
            name: 'Wedding Photographer',
            description: 'Professional wedding photography',
            icon: Icons.camera_alt,
            image: '/placeholder.svg?height=200&width=200&text=Wedding+Photo',
            basePrice: '₹50,000 - ₹2,00,000',
            rating: 4.8,
            category: 'Photography',
          ),
          ServiceItem(
            id: '5',
            name: 'Pre-Wedding Shoot',
            description: 'Romantic pre-wedding photography',
            icon: Icons.favorite,
            image: '/placeholder.svg?height=200&width=200&text=Pre+Wedding',
            basePrice: '₹25,000 - ₹75,000',
            rating: 4.6,
            category: 'Photography',
          ),
        ],
      ),
      ServiceCategory(
        name: 'Decoration',
        icon: Icons.celebration,
        color: Color(0xFFFF9800),
        services: [
          ServiceItem(
            id: '6',
            name: 'Wedding Decorator',
            description: 'Complete wedding decoration services',
            icon: Icons.celebration,
            image: '/placeholder.svg?height=200&width=200&text=Wedding+Decor',
            basePrice: '₹1,00,000 - ₹10,00,000',
            rating: 4.7,
            category: 'Decoration',
          ),
          ServiceItem(
            id: '7',
            name: 'Floral Arrangement',
            description: 'Beautiful floral decorations',
            icon: Icons.local_florist,
            image: '/placeholder.svg?height=200&width=200&text=Floral+Decor',
            basePrice: '₹20,000 - ₹1,50,000',
            rating: 4.5,
            category: 'Decoration',
          ),
        ],
      ),
      ServiceCategory(
        name: 'Catering',
        icon: Icons.restaurant,
        color: Color(0xFF4CAF50),
        services: [
          ServiceItem(
            id: '8',
            name: 'Wedding Caterer',
            description: 'Multi-cuisine wedding catering',
            icon: Icons.restaurant,
            image: '/placeholder.svg?height=200&width=200&text=Wedding+Catering',
            basePrice: '₹500 - ₹2,000 per plate',
            rating: 4.6,
            category: 'Catering',
          ),
          ServiceItem(
            id: '9',
            name: 'Sweet Shop',
            description: 'Traditional sweets and desserts',
            icon: Icons.cake,
            image: '/placeholder.svg?height=200&width=200&text=Wedding+Sweets',
            basePrice: '₹200 - ₹800 per kg',
            rating: 4.4,
            category: 'Catering',
          ),
        ],
      ),
      ServiceCategory(
        name: 'Entertainment',
        icon: Icons.music_note,
        color: Color(0xFF9C27B0),
        services: [
          ServiceItem(
            id: '10',
            name: 'DJ Services',
            description: 'Professional DJ and sound system',
            icon: Icons.music_note,
            image: '/placeholder.svg?height=200&width=200&text=DJ+Services',
            basePrice: '₹15,000 - ₹50,000',
            rating: 4.5,
            category: 'Entertainment',
          ),
          ServiceItem(
            id: '11',
            name: 'Live Band',
            description: 'Live music performances',
            icon: Icons.queue_music,
            image: '/placeholder.svg?height=200&width=200&text=Live+Band',
            basePrice: '₹25,000 - ₹1,00,000',
            rating: 4.7,
            category: 'Entertainment',
          ),
        ],
      ),
    ];
  }

  void selectCategory(int index) {
    selectedCategory.value = index;
  }

  void selectService(ServiceItem service) {
    selectedService.value = service;
    Get.to(()=>ServiceFormScreen());
  }

  void toggleAvailability(String day) {
    if (selectedAvailability.contains(day)) {
      selectedAvailability.remove(day);
    } else {
      selectedAvailability.add(day);
    }
  }

  void toggleServiceArea(String area) {
    if (selectedAreas.contains(area)) {
      selectedAreas.remove(area);
    } else {
      selectedAreas.add(area);
    }
  }

  void addImage() {
    // Simulate image picker
    selectedImages.add('/placeholder.svg?height=100&width=100&text=Sample+${selectedImages.length + 1}');
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    // Update form data
    formData.value = ServiceFormData(
      name: nameController.text,
      phone: phoneController.text,
      email: emailController.text,
      businessName: businessNameController.text,
      experience: experienceController.text,
      description: descriptionController.text,
      address: addressController.text,
      price: priceController.text,
      website: websiteController.text,
      availability: selectedAvailability.toList(),
      serviceAreas: selectedAreas.toList(),
      images: selectedImages.toList(),
    );

    isLoading.value = false;

    Get.snackbar(
      'Success!',
      'Your service has been registered successfully. We will review and contact you soon.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
    );

    // Clear form
    clearForm();
    Get.back();
  }

  void clearForm() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    businessNameController.clear();
    experienceController.clear();
    descriptionController.clear();
    addressController.clear();
    priceController.clear();
    websiteController.clear();
    selectedAvailability.clear();
    selectedAreas.clear();
    selectedImages.clear();
  }
}

// Data Models
class ServiceCategory {
  final String name;
  final IconData icon;
  final Color color;
  final List<ServiceItem> services;

  ServiceCategory({
    required this.name,
    required this.icon,
    required this.color,
    required this.services,
  });
}

class ServiceItem {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final String image;
  final String basePrice;
  final double rating;
  final String category;

  ServiceItem({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.image,
    required this.basePrice,
    required this.rating,
    required this.category,
  });
}

class ServiceFormData {
  final String name;
  final String phone;
  final String email;
  final String businessName;
  final String experience;
  final String description;
  final String address;
  final String price;
  final String website;
  final List<String> availability;
  final List<String> serviceAreas;
  final List<String> images;

  ServiceFormData({
    this.name = '',
    this.phone = '',
    this.email = '',
    this.businessName = '',
    this.experience = '',
    this.description = '',
    this.address = '',
    this.price = '',
    this.website = '',
    this.availability = const [],
    this.serviceAreas = const [],
    this.images = const [],
  });
}
