import 'package:flutter/material.dart';

class PortfolioData {
  // HERO SECTION
  static const String name = "Nikhar Tale";
  static const String role = "Building AI-Powered\nMobile Experiences.";
  static const String bio =
      "Senior Flutter Engineer specializing in Clean Architecture, offline-first applications, and on-device TFLite integrations. Currently architecting high-performance solutions at Infosys.";
  static const String email = "nikhartale12@gmail.com";
  static const String phone = "+91 7000391986"; // Replace with real number
  static const String github = "https://github.com/nikhar-tale";
  static const String linkedin =
      "https://linkedin.com/in/nikhar-tale-3359b41a2";
  static const String resumeUrl = "https://drive.google.com/file/d/1FazcseQMiUgtpal3jxYbKL0GNSrmt2GU/view";

  // STATS
  static const List<Map<String, String>> stats = [
    {"value": "4+", "label": "Years Experience"},
    {"value": "5+", "label": "Apps in Production"},
    {"value": "10k+", "label": "Daily Active Users"},
    {"value": "99.9%", "label": "Crash-Free Rate"},
  ];

  // EXPERTISE
  static const List<Map<String, dynamic>> expertise = [
    {
      "icon": Icons.architecture,
      "title": "Architecture & State",
      "description":
          "Deep expertise in feature-first Clean Architecture, BLoC pattern, and building robust offline-first synchronization using Hive and SQLite.",
    },
    {
      "icon": Icons.memory,
      "title": "AI & Edge Computing",
      "description":
          "Integrating on-device machine learning with TFLite, enabling real-time computer vision, auto-grading pipelines, and low-latency local processing.",
    },
    {
      "icon": Icons.devices,
      "title": "Native & Hardware",
      "description":
          "Bridging the gap between Flutter and native platforms using Method Channels, CameraX, and Bluetooth integrations for POS and IoT devices.",
    },
  ];

  // EXPERIENCE
  static const List<Map<String, dynamic>> experience = [
    {
      "role": "Flutter Developer",
      "company": "Infosys",
      "duration": "Oct 2025 – Present",
      "bullets": [
        "Developed and maintained cross-platform mobile applications using Flutter and Dart.",
        "Integrated RESTful APIs and Firebase backend services for real-time data synchronization.",
        "Optimized app performance and reduced rendering bottlenecks using Flutter DevTools.",
        "Collaborated with UI/UX designers to translate Figma prototypes into pixel-perfect responsive layouts.",
      ],
    },
    {
      "role": "Senior Software Engineer",
      "company": "Zehntech Technologies",
      "duration": "Sep 2021 – Oct 2025",
      "bullets": [
        "Architected enterprise-grade Flutter applications using feature-first Clean Architecture (Domain, Data, Presentation layers).",
        "Developed 'HumanWare explorē Magnifier', a versatile digital magnifier app with advanced camera controls and real-time image processing for accessibility.",
        "Built an AI grading pipeline utilizing TFLite on-device, GPT-4o, and AWS Lambda, reducing manual evaluation effort by 70%.",
        "Engineered robust offline-first caching mechanisms using Hive and SQLite, ensuring seamless user experiences in low-connectivity environments.",
        "Mentored junior developers, conducted code reviews, and established CI/CD pipelines using GitHub Actions for automated deployments.",
        "Managed end-to-end app release lifecycles to both the Google Play Store and Apple App Store.",
      ],
    },
  ];

  // CERTIFICATIONS
  static const List<Map<String, String>> certifications = [
    {
      "title": "Infosys Certified Flutter Developer",
      "issuer": "Infosys Springboard",
      "date": "2026",
    },
    {
      "title": "Infosys Certified Mobile App Developer",
      "issuer": "Infosys Springboard",
      "date": "2025",
    },
  ];

  // PROJECTS
  static const List<Map<String, dynamic>> projects = [
    {
      "title": "EduSync AI — Multi-Tenant Platform",
      "description":
          "A massive white-label architecture that generated over 200 unique school applications (Web & Mobile) from a single Flutter codebase. Features an integrated tool for teachers to scan and auto-grade handwritten worksheets using on-device AI.",
      "tech": ["Flutter", "White-Label", "TFLite", "AWS Lambda"],
      "playStoreUrl":
          "https://play.google.com/store/apps/details?id=com.app.p1676CB&pcampaignid=web_share", // Replace with real link
      "appStoreUrl":
          "https://apps.apple.com/us/app/ps-456-bronx-bears/id1561274472", // Replace with real link
      "imageUrl": "assets/images/eduSync.webp",
    },
    {
      "title": "BillMantraX — POS System",
      "description":
          "Enterprise omnichannel Point of Sale (POS) solution for restaurants. Runs seamlessly on mobile and tablets with offline-first Firebase synchronization, thermal Bluetooth printing, and real-time inventory tracking.",
      "tech": ["Flutter", "Firebase", "BLoC", "Bluetooth"],
      "playStoreUrl":
          "https://play.google.com/store/apps/details?id=com.billmantra.app&pcampaignid=web_share", // Replace with real link
      "imageUrl": "assets/images/BillMantraX.webp",
    },
    {
      "title": "HumanWare explorē Magnifier",
      "description":
          "A specialized accessibility application that turns a smartphone into a versatile digital magnifier. Engineered with advanced camera controls, real-time image processing, and a high-contrast UI specifically designed for visually impaired users.",
      "tech": ["Flutter", "CameraX", "Image Processing", "Accessibility"],
      "playStoreUrl":
          "https://play.google.com/store/apps/details?id=com.humanware.hwmagnifier",
      "appStoreUrl":
          "https://apps.apple.com/in/app/humanware-explorē-magnifier/id6443956466", // Replace with real link
      "imageUrl": "assets/images/humanWare_explore_magnifier.webp",
    },
    {
      "title": "AI Grading Engine",
      "description":
          "The standalone computer-vision and evaluation engine powering the grading feature of the EduSync platform. Uses real-time camera capture to scan handwritten text, process it via FastAPI, and grade it using GPT-4o.",
      "tech": ["Flutter", "FastAPI", "GPT-4o"],
      "imageUrl": "assets/images/ai_grading_engine.webp",
    },
  ];
}
