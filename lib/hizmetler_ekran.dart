import 'package:flutter/material.dart';

class HizmetlerEkran extends StatelessWidget {
  const HizmetlerEkran({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 177, 80, 112),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.pinkAccent),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Kübra Nur Boyraz",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Ana Sayfa"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text("Randevular"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Ayarlar"),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Çıkış Yap"),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(title: const Text("Hizmet Seçimi"), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            kategoriler(context, "Temel Saç Hizmetlerimiz", [
              "Saç Kesimi",
              "Saç Boyama",
              "Şekillendirme",
              "Saç Bakım",
            ]),
            kategoriler(context, "Özel Gün Hizmetlerimiz", [
              "Gelin Saç ve Makyaj",
            ]),
            kategoriler(context, "Güzellik ve Bakım Hizmetlerimiz", [
              "Makyaj",
              "Manikür & Pedikür",
              "Kaş & Bıyık",
            ]),
            kategoriler(context, "Ek Hizmetlerimiz", [
              "Protez & Kaynak Saç",
              "Evde Kuaför Hizmeti",
            ]),
          ],
        ),
      ),
    );
  }

  Widget kategoriler(
    BuildContext context,
    String basliklar,
    List<String> altHizmetler,
  ) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ExpansionTile(
        title: Text(
          basliklar,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 229, 123, 158),
          ),
        ),
        children: altHizmetler
            .map(
              (hizmet) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 218, 224, 225),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(hizmet),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 225, 175, 192),
                    ),
                    onPressed: () {
                      debugPrint(
                        "[LOG] $hizmet için randevu alınıyor.",
                      ); // Log Kuralı
                    },
                    child: const Text(
                      "Randevu Al",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
