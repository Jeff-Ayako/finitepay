import 'dart:math';
import 'package:finitepay/controllers/init_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VirtualCardScreen extends StatefulWidget {
  const VirtualCardScreen({super.key});

  @override
  _VirtualCardScreenState createState() => _VirtualCardScreenState();
}

class _VirtualCardScreenState extends State<VirtualCardScreen>
    with SingleTickerProviderStateMixin {
  bool isFront = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      isFront = !isFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Virtual Card")),
      body: Center(
        child: GestureDetector(
          onTap: _flipCard,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final angle = _animation.value * pi;
              final isFlipped = angle > pi / 2;

              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // Add perspective
                  ..rotateY(angle),
                child: isFlipped
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(pi),
                        child: _buildCardBack(),
                      )
                    : _buildCardFront(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCardFront() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        key: const ValueKey('Front'),
        width: Get.width,
        height: Get.height / 3,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/fwhitelogo.png',
                      width: 50,
                    ),
                    Text(
                      "Mastercard",
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/master.png',
                  width: 100,
                  height: 100,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Obx(
              () => cardsController.showCardDetails.value == false
                  ? Text(
                      "**** **** **** ${cardsController.actualCardDetails.value?.data.last4 ?? ''}",
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontSize: 22,
                        letterSpacing: 2.0,
                      ),
                    )
                  : Text(
                      cardsController
                              .actualCardDetails.value?.data.cardNumber ??
                          '',
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontSize: 22,
                        letterSpacing: 2.0,
                      ),
                    ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Card Holder",
                      style: GoogleFonts.lato(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    Obx(
                      () => Text(
                        cardsController
                                .actualCardDetails.value?.data.cardName ??
                            '',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Expires",
                      style: GoogleFonts.lato(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    Obx(
                      () => Text(
                        '${cardsController.actualCardDetails.value?.data.expiryMonth ?? ''}/ ${cardsController.actualCardDetails.value?.data.expiryYear ?? ''}',

                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 16,
                          textStyle:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                          fontWeight: FontWeight.bold,
                        ),
                        // ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardBack() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        key: const ValueKey('Back'),
        width: Get.width,
        height: Get.height / 3,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(
                  5,
                ),
              ),
              width: Get.width,
              child: Center(
                child: Obx(
                  () => Text(
                    "CVV: ${cardsController.actualCardDetails.value?.data.cvv ?? ''}", // Replace with actual CVV
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(),
            Text(
              """This card is for use only by the cardholder in accordance with the current condtions of use.
               """, // Replace or add additional details
              style: GoogleFonts.lato(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
