import csv

# CSV dosyasını okuma
def dosya_ac(path):
    try:
        with open(path, mode='r', newline='', encoding='utf-8') as file:
            reader = csv.reader(file)
            veriler = list(reader)
            return veriler
    except FileNotFoundError:
        print(f"{path} dosyası bulunamadı.")
        return []

# CSV dosyasına veri ekleme
def veri_ekle(path, veri):
    with open(path, mode='a', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        writer.writerow(veri)  # Yeni veriyi ekler
        print(f"Veri '{veri}' dosyaya eklendi.")

# CSV dosyasındaki mevcut verileri yazdırma
def hucreleri_oku(veriler):
    if veriler:
        for satir in veriler:
            print(satir)
    else:
        print("Dosya boş veya bulunamadı.")

# Ana fonksiyon
def ana():
    csv_path = "/Users/fbk/Desktop/okul.csv"  # CSV dosyasının yolu
    veriler = dosya_ac(csv_path)
    
    print("Mevcut veriler:")
    hucreleri_oku(veriler)
    
    # Yeni veri ekleme
    yeni_veri = input("Yeni veri girin (örnek: 1, Ahmet, Yılmaz): ").split(", ")
    veri_ekle(csv_path, yeni_veri)

if __name__ == "__main__":
    ana()
