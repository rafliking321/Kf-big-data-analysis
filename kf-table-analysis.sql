create table Kimia_Farma.kf_tabel_analisis as
select
ft.transaction_id, 
ft.date, 
kc.branch_id, 
kc.branch_name,
kc.kota,
kc.provinsi,
kc.rating, 
ft.customer_name,
pd.product_id,
pd.product_name, 
pd.price as actual_price, 
round(ft.discount_percentage * 100) as discount_percentage, 
case
    when pd.price <= 50000 then '10%'
    when pd.price between 50000 and 100000 then '15%'
    when pd.price between 100000 and 300000 then '20%'
    when pd.price between 300000 and 500000 then '25%'
    when pd.price > 500000 then '30%'
end as persentase_gross_laba,
round(pd.price -(pd.price * ft.discount_percentage )) as nett_sales, 
round(pd.price - (pd.price -(pd.price * ft.discount_percentage ))) as nett_profit,
ft.rating as rating_transaksi
from `Kimia_Farma.kf_final_transaction` as ft
join 
  `Kimia_Farma.kf_product` as pd 
on 
  ft.product_id = pd.product_id
join 
  `Kimia_Farma.kf_inventory` as inv 
on 
  ft.product_id = inv.product_id
join 
  `Kimia_Farma.kf_kantor_cabang` as kc 
on 
  ft.branch_id = kc.branch_id;


