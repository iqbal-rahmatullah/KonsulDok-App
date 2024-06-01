class Rating {
  final int id;
  final int doctorId;
  final int appointmentId;
  final String namePatient;
  final int rating;
  final DateTime createdAt;

  Rating(
      {required this.id,
      required this.doctorId,
      required this.appointmentId,
      required this.namePatient,
      required this.rating,
      required this.createdAt});
}
