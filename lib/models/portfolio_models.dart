class SkillModel {
  final String icon;
  final String name;
  final String level;
  final double percentage;

  const SkillModel({
    required this.icon,
    required this.name,
    required this.level,
    required this.percentage,
  });
}

class EducationModel {
  final String degree;
  final String shortName;
  final String field;
  final double cgpa;
  final String description;
  final String emoji;
  final String year;

  const EducationModel({
    required this.degree,
    required this.shortName,
    required this.field,
    required this.cgpa,
    required this.description,
    required this.emoji,
    required this.year,
  });
}

class ExperienceModel {
  final String role;
  final String company;
  final String duration;
  final String period;
  final bool isCurrent;
  final String description;
  final List<String> responsibilities;
  final List<String> techStack;

  const ExperienceModel({
    required this.role,
    required this.company,
    required this.duration,
    required this.period,
    required this.isCurrent,
    required this.description,
    required this.responsibilities,
    required this.techStack,
  });
}

class StatModel {
  final String value;
  final String label;

  const StatModel({required this.value, required this.label});
}
