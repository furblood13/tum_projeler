import sqlite3

# Veritabanı bağlantısı ve cursor oluşturma
def baglantiyi_ac():
    return sqlite3.connect("/Users/fbk/Desktop/okul.db")  # MacOS yolu

# Tabloyu oluşturma fonksiyonu
def tabloyu_olustur():
    try:
        bag = baglantiyi_ac()
        cur = bag.cursor()

        # Eğer tablo yoksa, öğrenci tablosunu oluştur
        cur.execute("""
        CREATE TABLE IF NOT EXISTS ogrenci (
            ogrno TEXT PRIMARY KEY,
            adi TEXT NOT NULL,
            soyadi TEXT NOT NULL
        )
        """)
        bag.commit()
        print("Tablo başarıyla oluşturuldu veya zaten mevcut.")
        
    except sqlite3.Error as e:
        print(f"Bir hata oluştu: {e}")
    finally:
        if bag:
            bag.close()

# Öğrenci ekleme fonksiyonu
def ogrenci_ekle():
    bag = None  # bag değişkenini başlatıyoruz
    try:
        bag = baglantiyi_ac()
        cur = bag.cursor()
        
        # Kullanıcıdan öğrenci bilgilerini al
        numara = input("Öğrenci Numarası: ")
        adi = input("Öğrenci Adı: ")
        soyadi = input("Öğrenci Soyadı: ")
        
        # Öğrenci numarasının daha önce var olup olmadığını kontrol et
        sql_check = "SELECT * FROM ogrenci WHERE ogrno = ?"
        cur.execute(sql_check, (numara,))
        if cur.fetchone():
            print("Bu numaraya sahip bir öğrenci zaten var!")
        else:
            # Öğrenci ekleme işlemi
            sql_insert = "INSERT INTO ogrenci (ogrno, adi, soyadi) VALUES (?, ?, ?)"
            cur.execute(sql_insert, (numara, adi, soyadi))
            bag.commit()
            print("Öğrenci başarıyla eklendi.")

    except sqlite3.Error as e:
        print(f"Bir hata oluştu: {e}")
    finally:
        if bag:
            bag.close()

# Öğrenci listesini yazdırma fonksiyonu
def ogrencileri_listele():
    try:
        bag = baglantiyi_ac()
        cur = bag.cursor()
        
        # Öğrencilerin listesini al
        sql_select = "SELECT * FROM ogrenci"
        cur.execute(sql_select)
        sonuclar = cur.fetchall()
        
        if sonuclar:
            print("Öğrenci Numarası | Öğrenci Adı | Öğrenci Soyadı")
            print("-" * 40)
            for satir in sonuclar:
                print(f"{satir[0]} | {satir[1]} | {satir[2]}")
        else:
            print("Hiç öğrenci bulunmamaktadır.")

    except sqlite3.Error as e:
        print(f"Bir hata oluştu: {e}")
    finally:
        if bag:
            bag.close()

# Ana Menü
def ana_menu():
    tabloyu_olustur()  # Program başladığında tabloyu oluştur

    while True:
        print("\n--- Öğrenci Veritabanı ---")
        print("1. Öğrenci Ekle")
        print("2. Öğrenci Listesini Görüntüle")
        print("3. Çıkış")
        
        secim = input("Yapmak istediğiniz işlemi seçin (1/2/3): ")
        
        if secim == "1":
            ogrenci_ekle()
        elif secim == "2":
            ogrencileri_listele()
        elif secim == "3":
            print("Çıkılıyor...")
            break
        else:
            print("Geçersiz seçim, tekrar deneyin.")

# Uygulamayı başlat
if __name__ == "__main__":
    ana_menu()
