import 'package:driver/globel/globel.dart';
import 'package:driver/splashscreen/splash_screen.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {

  String? name;
  String? email;
  
  MyDrawer({super.key, this.name,this.email});


  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
 Widget build(BuildContext context)
  {
    return Drawer(
      child: ListView(
        children: [
          //drawer header
          Container(
            height: 165,
            color: Colors.black,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.black54,
                  ),

                  const SizedBox(width: 16,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        widget.email.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const  SizedBox(height: 12.0,),

          //drawer body
          GestureDetector(
            onTap: ()
            {

            },
            child: const ListTile(
              leading: Icon(Icons.history, color: Colors.white,),
              title: Text(
                "History",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: ()
            {

            },
            child: const ListTile(
              leading: Icon(Icons.person, color: Colors.white,),
              title: Text(
                "Visit Profile",
                style: TextStyle(
                    color: Colors.white,
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: ()
            {

            },
            child: const ListTile(
              leading: Icon(Icons.info, color: Colors.white,),
              title: Text(
                "About",
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: ()
            {
              fAuth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
            },
            child: const ListTile(
              leading: Icon(Icons.logout, color: Colors.white,),
              title: Text(
                "Sign Out",
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
