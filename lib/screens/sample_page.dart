import 'package:e_bookstore/screens/constants.dart';
import 'package:e_bookstore/services/firebase_services.dart';
import 'package:e_bookstore/widgets/custom_action_bar.dart';
import 'package:e_bookstore/widgets/image_swipe.dart';
import 'package:e_bookstore/widgets/sample_swipe.dart';
import 'package:flutter/material.dart';

class SamplePage extends StatefulWidget {
  final String productId;



  SamplePage({this.productId});
  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            FutureBuilder(
              future: _firebaseServices.productsRef.doc(widget.productId)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> documentData = snapshot.data.data();
                  //to dispalay image in products page
                  //list of images
                  List imageList = documentData['samples'];
                  return ListView(
                    padding: EdgeInsets.only(
                      top: 90.0,
                    ),
                    children: [
                      SampleSwipe(
                        imageList: imageList,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 24.0, left: 24.0, right: 24.0, bottom: 4.0),
                        child: Text(
                          "${documentData['name']}",
                          style: Constants.RText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 22.0),
                        child: Text(
                          "${documentData['description']}",
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.transparent,
                        ),
                        height: 100.0,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }

                // Loading State
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            CustomActionBar(
              title: "Sample",
              hasBackArrow: true,
              hasTitle: true,
              hasBackground: true,
            )
          ],
        ),
      ),
    );
  }
}
