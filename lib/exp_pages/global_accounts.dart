import 'package:flutter/material.dart';

class StyledPage extends StatelessWidget {
  const StyledPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111), // Dark background color
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeaderText(),
              const SizedBox(height: 30),

              // Content Section with image and form
              _buildContentSection(context),
            ],
          ),
        ),
      ),
    );
  }

  // Build Header Section
  Widget _buildHeaderText() {
    return const Text(
      "Hassle-free international business payments with local bank details",
      style: TextStyle(
        fontSize: 32,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Build the Main Content Section
  Widget _buildContentSection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Flex(
          direction: constraints.maxWidth > 800 ? Axis.horizontal : Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Side: Image (placeholder for map or global visual)
            _buildLeftSide(constraints),
            SizedBox(width: constraints.maxWidth > 800 ? 50 : 0, height: constraints.maxWidth > 800 ? 0 : 40),

            // Right Side: Form and Benefits
            _buildRightSide(),
          ],
        );
      },
    );
  }

  // Build the Left Side (Image Section)
  Widget _buildLeftSide(BoxConstraints constraints) {
    return Expanded(
      flex: 1,
      child: Image.network(
        'https://www.airwallex.com/cms/images/pages/global_map_placeholder.png', // Placeholder image
        fit: BoxFit.cover,
      ),
    );
  }

  // Build the Right Side (Form and Benefits Section)
  Widget _buildRightSide() {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Form Section
          _buildFormSection(),
          const SizedBox(height: 30),

          // Benefit Points
          _buildBenefitPoint(Icons.savings, "Save on unnecessary bank charges", "There are no account opening fees, monthly maintenance charges, or minimum transaction requirements."),
          const SizedBox(height: 20),
          _buildBenefitPoint(Icons.settings, "Streamline your global cash management", "Convert held balances to different currencies in just a few clicks and review your global transactions in a single view."),
          const SizedBox(height: 20),
          _buildBenefitPoint(Icons.lock, "Know your funds are safe and secure", "Relax knowing that your money is secure and protected with end-to-end encryption and bank-level security."),
        ],
      ),
    );
  }

  // Build Form Section (Country Dropdown and Account Creation)
  Widget _buildFormSection() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Country Dropdown
            const Text(
              "Where do you want to open your Global Account?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Select Country',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "US", child: Text("United States")),
                DropdownMenuItem(value: "AU", child: Text("Australia")),
                DropdownMenuItem(value: "EU", child: Text("Europe")),
                DropdownMenuItem(value: "UK", child: Text("United Kingdom")),
                DropdownMenuItem(value: "JP", child: Text("Japan")),
                DropdownMenuItem(value: "SG", child: Text("Singapore")),
                DropdownMenuItem(value: "CA", child: Text("Canada")),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),

            // Account Nickname TextField
            const TextField(
              decoration: InputDecoration(
                labelText: "Account nickname",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Create Global Account Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  // primary: Colors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Create Global Account",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Benefit Point Widget
  Widget _buildBenefitPoint(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.orange, size: 30),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(fontSize: 16, color: Colors.white60),
              ),
            ],
          ),
        ),
      ],
    );
  }
}