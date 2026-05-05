import 'package:flutter/material.dart';

class HizmetlerEkran extends StatelessWidget {
  const HizmetlerEkran({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      debugPrint("[LOG] $hizmet için randevu alınıyor.");
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
