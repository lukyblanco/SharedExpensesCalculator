import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_calculator/enities/persona.dart';
import 'package:web_calculator/providers/calculo_provider.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final calcProvider = Provider.of<CalculoProvider>(context);
    final listaPersonas = calcProvider.listaDePersonas;

    if (listaPersonas.isEmpty) {
      context.go('/datos');
    }

    double gastoTotal = 0;
    for (var persona in listaPersonas) {
      gastoTotal += persona.montoGastado;
    }

    double gastoPromedio = gastoTotal / listaPersonas.length;

    List<Persona> personasQueDebenRecibir = [];
    List<Persona> personasQueDebenPagar = [];
    for (var persona in listaPersonas) {
      if (persona.montoGastado < gastoPromedio) {
        personasQueDebenRecibir.add(persona);
      } else if (persona.montoGastado > gastoPromedio) {
        personasQueDebenPagar.add(persona);
      }
    }

    personasQueDebenPagar
        .sort((a, b) => b.montoGastado.compareTo(a.montoGastado));
    personasQueDebenRecibir
        .sort((a, b) => a.montoGastado.compareTo(b.montoGastado));

    List<String> resultados = [];
    for (var personaDebePagar in personasQueDebenPagar) {
      for (var personaDebeRecibir in personasQueDebenRecibir) {
        double montoAPagar = personaDebePagar.montoGastado - gastoPromedio;
        double montoARecibir = gastoPromedio - personaDebeRecibir.montoGastado;
        double montoTransferir =
            montoAPagar < montoARecibir ? montoAPagar : montoARecibir;
        if (montoTransferir > 0) {
          resultados.add(
              '${personaDebeRecibir.nombre} le debe a ${personaDebePagar.nombre} \$ ${montoTransferir.toStringAsFixed(2)}');
          personaDebePagar.montoGastado -= montoTransferir;
          personaDebeRecibir.montoGastado += montoTransferir;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        // centerTitle: false,
        title: Text(
          'División de Gastos',
          style: GoogleFonts.montserratAlternates(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: 400,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Resumen:',
                      style: GoogleFonts.rubik(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Gasto total: \$ ${gastoTotal.toStringAsFixed(2)}',
                      style: GoogleFonts.rubik(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Gasto promedio por persona: \$ ${gastoPromedio.toStringAsFixed(2)}',
                      style: GoogleFonts.rubik(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Gastaron menos que el promedio: ${personasQueDebenRecibir.map((persona) => persona.nombre).join(', ')}',
                      style: GoogleFonts.rubik(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Gastaron más que el promedio: ${personasQueDebenPagar.map((persona) => persona.nombre).join(', ')}',
                      style: GoogleFonts.rubik(fontSize: 16),
                    ),
                    const SizedBox(height: 18),
                    const Divider(),
                    const SizedBox(height: 5),
                    Text(
                      'Resultados:',
                      style: GoogleFonts.rubik(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: resultados.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              resultados[index],
                              style: GoogleFonts.rubik(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
