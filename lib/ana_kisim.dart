import 'package:flutter/material.dart';
import 'package:flutter_kuafor/database_helper.dart';
import 'hizmetler_ekran.dart';
import 'randevular_ekran.dart';
import 'profil_ekran.dart';
import 'log_ekrani.dart';
import 'main.dart';

class AnaKisim extends StatefulWidget {
  final String kullaniciRolu;
  final String kullaniciTelNo;

  const AnaKisim({
    super.key,
    required this.kullaniciRolu,
    required this.kullaniciTelNo,
  });

  @override
  State<AnaKisim> createState() => _AnaKisimState();
}

class _AnaKisimState extends State<AnaKisim> {
  int sec = 0;
  late List<Widget> _sayfalar;

  @override
  void initState() {
    super.initState();
    _sayfalar = [
      const HizmetlerEkran(),
      const RandevularEkran(),
      ProfilEkran(kullaniciTelNo: widget.kullaniciTelNo),
    ];
  }

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
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "Kübra Kuaför Salon",
                  applicationIcon: const Icon(
                    Icons.content_cut,
                    color: Colors.pink,
                    size: 45,
                  ),
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Kübra Kuaför Salonumuz 2026 yılından itibaren Kayseri'de en iyi hizmetleri vermektedir. "
                        "Önceliğimiz her zaman müşterimizin memnuniyetidir. ",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text("Konum : Kayseri, Melikgazi"),
                    const Text("İletişim : 05556667788"),
                  ],
                );
              },
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
              onTap: () async {
                var db = DatabaseHelper();
                await db.logKaydet(
                  "başarılı çıkış yapıldı",
                  widget.kullaniciTelNo,
                );
                if (!context.mounted) return;
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
