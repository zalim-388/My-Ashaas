// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// // Main User Creation Page
// class UserCreation extends StatefulWidget {
//   @override
//   _UserCreationState createState() => _UserCreationState();
// }
//
// class _UserCreationState extends State<UserCreation> {
//   final _formKey = GlobalKey<FormState>();
//
//   // Form fields with initial values for faster testing/development
//   final TextEditingController _amountController = TextEditingController(text: '100');
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _panNumberController = TextEditingController();
//   final TextEditingController _stateController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _countryController = TextEditingController();
//   final TextEditingController _nomineeController = TextEditingController();
//   final TextEditingController _postCodeController = TextEditingController();
//   final TextEditingController _districtController = TextEditingController();
//   final TextEditingController _aadhaarNumberController = TextEditingController();
//   final TextEditingController _nomineeNumberController = TextEditingController();
//   final TextEditingController _contactNumberController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//
//   DateTime? _selectedDate;
//   File? _signatureImage;
//   bool _isLoading = false;
//   final ImagePicker _picker = ImagePicker();
//
//   // Group form fields for better organization
//   final List<Map<String, dynamic>> _personalInfoFields = [];
//   final List<Map<String, dynamic>> _contactInfoFields = [];
//   final List<Map<String, dynamic>> _addressFields = [];
//   final List<Map<String, dynamic>> _nomineeFields = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _setupFieldGroups();
//   }
//
//   void _setupFieldGroups() {
//     // Personal information fields
//     _personalInfoFields.addAll([
//       {
//         'controller': _nameController,
//         'label': 'First Name',
//         'icon': Icons.person,
//         'required': true,
//         'validator': (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter first name';
//           }
//           return null;
//         },
//       },
//       {
//         'controller': _lastNameController,
//         'label': 'Last Name',
//         'icon': Icons.person_outline,
//         'required': true,
//         'validator': (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter last name';
//           }
//           return null;
//         },
//       },
//       {
//         'controller': _panNumberController,
//         'label': 'PAN Number',
//         'icon': Icons.credit_card,
//         'textCapitalization': TextCapitalization.characters,
//       },
//       {
//         'controller': _aadhaarNumberController,
//         'label': 'Aadhaar Number',
//         'icon': Icons.badge,
//         'keyboardType': TextInputType.number,
//       },
//     ]);
//
//     // Contact information fields
//     _contactInfoFields.addAll([
//       {
//         'controller': _emailController,
//         'label': 'Email Address',
//         'icon': Icons.email,
//         'keyboardType': TextInputType.emailAddress,
//         'required': true,
//         'validator': (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter email';
//           }
//           if (!value.contains('@')) {
//             return 'Please enter a valid email';
//           }
//           return null;
//         },
//       },
//       {
//         'controller': _contactNumberController,
//         'label': 'Contact Number',
//         'icon': Icons.phone,
//         'keyboardType': TextInputType.phone,
//         'required': true,
//         'validator': (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter contact number';
//           }
//           return null;
//         },
//       },
//     ]);
//
//     // Address fields
//     _addressFields.addAll([
//       {
//         'controller': _addressController,
//         'label': 'Address',
//         'icon': Icons.home,
//         'maxLines': 2,
//       },
//       {
//         'controller': _stateController,
//         'label': 'State',
//         'icon': Icons.location_city,
//       },
//       {
//         'controller': _districtController,
//         'label': 'District',
//         'icon': Icons.place,
//       },
//       {
//         'controller': _postCodeController,
//         'label': 'Post Code',
//         'icon': Icons.pin,
//         'keyboardType': TextInputType.number,
//       },
//       {
//         'controller': _countryController,
//         'label': 'Country',
//         'icon': Icons.flag,
//       },
//     ]);
//
//     // Nominee fields
//     _nomineeFields.addAll([
//       {
//         'controller': _nomineeController,
//         'label': 'Nominee Name',
//         'icon': Icons.person_add,
//       },
//       {
//         'controller': _nomineeNumberController,
//         'label': 'Nominee Contact',
//         'icon': Icons.phone_forwarded,
//         'keyboardType': TextInputType.phone,
//       },
//     ]);
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate ?? DateTime(2000),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(
//               primary: Theme.of(context).primaryColor,
//               onPrimary: Colors.white,
//               surface: Colors.white,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }
//
//   Future<void> _pickImage() async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 800,
//         imageQuality: 80,
//       );
//       if (pickedFile != null) {
//         setState(() {
//           _signatureImage = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error picking image: $e')),
//       );
//     }
//   }
//
//   Widget _buildFormField(Map<String, dynamic> fieldData) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: TextFormField(
//         controller: fieldData['controller'],
//         decoration: InputDecoration(
//           labelText: fieldData['label'],
//           hintText: 'Enter ${fieldData['label']}',
//           prefixIcon: Icon(fieldData['icon']),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: Colors.grey.shade300),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
//           ),
//           filled: true,
//           fillColor: Colors.grey.shade50,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         ),
//         validator: fieldData['validator'],
//         keyboardType: fieldData['keyboardType'],
//         maxLines: fieldData['maxLines'] ?? 1,
//         textCapitalization: fieldData['textCapitalization'] ?? TextCapitalization.none,
//       ),
//     );
//   }
//
//   Widget _buildFormSection(String title, List<Map<String, dynamic>> fields) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       margin: const EdgeInsets.only(bottom: 20),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(bottom: 12),
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Theme.of(context).primaryColor,
//                 ),
//               ),
//             ),
//             ...fields.map((field) => _buildFormField(field)).toList(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Process form submission and navigate to payment page
//   void _processFormSubmission() {
//     if (_formKey.currentState!.validate()) {
//       // Check for date of birth
//       if (_selectedDate == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please select your date of birth')),
//         );
//         return;
//       }
//
//       // Validate signature (optional)
//       if (_signatureImage == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please upload your signature')),
//         );
//         return;
//       }
//
//       setState(() {
//         _isLoading = true;
//       });
//
//       // You can perform any pre-processing of form data here if needed
//
//       // Create a user data map to pass to the payment page
//       Map<String, dynamic> userData = {
//         'name': '${_nameController.text} ${_lastNameController.text}',
//         'email': _emailController.text,
//         'contact': _contactNumberController.text,
//         'amount': int.parse(_amountController.text),
//       };
//
//       // Navigate to the RazorpayPaymentPage
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => RazorpayPaymentPage(userData: userData),
//         ),
//       ).then((paymentResult) {
//         // Handle the result when we return from payment page
//         setState(() {
//           _isLoading = false;
//         });
//
//         if (paymentResult != null && paymentResult['success'] == true) {
//           // Show success dialog
//           _showPaymentResultDialog(
//               'Registration Successful!',
//               'Your payment was processed successfully.\nPayment ID: ${paymentResult['paymentId']}',
//               true
//           );
//         }
//       });
//     }
//   }
//
//   void _showPaymentResultDialog(String title, String message, bool isSuccess) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           title: Row(
//             children: [
//               Icon(
//                 isSuccess ? Icons.check_circle : Icons.error,
//                 color: isSuccess ? Colors.green : Colors.red,
//               ),
//               SizedBox(width: 10),
//               Text(title),
//             ],
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(message),
//               if (isSuccess) ...[
//                 SizedBox(height: 20),
//                 Text(
//                   'Your registration is now complete!',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 if (isSuccess) {
//                   // Reset form or navigate to home page
//                   Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(
//                       builder: (context) => SuccessScreen(
//                         userData: {
//                           'name': '${_nameController.text} ${_lastNameController.text}',
//                           'email': _emailController.text,
//                         },
//                       ),
//                     ),
//                   );
//                 }
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Registration'),
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             padding: const EdgeInsets.all(16),
//             children: [
//               // Header card
//               Card(
//                 elevation: 3,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 color: Theme.of(context).primaryColor,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       Text(
//                         'Registration',
//                         style: const TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Complete the form and submit to proceed to payment',
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(0.9),
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               // Personal Information Section
//               _buildFormSection('Personal Information', _personalInfoFields),
//
//               // Date of Birth Card
//               Card(
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 margin: const EdgeInsets.only(bottom: 20),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 12),
//                         child: Text(
//                           'Date of Birth',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () => _selectDate(context),
//                         borderRadius: BorderRadius.circular(12),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(12),
//                             color: Colors.grey.shade50,
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Icon(Icons.cake, color: Colors.grey.shade600),
//                                   const SizedBox(width: 12),
//                                   Text(
//                                     _selectedDate == null
//                                         ? 'Select Date of Birth'
//                                         : DateFormat('dd MMM yyyy').format(_selectedDate!),
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: _selectedDate == null ? Colors.grey.shade600 : Colors.black87,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Icon(Icons.calendar_today, color: Theme.of(context).primaryColor),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // Contact Information Section
//               _buildFormSection('Contact Information', _contactInfoFields),
//
//               // Address Section
//               _buildFormSection('Address Details', _addressFields),
//
//               // Nominee Information Section
//               _buildFormSection('Nominee Information', _nomineeFields),
//
//               // Signature Section
//               Card(
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 margin: const EdgeInsets.only(bottom: 20),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Icon(Icons.draw, color: Theme.of(context).primaryColor),
//                           const SizedBox(width: 8),
//                           Text(
//                             'Signature',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Theme.of(context).primaryColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Center(
//                         child: InkWell(
//                           onTap: _pickImage,
//                           child: Container(
//                             width: double.infinity,
//                             height: 150,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: _signatureImage == null ? Colors.grey.shade300 : Theme.of(context).primaryColor,
//                                 width: _signatureImage == null ? 1 : 2,
//                               ),
//                               borderRadius: BorderRadius.circular(12),
//                               color: Colors.grey.shade50,
//                             ),
//                             child: _signatureImage == null
//                                 ? Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.upload_file,
//                                   size: 48,
//                                   color: Colors.grey.shade400,
//                                 ),
//                                 const SizedBox(height: 8),
//                                 const Text(
//                                   'Tap to upload signature',
//                                   style: TextStyle(color: Colors.grey),
//                                 ),
//                               ],
//                             )
//                                 : ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Image.file(
//                                 _signatureImage!,
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // Submit Button
//               SizedBox(
//                 height: 56,
//                 child: ElevatedButton(
//                   onPressed: _isLoading ? null : _processFormSubmission,
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     elevation: 4,
//                   ),
//                   child: _isLoading
//                       ? const SizedBox(
//                     height: 24,
//                     width: 24,
//                     child: CircularProgressIndicator(
//                       color: Colors.white,
//                       strokeWidth: 2,
//                     ),
//                   )
//                       : Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(Icons.check_circle_outline),
//                       const SizedBox(width: 8),
//                       Text(
//                         'Submit & Proceed to Payment',
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     // Dispose all controllers
//     _amountController.dispose();
//     _nameController.dispose();
//     _lastNameController.dispose();
//     _panNumberController.dispose();
//     _stateController.dispose();
//     _addressController.dispose();
//     _countryController.dispose();
//     _nomineeController.dispose();
//     _postCodeController.dispose();
//     _districtController.dispose();
//     _aadhaarNumberController.dispose();
//     _nomineeNumberController.dispose();
//     _contactNumberController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }
// }
//
//
// class RazorpayPaymentPage extends StatefulWidget {
//   final Map<String, dynamic> userData;
//
//   const RazorpayPaymentPage({Key? key, required this.userData}) : super(key: key);
//
//   @override
//   State<RazorpayPaymentPage> createState() => _RazorpayPaymentPageState();
// }
//
// class _RazorpayPaymentPageState extends State<RazorpayPaymentPage> {
//   late Razorpay _razorpay;
//   bool _paymentInitiated = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//
//     // Auto-trigger payment on page load
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (!_paymentInitiated) {
//         _openCheckout();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     // Return success result to previous page
//     Navigator.pop(context, {
//       'success': true,
//       'paymentId': response.paymentId,
//     });
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     // Show error and return to form
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Payment Failed: ${response.message ?? "Unknown error"}')),
//     );
//
//     Navigator.pop(context, {
//       'success': false,
//       'error': response.message,
//     });
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('External Wallet Selected: ${response.walletName}')),
//     );
//   }
//
//   void _openCheckout() {
//     setState(() {
//       _paymentInitiated = true;
//     });
//
//     var options = {
//       'key': 'rzp_test_qnVc1uqRQpNYzh',
//       'amount': widget.userData['amount'] * 100, // Convert to paise
//       'name': widget.userData['name'],
//       'description': 'Registration Fee',
//       'prefill': {
//         'contact': widget.userData['contact'],
//         'email': widget.userData['email']
//       }
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//       Navigator.pop(context, {'success': false, 'error': e.toString()});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Payment'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context, {'success': false}),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(),
//             SizedBox(height: 24),
//             Text(
//               'Processing Payment...',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Please do not close this screen',
//               style: TextStyle(color: Colors.grey.shade600),
//             ),
//             SizedBox(height: 32),
//             ElevatedButton(
//               onPressed: _openCheckout,
//               child: Text('Retry Payment'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Success Screen after registration
// class SuccessScreen extends StatelessWidget {
//   final Map<String, dynamic> userData;
//
//   const SuccessScreen({Key? key, required this.userData}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         padding: EdgeInsets.all(24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.check_circle,
//               color: Colors.green,
//               size: 100,
//             ),
//             SizedBox(height: 32),
//             Text(
//               'Registration Successful!',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Welcome, ${userData['name']}',
//               style: TextStyle(
//                 fontSize: 18,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Your account has been created successfully.',
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.grey.shade700),
//             ),
//             SizedBox(height: 48),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to homepage or login
//                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(builder: (_) => HomePage()),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//               ),
//               child: Text('Continue to Dashboard'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Placeholder HomePage class
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home')),
//       body: Center(child: Text('Welcome to Dashboard')),
//     );
//   }
// }
//
// // Main App
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'User Registration',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: UserCreation(),
//     );
//   }
// }