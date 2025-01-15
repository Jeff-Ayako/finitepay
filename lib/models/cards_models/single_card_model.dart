// To parse this JSON data, do
//
//     final singleCardDetails = singleCardDetailsFromJson(jsonString);

import 'dart:convert';

SingleCardDetails singleCardDetailsFromJson(String str) => SingleCardDetails.fromJson(json.decode(str));

String singleCardDetailsToJson(SingleCardDetails data) => json.encode(data.toJson());

class SingleCardDetails {
    String status;
    String message;
    Data data;

    SingleCardDetails({
        required this.status,
        required this.message,
        required this.data,
    });

    factory SingleCardDetails.fromJson(Map<String, dynamic> json) => SingleCardDetails(
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
    String paycaddyCardId;
    String paycaddyWalletId;
    String cardId;
    String cardNumber;
    String expiryMonth;
    String expiryYear;
    String cvv;
    String last4;
    String cardCurrency;
    String brand;
    BillingAddress billingAddress;
    String cardName;
    String cardholderId;
    dynamic companyId;
    int createdAt;
    String issuingAppId;
    String cardType;
    bool isActive;
    bool livemode;
    MetaData metaData;
    dynamic pin3DsActivated;
    dynamic pin3Ds;
    dynamic insufficientFundsDeclineCount;
    dynamic hasDoneDebitInAMonth;
    bool blockedDueToFraud;
    String currentCardLimit;
    bool isDeleted;
    dynamic noKycSpendLimit;
    dynamic noKycSpendLimitLastRecorded;
    MerchantSpendCount merchantSpendCount;
    String bopaymentBalance;
    String balance;
    String availableBalance;
    String bookBalance;

    Data({
        required this.paycaddyCardId,
        required this.paycaddyWalletId,
        required this.cardId,
        required this.cardNumber,
        required this.expiryMonth,
        required this.expiryYear,
        required this.cvv,
        required this.last4,
        required this.cardCurrency,
        required this.brand,
        required this.billingAddress,
        required this.cardName,
        required this.cardholderId,
        required this.companyId,
        required this.createdAt,
        required this.issuingAppId,
        required this.cardType,
        required this.isActive,
        required this.livemode,
        required this.metaData,
        required this.pin3DsActivated,
        required this.pin3Ds,
        required this.insufficientFundsDeclineCount,
        required this.hasDoneDebitInAMonth,
        required this.blockedDueToFraud,
        required this.currentCardLimit,
        required this.isDeleted,
        required this.noKycSpendLimit,
        required this.noKycSpendLimitLastRecorded,
        required this.merchantSpendCount,
        required this.bopaymentBalance,
        required this.balance,
        required this.availableBalance,
        required this.bookBalance,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        paycaddyCardId: json["paycaddy_card_id"],
        paycaddyWalletId: json["paycaddy_wallet_id"],
        cardId: json["card_id"],
        cardNumber: json["card_number"],
        expiryMonth: json["expiry_month"],
        expiryYear: json["expiry_year"],
        cvv: json["cvv"],
        last4: json["last_4"],
        cardCurrency: json["card_currency"],
        brand: json["brand"],
        billingAddress: BillingAddress.fromJson(json["billing_address"]),
        cardName: json["card_name"],
        cardholderId: json["cardholder_id"],
        companyId: json["company_id"],
        createdAt: json["created_at"],
        issuingAppId: json["issuing_app_id"],
        cardType: json["card_type"],
        isActive: json["is_active"],
        livemode: json["livemode"],
        metaData: MetaData.fromJson(json["meta_data"]),
        pin3DsActivated: json["pin_3ds_activated"],
        pin3Ds: json["pin_3ds"],
        insufficientFundsDeclineCount: json["insufficient_funds_decline_count"],
        hasDoneDebitInAMonth: json["has_done_debit_in_a_month"],
        blockedDueToFraud: json["blocked_due_to_fraud"],
        currentCardLimit: json["current_card_limit"],
        isDeleted: json["is_deleted"],
        noKycSpendLimit: json["no_kyc_spend_limit"],
        noKycSpendLimitLastRecorded: json["no_kyc_spend_limit_last_recorded"],
        merchantSpendCount: MerchantSpendCount.fromJson(json["merchant_spend_count"]),
        bopaymentBalance: json["bopayment_balance"],
        balance: json["balance"],
        availableBalance: json["available_balance"],
        bookBalance: json["book_balance"],
    );

    Map<String, dynamic> toJson() => {
        "paycaddy_card_id": paycaddyCardId,
        "paycaddy_wallet_id": paycaddyWalletId,
        "card_id": cardId,
        "card_number": cardNumber,
        "expiry_month": expiryMonth,
        "expiry_year": expiryYear,
        "cvv": cvv,
        "last_4": last4,
        "card_currency": cardCurrency,
        "brand": brand,
        "billing_address": billingAddress.toJson(),
        "card_name": cardName,
        "cardholder_id": cardholderId,
        "company_id": companyId,
        "created_at": createdAt,
        "issuing_app_id": issuingAppId,
        "card_type": cardType,
        "is_active": isActive,
        "livemode": livemode,
        "meta_data": metaData.toJson(),
        "pin_3ds_activated": pin3DsActivated,
        "pin_3ds": pin3Ds,
        "insufficient_funds_decline_count": insufficientFundsDeclineCount,
        "has_done_debit_in_a_month": hasDoneDebitInAMonth,
        "blocked_due_to_fraud": blockedDueToFraud,
        "current_card_limit": currentCardLimit,
        "is_deleted": isDeleted,
        "no_kyc_spend_limit": noKycSpendLimit,
        "no_kyc_spend_limit_last_recorded": noKycSpendLimitLastRecorded,
        "merchant_spend_count": merchantSpendCount.toJson(),
        "bopayment_balance": bopaymentBalance,
        "balance": balance,
        "available_balance": availableBalance,
        "book_balance": bookBalance,
    };
}

class BillingAddress {
    String billingAddress1;
    String billingCity;
    String billingCountry;
    String billingZipCode;
    String countryCode;
    String state;
    String stateCode;

    BillingAddress({
        required this.billingAddress1,
        required this.billingCity,
        required this.billingCountry,
        required this.billingZipCode,
        required this.countryCode,
        required this.state,
        required this.stateCode,
    });

    factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
        billingAddress1: json["billing_address1"],
        billingCity: json["billing_city"],
        billingCountry: json["billing_country"],
        billingZipCode: json["billing_zip_code"],
        countryCode: json["country_code"],
        state: json["state"],
        stateCode: json["state_code"],
    );

    Map<String, dynamic> toJson() => {
        "billing_address1": billingAddress1,
        "billing_city": billingCity,
        "billing_country": billingCountry,
        "billing_zip_code": billingZipCode,
        "country_code": countryCode,
        "state": state,
        "state_code": stateCode,
    };
}

class MerchantSpendCount {
    MerchantSpendCount();

    factory MerchantSpendCount.fromJson(Map<String, dynamic> json) => MerchantSpendCount(
    );

    Map<String, dynamic> toJson() => {
    };
}

class MetaData {
    String userId;

    MetaData({
        required this.userId,
    });

    factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
    };
}
