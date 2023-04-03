import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:eventique/src/screen/home/adress/saved_adress.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../const/fonts.dart';

class AdressSelectiom extends StatefulWidget {
  AdressSelectiom({
    Key? key,
    required this.amount,

  }) :super(key: key){
      _reference =FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
      _collectionReference =_reference.collection("cart");
      
        
      

      


    }  
   String amount;

 
  @override
  State<AdressSelectiom> createState() => _AdressSelectiomState();
}
late DocumentReference _reference;
late CollectionReference _collectionReference;


class _AdressSelectiomState extends State<AdressSelectiom> {
    late Razorpay _razorpay;
  int? selectedRadio;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeRazorpay(); 

  }

  void initializeRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlepaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlepaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void launchRazorpay(
    String amount,
    
  ) {
    double amnt = double.parse(amount) * 100;
    var options = {
      'key': "rzp_test_biRLi88gm7Xhjk", 
      'amount': amnt,
      'phone':"ffwfwef",
      "description": "nothing"
    };
    try {
      _razorpay.open(options);
    } catch (e) {
 ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(e.toString()),
        duration: const Duration(seconds: 1),
      ),
    );
      clearCollection();
      
    }
  }

  void _handlepaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("payment success${response.orderId}\n ${response.paymentId}\n${response.signature}"),
        duration: Duration(seconds: 1),
      ),
    ); 

    
  }

  void _handlepaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("payment Failed" , style: TextStyle(color: Colors.red)),
        duration: Duration(seconds: 1), 
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("payment Failed", style: TextStyle(color: Colors.red),),
        duration: Duration(seconds: 1),
      ),
    );
  }


  int currentStep = 0;
  int selectedValue = 0; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Stepper(
        type: StepperType.vertical,
        steps: getSteps(),
        currentStep: currentStep,
        onStepContinue: () {
          final isLaststep = currentStep == getSteps().length - 1;
          if (isLaststep) {
            print("completed");

            launchRazorpay("${widget.amount}");


          } else {
            setState(() => currentStep += 1);
          }
        },
         

        onStepTapped: (value) => setState(() => currentStep = value),
        onStepCancel: currentStep == 0
            ? null
            : () {
                setState(() => currentStep -= 1);
              },
         controlsBuilder: (context, details) {
          final isLaststep =currentStep ==getSteps().length -1; 
          return Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                
                Expanded(child: ElevatedButton(onPressed: details.onStepContinue, child: Text(isLaststep ? 'PAY NOW'  :"NEXT"))),
                SizedBox(width: 30,),
                if(currentStep !=0)
                Expanded(child: ElevatedButton(onPressed: details.onStepCancel, child: Text("BACK",style: TextStyle(color: Colors.white),))), 

              ],
            ),
          );
           
         },
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text(
            "Adress",
            style: GoogleFonts.ptSerif(fontSize: 20, color: Colors.white),
          ),
          content: Column(
            children: [
              Text(
                "SELECT YOUR ADRESS",
                style: GoogleFonts.abrilFatface(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("adress")
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData &&
                      streamSnapshot.data!.docs.isNotEmpty) {
                    return Container(
                      height: 200,
                      child: ListView.builder(

                        itemCount: streamSnapshot.data!.docs.length,

                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];

                               
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 215, 213, 213),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.white)),
                              child: RadioListTile<int>(
                                value: index, 
                                groupValue:selectedValue, 
                                onChanged: ( value) {
                                   print('Selected value: $value'); 
                                   print(selectedValue); 
                                 setState(() {
                                   selectedValue = value! ; 
                                 });
                                   
                                  },  

                                
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        "HOUSENAME :${documentSnapshot['housename']}"),
                                    Text("PIN: ${documentSnapshot["pin"]}"),
                                    Text(
                                      "CITY : ${documentSnapshot["city"]}",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text("STATE: ${documentSnapshot["state"]}"),
                                  ],
                                ),
                                
                              ),

                            ),
                          );
                        },
                      ),
                    );
                  }

                  return Text("please add your Adress");
                },
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey)),
             
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SavedAdres(
                            userId: FirebaseAuth.instance.currentUser!.uid),
                      ));
                },
                child: Text("ADD OR EDIT"),
              ),
              SizedBox(height: 30,)
            ],
          ),
        ),
        Step(
            isActive: currentStep >= 1,
            title: Text(
              "Payment",
              style: GoogleFonts.ptSerif(fontSize: 20, color: Colors.white),
            ),
            content: Center(child: SizedBox(height: 100, )), 
        )
      ];

Future<void> clearCollection() async {
  final QuerySnapshot querySnapshot = await _collectionReference.get();
  final List<DocumentSnapshot> documents = querySnapshot.docs; 
  for (DocumentSnapshot document in documents) {
    await document.reference.delete();
  }
}

}

