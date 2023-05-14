import 'package:flutter/material.dart';

/// Defining the radius of the container and the radius of the button.
const double radiusContainer = 10.0;

const double radiusBtn = 8.0;

const double horizontalPadding = 14.0;

const double verticalPadding = 14.0;

const String messagePasswordIncorrect =
    "Current password incorrect!,Please try again!!";

const String messageConfirmPassword =
    "Current password incorrect!,Please try again!!";

const googleProvider = "google";

const int toPayStatus = 1;

const int processingStatus = 2;

const int shippingStatus = 3;

const int deliveredStatus = -1;

//key change password
final formkeyChangePassword = GlobalKey<FormState>();

bool get validateChangePassword =>
    formkeyChangePassword.currentState!.validate();
