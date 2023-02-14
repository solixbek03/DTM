create database dtm;

\c dtm

create type gender_type as enum('male', 'female');

create table regions(
    region_id serial primary key,
    region_name varchar(30) not null
);

create table users(
    user_id serial priimary key,
    fullname varchar(60) not null,
    contact text unique not null,
    region_id int references regions(region_id) not null,
    password varchar(20) not null,
    gender gender_type not null
);

create table subjects(
    subject_id serial primary key,
    subject_name varchar(30) not null
);

create table universities(
    university_id serial primary key,
    university_name text not null,
    region_id int references regions(region_id) not null
);

create table faculties(
    faculty_id serial primary key,
    faculty_name text not null,
    first_subject int references subjects(subject_id) not null,
    second_subject int references subjects(subject_id) not null,
    grant_count int not null,
    contract_count int not null,
    passing_score_grant decimal(4, 1) not null,
    passing_score_contract decimal(4, 1) not null,
    university_id int references universities(university_id) on delete cascade not null
);

create table questions(
    question_id serial,
    question text not null,
    question_variants jsonb not null,
    subject_id int references subjects(subject_id) on delete cascade not null
);

create table results(
    result_id serial,
    first_subject int not null,
    second_subject int not null,
    first_subject_id int references subjects(subject_id) not null,
    second_subject_id int references subjects(subject_id) not null,
    first_tests_count int not null,
    second_tests_count int not null,
    score_ball decimal(4,1) not null,
    date timestamp default current_timestamp,
    time int not null,
    user_id int references users(user_id) on delete cascade not null,
    faculty_id int references faculties(faculty_id) on delete cascade
);

insert into regions(region_id, region_name) values 
('1','Andijon viloyati'), 
('2','Buxoro viloyati'), 
('3','Farg`ona viloyati'), 
('4','Jizzax viloyati'), 
('5','Namangan viloyati'), 
('6','Navoi viloyati'), 
('7','Qashqadaryo viloyati'), 
('8','Qoraqalpog''iston Respublikasi'), 
('9','Samarqand viloyati'), 
('10','Surxondaryo viloyati'), 
('11','Toshkent viloyati'),
('12','Toshkent shahri'),
('13','Xorazm viloyati'); 

insert into subjects(subject_id, subject_name) values 
('1','Matematika'), 
('2','Ingliz tili'), 
('3','Fizika'), 
('4','Biologiya'), 
('5','Kimyo');

insert into users(user_id, fullname, contact, region_id, password, gender) values ('1','Saida', '998909191123', '3', '7397', 'female');
insert into users(user_id, fullname, contact, region_id, password, gender) values ('2','Said', '998901112233', '2', '7397', 'male');
insert into users(user_id, fullname, contact, region_id, password, gender) values ('3','Nodir', '998903332211', '4', '7397', 'male');
insert into users(user_id, fullname, contact, region_id, password, gender) values ('4','Diyora', '998904445566', '7', '7397', 'female');
insert into users(user_id, fullname, contact, region_id, password, gender) values ('5','Alisher', '998951238456', '1', '7397', 'male');

insert into universities(university_id ,university_name, region_id) values 
('1', 'Toshkent Transport Universiteti', '12'),
('2', 'Toshkent Farmatseptika instituti', '12'),
('3', 'Toshkent Moliya Instituti', '12'),
('4', 'Farg`ona Politexnika Instituti', '3');


insert into faculties(faculty_id, grant_count, contract_count ,faculty_name, first_subject, second_subject, passing_score_grant, passing_score_contract, university_id) values 
('1','20','45','Amaliy matematika', '1', '3', '165.7', '124.6', '1'),
('2','14','96','Raqamli Iqtisodiyot', '1', '2', '161.3', '101.9', '1'),
('3','35','81','Iqtisodiyot (tarmoqlar va sohalar bo''yicha)', '1', '2', '179.7', '129.5', '1'),
('4','36','49','Vagonlarga xizmat kursatish', '1', '3', '68.8', '56.9', '1'),
('5','45','59','Logistika', '1', '3', '126.8', '111.1', '1'),

('6','4','72','Biotibbiyot muhandisligi', '4', '5', '107.3', '60.7', '2'),
('7','26','76','Davolash ishi', '4', '5', '123.5', '105.5', '2'),
('8','25','82','Pediatriya ishi', '4', '5', '154', '95.4', '2'),
('9','20','99','Tibbiy-biologik ish', '4', '5', '147.2', '85.4', '2'),
('10','24','94','Xalq tabobati', '4', '5', '154.1', '99', '2'),

('11','12','53','Baholash ishi', '1', '2', '166.5', '113.6', '3'),
('12','5','57','Sug''urta ishi', '1', '2', '167.8', '81.1', '3'),
('13','16','54','Birja ishi', '1', '2', '175.1', '115.7', '3'),
('14','13','69','Iqtisodiy xavfsizlik', '1', '2', '175.8', '126', '3'),
('15','27','71','Biznes-tahlil', '1', '2', '175.1', '107.2', '3'),

('16', '25', '45', 'Tarmoq Xavsizligi', '1', '3', '168.7', '125.7', '4'),
('17','32', '56', 'Dasturiy injiniring', '1', '3', '167.9', '116.5', '4'),
('18','12','79','Texnik kurik', '1', '3', '169.1', '125.7', '4'),
('19','21','88','Yol Transporti', '1', '3', '161.8', '103.9', '4'),
('20','22','97','Mexatronika va robototexnika', '1', '3', '102.8', '67.3', '4');


insert into questions(question, question_variants, subject_id) values 
('17827516 quyidagi sonlardan qaysi biriga qoldiqsiz bolinadi?', '{
    "1": 4,
    "2": 5,
    "3": 3,
    "4": 10,
    "true": 1
}', '1'),
('752752 sonining ong tomoniga qanday raqam yozilsa, hosil bolgan son 3636 ga qoldiqsiz bolinadi?', '{
    "1": 6,
    "2": 4,
    "3": 7,
    "4": 2,
    "true": 3
}', '1'),
('246*013579246*013579 soni 9 ga bo''linishi uchun yulduzchaning o''rniga qanday raqam qo''yilishi kerak?', '{
    "1": 4,
    "2": 7,
    "3": 8,
    "4": 0,
    "true": 1
}', '1'),
('4∗10 yozuvdagi yulduzchani shunday raqam bilan almashtiringki, hosil bo‘lgan son 4545 ga qoldiqsiz bo‘linsin.', '{
    "1": "4",
    "2": "6",
    "3": "10",
    "4": "5",
    "true": 2
}', '1'),
('1782751617827516 quyidagi sonlardan qaysi biriga qoldiqsiz bo''linadi?', '{
    "1": 4,
    "2": 10,
    "3": 5,
    "4": 3,
    "true": 1
}', '1'),
('3, 6, 73,6,7 va 99 raqamlaridan ularni takrorlamasdan mumkin bo''lgan barcha 44 xonali sonlar tuzilgan. Bu sonlar ichida nechtasi 44 ga qoldiqsiz bo''linadi?', '{
    "1": 6,
    "2": 2,
    "3": 8,
    "4": 4,
    "true": 2
}', '1'),
('821 ga qanday eng kichik musbat sonni qo''shganda, yi''indi 66 ga qoldiqsiz bo''linadi?', '{
    "1": 4,
    "2": 5,
    "3": 1,
    "4": 7,
    "true": 4
}', '1'),
('3030 dan kichik tub sonlar nechta?', '{
    "1": 11,
    "2": 12,
    "3": 9,
    "4": 10,
    "true": 2
}', '1'),
('18 90 va 300 sonlarining eng kichik umumiy karralisini toping', '{
    "1": 18,
    "2": 80,
    "3": 900,
    "4": 10,
    "true": 3
}', '1'),
('Quyidagi sonlardan qaysi biri 1212 ga qoldiqsiz bo''linmaydi?', '{
    "1": 12024,
    "2": 13620,
    "3": 18320,
    "4": 9216,
    "true": 3
}', '1');

insert into questions(question, question_variants, subject_id) values 
('Choose the answer which truely completes the sentence.
Internet news … you more information than TV news.', '{
    "1": "give",
    "2": "is given",
    "3": "gives",
    "4": "are giving",
    "true": 4
}', '2'),
('Choose the answer which truely completes the sentence.
Rabbits have large front …, short tails, and hind legs and feet adapted for running and jumping.', '{
    "1": "teeth''s",
    "2": "teeth",
    "3": "tooth",
    "4": "tooth''s",
    "true": 2
}', '2'),
('Choose the answer which truely completes the sentence.
There … much international news in the local papers.', '{
    "1": "hasn''t",
    "2": "isn''t",
    "3": "haven''t",
    "4": "aren''t",
    "true": 1
}', '2'),
('Hundreds of tigers are still being illegally killed throughout Asia. Every day two wild … die, frequently leaving behind young helpless baby tigers to starve.', '{
    "1": "tigers",
    "2": "tigers",
    "3": "tiger",
    "4": "tiger''s",
    "true": 2
}', '2'),
('Choose the answer which truely completes the sentence.
There are a lot of … in the street', '{
    "1": "trees''",
    "2": "trees",
    "3": "tree",
    "4": "tree''s",
    "true": 3
}', '2'),
('Choose the answer which truely completes the sentence.
The ode was originally a ceremonial… written to celebrate public occasions or exalted subjects.', '{
    "1": "poem",
    "2": "poems''",
    "3": "poems",
    "4": "poem''s",
    "true": 3
}', '2'),
('Choose the answer which truely completes the sentence.
Faced with petroleum shortages in the 1970''s, scientists and … in the United States stepped up their efforts to develop more efficient heating systems.', '{
    "1": "engineers",
    "2": "engineer",
    "3": "engineers''",
    "4": "engineer''s",
    "true": 2
}', '2'),
('Choose the best answer.
On July 21, 1954, Walt Disney started building his dream park on 160 … in Anaheim, California, not far from Los Angeles', '{
    "1": "acres",
    "2": "acre''s",
    "3": "acre''",
    "4": "acre",
    "true": 4
}', '2'),
('Choose the answer which truely completes the sentence.
He has plenty of … in his library.', '{
    "1": "book''s",
    "2": "books",
    "3": "books''",
    "4": "book",
    "true": 4
}', '2'),
('John Keynes used his … of economics to help his college and himself.', '{
    "1": "knowledges",
    "2": "knowledge''s",
    "3": "a knowledge",
    "4": "knowledge",
    "true": 1
}', '2');

insert into questions(question, question_variants, subject_id) values 
('Sportchilar bir xil 16.2km/soat tezlik bilan uzunligi 20 m20m bo''lgan kolonna tashkil qilib yugurmoqdalar. Ularga qarama-qarshi yo''nalishda murabbiy 3 m/s3m/s tezlik bilan yugurmoqda. Har bir sportchi murabbiy bilan tenglashgach. orqaga burilib yana avvalgi tezligi bilan yugurishni davom ettiriyapti. Hamma sportchilar burilgandan keyin kolonna uzunligi (m)(m) qancha bo''ladi?', '{
    "1": "10",
    "2": "3",
    "3": "4",
    "4": "20",
    "true": 1
}', '3'),
('Sharcha balandligi 10 mm bo''lgan qiya tekislikdan ishqalanishsiz. dumalab tushmoqda. Sharchaning qiya tekislik oxiridagi tezligini (m/s) aniqlang.', '{
    "1": "19.6",
    "2": "14.1",
    "3": "20",
    "4": "10",
    "true": 2
}', '3'),
('Uzunligi 480480 mm bo''lgan poyezd tekis harakatlanib, 720720 mm uzunlikdagi ko''prikdan 22 minutda o''tdi. Poyezdning tezligi qanday?', '{
    "1": "4 m/s",
    "2": "3636 km/soat",
    "3": "10 km/soat",
    "4": "6 m/s",
    "true": 3
}', '3'),
('Quyidagi jumlaning mazmuniga mos ravishda gapni davom ettiring. Notekis harakatda tezlanish vektori ...', '{
    "1": "a < 0 holda moduli va yo''nalishi o''zgarmaydi",
    "2": "moduli va yo''nalishi o''zgarib turadi",
    "3": "a > 0 holda moduli va yo''nalishi o''zgarmaydi",
    "4": "moduli ozgarmas bolib, yonalishi uzluksiz ozgarib turadi",
    "true": 4
}', '3'),
('Mashina ikki punkt orasini 40 km/soat40km/soat tezlik bilan o''tdi. So''ngra tezligini 65 km/soat65km/soat da oshirib yana shuncha yo''l o''tgan. Ikkala holda ham tekis harakat qilgan. O''rtacha tezlikni (km/soat)(km/soat)toping.', '{
    "1": "260",
    "2": "52.5",
    "3": "4.5",
    "4": "130",
    "true": 3
}', '3'),
('Suvi qirg''oqga nisbatan 10.8 km/soat tezlik bilan oqayotgan daryoning kengligi 240 m240m. Tinch suvga nisbatan 14.4km/soat tezlik bilan harakatlana oladigan qayiq qancha vaqtda (min)(min) bu daryoni kesib o''tadi?', '{
    "1": "1.5",
    "2": "2",
    "3": "60",
    "4": "1",
    "true": 3
}', '3'),
('Oqimga qarshi suzayotgan bolaning suvga nisbatan tezligi 1 m/s1m/s, suvning qirg''oqqa nisbatan tezligi 0.5 m/s0.5m/s bo''lsa, bolaning qirg''oqqa nisbatan tezligini aniqlang (km/soat)(km/soat)', '{
    "1": "1.5",
    "2": "1",
    "3": "0.5",
    "4": "1.8",
    "true": 2
}', '3'),
('Qayiq kengligi 240 m240m bo''lgan daryoni kesib suzib o''tmoqda. Agar oqimning tezligi 2 m/s2m/s, qayiqning suvga nisbatan tezligi 3 m/s3m/s bo''lsa, qayiq ikkinchi sohilga o''tishi uchun qanday minimal vaqt (s)(s) zarur bo''ladi?', '{
    "1": "48",
    "2": "40",
    "3": "80",
    "4": "120",
    "true": 2
}', '3'),
('Qandaydir balandlikdan tushayotgan po''lat jismning yerga urilishidagi tezligi 50 m/s50m/s. Agar bunda kinetik energiya to''liq ravishda jismning ichki energiyasiga aylansa, u necha gradusga isiydi? Polatning solishtirma issiqlik sig''imi 500 J/kg\cdot K500J/kg⋅K.', '{
    "1": "25",
    "2": "10",
    "3": "5",
    "4": "2.5",
    "true": 3
}', '3'),
('Tosh tik yuqoriga v = 30 m/sv=30m/s tezlik bilan otildi. Qanday h (m)h(m) balandlikda uning kinetik energiyasi potensial energiyasining k = 3/5k=3/5 qismiga teng bo''ladi?', '{
    "1": "16",
    "2": "10",
    "3": "22",
    "4": "28",
    "true": 3
}', '3');

insert into questions(question, question_variants, subject_id) values 
('Gingko biloba o''simliklarning qaysi bo''limiga mansub?', '{
    "1": "Ochiq urug''lilar",
    "2": "Tuban o''simliklar",
    "3": "Yuksak sporali o''simliklar",
    "4": "Yopiq urug''lilar",
    "true": 1
}', '4'),
('Qaysi o''simliklarning barglari ancha barvaqt to''kiladi?
1) na''matak; 2) nastarin;
3) zarang; 4) tikandaraxt;
5) shamshod; 6) terak.', '{
    "1": "1, 2, 5",
    "2": "4, 5, 6",
    "3": "2, 3, 4",
    "4": "3, 4, 6",
    "true": 2
}', '4'),
('Qaysi o''simliklarning bargi va poyasi yo''q, lekin guli eng yirik gul hisoblanadi.', '{
    "1": "talipot palmasi",
    "2": "volfiya",
    "3": "sekvoyyadendron",
    "4": "raffleziya Arnoldi",
    "true": 1
}', '4'),
('Shakli o''zgargan barg (a) va shakli o''zgargan novda (b) ga ega bo''lgan o''simliklarni belgilang.
1) tokning gajaklari; 2) atirgulning tikani;
3) do''lananing tikani; 4) kaktus tikani;
5) zirkning tikani; 6) qulupnayning gajaklari;
7) no''xatning gajaklari; 8) piyozning seret bargi.', '{
    "1": "a-3, 4, 5; b-1,2, 6",
    "2": "a-2, 4, 7; b-3, 5, 6",
    "3": "a-4, 5, 7; b-1,3, 6",
    "4": "a-4, 5, 8; b-2, 3, 7",
    "true": 2
}', '4'),
('Sanoatda tolalarni ajratishda qaysi organizmdan foydalaniladi?', '{
    "1": "bakteriyalardan",
    "2": "achitqi zamburug''laridan",
    "3": "xlorella suvo''tidan",
    "4": "sianobakteriyalardan",
    "true": 4
}', '4'),
('O''simlik to''qimalari uchun xos ta''riflar to''g''ri berilgan javobni aniqlang.
a) asosiy to''qima; b) mexanik to''qima;
c) qoplovchi to''qima; d) o''tkazuvchi to''qima;
e) hosil qiluvchi to''qima;
1) hujayralari yupqa va elastik xususiyatga ega;
2) tirik zich joylashgan 1 qavat hujayralardan tashkil topgan;
3) qalin qobiqli cho''ziq, tirik hujayralardan tashkil topgan;
4) qalin cho''ziq, tik joylashgan hujayralardan iborat;
5) qalin qobiqli cho''ziq o''lik hujayralardan tashkil topgan.', '{
    "1": "a-1; b-4, 5; c-5; d-3",
    "2": "a-2, 5; b-3; c-4; d-1",
    "3": "b-3, 4; c-2; d-1 ; e-5",
    "4": "b-3, 5; c-2; d-4; e-1",
    "true": 4
}', '4'),
('Qaysi daraxtning shox-shabbasi g''uj bo''lib joylashgan?', '{
    "1": "olma",
    "2": "tol",
    "3": "qarag''ay",
    "4": "qayrag''och",
    "true": 3
}', '4'),
('Quruqlikda o''simliklar biomassasi umumiy biomassaning ... foizini tashkil etadi.', '{
    "1": "1",
    "2": "99",
    "3": "87",
    "4": "66",
    "true": 3
}', '4'),
('Harorati iliq kelgan kuz oylarida ham gullashda davom etadigan madaniy o''simliklarni aniqlang.', '{
    "1": "zubturum, xrizantema",
    "2": "xrizantema, kartoshkagul",
    "3": "kartoshkagul, boqila",
    "4": "moychechak, atirgul",
    "true": 3
}', '4'),
('Guli qulpoyaning uchidagi savatchada joylashgan o''simlikni belgilang.', '{
    "1": "lolaqizg''aldoq",
    "2": "makkajo''xori",
    "3": "zubturum",
    "4": "sabzi",
    "true": 4
}', '4');


insert into questions(question, question_variants, subject_id) values 
('Oqsil gidrolizida qaysi modda hosil bo''lmaydi?', '{
    "1": "22- aminopropankislota",
    "2": "xlorsirka kislota",
    "3": "aminosirka kislota",
    "4": "22- amino - 33-metilbutankislota (valin)",
    "true": 1
}', '5'),
('Konsentrlangan nitrat kislota ta''sirida quyidagi amino kislotalardan qaysi biri jigar rangga bo''yaladi.', '{
    "1": "glikokol",
    "2": "alanin",
    "3": "valin",
    "4": "fenilalanin",
    "true": 2
}', '5'),
('Organik birikmalar sinflari orasida katta ahamiyatga ega bo''lgan oqsillar qaysi sinf birikmalaridan tashkil topadi?', '{
    "1": "oksikislotalar va aminokislotalardan",
    "2": "aminokislotalardan",
    "3": "karbonkislotalar va diaminlardan",
    "4": "aminlar va oddiy efirlarban",
    "true": 2
}', '5'),
('Gidrolizga uchraydigan kimyoviy birikmalar qatorini aniqlang.
1) tuzlar; 2) asoslar; 3) kislotalar; 4) monosaxaridlar;
5) oqsillar; 6) murakkab efirlar; 7) yog''lar', '{
    "1": "1, 2, 3, 41,2,3,4",
    "2": "2,3,6,7",
    "3": "1,5,6,7",
    "4": "2,4,5,6",
    "true": 1
}', '5'),
('Katta odamning sutkalik ratsionida 120120 gg oqsil bo''lishi kеrak. Sutkalik ratsiondagi oqsilning 35% ini tarkibida 21\%21% oqsil bo''lgan no''xatdan olish uchun 11 kunda nеcha gramm no''xat iste''mol qilish kеrak?', '{
    "1": "109",
    "2": "62",
    "3": "200",
    "4": "160",
    "true": 3
}', '5'),
('Laktoalbuminning nisbiy molеkulyar massasi 1630016300 ga tеng. Uning 1010 gg miqdori gidrolizga uchratilganda 11.77811.778 gg turli xil aminokislotalar olindi. Shunday oqsilning molеkulasi tarkibida nеchta aminokislota qoldig''i boladi?', '{
    "1": "140",
    "2": "120",
    "3": "162",
    "4": "161",
    "true": 4
}', '5'),
('Protеin molеkulasi tarkibida 22 atom tеmir bo''lib, uning massa ulushi 0.28% ga tеng. Protеin molеkulasining absolyut massasini (kg) toping.', '{
    "1": "100",
    "2": "40",
    "3": "40000",
    "4": "6.68*100",
    "true": 4
}', '5'),
('Agar oqsil molеkulasi tarkibida ikki atom oltingugurt bo''lib, uning miqdori 0.64% ga tеng bo''lsa, oqsilning molеkulyar massasi qancha?', '{
    "1": "100",
    "2": "5000",
    "3": "100000",
    "4": "10000",
    "true": 3
}', '5'),
('Qaysi moddalar yordamida Byurеt rеaksiyasini amalga oshirish mumkin?
1) oksid; 2) mis (IIII) sulfat; 3) natriy gidroksid;
4) etilspirt; 5) polistirol', '{
    "1": "1,3,4",
    "2": "2,3",
    "3": "2,5",
    "4": "2,4",
    "true": 2
}', '5'),
('Katta odamning sutkalik ratsionida 120g oqsil bo''lishi kerak. Go''shtda oqsilning massa ulushi 20% bo''lsa sutkalik oqsilning 50% ini go''shtdan olish uchun 11 kunda nеcha gramm go''sht istе''mol qilish kеrak?', '{
    "1": "60",
    "2": "300",
    "3": "250",
    "4": "200",
    "true": 2
}', '5');

insert into results(first_subject, second_subject, date, time, user_id, faculty_id, first_subject_id, second_subject_id, first_tests_count, second_tests_count, score_ball) values 
('10', '10', '2022-08-28 17:30:43', '147', '1', '1', '1', '3', '10', '10', '189'),
('10', '10', '2022-08-28 17:30:43', '136', '2', '2', '1', '3', '10', '10', '189'),
('10', '10', '2022-08-28 17:30:43', '100', '3', '3', '1', '3', '10', '10', '189'),
('10', '10', '2022-08-28 17:30:43', '112', '4', '4', '1', '3', '10', '10', '169'),
('10', '10', '2022-08-28 17:30:43', '159', '5', '5', '1', '3', '10', '10', '189');