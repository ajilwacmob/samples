import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samples/uni_link/view/uni_link_details_screen.dart';
import 'package:uni_links5/uni_links.dart';

class UniLinkScreen extends StatefulWidget {
  const UniLinkScreen({super.key});

  @override
  State<UniLinkScreen> createState() => _UniLinkScreenState();
}

class _UniLinkScreenState extends State<UniLinkScreen> {
/* <activity
    android:name=".MainActivity"
    android:exported="true"
    android:launchMode="singleTask">
    <intent-filter>
        <!-- Declare the app can handle VIEW actions -->
        <action android:name="android.intent.action.VIEW" />

        <!-- Categories the app must match -->
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />

        <!-- Define the scheme and host -->
        <data
            android:scheme="sampleapp"
            android:host="example.com"
                android:path="/detailsscreen" />
    </intent-filter>
</activity> */

//Testing Your Setup
//adb shell am start -W -a android.intent.action.VIEW -d "sampleapp://example.com/detailsscreen" com.example.samples

/* android:host="example.com"

This is the domain or "host" that the app will respond to. Replace example.com with your app's domain.
Optional Additional Attributes

Path Matching: Add android:path, android:pathPrefix, or android:pathPattern to handle specific URL paths:
xml
Copy code
<data
    android:scheme="sampleapp"
    android:host="example.com"
    android:path="/detailsscreen" />
android:path: Matches exact paths (e.g., /specificpath).
android:pathPrefix: Matches paths starting with this prefix (e.g., /specificpath matches /specificpath/details).
android:pathPattern: Matches more complex patterns using regex.
 */

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  Future<void> initUniLinks() async {
    try {
      Uri? initialLink = await getInitialUri();
      if (initialLink != null) {
        handleLink(initialLink);
      }
    } on PlatformException {
      // Handle exception
    }

    uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        handleLink(uri);
      }
    }, onError: (err) {
      // Handle stream error
    });
  }

  void handleLink(Uri link) {
    if (link.host == 'formation2-test.jesusyouth.org' &&
        link.pathSegments.contains('auth') &&
        link.pathSegments.contains('reset-password')) {
      String userId = link.pathSegments.last;
      print(userId);
    }
    Navigator.push(context,
        CupertinoPageRoute(builder: (context) => const UniLinkDetailsScreen()));

    Uri uri = link;
    print('Scheme: ${uri.scheme}');
    print('Host: ${uri.host}');
    print('Path: ${uri.path}');
    print('Query Parameters: ${uri.queryParameters}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Uni Link Test App"),
        elevation: 1,
      ),
    );
  }
}
