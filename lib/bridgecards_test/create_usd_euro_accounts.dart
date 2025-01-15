import 'package:flutter/material.dart';

class UpgradeCardholderScreen extends StatefulWidget {
  const UpgradeCardholderScreen({super.key});

  @override
  _UpgradeCardholderScreenState createState() =>
      _UpgradeCardholderScreenState();
}

class _UpgradeCardholderScreenState extends State<UpgradeCardholderScreen> {
  final _formKey = GlobalKey<FormState>();
  // Form Field Controllers
  final TextEditingController cardholderIdController = TextEditingController();
  final TextEditingController utilityBillController = TextEditingController();
  final TextEditingController bankStatementController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController incomeBandController = TextEditingController();
  final TextEditingController employmentStatusController =
      TextEditingController();
  final TextEditingController accountDesignationController =
      TextEditingController();
  final TextEditingController incomeSourceController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController houseNoController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController issuedDateController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController idTypeController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers
    cardholderIdController.dispose();
    utilityBillController.dispose();
    bankStatementController.dispose();
    occupationController.dispose();
    incomeBandController.dispose();
    employmentStatusController.dispose();
    accountDesignationController.dispose();
    incomeSourceController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    postalCodeController.dispose();
    houseNoController.dispose();
    idNumberController.dispose();
    issuedDateController.dispose();
    expiryDateController.dispose();
    dobController.dispose();
    idTypeController.dispose();
    super.dispose();
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      // Collect the data into a map
      Map<String, dynamic> requestBody = {
        "cardholder_id": cardholderIdController.text,
        "utility_bill": utilityBillController.text,
        "bank_statement": bankStatementController.text,
        "occupation": occupationController.text,
        "income_band": incomeBandController.text,
        "employment_status": employmentStatusController.text,
        "account_designation": accountDesignationController.text,
        "income_source": incomeSourceController.text,
        "address": {
          "address": addressController.text,
          "city": cityController.text,
          "state": stateController.text,
          "country": countryController.text,
          "postal_code": postalCodeController.text,
          "house_no": houseNoController.text,
        },
        "id_number": idNumberController.text,
        "issued_date": issuedDateController.text,
        "expiry_date": expiryDateController.text,
        "date_of_birth": dobController.text,
        "id_type": idTypeController.text,
      };
      print("Request Body: $requestBody");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upgrade Cardholder'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cardholder ID
              buildTextField('Cardholder ID', cardholderIdController),
              buildTextField('Utility Bill (URL)', utilityBillController),
              buildTextField('Bank Statement (URL)', bankStatementController),
              buildTextField('Occupation', occupationController),
              buildTextField('Income Band', incomeBandController),
              buildTextField('Employment Status', employmentStatusController),
              buildTextField(
                  'Account Designation', accountDesignationController),
              buildTextField('Income Source', incomeSourceController),
              buildTextField('Address', addressController),
              buildTextField('City', cityController),
              buildTextField('State', stateController),
              buildTextField('Country', countryController),
              buildTextField('Postal Code', postalCodeController),
              buildTextField('House Number', houseNoController),
              buildTextField('ID Number', idNumberController),
              buildTextField('Issued Date (YYYY-MM-DD)', issuedDateController),
              buildTextField('Expiry Date (YYYY-MM-DD)', expiryDateController),
              buildTextField('Date of Birth (YYYY-MM-DD)', dobController),
              buildTextField('ID Type', idTypeController),
              const SizedBox(height: 16),
              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: submitForm,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
