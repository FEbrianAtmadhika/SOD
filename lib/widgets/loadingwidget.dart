import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: screenSize.width * 0.4, // 40% dari lebar layar
        height: screenSize.width * 0.4, // Tinggi sama dengan lebar (kotak)
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3), // Background dengan opacity 30%
          borderRadius: BorderRadius.circular(10), // Sudut melengkung
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20), // Padding untuk loader
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.green[800]!, // Warna awal gradien
                  Colors.greenAccent, // Warna akhir gradien
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: CircularProgressIndicator(
              strokeWidth: 6, // Lebar garis indikator
              valueColor:
                  AlwaysStoppedAnimation(Colors.white), // Warna indikator
            ),
          ),
        ),
      ),
    );
  }
}
