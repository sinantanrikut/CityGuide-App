//
//  DataService.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 3.06.2022.
//

import Foundation
import Firebase
import FirebaseDatabase



let DB_BASE =  Database.database().reference()
class DataService{
    
    //singleton
    static let instance = DataService()
    
    
    private let categories = [
        Category(title: "Parklar", imageName: "parklar.png"),
        Category(title: "Kütüphaneler", imageName: "kutuphaneler.png"),
        Category(title: "Tarihi Yerler", imageName: "tarihi-yerler.png"),
        Category(title: "Oteller", imageName: "oteller.png"),
        Category(title: "Marketler", imageName: "marketler.png"),
        Category(title: "İbadet Yerleri", imageName: "ibadet-yerleri.png"),
        Category(title: "Otoparklar", imageName: "otoparklar.png")
    ]
    
    
    private let parklar = [
            
        Places(title: "YILDIZ PARKI", imageName: "2.jpg", description: " Beşiktaş ile Ortaköy arasında yer alan, İstanbul merkezindeki en büyük koru olan Yıldız Parkı ziyaretçilerine şehir merkezinde, muhteşem bir doğa ve renk cümbüşü sunuyor. Çadır Köşkü, Malta Köşkü ve Kır Kahvesi’nde yeme içme molası verebileceğiniz gibi, Yıldız Parkı boyunca sıralanmış piknik masalarında ya da ağaçlar altındaki çim alanda piknik imkanı da bulunuyor. Yıldız Parkı’na hem Beşiktaş Ortaköy yolu üzerindeki Çırağan Sarayı’nın karşısından, hem de Balmumcu’dan Ortaköy’e doğru uzanan Palanga Caddesi üzerinden giriş yapılabilir. Yıldız Parkı’na yaya girişi ücretsiz, araç girişi için ücret alınıyor.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
               Places(title: " SELAMİÇEŞME ÖZGÜRLÜK PARKI ", imageName: "3.jpg", description: "1.5 km’lik bisiklet ve koşu pistine, 4 ayrı çocuk parkına, tenis, futbol ve basketbol sahalarına, peyzaj değil gerçek yeşil alan sunan kocaman ağaçlara , çeşitli etkinliklerin düzenlendiği amfi tiyatroya, hayvan heykelleri ile dolu güzel bir gölete ve bu gölete nazır bir şeyler yiyip içebileceğiniz bir kafeye (Fua Cafe & Restaurant) sahip Özgürlük Parkı Selamiçeşme’de bulunuyor. Parka Kadıköy-Fenerbahçe seferlerini yapan FB1 sefer numaralı belediye otobüsleri ile ulaşılabiliyor.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
               Places(title: " BEBEK PARKI ", imageName: "4.jpg", description: " Gazete ekleri ve magazin haberlerinde ünlülerin de çocuklarıyla boy boy pozlarına sıkça rastladığımız, İstanbul’daki en güzel parklar listemizin 4.sü olan Bebek Parkı her kesimden insanlar için İstanbul’un en gözde parklarından biri. Özelikle Avrupa yakasında oturanlar için kolay ulaşılabilir olması ve boğaz kıyısında oluşu Bebek Parkı’nın öne çıkan özellikleri. Bebek’teki mini dondurmacıdan ev yapımı dondurmanızı alıp parkta soluklanmak çok keyifli.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
               Places(title: " KURUÇEŞME CEMİL TOPUZLU PARKI ", imageName: "5.jpg", description: " İstanbul Boğazı’nın kenarındaki parklardan, Muallim Naci Caddesi üzerindeki Cemil Topuzlu Parkı, halk arasında daha çok Kuruçeşme Parkı olarak biliniyor. İstanbul’un en köklü balıkçılarından Park Fora’nın da yer aldığı park özellikle hafta sonları piknikçilere ev sahipliği yapıyor. Ortaköy sahiline 15 dakika yürüyüş mesafesindeki Cemil Topuzlu Parkı’nda küçük bir çocuk parkı da mevcut.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
               Places(title: " FENERBAHÇE PARKI ", imageName: "6.jpg", description: " Şehir merkezinde denizi ve yeşil alanı içiçe bulabileceğiniz ender yerlerden biri olan Fenerbahçe Parkı hem Anadolu yakasında, hem de Avrupa yakasında oturanların toplu taşıma ile dahi kolayca ulaşabileceği bir lokasyonda bulunuyor. Üç tarafı denizle çevrili ormanlık bir alan içindeki Fenerbahçe Parkı’nda denize nazır çimenlere yayılabilir, yine deniz manzaralı tahta masalarda piknik yapabilir ya da park bünyesindeki kafelerden faydalanabilirsiniz. Hafta sonu açık büfe kahvaltı severler için Cafe Romantika oldukça keyifli bir seçenek.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
                   Places(title: " NEZAHAT GÖKYİĞİT BOTANİK PARKI ", imageName: "7.jpg", description: "Ataşehir bölgesindeki beton ormanının ortasında çölde vaha misali süzülen Nezahat Gökyiğit Botanik Parkı botanik bahçeleri, göletleri, çocuk parkı ve piknik alanları ile İstanbullular için konutlarla içiçe olduğu için, kolay ulaşılabilir bir mesafede doğaya kaçış olanağı sunuyor.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
               Places(title: " EMİRGAN KORUSU VE PARKI ", imageName: "8.jpg", description: " Her yıl nisan ayında düzenlenen Lale festivalinini en muhteşem halini gözlemleyebileceğiniz Emirgan Korusu hafta sonu İstanbul’un kargaşasından kaçıp kendini doğanın kollarını bırakmak isteyen İstanbulluların tercih ettiği yeşillik ve ormanlık yerlerin başında geliyor. Emirgan Korusu ve Parkı’nda hem rengârenk çiçeklerle, özel motifeler işlenmiş ağaçlarla ve Boğaz manzarasıyla harika fotoğraflar çektirebilir, hem piknik, hem de 3 adet köşkten birinde kahvaltı keyfi yapabilirsiniz.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
               Places(title: " GÜLHANE PARKI ", imageName: "9.jpg", description: " İstanbul’un en eski parklarından olan ve Sarayburnu ile Sultanahmet arasında uzanan, İstanbul’daki en güzel parklar listemizin 5.si Gülhane Parkı Osmanlı Devleti döneminde Topkapı Sarayı’nın güllerle dolu dış bahçesi olarak kullanılmış ve adını buradan almış. Aynı zamanda Nazım Hikmet’in ceviz ağacı olduğu Gülhane Parkı’ndaki ulu çınar gölgelerinde yazın ortasında bile üşümek mümkün. Bağcılar – Kabataş tramvay hattını kullanıp Sultanahmet’ten bir önceki durak olan Gülhane durağında inebilir, parka girdikten sonra Sarayburnu’nun muhteşem manzarasına doğru uzanan sonbaharda sapsarı yapraklarla döşeli yolda ilerleyebilirsiniz.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
               Places(title: " MİHRABAT KORUSU, KANLICA ", imageName: "10.jpg", description: " İstanbul Anadolu Yakası’nın en güzel korularından biri olan Kanlıca sırtlarındaki Mihrabat Korusu hem ormanın içinde 3 kilometrelik bir yürüyüş parkuruna hem de karşı kıyıda Ortaköy sahili, Rumeli Hisarı, İstinye Koyu’na kadar uzanan muhteşem bir boğaz manzarasına sahip. Çam ağaçlarının sizi hayat dolu kokusuyla karşıladığı Mihrabat Korusu’nda kafe, restoran, özel davet ve organizasyon alanları, geniş bir otopark ve çocuk parkları bulunuyor.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
    
    ]
    

    private let kutuphaneler = [
            
        Places(title: "Atatürk Kitaplığı", imageName: "11.jpg", description: " İstanbul’da ders çalışılacak en güzel yer neresi diye soracak olursanız, gönüllerin şampiyonu Atatürk Kitaplığı derim. Cumhuriyet döneminin ilk kütüphanelerinden olan Atatürk Kitaplığı’nda 500 bine yakın kitap bulunuyor.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
              Places(title: "Beyazıt Devlet Kütüphanesi", imageName: "12.jpg", description: " 1884’te Kütüphane-i Umumi-i Osmani ismiyle kurulan kütüphane, muhteşem bir tarihi yapıda yer alıyor. Beyazıt Devlet Kütüphanesi, Türkiye’de devletin kurduğu ilk kütüphane olmasıyla da büyük bir öneme sahip.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
              Places(title: "Süleymaniye Yazma Eserler Kütüphanesi", imageName: "13.jpg", description: "Tarihe, edebiyata ve özellikle el yazması kitaplara ilgi duyanların mutlaka görmesi gerek bir diğer kütüphane, Süleymaniye Yazma Eserler Kütüphanesi. Yakın zamanda Türkiye Yazma Eserler Kurumu Başkanlığı’na bağlanan kütüphane, yazma eserlerin dijital kopyalarını görüntüleyip, temin edebileceğiniz önemli bir arşiv.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
              Places(title: "İstanbul Araştırmaları Enstitüsü", imageName: "14.jpg", description: " İstanbul hakkında araştırma yapmak isteyenlerin mutlaka uğraması gereken ilk durak İstanbul Araştırmaları Enstitüsü Kütüphanesi. Taksim’de Şişhane metrosuna yakın konumdaki kütüphane yalnızca araştırmacılara ve öğrencilere değil halka da hizmet veriyor.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
              Places(title: "İslam Araştırmaları Merkezi (İSAM)", imageName: "15.jpg", description: "İstanbul Anadolu Yakası’nın en güzel kütüphanesi bence İSAM yani İslâm Araştırmaları Merkezi Kütüphanesi. Türkiye Diyanet Vakfı tarafından 1988’de kurulan İSAM, Üsküdar İcadiye’de İstanbul 29 Mayıs Üniversitesi’nin hemen yanında yer alıyor.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
              Places(title: "Merkezefendi Millet Kıraathanesi (Merkezefendi Şehir Kütüphanesi)", imageName: "16.jpg", description: " Merkezefendi Şehir Kütüphanesi ismiyle kurulan ve Zeytinburnu, Merkezefendi’de yer alan Merkezefendi Millet Kıraathanesi, 24 saat açık kütüphanelerden biri. Cevizlibağ’a yakınlığıyla öne çıkan kütüphane hem metrobüsle hem de Bağcılar-Kabataş tramvay hattıyla olayca ulaşabileceğiniz bir konumda yer alıyor.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
                  Places(title: "Kadın Eserleri Kütüphanesi", imageName: "17.jpg", description: "1990 yılında 5 kadın (Doç. Dr. Füsun Akatlı, Prof. Dr. Jale Baysal, Aslı Davaz, Doç. Dr. Şirin Tekeli ve Füsun Yaraş) tarafından kurulan Kadın Eserleri Kütüphanesi, Balat‘taki tarihi bir binada yer alıyor.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
              Places(title: "Alman Arkeoloji Enstitüsü Kütüphanesi", imageName: "18.jpg", description: " Türkiye’nin en büyük arkeoloji kütüphanesi 56.000 kitap ve 250 bilim dergisiyle Beyoğlu’nda hizmet veriyor. Meraklıları İstanbul kent tarihi, Bizans ve Osmanlı’ya dair tarihi araştırmalara ulaşabilirler.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
              Places(title: "Boğaziçi Üniversitesi Kütüphanesi", imageName: "19.jpg", description: "İstanbul’daki en kapsamlı üniversite kütüphanelerinden biri Boğaziçi Üniversitesi’nin kütüphanesidir. Haftanın her günü ziyaret edilebilen kütüphanede çok geniş bir yelpazede 100.000’in üzerine eser mevcut. Dolayısıyla, aradığınız kitabı burada bulma şansınız epey yüksek.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
              Places(title: " İdris Güllüce Kütüphanesi", imageName: "20.jpg", description: " Anadolu Yakası’nda bulunanların, özellikle de bölgedeki öğrencilerin bizce mutlaka yararlanması gereken, Tuzla’da bulunan İdris Güllüce Kütüphanesi, haftanın yedi günü hizmet veren yararlı kütüphanelerden biri. Geniş bir kitap çeşitliliğine sahip kütüphanede 30.000’in üzerinde kitap bulunuyor.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
    
    ]
    
    
    private let tarihiYerler = [
            
        Places(title: "GALATA KULESİ", imageName: "21.jpg", description: " İstanbul’daki en güzel parklar listemizin ilki Göztepe 60. Yıl Parkı 2013 yılında tematik bir park haline getirildikten sonra rengarenk balıkların yaşadığı özel tasarım akvaryumları, lale ve gül bahçeleri, tik ağacından oyun teknesi, doğal göleti, fıskiyeleri ve her yaş grubundaki çocuklar için ayrı ayrı tasarlanmış oyun alanı ve ekipmanlarıyla Anadolu yakasının en gözde parklarından biri haline geldi. Göztepe’de, Bağdat Caddesi ve Sahil yolu arasında konumlandırılmış 60. Yıl Parkı’nda vakit geçirmek sadece çocuklar için değil, büyükler için de son derece keyifli.", price: "Ücretli", workingHours: "Hafta içi her gün"),
                Places(title: "AYASOFYA ULU CAMİİ", imageName: "22.jpg", description: " Beşiktaş ile Ortaköy arasında yer alan, İstanbul merkezindeki en büyük koru olan Yıldız Parkı ziyaretçilerine şehir merkezinde, muhteşem bir doğa ve renk cümbüşü sunuyor. Çadır Köşkü, Malta Köşkü ve Kır Kahvesi’nde yeme içme molası verebileceğiniz gibi, Yıldız Parkı boyunca sıralanmış piknik masalarında ya da ağaçlar altındaki çim alanda piknik imkanı da bulunuyor. Yıldız Parkı’na hem Beşiktaş Ortaköy yolu üzerindeki Çırağan Sarayı’nın karşısından, hem de Balmumcu’dan Ortaköy’e doğru uzanan Palanga Caddesi üzerinden giriş yapılabilir. Yıldız Parkı’na yaya girişi ücretsiz, araç girişi için ücret alınıyor.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
                Places(title: " KIZ KULESİ ", imageName: "23.jpg", description: "1.5 km’lik bisiklet ve koşu pistine, 4 ayrı çocuk parkına, tenis, futbol ve basketbol sahalarına, peyzaj değil gerçek yeşil alan sunan kocaman ağaçlara , çeşitli etkinliklerin düzenlendiği amfi tiyatroya, hayvan heykelleri ile dolu güzel bir gölete ve bu gölete nazır bir şeyler yiyip içebileceğiniz bir kafeye (Fua Cafe & Restaurant) sahip Özgürlük Parkı Selamiçeşme’de bulunuyor. Parka Kadıköy-Fenerbahçe seferlerini yapan FB1 sefer numaralı belediye otobüsleri ile ulaşılabiliyor.", price: "Ücretli", workingHours: "Hafta içi her gün"),
                Places(title: " BEYLERBEYİ SARAYI", imageName: "24.jpg", description: " Gazete ekleri ve magazin haberlerinde ünlülerin de çocuklarıyla boy boy pozlarına sıkça rastladığımız, İstanbul’daki en güzel parklar listemizin 4.sü olan Bebek Parkı her kesimden insanlar için İstanbul’un en gözde parklarından biri. Özelikle Avrupa yakasında oturanlar için kolay ulaşılabilir olması ve boğaz kıyısında oluşu Bebek Parkı’nın öne çıkan özellikleri. Bebek’teki mini dondurmacıdan ev yapımı dondurmanızı alıp parkta soluklanmak çok keyifli.", price: "Ücretli", workingHours: "Hafta içi her gün"),
                Places(title: " RUMELİ HİSARI ", imageName: "25.jpg", description: " İstanbul Boğazı’nın kenarındaki parklardan, Muallim Naci Caddesi üzerindeki Cemil Topuzlu Parkı, halk arasında daha çok Kuruçeşme Parkı olarak biliniyor. İstanbul’un en köklü balıkçılarından Park Fora’nın da yer aldığı park özellikle hafta sonları piknikçilere ev sahipliği yapıyor. Ortaköy sahiline 15 dakika yürüyüş mesafesindeki Cemil Topuzlu Parkı’nda küçük bir çocuk parkı da mevcut.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
                Places(title: " ANADOLU KAVAĞI ", imageName: "26.jpg", description: " Şehir merkezinde denizi ve yeşil alanı içiçe bulabileceğiniz ender yerlerden biri olan Fenerbahçe Parkı hem Anadolu yakasında, hem de Avrupa yakasında oturanların toplu taşıma ile dahi kolayca ulaşabileceği bir lokasyonda bulunuyor. Üç tarafı denizle çevrili ormanlık bir alan içindeki Fenerbahçe Parkı’nda denize nazır çimenlere yayılabilir, yine deniz manzaralı tahta masalarda piknik yapabilir ya da park bünyesindeki kafelerden faydalanabilirsiniz. Hafta sonu açık büfe kahvaltı severler için Cafe Romantika oldukça keyifli bir seçenek.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
                    Places(title: " HAYDARPAŞA GARI ", imageName: "27.jpg", description: "Ataşehir bölgesindeki beton ormanının ortasında çölde vaha misali süzülen Nezahat Gökyiğit Botanik Parkı botanik bahçeleri, göletleri, çocuk parkı ve piknik alanları ile İstanbullular için konutlarla içiçe olduğu için, kolay ulaşılabilir bir mesafede doğaya kaçış olanağı sunuyor.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
                Places(title: " KÜÇÜKSU KASRI ", imageName: "28.jpg", description: " Her yıl nisan ayında düzenlenen Lale festivalinini en muhteşem halini gözlemleyebileceğiniz Emirgan Korusu hafta sonu İstanbul’un kargaşasından kaçıp kendini doğanın kollarını bırakmak isteyen İstanbulluların tercih ettiği yeşillik ve ormanlık yerlerin başında geliyor. Emirgan Korusu ve Parkı’nda hem rengârenk çiçeklerle, özel motifeler işlenmiş ağaçlarla ve Boğaz manzarasıyla harika fotoğraflar çektirebilir, hem piknik, hem de 3 adet köşkten birinde kahvaltı keyfi yapabilirsiniz.", price: "Ücretli", workingHours: "Hafta içi her gün"),
                Places(title: " BOZDOĞAN KEMERİ ", imageName: "29.jpg", description: " İstanbul’un en eski parklarından olan ve Sarayburnu ile Sultanahmet arasında uzanan, İstanbul’daki en güzel parklar listemizin 5.si Gülhane Parkı Osmanlı Devleti döneminde Topkapı Sarayı’nın güllerle dolu dış bahçesi olarak kullanılmış ve adını buradan almış. Aynı zamanda Nazım Hikmet’in ceviz ağacı olduğu Gülhane Parkı’ndaki ulu çınar gölgelerinde yazın ortasında bile üşümek mümkün. Bağcılar – Kabataş tramvay hattını kullanıp Sultanahmet’ten bir önceki durak olan Gülhane durağında inebilir, parka girdikten sonra Sarayburnu’nun muhteşem manzarasına doğru uzanan sonbaharda sapsarı yapraklarla döşeli yolda ilerleyebilirsiniz.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
                Places(title: " 3.AHMET ÇEŞMESİ ", imageName: "30.jpg", description: " İstanbul Anadolu Yakası’nın en güzel korularından biri olan Kanlıca sırtlarındaki Mihrabat Korusu hem ormanın içinde 3 kilometrelik bir yürüyüş parkuruna hem de karşı kıyıda Ortaköy sahili, Rumeli Hisarı, İstinye Koyu’na kadar uzanan muhteşem bir boğaz manzarasına sahip. Çam ağaçlarının sizi hayat dolu kokusuyla karşıladığı Mihrabat Korusu’nda kafe, restoran, özel davet ve organizasyon alanları, geniş bir otopark ve çocuk parkları bulunuyor.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),

    
    ]
    
    
    private let oteller = [
            
        Places(title: " The House Hotel Bosphorus ", imageName: "31.jpg", description: " Boğaz’ın muhteşem manzarasına sahip özenle restore edilmiş bu butik otel, çağdaş tasarım ve 19. yüzyıl mimarisini birleştirmektedir. Ortaköy’deki restoran ve dükkanlara yakın bir konuma sahiptir. House Hotel Bosphorus odaları havadar ve modern olup, her birinde uydu TV ve minibar bulunmaktadır. Tüm odalar, yüksek tavan ve süslü duvarlarıyla, otelin özgün niteliğine uygun olarak dizayn edilmiştir.", price: "Ücretli", workingHours: "Hafta içi her gün"),
               Places(title: " Swissotel The Bosphorus ", imageName: "32.jpg", description: "Swissotel The Bosphorus, Dünya’nın Önde Gelen Otelleri (Leading Hotels of the World) üyesi de olan lüks bir oteldir. İstanbul’un merkezinde güzel bir konumda yer alan, geniş bahçelerle çevrili bu 5 yıldızlı tesis, Boğaz’ın muhteşem manzaralarını sunmaktadır. Tesis genelinde ücretsiz Wi-Fi erişimi mevcuttur. Ferah ve şık konuk odalarının çoğu, tarihi şehrin ve Boğaz’ın harika manzaralarına bakmaktadır. Odalar geleneksel Avrupa tarzında dekore edilmiştir ve lüks banyolara sahiptir.", price: "Ücretli", workingHours: "Hafta içi her gün"),
               Places(title: " The Marmara Taksim ", imageName: "33.jpg", description: "The Marmara Hotel, İstanbul’un hareketli Taksim Meydanı üzerinde yükselmektedir. Otelin lüks odaları kablo TV ve ücretsiz Wi-Fi erişimiyle donatılmıştır. Odalardan muhteşem Boğaz ve şehir manzaralarını izleyebilirsiniz. Açık havuz terasına sahip otelin spa alanında Türk hamamı vardır. The Marmara Taksim’in halı kaplı zeminlere sahip geniş odalarında gömme dolap ve çalışma masası vardır. En-suite mermer banyolar küvet ve saç kurutma makinesi ile donatılmıştır.", price: "Ücretli", workingHours: "Hafta içi her gün"),
               Places(title: " Shangri-La Bosphorus", imageName: "34.jpg", description: " Boğaz’ın Avrupa kıyısındaki Shangri-La Bosphorus, İstanbul, Dolmabahçe Sarayı ile Deniz Müzesi’nin arasında yer almaktadır. CHI, The Spa tesisinin yanı sıra kapalı bir yüzme havuzuna ev sahipliği yapan otelin odaları, modern olanaklarla zarif bir şekilde dekore edilmiştir. Odalara Asya’ya özgü unsurlara sahip çağdaş bir dekor hakimdir. Odaların her birinde yüksek teknoloji ürünleri, ücretsiz hızlı internet, düz ekran TV ve iPod yuvası yer alır. Mermer banyolarda ısıtmalı zeminler ve Bvlgari marka banyo malzemeleri vardır.", price: "Ücretli", workingHours: "Hafta içi her gün"),
               Places(title: " The Ritz Carlton", imageName: "35.jpg", description: " Şehir ve İstanbul Boğazı’nın pitoresk manzaralarına sahip The Ritz-Carlton, İstanbul; şehrin kalbinde yer alır. Tesis genelinde ücretsiz hızlı internet erişiminden yararlanabilirsiniz. Bu 5 yıldızlı otelden Sultanahmet, Topkapı Sarayı, Sultanahmet Cami ve Kapalı Çarşı gibi eski kentin ünlü cazibe noktalarına arabayla sadece 15 dakikada ulaşılabilir. The Ritz-Carlton’ın lüks mobilyalarla zarif bir şekilde dekore edilmiş tüm konaklama birimlerinde konforlu koltuklar içeren oturma alanı ve süslü çekmeceler göze çarpar. Tamamen mermerden yapılmış banyoda ayrı yağmur duşu, derin küvet, seçkin Asprey banyo malzemeleri ve yumuşak havlu bornoz ile terlikler mevcuttur. Manzara eşliğinde ücretsiz günlük gazetenizi okurken odanızdaki Nespresso makinesinde hazırlayabileceğiniz kahvenizi yudumlayabilirsiniz.", price: "Ücretli", workingHours: "Hafta içi her gün"),
               Places(title: " Grand Hyatt ", imageName: "36.jpg", description: " Şehrin merkezinde hizmet veren bu lüks İstanbul oteli, Taksim Meydanı’na ve ana kongre ve sergi merkezlerine yürüme mesafesindedir. Otelde modern toplantı salonları ve açık yüzme havuzunun yanı sıra spa ve fitness merkezi bulunmaktadır. Grand Hyatt İstanbul, açık renklerde dekore edilmiş lüks odalara sahiptir. Tüm odalarda oturma alanı, LCD TV ve çalışma alanı mevcuttur. Mermer banyolarda küvet ve cam kaplı yağmur duş bulunur.", price: "Ücretli", workingHours: "Hafta içi her gün"),
                   Places(title: " Cvk Park Bosphorus", imageName: "37.jpg", description: " Ekim 2013’te inşa edilen ve şehir merkezinin kalbinde yer alan CVK Park Bosphorus Hotel İstanbul, Taksim Meydanı’na sadece 150 metre uzaklıktadır. Şık iç mekanlara sahip olan otelin konukları, 2 yüzme havuzundan ve 8500 m²lik alanda hizmet veren kapsamlı Safira Spa Centre’dan faydalanabilirler. Ayrıca sauna, Türk hamamı, buhar odası ve masaj olanakları mevcuttur. CVK Park Bosphorus Hotel İstanbul’un lüks odalarında LCD TV, ücretsiz WiFi ve ücretsiz çay-kahve yapma imkanı eşliğinde elektrikli su ısıtıcısı bulunmaktadır. Odalardan bazıları spa küvetlidir. Ayrıca bazı odalar deniz, şehir veya bahçe manzarası sunar.", price: "Ücretli", workingHours: "Hafta içi her gün"),
               Places(title: " Four Seasons Bosphorus", imageName: "38.jpg", description: " Boğaz’da yer alan 19. yüzyıldan kalma yenilenmiş Osmanlı sarayı, lüks detaylarla uyum içinde olan tarihi bir mimariye sahiptir. Otelde ücretsiz şemsiye ve şezlonglarla donatılmış ısıtmalı açık havuz ve kapalı havuz bulunmaktadır. Deniz kıyısındaki tesiste ayrıca panoramik Boğaz manzaralı geniş bir teras ve bir bahçe vardır. Kaliteli mobilyalarla zevkli bir tarzda dekore edilmiş klimalı odaların tümünde iPod yuvası ve düz ekran uydu TV mevcuttur. Ayrıca minibar, kasa ve çalışma masası bulunmaktadır.", price: "Ücretli", workingHours: "Hafta içi her gün"),
               Places(title: " Hilton İstanbul Bosphorus", imageName: "39.jpg", description: " Beş yıldızlı bu otel, İstanbul’un Avrupa yakasında Boğaz’a nazır bir konumda hizmet vermektedir. Tesiste kapalı ve açık havuz, yemyeşil bir bahçe, geleneksel bir Türk hamamı ve 7 restoran ve bar seçeneği vardır. Hilton İstanbul Bosphrous’un aydınlık odalarında bahçe ya da Boğaz’a bakan balkonlar vardır. Birimler Türk işi detaylar içeren geleneksel dekora sahiptir. Odaların hepsi geniş pencerelidir ve ayrı bir oturma alanı, ışık geçirmeyen perdeler ve mermer banyolar sağlamaktadır. Executive Odalar, gün boyu atıştırmalıklar ve içecekler servis eden Executive Lounge’a ücretsiz erişimden yararlanabilir.", price: "Ücretli", workingHours: "Hafta içi her gün"),
               Places(title: " Çırağan Palace Kempinski", imageName: "40.jpg", description: " Bu 5 yıldızlı otel 19. yüzyıldan kalma bir Osmanlı sarayında yer almakta olup Boğaz manzaralı sonsuzluk havuzuna sahiptir. Ücretsiz Wi-Fi erişimli şık konuk odaları ile hizmet veren otelde spa ve sağlıklı yaşam merkezi vardır. Çırağan Palace Kempinski İstanbul’un odalarında lüks nevresimler ve boydan boya pencereler mevcuttur. Odalar, uydu TV ve minibar ile donatılmıştır. Ayrıca her odada bahçe veya deniz manzaralı balkon bulunmaktadır.", price: "Ücretli", workingHours: "Hafta içi her gün"),
    
    ]
    
    
    private let marketler = [
            
        Places(title: " GALATAPORT ", imageName: "41.jpg", description: "Galataport, İstanbul’da kruvaziyer gemilerine hizmet veren bir liman olarak Karaköy‘de konumlanıyor. Galataport uzun yıllar süren bir restorasyon çalışmasından sonra dev bir aktivite ve alışveriş alanı olarak ziyarete açıldı.", price: "Ücretli", workingHours: "Hafta içi her gün"),
               Places(title: " ATAKÖY GALLERIA AVM", imageName: "42.jpg", description: " Türkiye’nin ilk büyük alışveriş merkezi olan Ataköy Galleria AVM, 1988 yılından beri Bakırköy ilçesinde hizmet veriyor.", price: "Ücretli", workingHours: "Hafta içi her gün"),
               Places(title: " İSTANBUL CEVAHİR AVM ", imageName: "43.jpg", description: " Avrupa’nın 2, dünyanın 8’nci büyük AVM’si olan İstanbul Cevahir AVM, 2005 yılından beri Mediciyeköy ve Şişli semtlerinden bolca ziyaretçi çekiyor.", price: "Ücretli", workingHours: "Hafta içi her gün"),
               Places(title: " PROFİLO AVM ", imageName: "44.jpg", description: " Profilo AVM, Cevahir ve Kanyon gibi devasa AVM’ler ile büyüklük açısından kıyaslanamazsa da; Mecidiyeköy tarafında çalışan, yaşayan ve yolu Şişli’den geçenler için önemli AVM’ler arasında yerini alıyor.", price: "Ücretli", workingHours: "Hafta içi her gün"),
               Places(title: " KANYON  ", imageName: "45.jpg", description: " Açık alan AVM’lerinin öncüsü olan Kanyon, hem farklı atmosferi hem de lüks markalarıyla dikkat çekiyor. Metroyla direkt kapısına kadar ulaşım sağlanabilen Kanyon’da, sinema ve tiyatronun dışında düzenlenen konserler ve çeşitli festivaller eğlenceye farklı renkler katıyor.", price: "Ücretli", workingHours: "Hafta içi her gün"),
               Places(title: " İSTİNYE PARK ", imageName: "46.jpg", description: " 280 farklı mağazası, açık ve kapalı mekanları ile fark yaratan İstinye Park, 2007’den beri hizmet veriyor. İstinye Park AVM, Türkiye’ye ilk kez giriş yapan birçok lüks firmanın dükkanlarına da ev sahipliği yapıyor.", price: "Ücretli", workingHours: "Hafta içi her gün"),
                   Places(title: " HISTORIA ", imageName: "47.jpg", description: " Historia, İstanbul’un orta büyüklükteki alışveriş merkezlerinden biri. Tarihi Yarımada‘nın kalbinde bulunan Historia her ne kadar mütevazı boyutlara sahip olsa da genel anlamda alışveriş yapmak istyenlerin tüm ihtiyaçlarını karşılayacak donanıma sahip.", price: "Ücretli", workingHours: "Hafta içi her gün"),
               Places(title: " MALL OF ISTANBUL ", imageName: "48.jpg", description: " Ofis, rezidans ve oteliyle bir bütün olan Mall of İstanbul, İstanbul’un gelişen noktalarından Başakşehir’de yer alıyor. Türkiye’nin en büyük alışveriş, eğlence ve yaşam merkezi sloganıyla 2014’te açılan Mall of Istanbul’da 350 mağaza bulunuyor.", price: "Ücretli", workingHours: "Hafta içi her gün"),
               Places(title: " MARMARA FORUM ", imageName: "49.jpg", description: " Çocuklar için özel etkinlikler düzenleyen Marmara Çocuk Kulübü’nün etkinlikleriyle renklenen Marmara Forum, şehrin içindeki en iyi AVM’ler arasındaki yerini koruyor.", price: "Ücretli", workingHours: "Hafta içi her gün"),
               Places(title: " FORUM İSTANBUL ", imageName: "50.jpg", description: " Dünyaca ünlü markaları bir araya getiren, İstanbul Sea Life Akvaryumu ile gezilmeye değer bir deneyim sunan Forum İstanbul, önemli ev dekorasyon, yapı market ve spor mağazalarına da ev sahipliği yapıyor.", price: "Ücretli", workingHours: "Hafta içi her gün"),

    
    ]
    
    
    private let ibadetYerleri = [
            
        Places(title: " Ayasofya ", imageName: "51.jpg", description: " Bizans tarihçilerine göre ilk Ayasofya, İmparator Büyük Konstantin’in oğlu Konstantinus tarafından 390 yılında yaptırıldı. Bazilika planlı olan ilk yapı ahşap malzemeyle yapılmıştı ve bütünüyle yandı. Bugünkü Ayasofya’nın yapımına ise 532 yılında İmparator Iustinianus zamanında başlandı ve 537’de ibadete açıldı. İki mimar birlikte çalıştı: Miletoslu İsidoros ve Trallesli Anthemios.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
           Places(title: "Arap Camii", imageName: "52.jpg", description: " Arapların 716-717 yılında kenti kuşatması sırasında yapıldığı rivayet ediliyor. Ancak adı bu kuşatmadan değil, 15. yüzyılda İspanya’dan göçe zorlanarak İstanbul’a gelip cami çevresine yerleşen Endülüs Araplarından geliyor. Bazı duvar kalıntılarından hareketle, Arap Camii'nin yerinde eskiden kilise olduğu tahmin ediliyor. Bu kalıntıların üzerine 13. yüzyılda Latinler tarafından San Paolo Kilisesi inşa edildi. Bu sırada Galata, İtalyan ticaret şehirlerinden Cenova’nın yönetimindeydi.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
           Places(title: " Fatih Camii", imageName: "53.jpg", description: " II. Mehmet (Fatih) tarafından 1463-1470 tarihleri arasında Mimar Atik Sinan’a yaptırılan Fatih Külliyesi cami, medrese, darüşşifa, tabhane, imaret, kervansaray, sübyan mektebi, kitaplık, hamam, Saraçlar Çarşısı, Deve Hanı ve türbelerden oluşuyordu. Caminin yerinde Bizans dönemine ait Havariyun Kilisesi bulunuyordu. 1509, 1557, 1754 depremlerinde hasar görüp onarılan caminin kubbesi 1766 yılındaki büyük depremde tamamen çöktü, duvarları yıkıldı.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
           Places(title: " Süleymaniye Camii ", imageName: "54.jpg", description: " Mimar Sinan’ın 1550-1557 yılları arasında, I. Süleyman’ın (Kanuni) emriyle yaptığı Süleymaniye Külliyesi mimarisi, ekonomik ve kültürel işleviyle klasik dönemin simgesidir adeta. Yaklaşık 60 dönümlük engebeli alan üzerinde, geometrik bir düzen içinde yerleştirilen yapılar; cami, medreseler, türbeler, türbedar dairesi, darülhadis, tıp medresesi, darüşşifa, bimarhane, darülkurra, sübyan mektebi, imaret, tabhane, han, hamam, kitaplık ve pek çok dükkândan oluşan koca bir semt gibidir. Ve bu semti günümüzde yarıya yakını kapalı 11 kapısı bulunan dış avlu olanca ferahlığıyla çevreliyor.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
           Places(title: "Sultanahmet Camii", imageName: "55.jpg", description: " Sultan I. Ahmet tarafından yaptırılan, temelini 1609 yılında bizzat padişahın attığı Sultanahmet Camii 1617 yılında tamamlandı. Mimarbaşı Mehmet Ağa’nın yönetiminde yapılan cami, klasik üslupta olmakla birlikte, getirdiği yeniliklerle de Osmanlı mimarisinde özgün bir yeri olmasıyla dikkat çekiyor.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
           Places(title: " Eyüp Sultan Camii", imageName: "56.jpg", description: " Eyüp Sultan Camii II. Mehmet’in (Fatih) İstanbul’u aldıktan sonra yaptırdığı ilk yapı topluluğu olması açısından önemli. Külliye 1458’de yapıldı. Külliye için burasının seçilmesinin nedeniyse Hz. Muhammed’in alemdarı Ebu Eyyub Ensari’nin bu civarda gömülü olduğunun tahmin edilmesi. Ebu Eyyub Ensari’nin kabri olarak bilinen yere, külliyenin yapımı sırasında bir de türbe yapıldı.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
               Places(title: " Ortaköy Camii", imageName: "57.jpg", description: " Bir adı da Büyük Mecidiye Camii. Abdülmecit tarafından 1853 yılında Mimar Nigoğos Balyan’a yaptırılan cami Ortaköy İskelesi yanındadır. Tek kubbeli, iki ince minareli, barok üsluptaki yapının duvarları ak kesme taştan, mihrap mozaik ve mermer, minberi somaki mermerden yapılmış. Caminin 1894 depreminde hasar alan minarelerinin petek ve külahı yeniden yapıldı.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
           Places(title: "Zülfaris Sinagogu", imageName: "58.jpg", description: " İstanbul'da Karaköy'de bulunan sinagog, Hahambaşılık kayıtlarında “Kal Kadoş Galata” adıyla geçen sinagogun Galata’da 17. yüzyıldan beri mevcut olduğu biliniyor. Sinagogun bugünkü binası 19. yüzyılda yapıldı. Sinagogun adı, bulunduğu sokağın eski adı olan “Zülfi Arus”tan geliyor. 1905, 1962 yılında iki önemli onarım geçiren Zülfaris Sinagogu 1978 sonuna doğru yalnız cumartesi günleri açık tutuluyordu.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
           Places(title: " Aşkenaz Sinagogu", imageName: "59.jpg", description: " Avusturya kökenli Aşkenazlar tarafından 1900 yılında yaptırıldı. Sayıları binin altına düşen Aşkenaz ritine mensup Musevilerin, bir zamanlar İstanbul’da bulunan birkaç sinagogundan halen hizmette kalan tek sinagogdur. Avrupa stili cephesi ve Polonya etkili tahta pagoda stilindeki “ehal” ve “teva”sı ( dua kürsüsü) ile geleneksel Sefarad ve Romaniot sinagoglarından farklı bir görünüm arz eder.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),
           Places(title: " Neve Şalom Sinagogu", imageName: "60.jpg", description: " Galata’da Büyükhendek Caddesi üzerindeki Neve Şalom Sinagogu 1951 yılında kuruldu. Adının kelime anlamı; “barış vahası”.Modern ve görkemli yapısında hizmet veren Neve Şalom, İstanbul’daki en büyük Sefarad sinagogu olma özelliği taşıyor.  Sinagogda, şabat duaları dışında “Bar Mitzva”, düğün, “Brit-Mila” ve cenaze gibi dini törenler gerçekleştiriliyor.", price: "Ücretsiz", workingHours: "Hafta içi her gün"),

    
    ]
    
    private let otoparklar = [
            
        Places(title: " ADA OTOPARK ", imageName: "61.jpg", description: "Otopark, motorlu taşıtları toplu halde park etme için açık ya da kapalı alandır. Birçok belediye, binalar için minimum sayıda park yeri gerektirir.", price: "Ücretli", workingHours: "Hafta içi her gün"),
             Places(title: " PARKTURK ", imageName: "61.jpg", description: "Otopark, motorlu taşıtları toplu halde park etme için açık ya da kapalı alandır. Birçok belediye, binalar için minimum sayıda park yeri gerektirir.", price: "Ücretli", workingHours: "Hafta içi her gün"),
             Places(title: " YÜCEL OTOPARK ", imageName: "61.jpg", description: "Otopark, motorlu taşıtları toplu halde park etme için açık ya da kapalı alandır. Birçok belediye, binalar için minimum sayıda park yeri gerektirir.", price: "Ücretli", workingHours: "Hafta içi her gün"),
             Places(title: " AZMET OTOPARK ", imageName: "61.jpg", description: "Otopark, motorlu taşıtları toplu halde park etme için açık ya da kapalı alandır. Birçok belediye, binalar için minimum sayıda park yeri gerektirir.",price: "Ücretli", workingHours: "Hafta içi her gün"),
             Places(title: " SANCAK OTOPARK  ", imageName: "61.jpg", description: "Otopark, motorlu taşıtları toplu halde park etme için açık ya da kapalı alandır. Birçok belediye, binalar için minimum sayıda park yeri gerektirir.", price: "Ücretli", workingHours: "Hafta içi her gün"),
             Places(title: " BİRLİK OTOPARK  ", imageName: "61.jpg", description: "Otopark, motorlu taşıtları toplu halde park etme için açık ya da kapalı alandır. Birçok belediye, binalar için minimum sayıda park yeri gerektirir.",price: "Ücretli", workingHours: "Hafta içi her gün"),
                 Places(title: " ZALOĞLU OTOPARKI ", imageName: "61.jpg", description: "Otopark, motorlu taşıtları toplu halde park etme için açık ya da kapalı alandır. Birçok belediye, binalar için minimum sayıda park yeri gerektirir.", price: "Ücretli", workingHours: "Hafta içi her gün"),
             Places(title: " SEDEF TIR GARAJI ", imageName: "61.jpg", description: "Otopark, motorlu taşıtları toplu halde park etme için açık ya da kapalı alandır. Birçok belediye, binalar için minimum sayıda park yeri gerektirir.", price: "Ücretli", workingHours: "Hafta içi her gün"),
             Places(title: " PARK POINT ", imageName: "61.jpg", description: "Otopark, motorlu taşıtları toplu halde park etme için açık ya da kapalı alandır. Birçok belediye, binalar için minimum sayıda park yeri gerektirir.", price: "Ücretli", workingHours: "Hafta içi her gün"),
             Places(title: " OĞUZHAN OTOPARKI ", imageName: "61.jpg", description: "Otopark, motorlu taşıtları toplu halde park etme için açık ya da kapalı alandır. Birçok belediye, binalar için minimum sayıda park yeri gerektirir.",price: "Ücretli", workingHours: "Hafta içi her gün"),

    
    ]
    
    
    //Tanımlamaları yaptık.
    
    //Kategori için getter yaprık
    func getCategories() -> [Category]{
        return categories
    }
    
    func getParklar() -> [Places]{
        return parklar
        
    }
    
    func getKutuphaneler() -> [Places]{
        return kutuphaneler
        
    }
    func getTarihiYerler() -> [Places]{
        return tarihiYerler
        
    }
    func getOteller() -> [Places]{
        return oteller
        
    }
    func getMarketler() -> [Places]{
        return marketler
        
    }
    func getIbadetYerleri() -> [Places]{
        return ibadetYerleri
        
    }
    func getotoparklar() -> [Places]{
        return otoparklar
        
    }

    
    func getPlaces(forCategoryTitle title:String) -> [Places]{
        switch title{
            case "Parklar":
                return getParklar()
            case "Kütüphaneler":
                return getKutuphaneler()
            case "Tarihi Yerler":
                return getTarihiYerler()
            case "Oteller":
                return getOteller()
            case "Marketler":
                return getMarketler()
            case "İbadet Yerleri":
                return getIbadetYerleri()
            case "Otoparklar":
                return getotoparklar()
        default:
            return getOteller()
        }}
    
    
    

    }
    

