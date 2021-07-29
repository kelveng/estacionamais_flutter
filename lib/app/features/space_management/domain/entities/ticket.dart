import 'dart:convert';

class Ticket {
  final int id;
  final String plate;
  final int spaceId;
  final DateTime entryTime;
  final DateTime exitTime;
  final String status;
  final double amount;

  Ticket(
    this.id,
    this.plate,
    this.spaceId,
    this.entryTime,
    this.exitTime,
    this.status,
    this.amount,
  );

  Ticket copyWith({
    int id,
    String plate,
    int spaceId,
    DateTime entryTime,
    DateTime exitTime,
    String status,
    double amount,
  }) {
    return Ticket(
      id ?? this.id,
      plate ?? this.plate,
      spaceId ?? this.spaceId,
      entryTime ?? this.entryTime,
      exitTime ?? this.exitTime,
      status ?? this.status,
      amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plate': plate,
      'spaceId': spaceId,
      'entryTime': entryTime.millisecondsSinceEpoch,
      'exitTime': exitTime.millisecondsSinceEpoch,
      'status': status,
      'amount': amount,
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      map['id'],
      map['plate'],
      map['spaceId'],
      DateTime.fromMillisecondsSinceEpoch(map['entryTime']),
      DateTime.fromMillisecondsSinceEpoch(map['exitTime']),
      map['status'],
      map['amount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Ticket.fromJson(String source) => Ticket.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Ticket(id: $id, plate: $plate, spaceId: $spaceId, entryTime: $entryTime, exitTime: $exitTime, status: $status, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ticket &&
        other.id == id &&
        other.plate == plate &&
        other.spaceId == spaceId &&
        other.entryTime == entryTime &&
        other.exitTime == exitTime &&
        other.status == status &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        plate.hashCode ^
        spaceId.hashCode ^
        entryTime.hashCode ^
        exitTime.hashCode ^
        status.hashCode ^
        amount.hashCode;
  }
}
