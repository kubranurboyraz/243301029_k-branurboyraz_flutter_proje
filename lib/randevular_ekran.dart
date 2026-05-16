import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'odemeEkran.dart';

class RandevularEkran extends StatefulWidget {
  final String? secilenHizmet;
  final String kullaniciTelNo;
  final double fiyat;

  const RandevularEkran({
    super.key,
    this.secilenHizmet,
    required this.kullaniciTelNo,
    required this.fiyat,
  });

  @override
  State<RandevularEkran> createState() => _RandevularEkranState();
}

class _RandevularEkranState extends State<RandevularEkran> {
  DateTime secTarih = DateTime.now();
  TimeOfDay secSaat = TimeOfDay.now();

  Future<void> tarihSec(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: secTarih,
      firstDate: DateTime.now(),
      lastDate: DateTime(2028),
    );
    if (picked != null) {
      setState(() {
        secTarih = picked;
      });
    }
  }

  Future<void> saatSec(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: secSaat,
    );
    if (picked != null) {
      setState(() {
        secSaat = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Randevu Detayları"),
        backgroundColor: const Color.fromARGB(255, 229, 123, 158),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "Hizmet: ${widget.secilenHizmet ?? 'Genel Bakım'}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ListTile(
              title: Text(
                "Tarih: ${secTarih.day}/${secTarih.month}/${secTarih.year}",
              ),
              trailing: const Icon(Icons.calendar_month, color: Colors.pink),
              onTap: () => tarihSec(context),
            ),
            ListTile(
              title: Text("Saat: ${secSaat.format(context)}"),
              trailing: const Icon(Icons.access_time, color: Colors.pink),
              onTap: () => saatSec(context),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 229, 123, 158),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () async {
                var db = DatabaseHelper();
                var kullanici = await db.kullanicibulGetir(
                  widget.kullaniciTelNo,
                );

                if (kullanici != null) {
                  await db.randevuyuKaydet({
                    'kullaniciId': kullanici['id'],
                    'secilenHizmet': widget.secilenHizmet ?? 'Genel Bakım',
                    'tarih':
                        "${secTarih.day}/${secTarih.month}/${secTarih.year}",
                    'saat': secSaat.format(context),
                  });

                  await db.logKaydet(
                    "${widget.secilenHizmet} randevusu oluşturuldu",
                    widget.kullaniciTelNo,
                  );

                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Randevunuz Başarıyla Alındı!"),
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OdemeEkrani(
                          randevuId: 0,
                          tutar: widget.fiyat,
                          hizmetAdi: widget.secilenHizmet ?? 'Genel Bakım',
                        ),
                      ),
                    );
                  }
                }
              },
              child: const Text(
                "Randevuyu Onayla",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
