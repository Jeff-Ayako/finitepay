// To parse this JSON data, do
//
//     final cardTransactions = cardTransactionsFromJson(jsonString);

import 'dart:convert';

CardTransactions cardTransactionsFromJson(String str) => CardTransactions.fromJson(json.decode(str));

String cardTransactionsToJson(CardTransactions data) => json.encode(data.toJson());

class CardTransactions {
    String status;
    String message;
    Data data;

    CardTransactions({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CardTransactions.fromJson(Map<String, dynamic> json) => CardTransactions(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    List<Transaction> transactions;
    Meta meta;

    Data({
        required this.transactions,
        required this.meta,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
        "meta": meta.toJson(),
    };
}

class Meta {
    int total;
    int pages;
    dynamic previous;
    dynamic next;

    Meta({
        required this.total,
        required this.pages,
        required this.previous,
        required this.next,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json["total"],
        pages: json["pages"],
        previous: json["previous"],
        next: json["next"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "pages": pages,
        "previous": previous,
        "next": next,
    };
}

class Transaction {
    String amount;
    String bridgecardTransactionReference;
    String cardId;
    String cardTransactionType;
    String cardholderId;
    String clientTransactionReference;
    String currency;
    String description;
    String issuingAppId;
    bool livemode;
    DateTime transactionDate;
    int transactionTimestamp;
    EnrichedData enrichedData;

    Transaction({
        required this.amount,
        required this.bridgecardTransactionReference,
        required this.cardId,
        required this.cardTransactionType,
        required this.cardholderId,
        required this.clientTransactionReference,
        required this.currency,
        required this.description,
        required this.issuingAppId,
        required this.livemode,
        required this.transactionDate,
        required this.transactionTimestamp,
        required this.enrichedData,
    });

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        amount: json["amount"],
        bridgecardTransactionReference: json["bridgecard_transaction_reference"],
        cardId: json["card_id"],
        cardTransactionType: json["card_transaction_type"],
        cardholderId: json["cardholder_id"],
        clientTransactionReference: json["client_transaction_reference"],
        currency: json["currency"],
        description: json["description"],
        issuingAppId: json["issuing_app_id"],
        livemode: json["livemode"],
        transactionDate: DateTime.parse(json["transaction_date"]),
        transactionTimestamp: json["transaction_timestamp"],
        enrichedData: EnrichedData.fromJson(json["enriched_data"]),
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "bridgecard_transaction_reference": bridgecardTransactionReference,
        "card_id": cardId,
        "card_transaction_type": cardTransactionType,
        "cardholder_id": cardholderId,
        "client_transaction_reference": clientTransactionReference,
        "currency": currency,
        "description": description,
        "issuing_app_id": issuingAppId,
        "livemode": livemode,
        "transaction_date": transactionDate.toIso8601String(),
        "transaction_timestamp": transactionTimestamp,
        "enriched_data": enrichedData.toJson(),
    };
}

class EnrichedData {
    bool isRecurring;
    String merchantLogo;
    String transactionCategory;
    String transactionGroup;

    EnrichedData({
        required this.isRecurring,
        required this.merchantLogo,
        required this.transactionCategory,
        required this.transactionGroup,
    });

    factory EnrichedData.fromJson(Map<String, dynamic> json) => EnrichedData(
        isRecurring: json["is_recurring"],
        merchantLogo: json["merchant_logo"],
        transactionCategory: json["transaction_category"],
        transactionGroup: json["transaction_group"],
    );

    Map<String, dynamic> toJson() => {
        "is_recurring": isRecurring,
        "merchant_logo": merchantLogo,
        "transaction_category": transactionCategory,
        "transaction_group": transactionGroup,
    };
}
