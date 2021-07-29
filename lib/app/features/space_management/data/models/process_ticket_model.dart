class ProcessTicketModel {
  final String plate;
  final int spaceId;

  ProcessTicketModel(this.plate, this.spaceId);

  Map<String, dynamic> toMapProcess() {
    return {
      'plate': plate,
      'spaceId': spaceId,
    };
  }
}
