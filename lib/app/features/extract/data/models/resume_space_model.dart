import 'dart:convert';

import 'package:estaciona_mais/app/features/extract/domain/entities/resume_space.dart';

class ResumeSpaceModel extends ResumeSpace {
  ResumeSpaceModel(int id, String description, double total)
      : super(id, description, total);

  ResumeSpaceModel copyWith({
    int id,
    String description,
    double total,
  }) {
    return ResumeSpaceModel(
      id ?? this.id,
      description ?? this.description,
      total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'total': total,
    };
  }

  factory ResumeSpaceModel.fromMap(Map<String, dynamic> map) {
    return ResumeSpaceModel(
      map['id'],
      map['description'],
      map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResumeSpaceModel.fromJson(String source) =>
      ResumeSpaceModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ResumeSpace(id: $id, description: $description, total: $total)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResumeSpaceModel &&
        other.id == id &&
        other.description == description &&
        other.total == total;
  }

  @override
  int get hashCode => id.hashCode ^ description.hashCode ^ total.hashCode;
}
