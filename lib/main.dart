import 'package:bookbazaar/screen/cart_screen.dart';
import 'package:bookbazaar/screen/category_screen.dart';
import 'package:bookbazaar/screen/home_screen.dart';
import 'package:bookbazaar/screen/other_screen.dart';
import 'package:bookbazaar/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'screen/signin_scree.dart';
import 'screen/user_data.dart';





void main() async {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:MainScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
         '/userData': (context) => const UserData(),
         "/home":(context)=> MainScreen(),
         "/profile":(context) =>ProfileScreen()
         
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    const Home(),
   const CategoryScreen(),
       const CartScreen(),
          const OtherScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.black,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_rounded),
            backgroundColor: Colors.black,
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            backgroundColor: Colors.black,
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            backgroundColor: Colors.black,
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}