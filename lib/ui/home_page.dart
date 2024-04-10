import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:web_calculator/enities/persona.dart';
import 'package:web_calculator/providers/calculo_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String nombre = '';
  double montoGastado = 0;

  final List<Persona> listaPersonas = [];

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController montoController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ScrollController _controller = ScrollController();

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    super.initState();
    analytics.logEvent(name: 'page_view', parameters: {'page_name': 'Home'});
  }

  @override
  void dispose() {
    nombreController.dispose();
    montoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calcular Gastos..!!',
          style: GoogleFonts.montserratAlternates(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Inputs para el nombre y el monto
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: nombreController,
                            decoration: InputDecoration(
                              hintText: 'Nombre',
                              hintStyle: GoogleFonts.rubik(
                                  letterSpacing: .5,
                                  color: Colors.black.withOpacity(0.3)),
                              icon: const Icon(Icons.person_add_alt),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingresa un nombre';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              nombre = value;
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: montoController,
                            decoration: InputDecoration(
                              hintText: 'Monto',
                              hintStyle: GoogleFonts.rubik(
                                  letterSpacing: .5,
                                  color: Colors.black.withOpacity(0.3)),
                              icon: const Icon(Icons.add_card_outlined),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingresa un monto';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Ingresa un número válido';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              montoGastado = double.tryParse(value) ?? 0;
                            },
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    //? Botón para agregar datos
                    ElevatedButton(
                      onPressed: () {
                        analytics.logEvent(
                            name: 'click', parameters: {'clic_name': 'Agregar'});
                        if (_formKey.currentState!.validate()) {
                          // Agregar lógica para agregar datos
                          final persona = Persona(nombre, montoGastado);
                          if (listaPersonas
                              .any((persona) => persona.nombre == nombre)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Ese nombre ya existe',
                                  style: GoogleFonts.roboto(letterSpacing: 1),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            listaPersonas.add(persona);
                            setState(() {
                              nombre = '';
                              montoGastado = 0;
                              nombreController.clear();
                              montoController.clear();
                            });
                          }
                        }
                      },
                      child: Text('Agregar',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 5),
                    Text(
                      'Detalle de Gastos',
                      style: GoogleFonts.rubik(
                        letterSpacing: .8,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ? Tabla de personas
                    Expanded(
                        child: Visibility(
                      visible: listaPersonas.isNotEmpty,
                      child: SingleChildScrollView(
                        controller: _controller,
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          headingTextStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          headingRowColor:
                              MaterialStateProperty.all(Colors.grey[50]),
                          columns: [
                            DataColumn(
                                label:
                                    Text('Nombre', style: GoogleFonts.rubik())),
                            DataColumn(
                                label: Text('Monto Gastado',
                                    style: GoogleFonts.rubik()))
                          ],
                          rows: listaPersonas
                              .map((persona) => DataRow(
                                    cells: [
                                      DataCell(Text(persona.nombre)),
                                      DataCell(Text(
                                        '\$ ${persona.montoGastado.toString()}',
                                        style: GoogleFonts.rubik(),
                                      )),
                                    ],
                                  ))
                              .toList(),
                        ),
                      ),
                    )),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        analytics.logEvent(
                            name: 'click', parameters: {'clic_name': 'Calcular'});
                        if (listaPersonas.isNotEmpty &&
                            listaPersonas.length > 2) {
                          final calculoProvider = Provider.of<CalculoProvider>(
                              context,
                              listen: false);
                          calculoProvider.recibirPersonas(listaPersonas);
                          GoRouter.of(context).go('/results');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Debe haber al menos 3 personas para calcular!',
                                  style: GoogleFonts.roboto(letterSpacing: 1)),
                              backgroundColor: Colors.red));
                        }
                      },
                      child: Text('Calcular',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Powered By lukyblanco', style: TextStyle(fontSize: 10,fontStyle: FontStyle.italic))
                        ],
                      ),
                    )
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
