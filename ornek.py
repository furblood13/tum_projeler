import tkinter as tk
from tkinter import messagebox

# Pencere oluşturma
pencere = tk.Tk()
pencere.title("Basit Tkinter Uygulaması")
pencere.geometry("400x300")

# İsim-Soyisim Alma
tk.Label(pencere, text="Adınız:").grid(row=0, column=0, padx=10, pady=5)
tk.Label(pencere, text="Soyadınız:").grid(row=1, column=0, padx=10, pady=5)

adi = tk.StringVar()
soyadi = tk.StringVar()

ad_giris = tk.Entry(pencere, textvariable=adi)
ad_giris.grid(row=0, column=1, padx=10, pady=5)

soyad_giris = tk.Entry(pencere, textvariable=soyadi)
soyad_giris.grid(row=1, column=1, padx=10, pady=5)

def goster():
    isim = adi.get()
    soyisim = soyadi.get()
    if isim and soyisim:
        messagebox.showinfo("Bilgi", f"Adınız: {isim}, Soyadınız: {soyisim}")
    else:
        messagebox.showwarning("Uyarı", "Lütfen hem adınızı hem de soyadınızı giriniz!")

tk.Button(pencere, text="Göster", command=goster).grid(row=2, column=1, pady=10)

# Metreyi Kilometreye Çevirme
tk.Label(pencere, text="Metre:").grid(row=3, column=0, padx=10, pady=5)
metre = tk.DoubleVar()

metre_giris = tk.Entry(pencere, textvariable=metre)
metre_giris.grid(row=3, column=1, padx=10, pady=5)

def cevir():
    try:
        m = metre.get()
        km = m / 1000
        messagebox.showinfo("Sonuç", f"{m} metre, {km:.2f} kilometreye eşittir.")
    except tk.TclError:
        messagebox.showerror("Hata", "Lütfen geçerli bir sayı girin!")

tk.Button(pencere, text="Çevir", command=cevir).grid(row=4, column=1, pady=10)

# Döngü ile Sayıları Listeleme
tk.Label(pencere, text="Kaça kadar listeleyelim?").grid(row=5, column=0, padx=10, pady=5)
sayac = tk.IntVar()

sayac_giris = tk.Entry(pencere, textvariable=sayac)
sayac_giris.grid(row=5, column=1, padx=10, pady=5)

def listele():
    try:
        n = sayac.get()
        liste = [str(i) for i in range(1, n + 1)]
        messagebox.showinfo("Liste", "\n".join(liste))
    except tk.TclError:
        messagebox.showerror("Hata", "Lütfen geçerli bir sayı girin!")

tk.Button(pencere, text="Listele", command=listele).grid(row=6, column=1, pady=10)

# Uygulama döngüsü
pencere.mainloop()
