import 'dart:async';
import 'package:deeplinkproject/product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages:[
        GetPage(name: '/product', page:()=> Product()),
        GetPage(name: '/', page:()=> MyHomePage())
      ],
      initialRoute: '/',
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage();



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink(
      onSuccess: (PendingDynamicLinkData dynamicLink) async{
        final Uri? deeplink = dynamicLink.link;

        if(deeplink != null){
          print("Deep link "+ deeplink.toString());
           Get.toNamed(deeplink.queryParameters.values.first.toString());
          // Get.toNamed('/product');
        }
      }
    );
  }


@override
  void initState() {
  initDynamicLinks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text("Deeplinks"),
      ),
      body: Center(
        child: Container(
          child: Text("Deeplinking Page"),
        )
      ),

    );
  }
}


