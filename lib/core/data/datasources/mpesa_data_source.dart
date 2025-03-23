import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';

import '../models/payment_model.dart';

abstract class MpesaDataSource {
  Future<Map<String, dynamic>> initiateSTKPush(PaymentModel payment);
}

class MpesaDataSourceImpl implements MpesaDataSource {
  // Initialize M-PESA SDK
  void initialize() {
    MpesaFlutterPlugin.setConsumerKey(
        "");
    MpesaFlutterPlugin.setConsumerSecret(
        "");
  }

  @override
  Future<Map<String, dynamic>> initiateSTKPush(PaymentModel payment) async {
    try {
      final result = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: payment.businessCode,
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: payment.amount,
          partyA: payment.phoneNumber,
          partyB: payment.businessCode,
          callBackURL: Uri.parse(
              "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest"),
          accountReference: payment.reference,
          phoneNumber: payment.phoneNumber,
          baseUri: Uri.parse(
              "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest"),
          transactionDesc: payment.description,
          passKey:
          "");

      debugPrint("Transaction Result: $result");
      return {
        'success': true,
        'message': 'STK Push sent successfully',
        'data': result,
      };
    } catch (e) {
      debugPrint("Exception: $e");
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
}