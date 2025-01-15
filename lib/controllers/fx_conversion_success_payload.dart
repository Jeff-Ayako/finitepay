// To parse this JSON data, do
//
//     final conversionPayload = conversionPayloadFromJson(jsonString);

import 'dart:convert';

ConversionPayload conversionPayloadFromJson(String str) => ConversionPayload.fromJson(json.decode(str));

String conversionPayloadToJson(ConversionPayload data) => json.encode(data.toJson());

class ConversionPayload {
    String id;
    DateTime settlementDate;
    DateTime conversionDate;
    String shortReference;
    String creatorContactId;
    String accountId;
    String currencyPair;
    String status;
    String buyCurrency;
    String sellCurrency;
    String clientBuyAmount;
    String clientSellAmount;
    String fixedSide;
    String coreRate;
    String partnerRate;
    String partnerStatus;
    String partnerBuyAmount;
    String partnerSellAmount;
    String clientRate;
    bool depositRequired;
    String depositAmount;
    String depositCurrency;
    String depositStatus;
    String depositRequiredAt;
    List<dynamic> paymentIds;
    String unallocatedFunds;
    dynamic uniqueRequestId;
    DateTime createdAt;
    DateTime updatedAt;
    String midMarketRate;

    ConversionPayload({
        required this.id,
        required this.settlementDate,
        required this.conversionDate,
        required this.shortReference,
        required this.creatorContactId,
        required this.accountId,
        required this.currencyPair,
        required this.status,
        required this.buyCurrency,
        required this.sellCurrency,
        required this.clientBuyAmount,
        required this.clientSellAmount,
        required this.fixedSide,
        required this.coreRate,
        required this.partnerRate,
        required this.partnerStatus,
        required this.partnerBuyAmount,
        required this.partnerSellAmount,
        required this.clientRate,
        required this.depositRequired,
        required this.depositAmount,
        required this.depositCurrency,
        required this.depositStatus,
        required this.depositRequiredAt,
        required this.paymentIds,
        required this.unallocatedFunds,
        required this.uniqueRequestId,
        required this.createdAt,
        required this.updatedAt,
        required this.midMarketRate,
    });

    factory ConversionPayload.fromJson(Map<String, dynamic> json) => ConversionPayload(
        id: json["id"],
        settlementDate: DateTime.parse(json["settlement_date"]),
        conversionDate: DateTime.parse(json["conversion_date"]),
        shortReference: json["short_reference"],
        creatorContactId: json["creator_contact_id"],
        accountId: json["account_id"],
        currencyPair: json["currency_pair"],
        status: json["status"],
        buyCurrency: json["buy_currency"],
        sellCurrency: json["sell_currency"],
        clientBuyAmount: json["client_buy_amount"],
        clientSellAmount: json["client_sell_amount"],
        fixedSide: json["fixed_side"],
        coreRate: json["core_rate"],
        partnerRate: json["partner_rate"],
        partnerStatus: json["partner_status"],
        partnerBuyAmount: json["partner_buy_amount"],
        partnerSellAmount: json["partner_sell_amount"],
        clientRate: json["client_rate"],
        depositRequired: json["deposit_required"],
        depositAmount: json["deposit_amount"],
        depositCurrency: json["deposit_currency"],
        depositStatus: json["deposit_status"],
        depositRequiredAt: json["deposit_required_at"],
        paymentIds: List<dynamic>.from(json["payment_ids"].map((x) => x)),
        unallocatedFunds: json["unallocated_funds"],
        uniqueRequestId: json["unique_request_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        midMarketRate: json["mid_market_rate"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "settlement_date": settlementDate.toIso8601String(),
        "conversion_date": conversionDate.toIso8601String(),
        "short_reference": shortReference,
        "creator_contact_id": creatorContactId,
        "account_id": accountId,
        "currency_pair": currencyPair,
        "status": status,
        "buy_currency": buyCurrency,
        "sell_currency": sellCurrency,
        "client_buy_amount": clientBuyAmount,
        "client_sell_amount": clientSellAmount,
        "fixed_side": fixedSide,
        "core_rate": coreRate,
        "partner_rate": partnerRate,
        "partner_status": partnerStatus,
        "partner_buy_amount": partnerBuyAmount,
        "partner_sell_amount": partnerSellAmount,
        "client_rate": clientRate,
        "deposit_required": depositRequired,
        "deposit_amount": depositAmount,
        "deposit_currency": depositCurrency,
        "deposit_status": depositStatus,
        "deposit_required_at": depositRequiredAt,
        "payment_ids": List<dynamic>.from(paymentIds.map((x) => x)),
        "unallocated_funds": unallocatedFunds,
        "unique_request_id": uniqueRequestId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "mid_market_rate": midMarketRate,
    };
}
