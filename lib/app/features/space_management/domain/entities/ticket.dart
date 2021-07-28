abstract class Ticket {
  final int id;
  final String plate;
  final int spaceId;
  final DateTime entryTime;
  final DateTime exitTime;
  final String status;

  Ticket(this.id, this.plate, this.spaceId, this.entryTime, this.exitTime,
      this.status);
}
