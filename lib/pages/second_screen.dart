import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_submission/components/button.dart';
import 'package:suitmedia_submission/pages/third_screen.dart';
import 'package:suitmedia_submission/providers/user_provider.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (context, value, child) => Scaffold( 
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xff554af0)),
            onPressed: () => Navigator.of(context).pop(),
          ), 
          centerTitle: true,
          title: const Text(
            "Second Screen",
            style: TextStyle( 
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
                color: Colors.grey.withOpacity(0.5),
                height: 1,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              Text(
                "Welcome",
                style: TextStyle( 
                  color: Colors.grey,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                value.currentUser,
                style: TextStyle( 
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.bold
                ),
              ),
              Expanded( 
                child: Center( 
                child: Column( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      value.selectedUser.isNotEmpty ? value.selectedUser : "Selected User Name",
                      style: TextStyle( 
                        fontSize: MediaQuery.of(context).size.width * 0.07,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              )
              ),
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                child: CustomButton(onTap: () {
                  Navigator.push( 
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ThirdScreen()
                    )
                  );
                }, text: "Choose a user"),
              )
            ],
          ),
        ),
      )
    );
  }
}