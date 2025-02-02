
# **Virtual Internship Experience: Big Data Analytics - Kimia Farma**
Tool : BigQuery <br>
Visualization : "https://lookerstudio.google.com/s/k3IpeY-vPMk"

<br>

---

## 📂 **Introduction**
Program Project Based Internship kolaborasi Rakamin Academy dan Kimia Farma Big Data Analytics merupakan program pengembangan diri dan akselerasi karier yang diperuntukkan bagi mereka yang tertarik mendalami posisi Big Data Analytics di perusahaan Kimia Farma. Program ini memberikan akses pembelajaran dasar berupa Article Review (materi bacaan) dan Company Coaching Video (video learning) untuk memperkenalkan peserta dengan kompetensi dan keahlian yang harus dimiliki oleh Big Data Analytics di perusahaan. Selain materi, akan ada pengujian atas hasil pembelajaran peserta berupa soal-soal Task setiap minggunya dan diakhiri dengan pembuatan tugas akhir yang akan menjadi portofolio peserta pada program ini. <br>
<br>

**Objectives**
- Membuat Tabel Analisis
- Membuat visualisasi/dashboard laporan penjualan perusahaan Kimia Farma
<br>

**Dataset** <br>
Dataset yang disediakan terdiri dari tabel-tabel berikut:<br>
- kf_ﬁnal_transaction,<br> - kf_inventory,<br> - kf_kantor_cabang,<br> - kf_product. 
<br>

---



## 📂 **Tabel Analisis**
<br>
Membuat tabel analisa berdasarkan hasil aggregasi dari ke-empat tabel yang sudah diimport sebelumnya. Berikut ini adalah kolom-kolom yang mandatory pada tabel tersebut: <br> ● transaction_id : kode id transaksi,<br> ● date : tanggal transaksi dilakukan,<br> ● branch_id : kode id cabang Kimia Farma,<br> ● branch_name : nama cabang Kimia Farma,<br> ● kota : kota cabang Kimia Farma, <br>● provinsi : provinsi cabang Kimia Farma, <br> ● rating_cabang : penilaian konsumen terhadap cabang Kimia Farma <br>● customer_name : Nama customer yang melakukan transaksi, <br>● product_id : kode product obat, <br>● product_name : nama obat, <br>● actual_price : harga obat, <br>● discount_percentage : Persentase diskon yang diberikan pada obat,<br> ● persentase_gross_laba : Persentase laba yang seharusnya diterima dari obat dengan ketentuan berikut:<br> ■ Harga <= Rp 50.000 -> laba 10% <br>■ Harga > Rp 50.000 - 100.000 -> laba 15% <br>■ Harga > Rp 100.000 - 300.000 -> laba 20% <br>■ Harga > Rp 300.000 - 500.000 -> laba 25% <br>■ Harga > Rp 500.000 -> laba 30%, <br>● nett_sales : harga setelah diskon,<br> ● nett_proﬁt : keuntungan yang diperoleh Kimia Farma,<br> ● rating_transaksi : penilaian konsumen terhadap transaksi yang dilakukan. 
 <br>
<details> <br>
  <summary>   Klik untuk melihat Query </summary>
    <br>
    
```sql
CREATE TABLE `rakaminkfanalytic.kimia_farma.transaction_data` AS
SELECT
    t.transaction_id,
    t.date,
    t.branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.rating AS rating_cabang,
    t.customer_name,
    t.product_id,
    p.product_name,
    p.product_category,
    p.price AS actual_price,
    t.discount_percentage,
    CASE
        WHEN t.price <= 50000 THEN 0.10
        WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
        WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
        WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
        WHEN t.price > 500000 THEN 0.30
    END AS persentase_gross_laba,
    t.price AS nett_sales,
    t.price * (
        CASE
            WHEN t.price <= 50000 THEN 0.10
            WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
            WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
            WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
            WHEN t.price > 500000 THEN 0.30
        END
    ) AS nett_profit,
    t.rating AS rating_transaksi
FROM
    `rakaminkfanalytic.kimia_farma.kf_final_transaction` t
LEFT JOIN
    `rakaminkfanalytic.kimia_farma.kf_kantor_cabang` kc ON t.branch_id = kc.branch_id
LEFT JOIN
    `rakaminkfanalytic.kimia_farma.kf_product` p ON t.product_id = p.product_id;

---
