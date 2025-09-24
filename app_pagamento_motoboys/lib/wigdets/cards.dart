
import 'package:flutter/material.dart';

class CardNavegacao extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final Widget paginaDestino; 

  const CardNavegacao({
    super.key,
    required this.icone,
    required this.titulo,
    required this.paginaDestino,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => paginaDestino),
        );
      },
      child: Card(
        elevation: 5, 
        child: SizedBox(
          width: 150, 
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icone,
                size: 60,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 10),
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}