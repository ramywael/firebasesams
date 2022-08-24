import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
    );
  }
}
class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}
class _FirstScreenState extends State<FirstScreen> {
  final firestore = FirebaseFirestore.instance;
  TextEditingController emailtext=TextEditingController();
  TextEditingController passwordtext=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Firebase',
          ),
        ),
        body: Container(
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: TextFormField(controller: emailtext,keyboardType: TextInputType.emailAddress,decoration: InputDecoration(
                        hintText: "EmailAddress",labelText: "E-mail",border:OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                 ,prefixIcon: Icon(Icons.email_rounded)     ),),
                      content:  TextFormField(controller: passwordtext,obscureText: true,decoration: InputDecoration(suffixIcon: Icon(Icons.lock),labelText: "Password",hintText: "password",border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            firestore.collection("notes").add({"email":emailtext.text,"password": passwordtext.text});
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            color: Colors.yellowAccent,
                         //   decoration: BoxDecoration(backgroundBlendMode:BlendMode.color),
                            padding: const EdgeInsets.all(9),
                            child: const Text("okay",style: TextStyle(color: Colors.black87),),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text("Show alert Dialog box"),
              ),
              // StreamBuilder<QuerySnapshot>(
              //   stream: firestore.collection('notes').snapshots(),
              //   builder: (context, snapshot) {
              //     return snapshot.hasData
              //         ? ListView.builder(
              //             itemCount: snapshot.data!.docs.length,
              //             itemBuilder: (context, index) {
              //               return ListTile(
              //                 title: Text(
              //                   snapshot.data!.docs[index]['name'],
              //                 ),
              //               );
              //             },
              //           )
              //         : snapshot.hasError
              //             ? Text('Error is Happened')
              //             : CircularProgressIndicator();
              //   },
              // ),
            )
        )
    );
  }
}