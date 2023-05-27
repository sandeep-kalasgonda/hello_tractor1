import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
 
 String? massage;
 ProgressDialog({this.massage});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      child: Container(
        //margin: const EdgeInsets.all(0.0),
         decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(6),
         ),
         child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
               const SizedBox(width: 10,),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
              const SizedBox(width: 26.0,),

              Text(
                massage!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              )

            ],
          ),
         ),
      ),
    );
  }
}