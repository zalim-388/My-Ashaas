import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(home: AddBusinessScreen(), debugShowCheckedModeBanner: false),
  );
}

class AddBusinessScreen extends StatefulWidget {
  @override
  _AddBusinessScreenState createState() => _AddBusinessScreenState();
}

class _AddBusinessScreenState extends State<AddBusinessScreen> {
  final _formKey = GlobalKey<FormState>();

  final agentName = TextEditingController();
  final agentPhone = TextEditingController();
  final agentEmail = TextEditingController();
  final businessName = TextEditingController();
  final ownerName = TextEditingController();
  final department = TextEditingController();
  final location = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final gstNumber = TextEditingController();
  final aadhaarNumber = TextEditingController();
  final paymentMethod =
      TextEditingController(); // Should be 'Online' or 'Offline'

  Future<void> submitBusiness() async {
    final url = Uri.parse(
      "http://localhost:8000/addBusiness",
    ); // ✅ Make sure it's lowercase

    final Map<String, dynamic> body = {
      "agentName": agentName.text,
      "agentPhonenumber": agentPhone.text,
      "agentEmail": agentEmail.text,
      "businessName": businessName.text,
      "ownerName": ownerName.text,
      "department": department.text,
      "location": location.text,
      "email": email.text,
      "phoneNumber": phoneNumber.text,
      "gstNumber": gstNumber.text,
      "aadhaarNumber": aadhaarNumber.text,
      "paymentMethod": paymentMethod.text,
      "images": [], // Placeholder for now
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("✅ Business added successfully!")),
        );
        _formKey.currentState?.reset();
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("❌ API endpoint not found (404). Check the URL."),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "❌ Failed to add business. Code: ${response.statusCode}",
            ),
          ),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ Error: $e")));
    }
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator:
            (value) => value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }

  @override
  void dispose() {
    agentName.dispose();
    agentPhone.dispose();
    agentEmail.dispose();
    businessName.dispose();
    ownerName.dispose();
    department.dispose();
    location.dispose();
    email.dispose();
    phoneNumber.dispose();
    gstNumber.dispose();
    aadhaarNumber.dispose();
    paymentMethod.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Business")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField("Agent Name", agentName),
              buildTextField("Agent Phone", agentPhone),
              buildTextField("Agent Email", agentEmail),
              buildTextField("Business Name", businessName),
              buildTextField("Owner Name", ownerName),
              buildTextField("Department", department),
              buildTextField("Location", location),
              buildTextField("Email", email),
              buildTextField("Phone Number", phoneNumber),
              buildTextField("GST Number", gstNumber),
              buildTextField("Aadhaar Number", aadhaarNumber),
              buildTextField("Payment Method (Online/Offline)", paymentMethod),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    submitBusiness();
                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
