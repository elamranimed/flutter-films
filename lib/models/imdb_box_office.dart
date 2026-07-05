class ImdbMoney {
  final String? amount;
  final String? currency;

  ImdbMoney({this.amount, this.currency});

  factory ImdbMoney.fromJson(Map<String, dynamic> json) {
    return ImdbMoney(
      amount: json['amount']?.toString(), // Ensure string
      currency: json['currency'] as String?,
    );
  }
}

class ImdbOpeningWeekendGross {
  final ImdbMoney? gross;

  ImdbOpeningWeekendGross({this.gross});

  factory ImdbOpeningWeekendGross.fromJson(Map<String, dynamic> json) {
    return ImdbOpeningWeekendGross(
      gross: json['gross'] != null ? ImdbMoney.fromJson(json['gross']) : null,
    );
  }
}

class ImdbBoxOffice {
  final ImdbMoney? domesticGross;
  final ImdbMoney? worldwideGross;
  final ImdbOpeningWeekendGross? openingWeekendGross;
  final ImdbMoney? productionBudget;

  ImdbBoxOffice({
    this.domesticGross,
    this.worldwideGross,
    this.openingWeekendGross,
    this.productionBudget,
  });

  factory ImdbBoxOffice.fromJson(Map<String, dynamic> json) {
    return ImdbBoxOffice(
      domesticGross: json['domesticGross'] != null
          ? ImdbMoney.fromJson(json['domesticGross'])
          : null,
      worldwideGross: json['worldwideGross'] != null
          ? ImdbMoney.fromJson(json['worldwideGross'])
          : null,
      openingWeekendGross: json['openingWeekendGross'] != null
          ? ImdbOpeningWeekendGross.fromJson(json['openingWeekendGross'])
          : null,
      productionBudget: json['productionBudget'] != null
          ? ImdbMoney.fromJson(json['productionBudget'])
          : null,
    );
  }
}
