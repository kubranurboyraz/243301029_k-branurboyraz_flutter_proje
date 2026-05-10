import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'main.dart';

class ProfilEkran extends StatelessWidget {
  final String kullaniciTelNo;

  const ProfilEkran({super.key, required this.kullaniciTelNo});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: DatabaseHelper().kullanicibulGetir(kullaniciTelNo),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        var kullanici = snapshot.data;
        String adSoyad = kullanici != null
            ? kullanici['kullaniciAdi']
            : "Kullanıcı";
        String ePosta = kullanici != null
            ? kullanici['ePosta']
            : "E-posta bulunamadı";

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Color.fromARGB(255, 229, 123, 158),
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 15),

              Text(
                adSoyad,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                ePosta,
                style: const TextStyle(
                  color: Color.fromARGB(255, 123, 117, 117),
                ),
              ),
              const SizedBox(height: 30),

              bilgilerim(Icons.phone, "Telefon", kullaniciTelNo),
              bilgilerim(Icons.location_on, "Konum", "Kayseri, Türkiye"),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    var db = DatabaseHelper();

                    await db.logKaydet(
                      "başarılı çıkış yapıldı",
                      kullaniciTelNo,
                    );

                    if (!context.mounted) return;
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text(
                    "Çıkış Yap",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget bilgilerim(IconData ikon, String baslik, String icerik) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        leading: Icon(ikon, color: const Color.fromARGB(255, 229, 123, 158)),
        title: Text(
          baslik,
          style: const TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 250, 247, 247),
          ),
        ),
        subtitle: Text(
          icerik,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
