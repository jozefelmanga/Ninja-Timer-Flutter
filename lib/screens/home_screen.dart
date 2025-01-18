import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/second_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // get onPressed => null;
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueAccent,
      backgroundColor: const Color.fromARGB(255, 36, 116, 192),
      body: Container(
        // color: Colors.blue,
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Ninja Timer",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 5),
              ),
              child: ClipOval(
              child: Image.asset(
                "assets/ninja_theme.png",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              ),
            ),
            const SizedBox(
                height: 40,
              ),
              // ButtonBarTheme(data: null, child: Text("data")),
             Container(
              width: 350,  // Set a specific width
              child: TextField(
                style: TextStyle(color: Color.fromARGB(255, 229, 221, 209)),
                decoration: InputDecoration(
                  constraints: BoxConstraints(maxWidth: 400),  // Optional constraint on max width
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  labelText: 'Enter your name',
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  // print("button clicked!");
                  Navigator.push(  
                    context,  
                    MaterialPageRoute(builder: (context) => const SecondScreen()),  
                  );  
                },
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xFFFFB300))),
                child: const Text(
                  "Start",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ]),
      ),
    );
  }
}
