class VerificationRequest {
  final String id;
  final String studentName;
  final String studentInfo;
  final String organizationName;
  final String department;
  final String role;
  final String period;
  final String submittedAt;
  final String documentName;
  final String status; // 'Pending', 'Approved' or 'Rejected'

  const VerificationRequest({
    required this.id,
    required this.studentName,
    required this.studentInfo,
    required this.organizationName,
    required this.department,
    required this.role,
    required this.period,
    required this.submittedAt,
    required this.documentName,
    required this.status,
  });
}