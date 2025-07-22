import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/image_gallery_controller.dart';

class ImageGalleryScreen extends StatelessWidget {
  final ImageGalleryController controller = Get.put(ImageGalleryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: _buildImageViewer(),
          ),
          if (controller.canEdit.value)
            _buildBottomActions(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      title: Obx(() => Text(
        '${controller.currentIndex.value + 1} of ${controller.images.length}',
        style: TextStyle(color: Colors.white),
      )),
      actions: [
        if (controller.canEdit.value)
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            color: Colors.grey[900],
            onSelected: (value) {
              switch (value) {
                case 'replace':
                  controller.replaceImage(controller.currentIndex.value);
                  break;
                case 'delete':
                  controller.deleteImage(controller.currentIndex.value);
                  break;
                case 'main':
                  controller.setAsMainPhoto(controller.currentIndex.value);
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'replace',
                child: Row(
                  children: [
                    Icon(Icons.photo_camera, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text('Replace Photo', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'main',
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text('Set as Main', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Text('Delete Photo', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildImageViewer() {
    return Stack(
      children: [
        // Main image viewer
        Obx(() => PageView.builder(
          itemCount: controller.images.length,
          onPageChanged: controller.changeImage,
          controller: PageController(initialPage: controller.currentIndex.value),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(16),
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 3.0,
                child: Center(
                  child: Image.network(
                    controller.images[index],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[800],
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.broken_image,
                                size: 80,
                                color: Colors.grey[600],
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Failed to load image',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        )),

        // Image indicators
        Positioned(
          bottom: 100,
          left: 0,
          right: 0,
          child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: controller.images.asMap().entries.map((entry) {
              return Container(
                width: 8,
                height: 8,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.currentIndex.value == entry.key
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
              );
            }).toList(),
          )),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Thumbnail strip
          Container(
            height: 80,
            child: Obx(() => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.images.length + 1, // +1 for add button
              itemBuilder: (context, index) {
                if (index == controller.images.length) {
                  // Add photo button
                  return GestureDetector(
                    onTap: controller.addImage,
                    child: Container(
                      width: 80,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey[600]!,
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return GestureDetector(
                  onTap: () => controller.changeImage(index),
                  child: Container(
                    width: 80,
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: controller.currentIndex.value == index
                            ? Color(0xFF4CAF50)
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            controller.images[index],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[700],
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.grey[500],
                                ),
                              );
                            },
                          ),
                        ),
                        if (index == 0)
                          Positioned(
                            top: 4,
                            left: 4,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: Color(0xFF4CAF50),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'MAIN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            )),
          ),

          SizedBox(height: 16),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => controller.replaceImage(controller.currentIndex.value),
                  icon: Icon(Icons.photo_camera, size: 18),
                  label: Text('Replace'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => controller.setAsMainPhoto(controller.currentIndex.value),
                  icon: Icon(Icons.star, size: 18),
                  label: Text('Set Main'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              IconButton(
                onPressed: () => controller.deleteImage(controller.currentIndex.value),
                icon: Icon(Icons.delete, color: Colors.red),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
