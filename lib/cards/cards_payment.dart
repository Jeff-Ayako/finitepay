import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

bool isBack = false;
final cardNumberController = TextEditingController();
final expiryDateController = TextEditingController();
final cvvController = TextEditingController();

class CardPaymentApp extends StatelessWidget {
  const CardPaymentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CardPaymentScreen();
  }
}

class CardPaymentScreen extends StatelessWidget {
  const CardPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Card Payment',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF5A31F4),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: Get.width <= 500 ? 0 : Get.width / 2,
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(flex: 2, child: CardDetailsScreen()),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        'Enter your card details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5A31F4),
                        ),
                      ),
                      SizedBox(height: 20),
                      CardNumberField(),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(child: ExpiryDateField()),
                          SizedBox(width: 20),
                          Expanded(child: CVVField()),
                        ],
                      ),
                      SizedBox(height: 30),
                      PayButton(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardNumberField extends StatefulWidget {
  const CardNumberField({super.key});

  @override
  State<CardNumberField> createState() => _CardNumberFieldState();
}

class _CardNumberFieldState extends State<CardNumberField> {
  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) setState(() => isBack = false);
      },
      child: TextField(
        keyboardType: TextInputType.number,
        controller: cardNumberController,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(16),
          CardNumberInputFormatter(),
        ],
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Card Number',
          prefixIcon: Icon(Icons.credit_card),
          hintText: 'XXXX XXXX XXXX XXXX',
        ),
      ),
    );
  }
}

class ExpiryDateField extends StatefulWidget {
  const ExpiryDateField({super.key});

  @override
  State<ExpiryDateField> createState() => _ExpiryDateFieldState();
}

class _ExpiryDateFieldState extends State<ExpiryDateField> {
  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) setState(() => isBack = false);
      },
      child: TextField(
        controller: expiryDateController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(4),
          ExpiryDateInputFormatter(),
        ],
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Expiry Date',
          prefixIcon: Icon(Icons.date_range),
          hintText: 'MM/YY',
        ),
      ),
    );
  }
}

class CVVField extends StatefulWidget {
  const CVVField({super.key});

  @override
  State<CVVField> createState() => _CVVFieldState();
}

class _CVVFieldState extends State<CVVField> {
  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() => isBack = hasFocus);
      },
      child: TextField(
        controller: cvvController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'CVV',
          prefixIcon: Icon(Icons.lock),
          hintText: 'XXX',
        ),
        obscureText: true,
      ),
    );
  }
}

class PayButton extends StatelessWidget {
  const PayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Processing payment...')),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          backgroundColor: const Color(0xFF5A31F4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: const Text(
          'Pay Now',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');
    StringBuffer newString = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      if (i % 4 == 0 && i != 0) {
        newString.write(' ');
      }
      newString.write(newText[i]);
    }
    return newValue.copyWith(
      text: newString.toString(),
      selection: TextSelection.collapsed(offset: newString.length),
    );
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (newText.length > 2) {
      newText = '${newText.substring(0, 2)}/${newText.substring(2)}';
    }
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class CardDetailsScreen extends StatefulWidget {
  const CardDetailsScreen({super.key});

  @override
  _CardDetailsScreenState createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Enter Card Details'),
      //   backgroundColor: const Color(0xFF5A31F4),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isBack = !isBack;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            transform: Matrix4.rotationY(isBack ? pi : 0),
            child: isBack ? buildCardBack() : buildCardFront(),
          ),
        ),
      ),
    );
  }

  Widget buildCardFront() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF5A31F4),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CARD NUMBER',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            const SizedBox(height: 10),
            Text(
              cardNumberController.text.isEmpty
                  ? 'XXXX XXXX XXXX XXXX'
                  : cardNumberController.text,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            const Spacer(),
            const Text(
              'EXPIRY DATE',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            const SizedBox(height: 10),
            Text(
              expiryDateController.text.isEmpty
                  ? 'MM/YY'
                  : expiryDateController.text,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardBack() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF5A31F4),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              color: Colors.black,
            ),
            const SizedBox(height: 20),
            const Text(
              'CVV',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            const SizedBox(height: 10),
            Text(
              cvvController.text.isEmpty ? 'XXX' : cvvController.text,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    required void Function(bool hasFocus) onFocusChange,
  }) {
    return Focus(
      onFocusChange: onFocusChange,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          if (!obscureText) LengthLimitingTextInputFormatter(16),
        ],
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
