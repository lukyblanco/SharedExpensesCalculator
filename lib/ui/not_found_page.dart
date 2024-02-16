import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('404 - Página no encontrada',style: GoogleFonts.montserratAlternates(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'La página que estás buscando no fue encontrada.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () => context.go('/datos'),
                child: const Text('Volver'),
              ),
            ],
          ),
        ),
      );
  }
}