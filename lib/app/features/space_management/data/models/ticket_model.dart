import 'dart:convert';

import 'package:estaciona_mais/app/features/space_management/domain/entities/ticket.dart';

class TicketModel extends Ticket {
  TicketModel(int id, String plate, int spaceId, DateTime entryTime,
      DateTime exitTime, String status, double amount, String duration)
      : super(
            id, plate, spaceId, entryTime, exitTime, status, amount, duration);

  TicketModel copyWith({
    int id,
    String plate,
    int spaceId,
    DateTime entryTime,
    DateTime exitTime,
    String status,
    double amount,
  }) {
    return TicketModel(
      id ?? this.id,
      plate ?? this.plate,
      spaceId ?? this.spaceId,
      entryTime ?? this.entryTime,
      exitTime ?? this.exitTime,
      status ?? this.status,
      amount ?? this.amount,
      duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMapPayment() {
    return {
      'ticketId': id,
      'spaceId': spaceId,
      'amount': amount,
    };
  }

  Map<String, dynamic> toMapCancel() {
    return {
      'ticketId': id,
      'spaceId': spaceId,
    };
  }

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
      map['id'],
      map['plate'],
      map['space_id'],
      DateTime.parse(map['entry_time']),
      map['exit_time'] != null ? DateTime.parse(map['exit_time']) : null,
      map['status'],
      map['amount'],
      map['duration'],
    );
  }

  factory TicketModel.fromJson(String source) =>
      TicketModel.fromMap(json.decode(source));

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
        other.amount == amount &&
        other.duration == duration;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        plate.hashCode ^
        spaceId.hashCode ^
        entryTime.hashCode ^
        exitTime.hashCode ^
        status.hashCode ^
        amount.hashCode ^
        duration.hashCode;
  }
}
