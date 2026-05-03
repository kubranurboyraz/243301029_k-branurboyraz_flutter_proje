import 'package:flutter/material.dart';
import 'hizmetler_ekran.dart';
import 'randevular_ekran.dart';
import 'profil_ekran.dart';

class AnaKisim extends StatefulWidget {
  const AnaKisim({super.key});

  @override
  State<AnaKisim> createState() => _AnaKisimState();
}

// ignore: unused_field
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
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Çıkış Yap"),
              onTap: () {
                Navigator.pop(context);
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
        onTap: (index) {
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
