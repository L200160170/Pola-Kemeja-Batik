# POLA KEMEJA BATIK 

Aplikasi Pola kemeja batik ini masih berupa front end dengan menggunakan flutter.
Akan ada penambahan fitur :
- menyimpan gambar.
- zoom in / zoom out pada gambar.
- slide pada hasil pemrosesan.

Sementara itu untuk back end akan menggunakan openCV(template matching) python yang dihubungkan menggunakan heroku. 

## Video penggunaan aplikasi
<p align ="center">
  <video controls>
    <source src="readme/Screenrecorder.mp4" type="video/mp4">
  </video>
  </br>
 </p>
 Aplikasi di atas masih belum selesai. 

## Rancangan penentuan bagian baju
<p align ="center">
  <img src="readme/rancangan.jpg"/>
  <h5 align ="center">Rancangan</h5>

</p>

## Hasil yang diharapkan
<p align ="center">
  <img src="readme/desain.png"/>
  <h5 align ="center">Desain</h5>
  </br>
  <img src="readme/pola.png"/>
  <h5 align ="center">Pola</h5>
</p>
Bagian pola tubuh depan seharusnya tidak miring seperti itu,karena contoh gambar yang saya ambil tidak lurus. saya mencoba untuk mencari motifnya.
Dan untuk kantongnya opsional bisa memakai yang kotak seperti di rancangan atau memakai kantong paspol seperti gambar di desain hasil jadi. 
Dengan ketentuan kantong : jika dalam pencarian kantong tidak memiliki motif maka menggungakan paspol (bebas tidak harus bermotif)

## Permasalahannya
1.Untuk ukuran kemeja, sebaiknya bagaimana ya pak?. Menggunakan ukuran badan asli dari pengguna, atau  di beri ukuran misal (S, M, L, XL). Kalau menggunakan ukuran badan asli , harus menggambar dulu pola nya sesuai inputan user. Sedangkan untuk ukuran (S, M, L, XL) kita bisa menggunakan template pola kemeja yang sudah disiapkan.
2. Untuk proses pencarian gambarnya sendiri menggunakan template matching. Tapi untuk sekarang untuk pencocokan gambar yang sama masih belum menemukan posisi yang tepat
