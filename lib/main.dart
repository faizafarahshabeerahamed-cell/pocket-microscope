
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const Color backgroundColor = Color(0xFF07111F);
const Color cardColor = Color(0xFF101E30);
const Color accentColor = Color(0xFF43F5CF);
const Color mutedColor = Color(0xFF91A5BA);

void main() {
  runApp(const PocketMicroscopeApp());
}

class PocketMicroscopeApp extends StatelessWidget {
  const PocketMicroscopeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pocket Microscope',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: const ColorScheme.dark(
          primary: accentColor,
          surface: cardColor,
        ),
        useMaterial3: true,
        fontFamily: 'Arial',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Uint8List? selectedImage;
  String? imageName;
  bool isUploading = false;

  Future<void> uploadImage() async {
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (image == null) return;

      setState(() {
        isUploading = true;
      });

      final Uint8List bytes = await image.readAsBytes();

      if (!mounted) return;

      setState(() {
        selectedImage = bytes;
        imageName = image.name;
        isUploading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not load the image. Please try again.'),
        ),
      );
    }
  }

  Widget sectionTitle(String number, String title) {
    return Row(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: accentColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget panel({
    required Widget child,
    EdgeInsets padding = const EdgeInsets.all(20),
  }) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF26384D),
        ),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 18,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NAVIGATION BAR
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: accentColor.withValues(alpha: 0.4),
                          ),
                        ),
                        child: const Icon(
                          Icons.biotech,
                          color: accentColor,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'POCKET MICROSCOPE',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'PORTABLE MICROSCOPY LAB',
                              style: TextStyle(
                                fontSize: 9,
                                color: mutedColor,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: accentColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 7,
                              color: accentColor,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'ONLINE',
                              style: TextStyle(
                                fontSize: 10,
                                color: accentColor,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 34),

                  // HERO SECTION
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF142C3D),
                          Color(0xFF0D192B),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFF2B485A),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: accentColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'NEXT-GEN MICROSCOPY',
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 10,
                              letterSpacing: 1.4,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'See the invisible.',
                          style: TextStyle(
                            fontSize: 34,
                            height: 1.15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.8,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Microscopy meets computer vision image analysis.',
                          style: TextStyle(
                            color: mutedColor,
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            Icon(
                              Icons.bolt,
                              color: accentColor,
                              size: 18,
                            ),
                            SizedBox(width: 7),
                            Expanded(
                              child: Text(
                                'A portable approach to exploring microscope images',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFD3E2EE),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  sectionTitle('01', 'Your workspace'),
                  const SizedBox(height: 15),

                  // UPLOAD PANEL
                  panel(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.cloud_upload_outlined,
                              color: accentColor,
                              size: 22,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Import a sample',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Choose a microscope image from your device.',
                          style: TextStyle(
                            color: mutedColor,
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // IMAGE PREVIEW
                        Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(
                            minHeight: 200,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF091421),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xFF30465A),
                            ),
                          ),
                          child: selectedImage == null
                              ? const Padding(
                                  padding: EdgeInsets.all(25),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.center_focus_strong,
                                        color: accentColor,
                                        size: 46,
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'NO SAMPLE LOADED',
                                        style: TextStyle(
                                          color: mutedColor,
                                          fontSize: 11,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                      SizedBox(height: 7),
                                      Text(
                                        'Your image will appear here',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.memory(
                                    selectedImage!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                        ),

                        if (imageName != null) ...[
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                color: accentColor,
                                size: 17,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  imageName!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: accentColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],

                        const SizedBox(height: 18),

                        // WORKING UPLOAD BUTTON
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: isUploading ? null : uploadImage,
                            icon: Icon(
                              selectedImage == null
                                  ? Icons.add_photo_alternate_outlined
                                  : Icons.refresh,
                            ),
                            label: Text(
                              isUploading
                                  ? 'Loading image...'
                                  : selectedImage == null
                                      ? 'Upload Image'
                                      : 'Choose Another Image',
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentColor,
                              foregroundColor: backgroundColor,
                              padding: const EdgeInsets.symmetric(
                                vertical: 17,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  sectionTitle('02', 'Analysis console'),
                  const SizedBox(height: 15),

                  // FUTURE AI PANEL
                  panel(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.memory,
                              color: accentColor,
                              size: 23,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Computer vision engine',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.lock_outline,
                              color: mutedColor,
                              size: 18,
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF091421),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Column(
                            children: [
                              Icon(
                                Icons.biotech_outlined,
                                color: Color(0xFF668394),
                                size: 38,
                              ),
                              SizedBox(height: 12),
                              Text(
                                ' COMPUTER VISION ENGINE NOT CONNECTED',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: accentColor,
                                  fontSize: 11,
                                  letterSpacing: 1.1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Image upload is ready. Connect a validated '
                                'image-analysis model to detect or count cells.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: mutedColor,
                                  fontSize: 12,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // FOOTER
                  const Center(
                    child: Text(
                      'POCKET MICROSCOPE  •  RESEARCH PROJECT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF657B91),
                        fontSize: 10,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

