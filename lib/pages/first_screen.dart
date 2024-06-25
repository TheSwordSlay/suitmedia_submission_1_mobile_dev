import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_submission/components/button.dart';
import 'package:suitmedia_submission/components/text_field.dart';
import 'package:suitmedia_submission/pages/second_screen.dart';
import 'package:suitmedia_submission/providers/user_provider.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameTextController = TextEditingController();
    final palindromeTextController = TextEditingController();

    bool checkPalindrome(String word) {
      for (int i = 0; i < word.length ~/ 2; i++) {
        if (word[i] != word[word.length - i - 1]) return false;
      }
      return true;
    }

    Future openDialog(String message) => showDialog(
      context: context, 
      builder: (context) => AlertDialog( 
        title: Text(message),
        actions: [ 
          TextButton( 
            onPressed: () {
              Navigator.pop(context);
            }, 
            child: Text("OK"))
        ],
      )
    );

    return Consumer<UserProvider> (
      builder: (context, value, child) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover
            )
          ),
          child: Center( 
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage( 
                      'assets/btn_add_photo.png',
                    ),
                    height: MediaQuery.of(context).size.width * 0.3,
                  ),

                SizedBox(height: MediaQuery.of(context).size.width *0.2,),
                CustomTextField(controller: nameTextController, hintText: 'Name', obscureText: false),

                const SizedBox(height: 20,),
                CustomTextField(controller: palindromeTextController, hintText: 'Palindrome', obscureText: false),

                SizedBox(height: MediaQuery.of(context).size.width *0.1,),
                CustomButton(onTap: () {
                  if(palindromeTextController.text.isEmpty) {
                    openDialog("The palindrome text field is empty");
                  } else if (checkPalindrome(palindromeTextController.text)) {
                    openDialog("isPalindrome");
                  } else {
                    openDialog("not palindrome");
                  }
                }, text: "Check"),

                const SizedBox(height: 20,),
                CustomButton(onTap: () {
                  if(nameTextController.text.isEmpty) {
                    openDialog("Name field must be filled before pressing next");
                  } else {
                    final setUser = context.read<UserProvider>();
                    setUser.setCurrentUser(nameTextController.text);

                    Navigator.push( 
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SecondScreen()
                      )
                    );
                  }
                }, text: "Next"),
                ],
              ),
            ),

          )

        ),
      ),
    );
  }
}