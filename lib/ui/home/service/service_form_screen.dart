import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/service_controller.dart';

class ServiceFormScreen extends StatelessWidget {
  final ServiceController controller = Get.find<ServiceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildServiceHeader(),
              SizedBox(height: 24),
              _buildPersonalInfoSection(),
              SizedBox(height: 24),
              _buildBusinessInfoSection(),
              SizedBox(height: 24),
              _buildServiceDetailsSection(),
              SizedBox(height: 24),
              _buildAvailabilitySection(),
              SizedBox(height: 24),
              _buildServiceAreasSection(),
              SizedBox(height: 24),
              _buildImageSection(),
              SizedBox(height: 32),
              _buildSubmitButton(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF4CAF50),
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'Register Service',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildServiceHeader() {
    return Obx(() {
      final service = controller.selectedService.value;
      if (service == null) return SizedBox.shrink();

      return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4CAF50),
              Color(0xFF45a049),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF4CAF50).withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                service.icon,
                color: Colors.white,
                size: 32,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    service.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      service.basePrice,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPersonalInfoSection() {
    return _buildSection(
      'Personal Information',
      Icons.person_outline,
      [
        _buildTextField(
          controller: controller.nameController,
          label: 'Full Name',
          hint: 'Enter your full name',
          icon: Icons.person,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        SizedBox(height: 16),
        _buildTextField(
          controller: controller.phoneController,
          label: 'Phone Number',
          hint: 'Enter your phone number',
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number';
            }
            if (value.length < 10) {
              return 'Please enter a valid phone number';
            }
            return null;
          },
        ),
        SizedBox(height: 16),
        _buildTextField(
          controller: controller.emailController,
          label: 'Email Address',
          hint: 'Enter your email address',
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!GetUtils.isEmail(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildBusinessInfoSection() {
    return _buildSection(
      'Business Information',
      Icons.business_outlined,
      [
        _buildTextField(
          controller: controller.businessNameController,
          label: 'Business Name',
          hint: 'Enter your business name',
          icon: Icons.business,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your business name';
            }
            return null;
          },
        ),
        SizedBox(height: 16),
        _buildTextField(
          controller: controller.experienceController,
          label: 'Years of Experience',
          hint: 'Enter years of experience',
          icon: Icons.work_history,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your experience';
            }
            return null;
          },
        ),
        SizedBox(height: 16),
        _buildTextField(
          controller: controller.addressController,
          label: 'Business Address',
          hint: 'Enter your business address',
          icon: Icons.location_on,
          maxLines: 3,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your business address';
            }
            return null;
          },
        ),
        SizedBox(height: 16),
        _buildTextField(
          controller: controller.websiteController,
          label: 'Website (Optional)',
          hint: 'Enter your website URL',
          icon: Icons.web,
          keyboardType: TextInputType.url,
        ),
      ],
    );
  }

  Widget _buildServiceDetailsSection() {
    return _buildSection(
      'Service Details',
      Icons.design_services_outlined,
      [
        _buildTextField(
          controller: controller.priceController,
          label: 'Price Range',
          hint: 'e.g., ₹10,000 - ₹50,000',
          icon: Icons.currency_rupee,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your price range';
            }
            return null;
          },
        ),
        SizedBox(height: 16),
        _buildTextField(
          controller: controller.descriptionController,
          label: 'Service Description',
          hint: 'Describe your services in detail',
          icon: Icons.description,
          maxLines: 4,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter service description';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildAvailabilitySection() {
    return _buildSection(
      'Availability',
      Icons.schedule_outlined,
      [
        Text(
          'Select your available days:',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12),
        Obx(() => Wrap(
          spacing: 8,
          runSpacing: 8,
          children: controller.availabilityOptions.map((day) {
            final isSelected = controller.selectedAvailability.contains(day);
            return GestureDetector(
              onTap: () => controller.toggleAvailability(day),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF4CAF50) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? Color(0xFF4CAF50) : Colors.grey[300]!,
                  ),
                  boxShadow: isSelected ? [
                    BoxShadow(
                      color: Color(0xFF4CAF50).withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ] : null,
                ),
                child: Text(
                  day,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            );
          }).toList(),
        )),
      ],
    );
  }

  Widget _buildServiceAreasSection() {
    return _buildSection(
      'Service Areas',
      Icons.map_outlined,
      [
        Text(
          'Select cities where you provide services:',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12),
        Obx(() => Wrap(
          spacing: 8,
          runSpacing: 8,
          children: controller.serviceAreas.map((area) {
            final isSelected = controller.selectedAreas.contains(area);
            return GestureDetector(
              onTap: () => controller.toggleServiceArea(area),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF4CAF50).withOpacity(0.1) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? Color(0xFF4CAF50) : Colors.grey[300]!,
                  ),
                ),
                child: Text(
                  area,
                  style: TextStyle(
                    color: isSelected ? Color(0xFF4CAF50) : Colors.grey[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
                ),
              ),
            );
          }).toList(),
        )),
      ],
    );
  }

  Widget _buildImageSection() {
    return _buildSection(
      'Portfolio Images',
      Icons.photo_library_outlined,
      [
        Text(
          'Add images of your work (Optional):',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12),
        Obx(() => Column(
          children: [
            if (controller.selectedImages.isNotEmpty)
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.selectedImages.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                controller.selectedImages[index],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[200],
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.grey[400],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => controller.removeImage(index),
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            SizedBox(height: 12),
            GestureDetector(
              onTap: controller.addImage,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color(0xFF4CAF50).withOpacity(0.3),
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      color: Color(0xFF4CAF50),
                      size: 32,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Add Portfolio Images',
                      style: TextStyle(
                        color: Color(0xFF4CAF50),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Obx(() => Container(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: controller.isLoading.value ? null : controller.submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF4CAF50),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
        ),
        child: controller.isLoading.value
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Submitting...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
            : Text(
          'Register Service',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF4CAF50).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Color(0xFF4CAF50),
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Color(0xFF4CAF50)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF4CAF50), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
