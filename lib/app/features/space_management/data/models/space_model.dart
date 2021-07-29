import 'dart:convert';

import 'package:estaciona_mais/app/features/space_management/domain/entities/space.dart';

class SpaceModel extends Space {
  SpaceModel(int id, String description, bool isBusy, int ticketId)
      : super(id, description, isBusy, ticketId);

  SpaceModel copyWith({
    int id,
    String description,
    bool isBusy,
  }) {
    return SpaceModel(
      id ?? this.id,
      description ?? this.description,
      isBusy ?? this.isBusy,
      ticketId ?? this.ticketId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'isBusy': isBusy,
      'ticketId': ticketId,
    };
  }

  factory SpaceModel.fromMap(Map<String, dynamic> map) {
    return SpaceModel(
        map['id'], map['description'], map['is_busy'], map['ticket_id'] ?? 0);
  }

  String toJson() => json.encode(toMap());

  factory SpaceModel.fromJson(String source) =>
      SpaceModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'Space(id: $id, description: $description, isBusy: $isBusy)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SpaceModel &&
        other.id == id &&
        other.description == description &&
        other.isBusy == isBusy;
  }

  @override
  int get hashCode => id.hashCode ^ description.hashCode ^ isBusy.hashCode;
}
