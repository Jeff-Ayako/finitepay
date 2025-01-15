// To parse this JSON data, do
//
//     final transactionsMade = transactionsMadeFromJson(jsonString);

import 'dart:convert';

TransactionsMade transactionsMadeFromJson(String str) => TransactionsMade.fromJson(json.decode(str));

String transactionsMadeToJson(TransactionsMade data) => json.encode(data.toJson());

class TransactionsMade {
    List<Transaction> transactions;
    Pagination pagination;

    TransactionsMade({
        required this.transactions,
        required this.pagination,
    });

    factory TransactionsMade.fromJson(Map<String, dynamic> json) => TransactionsMade(
        transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
    };
}

class Pagination {
    int totalEntries;
    int totalPages;
    int currentPage;
    int perPage;
    int previousPage;
    int nextPage;
    String order;
    String orderAscDesc;

    Pagination({
        required this.totalEntries,
        required this.totalPages,
        required this.currentPage,
        required this.perPage,
        required this.previousPage,
        required this.nextPage,
        required this.order,
        required this.orderAscDesc,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalEntries: json["total_entries"],
        totalPages: json["total_pages"],
        currentPage: json["current_page"],
        perPage: json["per_page"],
        previousPage: json["previous_page"],
        nextPage: json["next_page"],
        order: json["order"],
        orderAscDesc: json["order_asc_desc"],
    );

    Map<String, dynamic> toJson() => {
        "total_entries": totalEntries,
        "total_pages": totalPages,
        "current_page": currentPage,
        "per_page": perPage,
        "previous_page": previousPage,
        "next_page": nextPage,
        "order": order,
        "order_asc_desc": orderAscDesc,
    };
}

class Transaction {
    String id;
    String balanceId;
    String accountId;
    String currency;
    String amount;
    String balanceAmount;
    String type;
    String relatedEntityType;
    String relatedEntityId;
    String relatedEntityShortReference;
    String status;
    String reason;
    String settlesAt;
    DateTime createdAt;
    DateTime updatedAt;
    String completedAt;
    String action;

    Transaction({
        required this.id,
        required this.balanceId,
        required this.accountId,
        required this.currency,
        required this.amount,
        required this.balanceAmount,
        required this.type,
        required this.relatedEntityType,
        required this.relatedEntityId,
        required this.relatedEntityShortReference,
        required this.status,
        required this.reason,
        required this.settlesAt,
        required this.createdAt,
        required this.updatedAt,
        required this.completedAt,
        required this.action,
    });

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        balanceId: json["balance_id"],
        accountId: json["account_id"],
        currency: json["currency"],
        amount: json["amount"],
        balanceAmount: json["balance_amount"],
        type: json["type"],
        relatedEntityType: json["related_entity_type"],
        relatedEntityId: json["related_entity_id"],
        relatedEntityShortReference: json["related_entity_short_reference"],
        status: json["status"],
        reason: json["reason"],
        settlesAt: json["settles_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        completedAt: json["completed_at"],
        action: json["action"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "balance_id": balanceId,
        "account_id": accountId,
        "currency": currency,
        "amount": amount,
        "balance_amount": balanceAmount,
        "type": type,
        "related_entity_type": relatedEntityType,
        "related_entity_id": relatedEntityId,
        "related_entity_short_reference": relatedEntityShortReference,
        "status": status,
        "reason": reason,
        "settles_at": settlesAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "completed_at": completedAt,
        "action": action,
    };
}
