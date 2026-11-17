import 'models/experience.dart';
const mockCurrentUserId = 'user_001';

final List<Experience> mockExperiences = [
  Experience(
    id: 'exp_001',
    authorId: mockCurrentUserId,
    company: 'Example Company',
    position: 'Software Engineering Intern',
    department: 'Engineering',
    location: 'Istanbul, Türkiye',
    workType: 'Hybrid',
    duration: 'July 2026 – September 2026',
    rating: 4.0,
    isVerified: true,
    recommends: true,
    createdAt: DateTime(2026, 10, 15),
    review: 'I worked on backend APIs and tested new features. '
        'Regular code reviews helped me improve my coding skills.',
    pros: [
      'Supportive team and regular mentoring',
      'Hands-on experience with real projects',
    ],
    cons: [
      'Limited onboarding documentation',
      'Some tasks were repetitive',
    ],
    applicationChannel: 'Company website',
    interviewRounds: 2,
    interviewDifficulty: 'Moderate',
    interviewDescription: 'An HR interview followed by a technical '
        'interview and a short coding exercise.',
    technologies: ['Python', 'SQL', 'Git', 'REST APIs'],
  ),
  Experience(
    id: 'exp_002',
    authorId: 'user_002',
    company: 'Sample Research Lab',
    position: 'Research Intern',
    department: 'Machine Learning',
    location: 'Ankara, Türkiye',
    workType: 'On-site',
    duration: 'June 2026 – August 2026',
    rating: 4.8,
    isVerified: false,
    recommends: true,
    createdAt: DateTime(2026, 11, 10),
    review: 'I helped prepare datasets and evaluate machine learning '
        'models. Weekly meetings provided useful research feedback.',
    pros: [
      'Close collaboration with researchers',
      'Opportunity to explore different models',
    ],
    cons: [
      'Required substantial independent reading',
    ],
    applicationChannel: 'University career portal',
    interviewRounds: 1,
    interviewDifficulty: 'Challenging',
    interviewDescription: 'A technical discussion about previous '
        'projects, statistics and machine learning fundamentals.',
    technologies: ['Python', 'Pandas', 'Scikit-learn'],
  ),
  Experience(
    id: 'exp_003',
    authorId: mockCurrentUserId,
    company: 'Demo Digital',
    position: 'Mobile Development Intern',
    department: 'Product Development',
    location: 'Izmir, Türkiye',
    workType: 'Remote',
    duration: 'July 2026 – August 2026',
    rating: 3.5,
    isVerified: true,
    recommends: false,
    createdAt: DateTime(2026, 11, 12),
    review: 'I built mobile interface components and fixed layout '
        'issues. However, feedback and mentoring were limited.',
    pros: [
      'Flexible working hours',
      'Practical mobile development experience',
    ],
    cons: [
      'Limited mentoring',
      'Unclear task descriptions',
    ],
    applicationChannel: 'Online job listing',
    interviewRounds: 2,
    interviewDifficulty: 'Easy',
    interviewDescription: 'A short introductory call followed '
        'by a discussion of a sample mobile application.',
    technologies: ['Flutter', 'Dart', 'Git'],
  ),
];