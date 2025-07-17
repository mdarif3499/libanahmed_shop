import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../routes/app_routes.dart';
import '../../../widgets/app_snack_bar/app_snack_bar.dart';

class PaymentConnectedScreen extends StatefulWidget {
  final String paymentUrl;

  const PaymentConnectedScreen({super.key, required this.paymentUrl});

  @override
  State<PaymentConnectedScreen> createState() => _PaymentConnectedScreenState();
}

class _PaymentConnectedScreenState extends State<PaymentConnectedScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;

  // Base success URL pattern - account ID will be dynamic
  static const String _successUrlPattern = "/api/v1/payment/success-account/";
  static const String _errorUrlPattern = "/payment/error";

  @override
  void initState() {
    super.initState();
    _initializeWebViewController();
  }

  void _initializeWebViewController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() => _isLoading = true);
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            setState(() => _isLoading = false);
            print('Page finished loading: $url');
            _handleNavigation(url);
          },
          onWebResourceError: (WebResourceError error) {
            setState(() => _hasError = true);
            print('Web resource error: ${error.description}');
            _showErrorDialog(error.description);
          },
          onNavigationRequest: (NavigationRequest request) {
            print('Navigation request: ${request.url}');

            // Allow navigation to success/error URLs
            if (request.url.contains(_successUrlPattern) ||
                request.url.contains(_errorUrlPattern)) {
              return NavigationDecision.navigate;
            }

            // Allow navigation to Stripe related URLs
            if (request.url.contains('stripe.com') ||
                request.url.contains('connect.stripe.com') ||
                request.url.contains('js.stripe.com') ||
                request.url.contains('api.stripe.com')) {
              return NavigationDecision.navigate;
            }

            // Allow navigation to your API base URL
            if (request.url.contains('10.10.7.30:5003') ||
                request.url.contains('localhost:5003') ||
                request.url.contains('your-api-domain.com')) {
              return NavigationDecision.navigate;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  void _handleNavigation(String url) {
    print('Handling navigation: $url');

    // Check if URL contains the success pattern
    if (url.contains(_successUrlPattern)) {
      // Extract account ID from URL
      String accountId = _extractAccountIdFromUrl(url);
      print('Payment success detected with account ID: $accountId');
      _handlePaymentSuccess(accountId);
    } else if (url.contains(_errorUrlPattern)) {
      print('Payment error detected');
      _showErrorDialog('Payment processing failed');
    }
  }

  String _extractAccountIdFromUrl(String url) {
    // Extract account ID from URL like: /api/v1/payment/success-account/acct_1234567890
    try {
      final parts = url.split(_successUrlPattern);
      if (parts.length > 1) {
        // Get the part after success-account/ and remove any query parameters
        String accountPart = parts[1].split('?')[0];
        return accountPart;
      }
    } catch (e) {
      print('Error extracting account ID: $e');
    }
    return '';
  }

  void _handlePaymentSuccess(String accountId) {
    print('Payment completed successfully with account ID: $accountId');

    // Show success message
    AppSnackBar.success('Payment gateway connected successfully!');

    // Navigate back to payment method screen
    Get.offNamed(AppRoutes.ownerMenuPaymentMethod);

    // You can also save the account ID for future use
    // StorageServices.instance.saveAccountId(accountId);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Payment Connection Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _hasError = false;
                _isLoading = true;
              });
              _controller.reload();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect Payment Gateway'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _hasError ? null : () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _hasError ? null : () => _controller.reload(),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator.adaptive(),
                  SizedBox(height: 16),
                  Text('Connecting to payment gateway...'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
