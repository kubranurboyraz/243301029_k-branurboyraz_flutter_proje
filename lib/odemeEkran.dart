import 'package:flutter/material.dart';
import 'database_helper.dart';

class OdemeEkrani extends StatefulWidget {
  final int randevuId;
  final double tutar;
  final String hizmetAdi;

  const OdemeEkrani({
    super.key,
    required this.randevuId,
    required this.tutar,
    required this.hizmetAdi,
  });

  @override
  State<OdemeEkrani> createState() => _OdemeEkraniState();
}

class _OdemeEkraniState extends State<OdemeEkrani> {
  final _formKey = GlobalKey<FormState>();
  String kartNo = "**** **** **** ****";
  String kartSahibi = "AD SOYAD";
  String skt = "AA/YY";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ödeme Yapın"),
        backgroundColor: const Color.fromARGB(255, 229, 123, 158),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.credit_card,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    Text(
                      kartNo,
                      style: const TextStyle(
                        color: Colors.white10,
                        fontSize: 22,
                        letterSpacing: 2,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "KART SAHİBİ",
                              style: TextStyle(
                                color: Colors.white10,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              kartSahibi,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "SKT",
                              style: TextStyle(
                                color: Colors.white10,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              skt,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Kart Sahibi",
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => setState(() => kartSahibi = v.toUpperCase()),
                validator: (v) => v!.isEmpty ? "İsim boş geçilemez!" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Kart Numarası",
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => setState(() => kartNo = v),
                validator: (v) => v!.length < 16 ? "Geçersiz numara" : null,
              ),
              const SizedBox(height: 25),

              Text(
                "Ödenecek Tutar: ${widget.tutar} TL",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
              const SizedBox(height: 25),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 185, 240, 187),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await DatabaseHelper().odemeDurumGuncelle(widget.randevuId);

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Ödeme Onaylandı! ")),
                      );
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text(
                  "GÜVENLİ ÖDEME",
                  style: TextStyle(
                    color: Color.fromARGB(255, 237, 226, 226),
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
