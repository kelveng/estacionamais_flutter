import 'dart:convert';

import 'package:estaciona_mais/app/features/home/domain/entities/entities.dart';

class BalanceResumeModel extends BalanceResume {
  BalanceResumeModel({
    DateTime date,
    double amount,
  }) : super(amount: amount, date: date);
  @override
  String toString() => 'BalanceResume(date: $date, amount: $amount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BalanceResume &&
        other.date == date &&
        other.amount == amount;
  }

  @override
  int get hashCode => date.hashCode ^ amount.hashCode;

  BalanceResumeModel copyWith({
    DateTime date,
    double amount,
  }) {
    return BalanceResumeModel(
      date: date ?? this.date,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.millisecondsSinceEpoch,
      'amount': amount,
    };
  }

  factory BalanceResumeModel.fromMap(Map<String, dynamic> map) {
    return BalanceResumeModel(
      date: DateTime.parse(map['date']),
      amount: map['amount'] is int ? map['amount'] * 1.0 : map['amount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BalanceResumeModel.fromJson(String source) =>
      BalanceResumeModel.fromMap(json.decode(source));
}
