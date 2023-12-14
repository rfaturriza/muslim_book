import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';

var midtransConfigSB = MidtransConfig(
  clientKey: dotenv.env['MIDTRANS_CLIENT_KEY_SANDBOX'] ?? emptyString,
  merchantBaseUrl: dotenv.env['MIDTRANS_MERCHANT_BASE_URL_SANDBOX'] ?? emptyString,
  colorTheme: ColorTheme(
    colorPrimary: Colors.blue,
    colorPrimaryDark: Colors.blue,
    colorSecondary: Colors.blue,
  ),
);

var midtransConfig = MidtransConfig(
  clientKey: dotenv.env['MIDTRANS_CLIENT_KEY'] ?? emptyString,
  merchantBaseUrl: dotenv.env['MIDTRANS_MERCHANT_BASE_URL'] ?? emptyString,
  colorTheme: ColorTheme(
    colorPrimary: Colors.blue,
    colorPrimaryDark: Colors.blue,
    colorSecondary: Colors.blue,
  ),
);
