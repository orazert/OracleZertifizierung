This Version is based on Ludwig's schema design and Mario's data!
All data were extracted from warenkorb06.pdf.

About step 1 to 3, pls see Ludwigs Anleitung.txt

1. copy *.csv to a folder
2. create directory and grant read/write to public
3. modify warenkorb_v2.sql: change "rwfiles" to your directory name
4. run warenkorb_v2a.sql

Changes in this version:
1. no column for sum
2. wk_seq starts with 1000   --change sql
3. add wk_waren FK

Note:
1. in ext_waren.csv, column "prozent" has a date format, just ignore it. 
It works well to import data from csv to oracle. But why?

2. Problem for wk_waren UK is still open

3. How to design Positions, e.g. Seniorenheim (3 Positionen)