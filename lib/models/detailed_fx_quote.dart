// To parse this JSON data, do
//
//     final detailedFxQuote = detailedFxQuoteFromJson(jsonString);

import 'dart:convert';

DetailedFxQuote detailedFxQuoteFromJson(String str) => DetailedFxQuote.fromJson(json.decode(str));

String detailedFxQuoteToJson(DetailedFxQuote data) => json.encode(data.toJson());

class DetailedFxQuote {
    DateTime settlementCutOffTime;
    String currencyPair;
    String clientBuyCurrency;
    String clientSellCurrency;
    String clientBuyAmount;
    String clientSellAmount;
    String fixedSide;
    String clientRate;
    dynamic partnerRate;
    String coreRate;
    bool depositRequired;
    String depositAmount;
    String depositCurrency;
    String midMarketRate;

    DetailedFxQuote({
        required this.settlementCutOffTime,
        required this.currencyPair,
        required this.clientBuyCurrency,
        required this.clientSellCurrency,
        required this.clientBuyAmount,
        required this.clientSellAmount,
        required this.fixedSide,
        required this.clientRate,
        required this.partnerRate,
        required this.coreRate,
        required this.depositRequired,
        required this.depositAmount,
        required this.depositCurrency,
        required this.midMarketRate,
    });

    factory DetailedFxQuote.fromJson(Map<String, dynamic> json) => DetailedFxQuote(
        settlementCutOffTime: DateTime.parse(json["settlement_cut_off_time"]),
        currencyPair: json["currency_pair"],
        clientBuyCurrency: json["client_buy_currency"],
        clientSellCurrency: json["client_sell_currency"],
        clientBuyAmount: json["client_buy_amount"],
        clientSellAmount: json["client_sell_amount"],
        fixedSide: json["fixed_side"],
        clientRate: json["client_rate"],
        partnerRate: json["partner_rate"],
        coreRate: json["core_rate"],
        depositRequired: json["deposit_required"],
        depositAmount: json["deposit_amount"],
        depositCurrency: json["deposit_currency"],
        midMarketRate: json["mid_market_rate"],
    );

    Map<String, dynamic> toJson() => {
        "settlement_cut_off_time": settlementCutOffTime.toIso8601String(),
        "currency_pair": currencyPair,
        "client_buy_currency": clientBuyCurrency,
        "client_sell_currency": clientSellCurrency,
        "client_buy_amount": clientBuyAmount,
        "client_sell_amount": clientSellAmount,
        "fixed_side": fixedSide,
        "client_rate": clientRate,
        "partner_rate": partnerRate,
        "core_rate": coreRate,
        "deposit_required": depositRequired,
        "deposit_amount": depositAmount,
        "deposit_currency": depositCurrency,
        "mid_market_rate": midMarketRate,
    };
}
