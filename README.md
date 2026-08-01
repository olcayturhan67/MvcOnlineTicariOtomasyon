# MVC Online Ticari Otomasyon

ASP.NET Core MVC ile geliştirilmiş, işletmelerin temel ticari süreçlerini tek panel üzerinden yönetmesini amaçlayan web tabanlı bir otomasyon projesidir. Uygulama; ürün ve stok takibi, satış, fatura, cari hesap, personel, departman, kargo, mesajlaşma, raporlama ve istatistik işlemlerini içerir.

## Özellikler

- Ürün, kategori ve stok yönetimi
- Ürün arama, listeleme ve sayfalama
- Satış oluşturma, güncelleme ve satış detaylarını görüntüleme
- Fatura ve fatura kalemi yönetimi
- Dinamik olarak fatura oluşturma
- Cari hesap ekleme, güncelleme ve hareketlerini görüntüleme
- Müşteri paneli üzerinden sipariş ve kargo takibi
- Gelen, giden ve silinen mesajların yönetimi
- Personel ve departman yönetimi
- Personel görseli yükleme
- Kargo oluşturma ve takip koduyla sorgulama
- QR kod oluşturma
- Grafikler, istatistikler ve özet tablolar
- Yapılacaklar listesi
- Cookie tabanlı kullanıcı girişi ve rol bazlı yetkilendirme
- Özel hata ve HTTP durum sayfaları
- Docker ile uygulama ve SQL Server kurulumu

## Kullanılan Teknolojiler

### Backend

- C#
- .NET 8
- ASP.NET Core MVC
- Entity Framework Core 8
- Microsoft SQL Server
- LINQ
- Cookie Authentication
- Role-based Authorization

### Frontend

- Razor Views (`.cshtml`)
- HTML5, CSS3 ve JavaScript
- Bootstrap
- jQuery
- DataTables
- AdminLTE ve hazır yönetim paneli bileşenleri

### Kütüphaneler

- **X.PagedList.Mvc.Core:** Sayfalama işlemleri
- **QRCoder:** QR kod üretimi
- **ScottPlot:** Sunucu tarafında grafik oluşturma
- **Newtonsoft.Json:** JSON işlemleri
- **Entity Framework Core Tools/Design:** Migration ve veritabanı geliştirme araçları

### DevOps

- Docker
- Docker Compose
- SQL Server 2022 container

## Proje Yapısı

```text
MvcOnlineTicariOtomasyon/
|-- Controllers/          # HTTP istekleri ve uygulama akışı
|-- Models/
|   `-- Siniflar/         # Entity, DbContext ve ViewModel sınıfları
|-- Views/                # Razor arayüzleri ve partial view'lar
|-- Migrations/           # Entity Framework Core migration dosyaları
|-- wwwroot/              # CSS, JavaScript, görseller ve tema dosyaları
|-- Program.cs            # Servisler, middleware ve route ayarları
|-- appsettings.json      # Uygulama ve bağlantı ayarları
`-- MvcOnlineTicariOtomasyon.csproj

Dockerfile                # Uygulamanın container imajı
docker-compose.yml        # Web uygulaması ve SQL Server servisleri
MvcOnlineTicariOtomasyon.sln
```

## Temel Veri Modelleri

Uygulamada Entity Framework Core üzerinden aşağıdaki temel tablolar yönetilir:

- `Admin`
- `Cari`
- `Kategori`
- `Urun`
- `SatisHareket`
- `Faturalar` ve `FaturaKalem`
- `Personel` ve `Departman`
- `Gider`
- `KargoDetay` ve `KargoTakip`
- `Mesajlar`
- `Yapilacak`

`Context` sınıfı uygulamanın Entity Framework Core veritabanı bağlantısını ve `DbSet` tanımlarını içerir. Controller sınıfları iş akışını yönetir, Razor View dosyaları ise kullanıcı arayüzünü oluşturur.

## Gereksinimler

Yerel kurulum için:

- [.NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)
- SQL Server 2019 veya üzeri
- İsteğe bağlı: Visual Studio 2022

Docker kurulumu için:

- Docker Desktop
- Docker Compose

## Yerel Kurulum

1. Depoyu klonlayın:

   ```bash
   git clone <repository-url>
   cd MvcOnlineTicariOtomasyon
   ```

2. `MvcOnlineTicariOtomasyon/appsettings.json` dosyasındaki `ConnectionStrings:Context` değerini kendi SQL Server bilgilerinizle düzenleyin. Örnek:

   ```json
   {
     "ConnectionStrings": {
       "Context": "Server=localhost;Database=dataproje;Trusted_Connection=True;TrustServerCertificate=True;"
     }
   }
   ```

3. Bağımlılıkları yükleyin:

   ```bash
   dotnet restore
   ```

4. Veritabanını oluşturun veya migration'ları uygulayın:

   ```bash
   dotnet ef database update --project MvcOnlineTicariOtomasyon
   ```

   `dotnet ef` komutu kurulu değilse:

   ```bash
   dotnet tool install --global dotnet-ef
   ```

5. Uygulamayı çalıştırın:

   ```bash
   dotnet run --project MvcOnlineTicariOtomasyon
   ```

6. Terminalde gösterilen `https://localhost:...` adresini tarayıcıda açın.

## Docker ile Çalıştırma

Proje kök dizininde `.env` dosyası oluşturun ve SQL Server için güçlü bir parola belirleyin:

```env
MSSQL_SA_PASSWORD=Guclu_Bir_Parola123!
```

Ardından servisleri oluşturup başlatın:

```bash
docker compose up --build -d
```

Uygulama aşağıdaki adreste çalışır:

```text
http://localhost:8080
```

Servisleri durdurmak için:

```bash
docker compose down
```

Veritabanı verileri `sqlserver_data` adlı Docker volume içerisinde kalıcı olarak saklanır.

## Kimlik Doğrulama ve Yetkilendirme

Uygulamada cookie tabanlı kimlik doğrulama kullanılır. Giriş yapmayan kullanıcılar varsayılan olarak giriş ekranına yönlendirilir. Müşteri paneli `Cari` rolüyle, bazı yönetim işlemleri ise yönetici rolüyle sınırlandırılmıştır.

> Proje ilk kez çalıştırıldığında giriş yapabilmek için veritabanında uygun bir admin veya cari kullanıcı kaydı bulunmalıdır.

## Güvenlik Notları

- Gerçek bağlantı bilgilerini, parolaları ve `.env` dosyasını GitHub'a göndermeyin.
- Üretim ortamında güçlü ve benzersiz bir SQL Server parolası kullanın.
- Hassas ayarları environment variable, .NET User Secrets veya güvenli bir secret manager ile yönetin.
- Canlıya almadan önce varsayılan kullanıcıları ve örnek verileri değiştirin.

## Ekran Görüntüleri

Projeye ait ekran görüntülerini örneğin `docs/screenshots` klasörüne ekledikten sonra bu bölüme yerleştirebilirsiniz:

```markdown
![Yönetim Paneli](docs/screenshots/dashboard.png)
```

## Katkıda Bulunma

1. Projeyi fork edin.
2. Yeni bir özellik dalı oluşturun: `git checkout -b feature/yeni-ozellik`
3. Değişikliklerinizi commit edin: `git commit -m "Yeni özellik eklendi"`
4. Dalınızı gönderin: `git push origin feature/yeni-ozellik`
5. Pull Request açın.

## Lisans

Bu proje için henüz bir lisans belirtilmemiştir. Açık kaynak olarak yayımlamadan önce uygun bir `LICENSE` dosyası ekleyebilirsiniz.
