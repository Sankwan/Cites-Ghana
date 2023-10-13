import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget{
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                // Container(
                //   padding: const EdgeInsets.fromLTRB(15.0, 40.0, 0.0, 0.0),
                //   child: const Text('Forgot your \npassword?',
                //     style: TextStyle(
                //         fontSize: 40.0, fontWeight: FontWeight.bold
                //     ),
                //   ),
                // ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 75.0, 0.0, 0.0),
                    child: const Text('REVIEW',
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.green
                      ),
                    ),
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.fromLTRB(175.0, 150, 0.0, 0.0),
                //   child: const Text('!',
                //     style: TextStyle(
                //         fontSize: 55.0, fontWeight: FontWeight.bold, color: Colors.green
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top:25.0, left: 20.0, right: 20.0),
            child: Column(
              children:  <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      )
                  ),
                  validator: (value){
                    if(value!.isEmpty ||!RegExp(r'[a-z A-Z]+$').hasMatch(value)){
                      return "Enter a valid Email Address";
                    }else{
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20.0,),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'STAFF ID',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)
                      )
                  ),
                  obscureText: true,
                  validator: (value){
                    if(value!.isEmpty ||!RegExp(r'[a-z A-Z]+$').hasMatch(value)){
                      return "Enter a valid Identification Number";
                    }else{
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20.0,),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'LAST REMEMBERED PASSWORD',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)
                      )
                  ),
                ),
                const SizedBox(height: 20.0,),
                const TextField(
                  decoration: InputDecoration(
                      labelText: 'NEW PASSWORD',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)
                      )
                  ),
                ),
                const SizedBox(height: 55.0,),
                Container(
                  height: 50.0,
                  width: 300.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.green,
                    elevation: 10.0,
                    child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context, MaterialPageRoute(builder: (_) => const LoginPage()));
                        },
                        child: const Center(
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        )
                    ),
                  ),
                ),
                // SizedBox(height: 20.0,),
                // Container(
                //   height: 50,
                //   width: 300,
                //   color: Colors.transparent,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //           color: Colors.black,
                //           style: BorderStyle.solid,
                //           width: 1.5
                //       ),
                //       color: Colors.transparent,
                //       borderRadius: BorderRadius.circular(20.0),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children:  <Widget>[
                //         Center(
                //           child: Image.asset('assets/googlelogo.png', height: 70, width: 70,),
                //         ),
                //         const SizedBox(width: 10.0,),
                //         const Center(
                //           child: Text('Log in with google',
                //             style: TextStyle(
                //                 fontFamily: 'Montserrat',
                //                 fontWeight: FontWeight.bold
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          // const SizedBox(height: 20.0,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     const Text(
          //       'New to CITES?',
          //       style: TextStyle(
          //         color: Colors.grey,
          //       ),
          //     ),
          //     const SizedBox(width: 5.0,),
          //     InkWell(
          //       onTap: () {
          //         // Navigator.of(context).pushNamed('/signup');
          //       },
          //       child: const Text('Register',
          //         style: TextStyle(
          //           color: Colors.green,
          //           fontFamily: 'Montserrat',
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}