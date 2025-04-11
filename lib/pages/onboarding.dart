import 'package:flutter/material.dart';
class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,

body: Container(
  child: Column(
mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(height: 80,),
      Center(child: Image.asset('images/name',height: 300,width: 300,fit: BoxFit.cover,)),
Text('THIS IS THE WELCOME PAGE ',style: TextStyle(color: Colors.white,
  fontWeight: FontWeight.bold,fontSize:30,),textAlign: TextAlign.center,),
      Text('WELCOME TO THIS PROJECT THAT i am creating  using flutter ',
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:30),textAlign: TextAlign.center,),
      Material(
        child: Container(
          width:MediaQuery.of(context).size.width/2,
          height: MediaQuery.of(context).size.height/2,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Text('next',style: TextStyle(fontSize: 30),),
          
        
        ),
      ),
    ],
  ),
),

    );
  }
}
