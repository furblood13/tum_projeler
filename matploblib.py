import matplotlib.pyplot as plt
import numpy as np

# 1. Çizgi Grafiği (Line Plot)
def cizgi_grafik():
    x = np.linspace(0, 10, 100)  # 0 ile 10 arasında 100 eşit aralıklı değer
    y = np.sin(x)
    plt.figure(figsize=(8, 5))
    plt.plot(x, y, label="sin(x)", color="blue", linestyle="--")
    plt.title("Çizgi Grafiği Örneği")
    plt.xlabel("X Ekseni")
    plt.ylabel("Y Ekseni")
    plt.legend()
    plt.grid()
    plt.show()

# 2. Çubuk Grafiği (Bar Plot)
def cubuk_grafik():
    kategoriler = ["A", "B", "C", "D"]
    degerler = [10, 20, 15, 25]
    plt.figure(figsize=(8, 5))
    plt.bar(kategoriler, degerler, color="green", alpha=0.7)
    plt.title("Çubuk Grafiği Örneği")
    plt.xlabel("Kategoriler")
    plt.ylabel("Değerler")
    plt.show()

# 3. Pasta Grafiği (Pie Chart)
def pasta_grafik():
    dilimler = [30, 20, 25, 25]
    etiketler = ["A", "B", "C", "D"]
    renkler = ["red", "blue", "green", "orange"]
    plt.figure(figsize=(8, 5))
    plt.pie(dilimler, labels=etiketler, colors=renkler, autopct="%1.1f%%", startangle=90)
    plt.title("Pasta Grafiği Örneği")
    plt.show()

# 4. Histogram
def histogram():
    veri = np.random.randn(1000)  # 1000 rastgele sayı (normal dağılım)
    plt.figure(figsize=(8, 5))
    plt.hist(veri, bins=20, color="purple", alpha=0.7, edgecolor="black")
    plt.title("Histogram Örneği")
    plt.xlabel("Değer Aralığı")
    plt.ylabel("Frekans")
    plt.show()

# 5. Dağılım Grafiği (Scatter Plot)
def dagilim_grafik():
    x = np.random.rand(100)  # 0 ile 1 arasında 100 rastgele sayı
    y = np.random.rand(100)
    plt.figure(figsize=(8, 5))
    plt.scatter(x, y, color="cyan", edgecolor="black", alpha=0.6)
    plt.title("Dağılım Grafiği Örneği")
    plt.xlabel("X Ekseni")
    plt.ylabel("Y Ekseni")
    plt.show()

# Menü ile Grafik Seçimi
while True:
    print("\nMatplotlib Rehberi")
    print("1. Çizgi Grafiği")
    print("2. Çubuk Grafiği")
    print("3. Pasta Grafiği")
    print("4. Histogram")
    print("5. Dağılım Grafiği")
    print("6. Çıkış")
    
    secim = input("Bir grafik seçin (1-6): ")
    
    if secim == "1":
        cizgi_grafik()
    elif secim == "2":
        cubuk_grafik()
    elif secim == "3":
        pasta_grafik()
    elif secim == "4":
        histogram()
    elif secim == "5":
        dagilim_grafik()
    elif secim == "6":
        print("Programdan çıkılıyor...")
        break
    else:
        print("Geçerli bir seçim yapınız!")
