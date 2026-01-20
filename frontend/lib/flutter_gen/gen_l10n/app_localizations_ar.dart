// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'تطبيق متعدد البائعين';

  @override
  String get welcome => 'مرحبا';

  @override
  String get home => 'الرئيسية';

  @override
  String get categories => 'الفئات';

  @override
  String get cart => 'عربة التسوق';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get shops => 'المتاجر';

  @override
  String get products => 'المنتجات';

  @override
  String get orders => 'الطلبات';

  @override
  String get settings => 'الإعدادات';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get signup => 'إنشاء حساب';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get search => 'بحث';

  @override
  String get price => 'السعر';

  @override
  String get addToCart => 'أضف إلى السلة';

  @override
  String get buyNow => 'اشتر الآن';

  @override
  String get description => 'الوصف';

  @override
  String get reviews => 'التقييمات';

  @override
  String get total => 'المجموع';

  @override
  String get checkout => 'الدفع';

  @override
  String get orderHistory => 'سجل الطلبات';

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get inventory => 'المخزون';

  @override
  String get sales => 'المبيعات';

  @override
  String get ads => 'الإعلانات';

  @override
  String get shopInfo => 'معلومات المتجر';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get error => 'خطأ';

  @override
  String get success => 'نجاح';

  @override
  String get noInternet => 'لا يوجد اتصال بالإنترنت';

  @override
  String get language => 'اللغة';

  @override
  String get popularProducts => 'المنتجات الشائعة';

  @override
  String get showAll => 'عرض الكل';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get searchHint => 'ابحث عن منتجات، متاجر...';

  @override
  String get sponsored => 'مميز';

  @override
  String get shopNow => 'تسوق الآن';

  @override
  String get welcomeBack => 'مرحباً بعودتك،';

  @override
  String get today => 'اليوم';

  @override
  String get totalProductsCount => 'إجمالي المنتجات';

  @override
  String get totalOrdersCount => 'إجمالي الطلبات';

  @override
  String get totalRevenue => 'إجمالي الإيرادات';

  @override
  String get activeCustomers => 'العملاء النشطون';

  @override
  String get salesOverTime => 'المبيعات بمرور الوقت';

  @override
  String get monthlyOrderCount => 'عدد الطلبات الشهري';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get googleSignIn => 'تسجيل الدخول باستخدام جوجل';

  @override
  String get googleSignUp => 'إنشاء حساب باستخدام جوجل';

  @override
  String get summerCollection => 'مجموعة الصيف';

  @override
  String get discount50 => 'خصم 50% الآن';

  @override
  String get newArrivals => 'وصل حديثاً';

  @override
  String get checkNow => 'تحقق الآن';

  @override
  String get exclusiveDeals => 'عروض حصرية';

  @override
  String get limitedTime => 'وقت محدود';

  @override
  String get beautySale => 'تخفيضات التجميل';

  @override
  String get upTo70Off => 'خصم يصل إلى 70%';

  @override
  String get techDeals => 'عروض التقنية';

  @override
  String get latestGadgets => 'أحدث الأجهزة';

  @override
  String get homeDecor => 'ديكور المنزل';

  @override
  String get modernFurniture => 'أثاث عصري';

  @override
  String get fitnessGear => 'معدات اللياقة';

  @override
  String get stayActive => 'حافظ على نشاطك';

  @override
  String get bookFair => 'معرض الكتاب';

  @override
  String get bestSellers => 'الأكثر مبيعاً';

  @override
  String get fashionWeek => 'أسبوع الموضة';

  @override
  String get trendyStyles => 'ستايلات عصرية';

  @override
  String get gamingZone => 'منطقة الألعاب';

  @override
  String get newConsoles => 'أجهزة ألعاب جديدة';

  @override
  String get kitchenware => 'أدوات المطبخ';

  @override
  String get premiumCookware => 'أواني طبخ مميزة';

  @override
  String get smartWatches => 'ساعات ذكية';

  @override
  String get healthTracking => 'تتبع الصحة';

  @override
  String get audioGear => 'معدات صوتية';

  @override
  String get premiumSound => 'صوت ممتاز';

  @override
  String get productDetails => 'تفاصيل المنتج';

  @override
  String get inStock => 'متوفر';

  @override
  String get outOfStock => 'غير متوفر';

  @override
  String get available => 'متاح';

  @override
  String get unavailable => 'غير متاح';

  @override
  String get selectQuantity => 'اختر الكمية';

  @override
  String stockCount(String count) {
    return 'المخزون: $count';
  }

  @override
  String get rateThisProduct => 'قيم هذا المنتج';

  @override
  String get tapStarsToRate => 'اضغط على النجوم للتقييم';

  @override
  String youRated(String rating) {
    return 'لقد قمت بتقييم $rating نجوم';
  }

  @override
  String addedToCart(String count) {
    return 'تم إضافة $count عناصر إلى السلة';
  }

  @override
  String get welcomeBackTitle => 'مرحباً بعودتك';

  @override
  String get signInSubtitle => 'سجل الدخول للمتابعة إلى حسابك';

  @override
  String get emailAddress => 'عنوان البريد الإلكتروني';

  @override
  String get rememberMe => 'تذكرني';

  @override
  String get forgotPassword => 'هل نسيت كلمة السر؟';

  @override
  String get noAccount => 'ليس لديك حساب؟ ';

  @override
  String get createAccountTitle => 'إنشاء حساب';

  @override
  String get joinCommunity => 'انضم إلى مجتمعنا اليوم';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get address => 'العنوان';

  @override
  String get createPassword => 'أنشئ كلمة مرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get passwordsDoNotMatch => 'كلمات المرور غير متطابقة';

  @override
  String get accountCreated => 'تم إنشاء الحساب بنجاح!';

  @override
  String get orContinueWith => 'أو المتابعة باستخدام';

  @override
  String get orSignUpWith => 'أو التسجيل باستخدام';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟ ';

  @override
  String get fillAllFields => 'يرجى ملء جميع الحقول';

  @override
  String get invalidCredentials => 'البريد الإلكتروني أو كلمة المرور غير صالحة';

  @override
  String get welcomeShopOwner =>
      'مرحباً بك، صاحب المتجر! تم تسجيل الدخول بنجاح!';

  @override
  String get myCart => 'سلتي';

  @override
  String itemsCount(Object count) {
    return '$count منتجات';
  }

  @override
  String get clearCartTitle => 'مسح السلة؟';

  @override
  String get clearCartConfirm =>
      'هل أنت متأكد أنك تريد إزالة جميع العناصر من سلتك؟';

  @override
  String get clearAll => 'مسح الكل';

  @override
  String get personalProfile => 'الملف الشخصي';

  @override
  String get orderPlacedSuccessfully => 'تم تقديم الطلب بنجاح!';

  @override
  String itemRemoved(String name) {
    return 'تمت إزالة $name من السلة';
  }

  @override
  String get emptyCart => 'سلتك فارغة';

  @override
  String get emptyCartSubtitle =>
      'يبدو أنك لم تضف أي منتجات إلى سلتك بعد. ابدأ التسوق لملئها!';

  @override
  String get startShopping => 'ابدأ التسوق';

  @override
  String get proceedToCheckout => 'المتابعة إلى الدفع';

  @override
  String get continueShopping => 'متابعة التسوق';

  @override
  String get orderSummary => 'ملخص الطلب';

  @override
  String get subtotal => 'المجموع الفرعي';

  @override
  String get shipping => 'الشحن';

  @override
  String get orderSuccess => 'تم تقديم الطلب بنجاح!';

  @override
  String willBeCharged(String amount) {
    return 'سيتم خصم $amount';
  }

  @override
  String productDescription(String name) {
    return '$name عالي الجودة مصمم لأداء استثنائي. مصنوع من مواد ممتازة مع الاهتمام بالتفاصيل، يوفر هذا المنتج الموثوقية والأناقة. مثالي للاستخدام اليومي مع ميزات تعزز تجربتك.';
  }

  @override
  String stockStatus(String status) {
    return 'المخزون: $status';
  }

  @override
  String get electronics => 'إلكترونيات';

  @override
  String get accessories => 'إكسسوارات';

  @override
  String get cosmetics => 'مستحضرات التجميل';

  @override
  String get groceries => 'بقالة';

  @override
  String get fashion => 'أزياء';

  @override
  String get featuredShops => 'المتاجر المميزة';

  @override
  String get visitShop => 'زيارة المتجر';

  @override
  String get seeAll => 'مشاهدة الكل';

  @override
  String get management => 'الإدارة';

  @override
  String get ordersManagement => 'إدارة الطلبات';

  @override
  String get revenue => 'الإيرادات';

  @override
  String get rating => 'التقييم';

  @override
  String get manageProducts => 'إدارة المنتجات';

  @override
  String get manageProductsSubtitle => 'إضافة أو تعديل أو حذف المنتجات';

  @override
  String get manageAds => 'إدارة الإعلانات';

  @override
  String get manageAdsSubtitle => 'إنشاء وتتبع الإعلانات';

  @override
  String get manageInventory => 'إدارة المخزون';

  @override
  String get manageInventorySubtitle => 'تتبع المخزون والإمدادات';

  @override
  String get viewAllOrders => 'عرض جميع الطلبات';

  @override
  String get viewAllOrdersSubtitle => 'عرض سجل الطلبات الكامل';

  @override
  String get shopInfoSubtitle => 'إدارة تفاصيل متجرك';

  @override
  String get shopOwner => 'صاحب المتجر';

  @override
  String get exportAllOrders => 'تصدير كل الطلبات';

  @override
  String get refreshOrders => 'تحديث الطلبات';

  @override
  String get refreshingOrders => 'جاري تحديث الطلبات...';

  @override
  String exportingOrders(int count, String filter) {
    return 'جاري تصدير $count من طلبات $filter...';
  }

  @override
  String preparingFile(String format) {
    return 'جاري تحضير ملف $format الخاص بك';
  }

  @override
  String get exportSuccessful => 'تم التصدير بنجاح!';

  @override
  String yourFileIsReady(String format) {
    return 'ملف $format الخاص بك جاهز:';
  }

  @override
  String get size => 'الحجم';

  @override
  String get preview => 'معاينة:';

  @override
  String get close => 'إغلاق';

  @override
  String fileDownloadedSuccessfully(String format) {
    return 'تم تنزيل ملف $format بنجاح!';
  }

  @override
  String get download => 'تنزيل';

  @override
  String get dropHereToExport => 'أفلت هنا للتصدير';

  @override
  String get last7Days => 'أداء آخر 7 أيام';

  @override
  String get orderTrends => 'اتجاهات الطلبات على مدار آخر 6 أشهر';

  @override
  String get topSellingProducts => 'المنتجات الأكثر مبيعاً';

  @override
  String get bestPerformingItems => 'أفضل العناصر أداءً';

  @override
  String get categoryRevenue => 'إيرادات الفئات';

  @override
  String get revenueDistribution => 'توزيع الإيرادات حسب الفئة';

  @override
  String get inventoryLevels => 'مستويات المخزون';

  @override
  String get facialCleansing => 'تنظيف الوجه';

  @override
  String get splash => 'سبلاش';

  @override
  String get shampoo => 'شامبو';

  @override
  String get passionOrchidPerfume => 'عطر باشن أوركيد';

  @override
  String get profileInfo => 'معلومات الملف الشخصي';

  @override
  String get usernameLabel => 'اسم المستخدم *';

  @override
  String get phoneLabel => 'رقم الهاتف';

  @override
  String get emailLabel => 'البريد الإلكتروني *';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get genderLabel => 'الجنس';

  @override
  String get addressLabel => 'العنوان';

  @override
  String get locationLabel => 'الموقع (خرائط جوجل)';

  @override
  String get myWishlist => 'قائمة رغباتي';

  @override
  String get wishlistEmpty => 'قائمة الرغبات فارغة';

  @override
  String get contactSupport => 'الاتصال بالدعم';

  @override
  String get myOrders => 'طلباتي';

  @override
  String get logoutConfirm => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get loggedOut => 'تم تسجيل الخروج بنجاح!';

  @override
  String get chooseProfilePhoto => 'اختر صورة الملف الشخصي';

  @override
  String get camera => 'الكاميرا';

  @override
  String get gallery => 'المعرض';

  @override
  String get profileUpdated => 'تم تحديث الملف الشخصي بنجاح!';

  @override
  String get mapsError => 'تعذر فتح خرائط جوجل';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get tapToChangePhoto => 'اصغط لتغيير الصورة';

  @override
  String get mapPreview => 'معاينة الخريطة';

  @override
  String get coordinatesLabel => 'الإحداثيات';

  @override
  String get coordinatesSaved => 'تم حفظ الإحداثيات من خرائط جوجل';

  @override
  String get googleMapsPlaceholder => 'مكان خرائط جوجل';

  @override
  String get mapLocation => 'موقع الخريطة';

  @override
  String get latitudeLabel => 'خط العرض';

  @override
  String get longitudeLabel => 'خط الطول';

  @override
  String get editLocation => 'تعديل الموقع';

  @override
  String locationLabelWithColon(String location) {
    return 'الموقع: $location';
  }

  @override
  String coordinatesLabelWithColon(String lat, String lng) {
    return 'الإحداثيات: $lat, $lng';
  }

  @override
  String orderItemFormat(String name, String quantity) {
    return '• $name (x$quantity)';
  }

  @override
  String get contactUs => 'اتصل بنا';

  @override
  String get dropUsLine => 'اتصل بنا في أي وقت، وسنرد عليك في أقرب وقت ممكن!';

  @override
  String get phone => 'الهاتف';

  @override
  String get phoneNumberExample => '+961 71 503 235';

  @override
  String get emailExample => 'info@diraya.dev';

  @override
  String get followUs => 'تابعنا';

  @override
  String get stayConnected => 'ابق على اتصال معنا على وسائل التواصل الاجتماعي';

  @override
  String get getInTouch => 'تواصل معنا!';

  @override
  String get fillOutForm => 'املأ النموذج أدناه لإرسال رسالة إلينا.';

  @override
  String get nameLabel => 'الاسم';

  @override
  String get messageLabel => 'الرسالة';

  @override
  String get messageSentSuccessfully => 'تم إرسال الرسالة بنجاح!';

  @override
  String get sendMessage => 'إرسال الرسالة';

  @override
  String get locationMapPlaceholder => 'نائب خريطة الموقع';

  @override
  String get trackOrdersSubtitle => 'تتبع وإدارة جميع طلباتك في مكان واحد';

  @override
  String orderNumber(Object id) {
    return 'رقم الطلب #$id';
  }

  @override
  String get pending => 'قيد الانتظار';

  @override
  String get shipped => 'تم الشحن';

  @override
  String get completed => 'مكتمل';

  @override
  String get cancelled => 'ملغي';

  @override
  String get canceled => 'ملغي';

  @override
  String itemsInOrder(Object count) {
    return '$count عناصر في هذا الطلب';
  }

  @override
  String moreItems(Object count) {
    return '+$count عناصر أخرى';
  }

  @override
  String get totalAmountLabel => 'المبلغ الإجمالي';

  @override
  String get delivered => 'تم التوصيل';

  @override
  String submitLocation(Object location) {
    return 'إرسال الموقع: $location';
  }

  @override
  String get all => 'الكل';

  @override
  String get active => 'نشط';

  @override
  String get inactive => 'غير نشط';

  @override
  String get allCategories => 'كل الفئات';

  @override
  String get skinCare => 'العناية بالبشرة';

  @override
  String get noProductsFound => 'لم يتم العثور على منتجات';

  @override
  String get emptyProductsSubtitle => 'جرب تعديل الفلاتر أو إضافة منتج جديد';

  @override
  String get updateProduct => 'تحديث المنتج';

  @override
  String get searchProductsHint => 'البحث عن المنتجات بالاسم...';

  @override
  String get productUpdatedSuccessfully => 'تم تحديث المنتج بنجاح!';

  @override
  String get productAddedSuccessfully => 'تم إضافة المنتج بنجاح!';

  @override
  String get fillRequiredFields => 'يرجى ملء جميع الحقول المطلوبة (*)';

  @override
  String get orderDetails => 'تفاصيل الطلب';

  @override
  String get customerInformation => 'معلومات العميل';

  @override
  String selectNewStatusFor(String id) {
    return 'اختر الحالة الجديدة للطلب $id';
  }

  @override
  String orderStatusUpdatedTo(String id, String status) {
    return 'تم تحديث حالة الطلب $id إلى $status';
  }

  @override
  String get exportOrdersTitle => 'تصدير الطلبات';

  @override
  String get dragToExportHint =>
      'اسحب التنسيق إلى منطقة التصدير أو انقر للتصدير';

  @override
  String get updateOrderStatusTitle => 'تحديث حالة الطلب';

  @override
  String get exportZone => 'أفلت الصيغة هنا للتصدير';

  @override
  String exportAs(String format) {
    return 'تصدير بصيغة $format';
  }

  @override
  String ordersExported(String format) {
    return 'تم تصدير الطلبات بصيغة $format';
  }

  @override
  String get pendingStatus => 'قيد الانتظار';

  @override
  String get shopInformation => 'معلومات المتجر';

  @override
  String get basicInformation => 'معلومات أساسية';

  @override
  String get ownerName => 'اسم المالك';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get shopDescription => 'وصف المتجر';

  @override
  String get socialMedia => 'وسائل التواصل الاجتماعي';

  @override
  String get location => 'الموقع';

  @override
  String get shopImages => 'صور المتجر';

  @override
  String get shopLogo => 'شعار المتجر';

  @override
  String get coverImage => 'صورة الغلاف';

  @override
  String get shopSettings => 'إعدادات المتجر';

  @override
  String get shopStatus => 'حالة المتجر';

  @override
  String get productLimit => 'حد المنتجات';

  @override
  String get shopCreatedAt => 'تاريخ إنشاء المتجر';

  @override
  String get saveShopInfo => 'حفظ معلومات المتجر';

  @override
  String get shopInfoSaved => 'تم حفظ معلومات المتجر بنجاح!';

  @override
  String get enterPhoneNumber => 'أدخل رقم الهاتف';

  @override
  String get describeShop => 'صف متجرك...';

  @override
  String get selectCategoriesHelp => '(اختر فئة واحدة أو أكثر لمتجرك)';

  @override
  String get optional => 'اختياري';

  @override
  String get instagramUrl => 'رابط إنستغرام';

  @override
  String get facebookUrl => 'رابط فيسبوك';

  @override
  String get tiktokUrl => 'رابط تيك توك';

  @override
  String get shopLocation => 'موقع المتجر';

  @override
  String get logoSubtitle => 'اختياري (500x500 بكسل)';

  @override
  String get coverSubtitle => 'اختياري (1200x300 بكسل)';

  @override
  String get productLimitHelp => 'أقصى عدد من المنتجات المسموح بها';

  @override
  String get createdAtHelp => 'لا يمكن تغيير هذا التاريخ';

  @override
  String get couldNotOpenMaps => 'تعذر فتح الخرائط';

  @override
  String get homeGarden => 'المنزل والحديقة';

  @override
  String get foodBeverage => 'الأغذية والمشروبات';

  @override
  String get sports => 'الرياضة';

  @override
  String get books => 'الكتب';

  @override
  String get toys => 'الألعاب';

  @override
  String get health => 'الصحة';

  @override
  String get accessDownloadsDirectoryError => 'تعذر الوصول إلى مجلد التنزيلات';

  @override
  String get addStaticImage => 'إضافة صورة إعلان ثابتة';

  @override
  String get errorLoadingImage => 'خطأ في تحميل الصورة';

  @override
  String get expirationDateLabel => 'تاريخ الانتهاء*';

  @override
  String get expirationDateDescription =>
      'تاريخ الانتهاء* - (محدد من قبل المسؤول)';

  @override
  String get noDynamicAdImages => 'لم يتم إضافة صور إعلانات ديناميكية بعد';

  @override
  String get clickAddImagesButton =>
      'انقر على زر \"إضافة صور\" أدناه لإضافة صور';

  @override
  String dynamicImagesCount(String count, String limit) {
    return 'الصور: $count/$limit';
  }

  @override
  String get staticAdPlan => 'خطة الإعلان الثابت';

  @override
  String get dynamicAdPlan => 'خطة الإعلان الديناميكي';

  @override
  String get addImagesToDynamicAdPlan => 'إضافة صور إلى خطة الإعلان الديناميكي';

  @override
  String maxImagesReached(String limit) {
    return 'تم الوصول إلى الحد الأقصى $limit من الصور لخطة الإعلان الديناميكي';
  }

  @override
  String addUpToImages(String limit) {
    return 'أضف ما يصل إلى $limit صور لخطة الإعلان الديناميكي';
  }

  @override
  String get manageProductsTitle => 'إدارة المنتجات';

  @override
  String get addProduct => 'إضافة منتج';

  @override
  String get editProduct => 'تعديل المنتج';

  @override
  String get productNameLabel => 'اسم المنتج *';

  @override
  String get priceLabel => 'السعر *';

  @override
  String get salePriceLabel => 'سعر البيع';

  @override
  String get quantityLabel => 'الكمية *';

  @override
  String get categoriesLabel => 'الفئات *';

  @override
  String get weightOptional => 'الوزن (اختياري)';

  @override
  String get addNewWeight => 'إضافة وزن جديد';

  @override
  String get weightHint => 'مثلاً: 250 جرام';

  @override
  String get addNew => 'إضافة جديد';

  @override
  String get productStatusUpdated => 'تم تحديث حالة المنتج!';

  @override
  String get beauty => 'تجميل';

  @override
  String get automotive => 'سيارات';

  @override
  String get jewelry => 'مجوهرات';

  @override
  String get pets => 'حيوانات أليفة';

  @override
  String get searchCategoriesHint => 'ابحث عن الفئات...';

  @override
  String get browseByCategory => 'تصفح المنتجات حسب الفئة';

  @override
  String categoriesCount(Object count) {
    return '$count فئة';
  }

  @override
  String get noCategoriesAvailable => 'لا توجد فئات متاحة';

  @override
  String get noCategoriesFound => 'لم يتم العثور على فئات';

  @override
  String get categoriesWillAppearHere => 'ستظهر الفئات هنا';

  @override
  String noResultsFor(Object query) {
    return 'لا توجد نتائج لـ \"\$query\"';
  }

  @override
  String get clearSearch => 'مسح البحث';

  @override
  String get recentOrders => 'الطلبات الأخيرة';

  @override
  String get export => 'تصدير';

  @override
  String get viewDetails => 'عرض التفاصيل';

  @override
  String get updateStatus => 'تحديث الحالة';

  @override
  String get orderId => 'رقم الطلب';

  @override
  String get date => 'التاريخ';

  @override
  String get statusLabel => 'الحالة';

  @override
  String get updateProfilePhoto => 'تحديث صورة الملف الشخصي';

  @override
  String get browseAsUser => 'تصفح كعميل';

  @override
  String get deleteProductTitle => 'حذف المنتج';

  @override
  String deleteProductConfirm(Object name) {
    return 'هل أنت متأكد من حذف \"$name\"؟ لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String deletedSuccessfully(Object name) {
    return 'تم حذف $name بنجاح';
  }

  @override
  String get categoryRequired => 'مطلوب فئة واحدة على الأقل';

  @override
  String get imageRequired => 'مطلوبة صورة واحدة على الأقل';

  @override
  String get customBrandHint => 'أدخل اسم العلامة التجارية المخصصة';

  @override
  String get addPhoto => 'إضافة';

  @override
  String get productImagesLabel => 'صور المنتج *';

  @override
  String get addOneToThreeImages => 'أضف من 1 إلى 3 صور';

  @override
  String get adsManagement => 'إدارة الإعلانات';

  @override
  String get adsConfiguration => 'تكوين الإعلانات';

  @override
  String get viewEditAdsPlans => 'عرض وتعديل خطط الإعلانات الخاصة بك.';

  @override
  String get expirationDate => 'تاريخ الانتهاء*';

  @override
  String get setBySuperAdmin => 'تم التعيين بواسطة المسؤول المتميز';

  @override
  String get adsLimitLabel => 'حد الإعلانات (0 للتعطيل)';

  @override
  String get staticAdImageLabel => 'صورة إعلان ثابتة (اختياري)';

  @override
  String dynamicAdImagesLabel(String count, String limit) {
    return 'صور إعلانات ديناميكية ($count/$limit)';
  }

  @override
  String get noDynamicAds => 'لم يتم إضافة صور إعلانات ديناميكية بعد';

  @override
  String get clickAddImages => 'انقر على زر \"إضافة صور\" أدناه لإضافة صور';

  @override
  String get downloadToSave => 'انقر على زر التنزيل للحفظ، والحذف للإزالة';

  @override
  String get adsSavedSuccessfully => 'تم حفظ صور الإعلانات بنجاح!';

  @override
  String adsLimitError(String count, String limit) {
    return 'يجب أن يتطابق عدد صور الإعلانات الديناميكية ($count) مع حد الإعلانات ($limit)';
  }

  @override
  String get noStaticImageError => 'لا توجد صورة ثابتة لتنزيلها';

  @override
  String get storagePermissionRequired => 'مطلوب إذن التخزين لتنزيل الصور';

  @override
  String get enableStoragePermission =>
      'يرجى تمكين إذن التخزين في إعدادات التطبيق';

  @override
  String get downloadSuccess => 'تم تنزيل الصورة بنجاح إلى مجلد التنزيلات';

  @override
  String downloadError(Object error) {
    return 'فشل تنزيل الصورة: $error';
  }

  @override
  String get adsLimitDisabledByAdmin =>
      'تم تعطيل حد الإعلانات (تم تعيينه إلى 0) بواسطة المسؤول المتميز';

  @override
  String get inventoryManagement => 'إدارة المخزون';

  @override
  String get productsOverview => 'نظرة عامة على المنتجات';

  @override
  String get manageStockLevels =>
      'إدارة مستويات المخزون لجميع المنتجات في مخزونك.';

  @override
  String get totalProducts => 'إجمالي المنتجات';

  @override
  String get lowStock => 'انخفاض المخزون';

  @override
  String inStockCount(String count) {
    return '$count في المخزون';
  }

  @override
  String get inventoryUpdated => 'تم تحديث المخزون بنجاح!';

  @override
  String get cancelOrder => 'إلغاء الطلب';

  @override
  String cancelOrderConfirmation(String id) {
    return 'هل أنت متأكد أنك تريد إلغاء الطلب $id؟ لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String get no => 'لا';

  @override
  String get yesCancelOrder => 'نعم، إلغاء الطلب';

  @override
  String orderCanceled(String id) {
    return 'تم إلغاء الطلب $id';
  }

  @override
  String get undo => 'تراجع';

  @override
  String deleteOrderConfirm(String id) {
    return 'هل أنت متأكد من حذف الطلب $id؟';
  }

  @override
  String get discoverShops => 'اكتشف المتاجر';

  @override
  String get browseCuratedVendors => 'تصفح البائعين المختارين';

  @override
  String get searchShopsHint => 'ابحث عن المتاجر بالاسم...';

  @override
  String get noShopsFound => 'لم يتم العثور على متاجر';

  @override
  String get noShopsAvailable => 'لا توجد متاجر متاحة';

  @override
  String get shopsWillAppearHere => 'ستظهر المتاجر هنا';

  @override
  String productCount(Object count) {
    return '$count منتجات';
  }

  @override
  String viewsCount(Object views) {
    return '$views مشاهدة';
  }

  @override
  String get searchInShopHint => 'بحث في المتجر...';

  @override
  String get filter => 'Filter';

  @override
  String get filters => 'المرشحات';

  @override
  String get category => 'الفئة';

  @override
  String get brand => 'العلامة التجارية';

  @override
  String get priceRange => 'نطاق السعر';

  @override
  String get noProductsAvailable => 'لا توجد منتجات متاحة';

  @override
  String inCartCount(Object count) {
    return '$count في السلة';
  }

  @override
  String get skincare => 'العناية بالبشرة';

  @override
  String get masks => 'الأقنعة';

  @override
  String get toners => 'تونر';

  @override
  String get suncare => 'العناية من الشمس';

  @override
  String get lipCare => 'العناية بالشفاه';

  @override
  String get bodyCare => 'العناية بالجسم';

  @override
  String get cleansers => 'منظفات';

  @override
  String get essences => 'إسنس';

  @override
  String get discoverProductsSubtitle => 'اكتشف مجموعتنا الكاملة';

  @override
  String get allBrands => 'جميع العلامات التجارية';

  @override
  String get minPrice => 'الحد الأدنى';

  @override
  String get maxPrice => 'الحد الأقصى';

  @override
  String productsFound(Object count) {
    return 'تم العثور على $count منتجات';
  }

  @override
  String get adjustFiltersHint => 'حاول تعديل المرشحات أو البحث';

  @override
  String get sportsOutdoors => 'الرياضة والهواء الطلق';

  @override
  String get foodBeverages => 'الطعام والمشروبات';

  @override
  String get beautyHealth => 'الجمال والصحة';

  @override
  String get booksMedia => 'الكتب والوسائط';

  @override
  String get shippingMethod => 'طريقة الشحن';

  @override
  String get paymentMethod => 'طريقة الدفع';

  @override
  String get shippingAddress => 'عنوان الشحن';

  @override
  String get orderItems => 'عناصر الطلب';

  @override
  String get quantity => 'الكمية';

  @override
  String get notes => 'ملاحظات';

  @override
  String get generated => 'تم الإنشاء';

  @override
  String get ordersReport => 'تقرير الطلبات';

  @override
  String get ordersDocument => 'وثيقة الطلبات';

  @override
  String get ordersCount => 'عدد الطلبات';

  @override
  String get itemsOrdered => 'العناصر المطلوبة';

  @override
  String get orderDate => 'تاريخ الطلب';

  @override
  String get totalAmount => 'المبلغ الإجمالي';

  @override
  String get filterAll => 'الكل';

  @override
  String get filterPending => 'قيد الانتظار';

  @override
  String get filterShipped => 'تم الشحن';

  @override
  String get filterCompleted => 'مكتمل';

  @override
  String get filterCanceled => 'ملغي';

  @override
  String get orderStatus => 'حالة الطلب';

  @override
  String get customerInfo => 'معلومات العميل';

  @override
  String get itemName => 'الصنف';

  @override
  String get qty => 'الكمية';

  @override
  String get shippingFee => 'رسوم الشحن';

  @override
  String get taxes => 'الضرائب';

  @override
  String get shippingInfo => 'معلومات الشحن';

  @override
  String get contactInfo => 'معلومات الاتصال';

  @override
  String get paymentInfo => 'معلومات الدفع';

  @override
  String get orderNotes => 'ملاحظات الطلب';

  @override
  String get noNotes => 'لا توجد ملاحظات إضافية';

  @override
  String get totalOrders => 'إجمالي الطلبات';

  @override
  String get customer => 'العميل';

  @override
  String get order => 'الطلب';

  @override
  String get status => 'الحالة';

  @override
  String get items => 'العناصر';

  @override
  String get tax => 'الضريبة';

  @override
  String get backToDashboard => 'العودة للوحة التحكم';
}
