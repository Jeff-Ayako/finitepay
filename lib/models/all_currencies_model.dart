// To parse this JSON data, do
//
//     final allCurrencies = allCurrenciesFromJson(jsonString);

import 'dart:convert';

AllCurrencies allCurrenciesFromJson(String str) => AllCurrencies.fromJson(json.decode(str));

String allCurrenciesToJson(AllCurrencies data) => json.encode(data.toJson());

class AllCurrencies {
    List<Balance> balances;
    Pagination pagination;

    AllCurrencies({
        required this.balances,
        required this.pagination,
    });

    factory AllCurrencies.fromJson(Map<String, dynamic> json) => AllCurrencies(
        balances: List<Balance>.from(json["balances"].map((x) => Balance.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "balances": List<dynamic>.from(balances.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
    };
}

class Balance {
    String id;
    String accountId;
    String currency;
    String amount;
    DateTime createdAt;
    DateTime updatedAt;

    Balance({
        required this.id,
        required this.accountId,
        required this.currency,
        required this.amount,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        id: json["id"],
        accountId: json["account_id"],
        currency: json["currency"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "account_id": accountId,
        "currency": currency,
        "amount": amount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
