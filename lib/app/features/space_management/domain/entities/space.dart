abstract class Space {
  final int id;
  final String description;
  final bool isBusy;
  final int ticketId;

  Space(
    this.id,
    this.description,
    this.isBusy,
    this.ticketId,
  );
}
