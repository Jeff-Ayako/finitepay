// To parse this JSON data, do
//
//     final successPaymentModal = successPaymentModalFromJson(jsonString);

import 'dart:convert';

SuccessPaymentModal successPaymentModalFromJson(String str) => SuccessPaymentModal.fromJson(json.decode(str));

String successPaymentModalToJson(SuccessPaymentModal data) => json.encode(data.toJson());

class SuccessPaymentModal {
    String id;
    String amount;
    String beneficiaryId;
    String currency;
    String reference;
    String reason;
    String status;
    String creatorContactId;
    String paymentType;
    DateTime paymentDate;
    String transferredAt;
    String authorisationStepsRequired;
    String lastUpdaterContactId;
    String shortReference;
    dynamic conversionId;
    String failureReason;
    String payerId;
    String payerDetailsSource;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic paymentGroupId;
    String uniqueRequestId;
    String failureReturnedAmount;
    dynamic ultimateBeneficiaryName;

    SuccessPaymentModal({
        required this.id,
        required this.amount,
        required this.beneficiaryId,
        required this.currency,
        required this.reference,
        required this.reason,
        required this.status,
        required this.creatorContactId,
        required this.paymentType,
        required this.paymentDate,
        required this.transferredAt,
        required this.authorisationStepsRequired,
        required this.lastUpdaterContactId,
        required this.shortReference,
        required this.conversionId,
        required this.failureReason,
        required this.payerId,
        required this.payerDetailsSource,
        required this.createdAt,
        required this.updatedAt,
        required this.paymentGroupId,
        required this.uniqueRequestId,
        required this.failureReturnedAmount,
        required this.ultimateBeneficiaryName,
    });

    factory SuccessPaymentModal.fromJson(Map<String, dynamic> json) => SuccessPaymentModal(
        id: json["id"],
        amount: json["amount"],
        beneficiaryId: json["beneficiary_id"],
        currency: json["currency"],
        reference: json["reference"],
        reason: json["reason"],
        status: json["status"],
        creatorContactId: json["creator_contact_id"],
        paymentType: json["payment_type"],
        paymentDate: DateTime.parse(json["payment_date"]),
        transferredAt: json["transferred_at"],
        authorisationStepsRequired: json["authorisation_steps_required"],
        lastUpdaterContactId: json["last_updater_contact_id"],
        shortReference: json["short_reference"],
        conversionId: json["conversion_id"],
        failureReason: json["failure_reason"],
        payerId: json["payer_id"],
        payerDetailsSource: json["payer_details_source"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        paymentGroupId: json["payment_group_id"],
        uniqueRequestId: json["unique_request_id"],
        failureReturnedAmount: json["failure_returned_amount"],
        ultimateBeneficiaryName: json["ultimate_beneficiary_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "beneficiary_id": beneficiaryId,
        "currency": currency,
        "reference": reference,
        "reason": reason,
        "status": status,
        "creator_contact_id": creatorContactId,
        "payment_type": paymentType,
        "payment_date": "${paymentDate.year.toString().padLeft(4, '0')}-${paymentDate.month.toString().padLeft(2, '0')}-${paymentDate.day.toString().padLeft(2, '0')}",
        "transferred_at": transferredAt,
        "authorisation_steps_required": authorisationStepsRequired,
        "last_updater_contact_id": lastUpdaterContactId,
        "short_reference": shortReference,
        "conversion_id": conversionId,
        "failure_reason": failureReason,
        "payer_id": payerId,
        "payer_details_source": payerDetailsSource,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "payment_group_id": paymentGroupId,
        "unique_request_id": uniqueRequestId,
        "failure_returned_amount": failureReturnedAmount,
        "ultimate_beneficiary_name": ultimateBeneficiaryName,
    };
}
