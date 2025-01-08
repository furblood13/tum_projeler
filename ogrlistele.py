import sqlite3

# Veritabanına bağlanma
def baglantiyi_ac():
    return sqlite3.connect("/Users/fbk/Desktop/okul.db")  # MacOS yolu

# 'F' ile başlayan isimleri listeleme
def f_ile_baslayanlari_listele():
    try:
        bag = baglantiyi_ac()
        cur = bag.cursor()
        
        # 'F' ile başlayan isimleri seçen SQL sorgusu
        cur.execute("SELECT * FROM ogrenci WHERE adi LIKE 'F%'")
        sonuclar = cur.fetchall()
        
        if sonuclar:
            print("Öğrenci Numarası | Öğrenci Adı | Öğrenci Soyadı")
            print("-" * 40)
            for satir in sonuclar:
                print(f"{satir[0]} | {satir[1]} | {satir[2]}")
        else:
            print("Baş harfi 'F' olan öğrenci bulunmamaktadır.")
    
    except sqlite3.Error as e:
        print(f"Bir hata oluştu: {e}")
    finally:
        if bag:
            bag.close()

# 'F' ile başlayan öğrencilere yönelik sorguyu çalıştır
if __name__ == "__main__":
    f_ile_baslayanlari_listele()
