class Event {
  final String eventId;
  final String userId;
  final String name;
  final String imagePath;
  final String startDateTime;
  final String endDateTime;

  Event({
    required this.eventId,
    required this.userId,
    required this.name,
    required this.imagePath,
    required this.startDateTime,
    required this.endDateTime,
  });
}
