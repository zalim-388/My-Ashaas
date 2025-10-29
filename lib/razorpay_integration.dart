// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: RazorpayIntegration(),
//     );
//   }
// }
//
// class RazorpayIntegration extends StatefulWidget {
//   const RazorpayIntegration({super.key});
//
//   @override
//   State<RazorpayIntegration> createState() => _RazorpayIntegrationState();
// }
//
// class _RazorpayIntegrationState extends State<RazorpayIntegration> {
//
//   late Razorpay _razorpay;
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     // Do something when payment succeeds
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     // Do something when payment fails
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     // Do something when an external wallet was selected
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }
//
//   void openCheckout() async {
//     var options = {
//       'key': 'rzp_test_qnVc1uqRQpNYzh',
//       'amount': 100,
//       'name': 'murshid',
//       'description': 'Fine T-Shirt',
//       'prefill': {
//         'contact': '8888888888',
//         'email': 'test@razorpay.com'
//       }
//     };
//
//     try{
//       _razorpay.open(options);
//     }catch(e){
//       print('Error $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: (){
//             openCheckout();
//           },
//           child: Text("pay"),
//         ),
//       ),
//     );
//   }
// }
