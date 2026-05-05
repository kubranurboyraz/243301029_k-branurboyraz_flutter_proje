import 'package:flutter/material.dart';
import 'hizmetler_ekran.dart';
import 'randevular_ekran.dart';
import 'profil_ekran.dart';
import 'log_ekrani.dart';
import 'main.dart';

class AnaKisim extends StatefulWidget {
  final String kullaniciRolu;

  const AnaKisim({super.key, required this.kullaniciRolu});

  @override
  State<AnaKisim> createState() => _AnaKisimState();
}

class _AnaKisimState extends State<AnaKisim> {
  int sec = 0;

  final List<Widget> _sayfalar = [
    const HizmetlerEkran(),
    const RandevularEkran(),
    const ProfilEkran(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.pinkAccent),
              child: Text(
                "Kübra Kuaför Menü",
                style: TextStyle(color: Color.fromARGB(255, 220, 129, 179)),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Ayarlar"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("Hakkımızda"),
              onTap: () {},
            ),

            if (widget.kullaniciRolu == 'yönetici')
              ListTile(
                leading: const Icon(Icons.history, color: Colors.blue),
                title: const Text(" Tüm Sistem Geçmişi Log Kayıtları"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogEkrani()),
                  );
                },
              ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text("Çıkış Yap"),
              onTap: () {
                Navigator.pop(context);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Kübra Kuaför"),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),

      body: _sayfalar[sec],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: sec,
        selectedItemColor: Colors.pinkAccent,
        onTap: (index) async {
          debugPrint("[LOG] Sekme değiştirildi: $index");
          setState(() {
            sec = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.cut), label: "Hizmetler"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Randevularım",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profilim"),
        ],
      ),
    );
  }
}
