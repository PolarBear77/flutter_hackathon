import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Welecome!",
                        style: TextStyle(fontSize: 30,),
                      ),
                      Text(
                            "Let's find your solumate",
                        style: TextStyle(fontSize: 30,),
                      )
                    ],
                  )
                  ),

                FloatingActionButton(
                  child: Text("Start", style: TextStyle(color: Colors.white),),
                  backgroundColor: Colors.lightBlueAccent,
                  onPressed: () => {
                    Navigator.pushNamed(context, '/login')
                  },
                )
              ],
            )
          )

      )
    );
  }
}