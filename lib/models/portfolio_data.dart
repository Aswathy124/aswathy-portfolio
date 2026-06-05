import 'portfolio_models.dart';

class PortfolioData {
  static const List<SkillModel> skills = [
    SkillModel(icon: '📱', name: 'Flutter', level: 'Primary Skill', percentage: 0.90),
    SkillModel(icon: '🎯', name: 'Dart', level: 'Expert', percentage: 0.88),
    SkillModel(icon: '🔥', name: 'Firebase', level: 'Advanced', percentage: 0.82),
    SkillModel(icon: '🧩', name: 'Getx', level: 'Advanced', percentage: 0.78),
    SkillModel(icon: '🌐', name: 'REST APIs', level: 'Advanced', percentage: 0.85),
    SkillModel(icon: '📦', name: 'State Management', level: 'Advanced', percentage: 0.80),
    SkillModel(icon: '🗃️', name: 'Hive', level: 'Intermediate', percentage: 0.70),
    SkillModel(icon: '🔧', name: 'Git & Version Control', level: 'Proficient', percentage: 0.82),
    SkillModel(icon: '🎨', name: 'UI/UX Implementation', level: 'Proficient', percentage: 0.78),
    SkillModel(icon: '🤖', name: 'Android Platform', level: 'Intermediate', percentage: 0.72),
    SkillModel(icon: '🍎', name: 'iOS Deployment', level: 'Intermediate', percentage: 0.68),
  ];

  static const List<EducationModel> education = [
    EducationModel(
      emoji: '🎓',
      degree: 'Master of Computer Applications',
      shortName: 'MCA',
      field: 'Computer Science & Applications',
      cgpa: 7.5,
      description:
          'Specialized in advanced software development, algorithms, database management, and mobile application development using modern frameworks.',
  year: '2019 - 2022',
  ),
    EducationModel(
      emoji: '📚',
      degree: 'Bachelor of Computer Applications',
      shortName: 'BCA',
      field: 'Computer Applications',
      cgpa: 7.89,

      description:
          'Built a strong foundation in programming, data structures, web technologies, and software engineering principles.',
  year: '2022 - 2024',
    ),
  ];

  static const List<ExperienceModel> experience = [
    ExperienceModel(
      role: 'Flutter Developer',
      company: 'Inciem Business Consultants',
      duration: '1 Year 10 Month',
      period: 'Present',
      isCurrent: true,
      description:
          'Working as a Flutter Developer contributing to the design, development, and delivery of cross-platform mobile applications for business clients.',
      responsibilities: [
        'Developing and maintaining cross-platform Flutter apps for Android & iOS using Dart',
        'Implementing state management using Getx',
        'Integrating REST APIs and Firebase services (Firestore, Auth, Storage)',
        'Building reusable widget libraries following Flutter clean architecture',
        'Collaborating with UI/UX designers to implement pixel-perfect interfaces',
        'Participating in code reviews, agile sprints, and technical documentation',
        'Deployed apps in Google Play Store and Apple App Store',
      ],
      techStack: ['Flutter', 'Dart', 'Firebase', 'REST APIs' ,'Git', 'Android', 'iOS'],
    ),
  ];

  static const List<StatModel> stats = [
    StatModel(value: '1.10yr', label: 'Industry Exp'),
    StatModel(value: 'MCA', label: '7.5 CGPA'),
    StatModel(value: 'BCA', label: '7.89 CGPA'),
  ];

  static const List<String> techTags = [
    'Flutter', 'Dart', 'Firebase', 'REST APIs',
     'GetX', 'SQLite', 'Hive', 'Git', 'Agile',
    'Android', 'iOS', 'Figma', 'VS Code', 'Google Play', 'App Store',
  ];

  static const List<Map<String, String>> timeline = [
    {
      'year': 'Present · 2024–2026',
      'role': 'Flutter Developer',
      'place': 'Inciem Business Consultants',
    },
    {
      'year': 'Completed · MCA',
      'role': 'Master of Computer Applications',
      'place': 'CGPA: 7.5 / 10',
    },
    {
      'year': 'Completed · BCA',
      'role': 'Bachelor of Computer Applications',
      'place': 'CGPA: 7.89 / 10',
    },
 
  ];
}
