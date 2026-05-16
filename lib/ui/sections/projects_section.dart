import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/theme/app_theme.dart';
import 'package:portfolio_web/data/portfolio_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:vector_math/vector_math_64.dart' as vmath;

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 100),
          color: AppTheme.surface, // Subtle contrast from Hero
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 100),
                child: Semantics(
                  header: true,
                  child: Row(
                    children: [
                      const Icon(Icons.apps, color: AppTheme.secondary),
                      const SizedBox(width: 12),
                      Text(
                        "Featured Work",
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: isMobile ? 32 : 48,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 80),
              // Horizontal App Store style scrolling
              SizedBox(
                height: isMobile ? 950 : 1100, // Tighter height on mobile to prevent dead space
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none, // Allow shadows and hover animations to draw outside
                  padding: EdgeInsets.only(
                    left: isMobile ? 24 : 100,
                    right: isMobile ? 24 : 100,
                    top: 20, // Prevents clipping when phone translates up by -10.0
                    bottom: 40, // Prevents clipping of the drop shadow
                  ),
                  itemCount: PortfolioData.projects.length,
                  itemBuilder: (context, index) {
                    final cardWidth = isMobile 
                        ? (MediaQuery.of(context).size.width * 0.72).clamp(200.0, 240.0) // Clamped smaller to keep mobile phones from getting too tall
                        : 300.0;
                    return Padding(
                      padding: EdgeInsets.only(right: isMobile ? 20 : 40),
                      child: _PhoneProjectCard(
                        project: PortfolioData.projects[index],
                        cardWidth: cardWidth,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PhoneProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final double cardWidth;

  const _PhoneProjectCard({
    required this.project,
    required this.cardWidth,
  });

  @override
  State<_PhoneProjectCard> createState() => _PhoneProjectCardState();
}

class _PhoneProjectCardState extends State<_PhoneProjectCard> {
  bool isHovered = false;
  double tiltX = 0;
  double tiltY = 0;

  bool get _active => isHovered || MediaQuery.of(context).size.width < 800;

  void _onMouseUpdate(PointerEvent event, BoxConstraints constraints) {
    if (!isHovered) return;
    
    // Calculate relative position (from -1.0 to 1.0)
    final x = (event.localPosition.dx / constraints.maxWidth) * 2 - 1;
    final y = (event.localPosition.dy / constraints.maxHeight) * 2 - 1;
    
    setState(() {
      tiltX = -y * 0.15; // Vertical mouse movement tilts around X axis
      tiltY = x * 0.15;  // Horizontal mouse movement tilts around Y axis
    });
  }

  void _resetTilt() {
    setState(() {
      tiltX = 0;
      tiltY = 0;
    });
  }

  Widget _getTechIcon(String tech) {
    IconData iconData;
    Color iconColor;
    switch (tech.toLowerCase()) {
      case 'flutter':
        iconData = SimpleIcons.flutter;
        iconColor = const Color(0xFF54C5F8); // Flutter Blue
        break;
      case 'firebase':
        iconData = SimpleIcons.firebase;
        iconColor = const Color(0xFFFFCA28); // Firebase Yellow
        break;
      case 'aws lambda':
        iconData = FontAwesomeIcons.aws;
        iconColor = const Color(0xFFFF9900); // AWS Orange
        break;
      case 'fastapi':
        iconData = SimpleIcons.fastapi;
        iconColor = const Color(0xFF009688); // FastAPI Teal
        break;
      case 'gpt-4o':
      case 'openai':
        iconData = SimpleIcons.openai;
        iconColor = Colors.white; // OpenAI White
        break;
      case 'bluetooth':
        iconData = FontAwesomeIcons.bluetooth;
        iconColor = const Color(0xFF0082FC); // Bluetooth Blue
        break;
      case 'bloc':
        iconData = Icons.widgets;
        iconColor = const Color(0xFF8A2BE2); // BLoC Purple
        break;
      case 'tflite':
        iconData = SimpleIcons.tensorflow;
        iconColor = const Color(0xFFFF6F00); // TensorFlow Orange
        break;
      case 'hive':
        iconData = Icons.storage;
        iconColor = const Color(0xFFFFD700); // Hive Gold
        break;
      case 'white-label':
        iconData = Icons.branding_watermark;
        iconColor = Colors.grey.shade400;
        break;
      case 'camerax':
        iconData = Icons.camera_alt;
        iconColor = const Color(0xFF3DDC84); // Android Green
        break;
      case 'image processing':
        iconData = Icons.image;
        iconColor = Colors.tealAccent;
        break;
      case 'accessibility':
        iconData = Icons.accessibility_new;
        iconColor = Colors.blueAccent;
        break;
      default:
        iconData = Icons.code;
        iconColor = AppTheme.secondary;
    }
    return Icon(iconData, size: 14, color: iconColor);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.cardWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // iPhone Hardware Mockup
          LayoutBuilder(
            builder: (context, constraints) {
              return MouseRegion(
                onEnter: (_) => setState(() => isHovered = true),
                onExit: (_) {
                  setState(() => isHovered = false);
                  _resetTilt();
                },
                onHover: (event) => _onMouseUpdate(event, constraints),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001) // Perspective
                    ..rotateX(tiltX)
                    ..rotateY(tiltY)
                    ..translateByVector3(vmath.Vector3(0.0, _active ? -10.0 : 0.0, 0.0)),
                  child: Stack(
                    children: [
                      // Volume Up Button
                      Positioned(
                        left: -3,
                        top: 170,
                        child: Container(
                          width: 3,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade700,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              bottomLeft: Radius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      // Volume Down Button
                      Positioned(
                        left: -3,
                        top: 230,
                        child: Container(
                          width: 3,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade700,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              bottomLeft: Radius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      // Power Button
                      Positioned(
                        right: -3,
                        top: 200,
                        child: Container(
                          width: 3,
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade700,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      // Main Device Frame
                      Container(
                        height: widget.cardWidth * (19.5 / 9), // Exact iPhone aspect ratio
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(45),
                          border: Border.all(color: const Color(0xFF2C2C2C), width: 10),
                          boxShadow: [
                            if (_active)
                              BoxShadow(
                                color: AppTheme.secondary.withValues(alpha: 0.3),
                                blurRadius: 40,
                                offset: const Offset(0, 20),
                              ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Screen Content (App Screenshot)
                              widget.project['imageUrl'].startsWith('http')
                                  ? Image.network(
                                      widget.project['imageUrl'],
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      widget.project['imageUrl'],
                                      fit: BoxFit.cover,
                                    ),
                              // Inner Bezel Shadow (for realism)
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black.withValues(alpha: 0.3), width: 2),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                              ),
                              // Dynamic Island
                              Positioned(
                                top: 8,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    width: 100,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                              // Home Indicator
                              Positioned(
                                bottom: 8,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    width: 120,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.8),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          // Project Info
          Semantics(
            label: "Project title: ${widget.project['title']}",
            child: Text(
              widget.project['title'],
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 12),
          Semantics(
            label: "Project description",
            child: Text(
              widget.project['description'],
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 20),
          // Tech Stack
          Semantics(
            label: "Technologies used: ${(widget.project['tech'] as List).join(', ')}",
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (widget.project['tech'] as List<dynamic>).map((tech) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _getTechIcon(tech.toString()),
                      const SizedBox(width: 6),
                      Text(
                        tech.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppTheme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
          // Actions
          Row(
            children: [
              if (widget.project['playStoreUrl'] != null)
                Semantics(
                  button: true,
                  label: "View ${widget.project['title']} on Google Play Store",
                  child: IconButton(
                    icon: const Icon(FontAwesomeIcons.googlePlay, color: Colors.white, size: 20),
                    tooltip: "Google Play Store",
                    onPressed: () => launchUrl(Uri.parse(widget.project['playStoreUrl'])),
                  ),
                ),
              if (widget.project['appStoreUrl'] != null)
                Semantics(
                  button: true,
                  label: "View ${widget.project['title']} on Apple App Store",
                  child: IconButton(
                    icon: const Icon(FontAwesomeIcons.appStoreIos, color: Colors.white, size: 22),
                    tooltip: "Apple App Store",
                    onPressed: () => launchUrl(Uri.parse(widget.project['appStoreUrl'])),
                  ),
                ),
              if (widget.project['githubUrl'] != null)
                Semantics(
                  button: true,
                  label: "View ${widget.project['title']} source code on GitHub",
                  child: IconButton(
                    icon: const Icon(FontAwesomeIcons.github, color: Colors.white, size: 22),
                    tooltip: "Source Code",
                    onPressed: () => launchUrl(Uri.parse(widget.project['githubUrl'])),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
