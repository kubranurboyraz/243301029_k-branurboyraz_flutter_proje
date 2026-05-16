import 'package:flutter/material.dart';
import 'package:flutter_kuafor/randevular_ekran.dart';

class HizmetlerEkran extends StatelessWidget {
  final String kullaniciTelNo;
  const HizmetlerEkran({super.key, required this.kullaniciTelNo});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          kategoriler(context, "Temel Saç Hizmetlerimiz", [
            {"ad": "Saç Kesim", "fiyat": 500.0},
            {"ad": "Saç Boyama", "fiyat": 2000.0},
            {"ad": "Şekillendirme", "fiyat": 400.0},
            {"ad": "Saç Bakım", "fiyat": 1500.0},
          ]),
          kategoriler(context, "Özel Gün Hizmetlerimiz", [
            {"ad": "Gelin Saç ve Makyaj", "fiyat": 6000.0},
          ]),

          kategoriler(context, "Temel Saç Hizmetlerimiz", [
            {"ad": "Makyaj", "fiyat": 500.0},
            {"ad": "Manikür & Pedikür", "fiyat": 1500.0},
            {"ad": "Kaş & Bıyık", "fiyat": 200.0},
          ]),
          kategoriler(context, "Temel Saç Hizmetlerimiz", [
            {"ad": "Protez & Kaynak Saç", "fiyat": 4000.0},
            {"ad": "Evde Kuaför Hizmeti", "fiyat": 1500.0},
          ]),
        ],
      ),
    );
  }

  Widget kategoriler(
    BuildContext context,
    String basliklar,
    List<Map<String, dynamic>> altHizmetler,
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
                  title: Text(hizmet['ad']),
                  subtitle: Text(
                    "${hizmet['fiyat']} TL",
                    style: const TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 225, 175, 192),
                    ),
                    onPressed: () {
                      debugPrint("[LOG] $hizmet için randevu alınıyor.");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RandevularEkran(
                            secilenHizmet: hizmet['ad'],
                            kullaniciTelNo: kullaniciTelNo,
                            fiyat: hizmet['fiyat'],
                          ),
                        ),
                      );
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
