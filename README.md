# ✂️ Kübra Kuaför Salonu - Mobil Uygulama projesi

Bu proje, bir kadın kuaför salonunun günlük hizmetlerini, randevu yönetimini ve müşteri rollerini dijitalleştirmek amacıyla **Flutter** framework'ü kullanılarak geliştirilmiş bir mobil uygulamadır.

## 👤 Öğrenci Bilgileri
* **Öğrenci Adı Soyadı:** Kübra Nur BOYRAZ
* **Öğrenci Numarası:** 243301029
* **Üniversite / Bölüm / Fakülte** Selçuk Üniversitesi - Bilgisayar Mühendisliği - Teknoloji Fakültesi

---

## 🚀 Projenin Öne Çıkan Özellikleri

* **Güvenli Giriş Sistemi:** Kullanıcılar sisteme hem **e-posta** adresleriyle hem de **telefon numaralarıyla**  güvenli bir şekilde giriş yapabilirler.
* **Dinamik Rol Yönetimi (RBAC):** Giriş yapan kullanıcının rolü veritabanından dinamik olarak okunur:
  * **Yönetici (Admin):** Salon operasyonlarını, hizmetleri ve tüm randevuları yönetebilir.
  * **Müşteri:** Hizmetleri görüntüleyebilir,  randevu alabilir ve geçmiş randevularını takip edebilir.
* *** Firebase Entegrasyonu:** Kimlik doğrulama süreçleri arka planda **Firebase Auth**  ile asenkron olarak senkronize edilir.
* **Performans Odaklı Yerel Veri Mimarisi:** Veri yönetimi ve kullanıcı rolleri yerel **SQLite** veritabanı mimarisi üzerinde kurgulanmıştır. Bu sayede uygulama çok hızlı  çalışır.
* **Hot Restart ve Oturum Koruması:** Hot Restart işlemlerinde en son aktif olan oturum açık kalır.
* **İşlem Günlüğü (Logging):** Sistemde yapılan başarılı girişler ve kritik işlemler güvenlik amacıyla yerelde loglanır. sadece yönetici görebilir 

---

## 🛠️ Kullanılan Paketler (Dependencies)

Projede kullanılan temel kütüphaneler ve sürümleri şu şekildedir:
* `firebase_core`: 2.24.0 
* `firebase_auth`: 4.15.0
* `sqflite`: Yerel veritabanı yönetimi ve SQL sorguları için
* `path`: Veritabanı dosya yolları güvenliği için

---

## 🧑‍💻 Test Hesapları Bilgileri

Uygulamayı test etmek ve roller arası geçişi incelemek için aşağıdaki hesap kombinasyonları tanımlanmıştır:

| Rol | E-Posta | Telefon Numarası | Şifre |
| :--- | :--- | :--- | :--- |
| **Yönetici (Kübra)** | `yonetici@kuafor.com` | `05556667788` | `kubra05` |
| **Müşteri (Selin)** | `selin@mail.com` | `05558889911` | `selin52` |

---


## 📸 Uygulama Ekran Görüntüleri



### 📱 Giriş, Kayıt ve Temel Ekranlar
<p align="center">
  <img src="assets/ekran1.png" width="23%" alt="Ekran 1" />
  <img src="assets/ekran5.png" width="23%" alt="Ekran 5" />
  <img src="assets/ekran8.png" width="23%" alt="Ekran 8" />
  <img src="assets/ekran4.png" width="23%" alt="Ekran 4" />
</p>

### ✂️ Hizmetler ve Randevu Yönetim Ekranları
<p align="center">
  <img src="assets/ekran2.png" width="23%" alt="Ekran 2" />
  <img src="assets/ekran3.png" width="23%" alt="Ekran 3" />
  <img src="assets/ekran4.png" width="23%" alt="Ekran 4" />
  <img src="assets/ekran6.png" width="23%" alt="Ekran 6" />
</p>

### 👤 Profil, Ayarlar ve Özet Ekranları
<p align="center">
  <img src="assets/ekran7.png" width="23%" alt="Ekran 7" />
  <img src="assets/ekran10.png" width="23%" alt="Ekran 10" />
  <img src="assets/ekra11.png" width="23%" alt="Ekran 11" />
</p>

---

### 📈 GitHub Commit Geçmişi 
<p align="center">
  <img src="assets/commit_gecmisi.png" width="80%" alt="GitHub Commit Geçmişi" />
</p>



