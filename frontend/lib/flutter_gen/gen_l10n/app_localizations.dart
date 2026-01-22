import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Multivendor App'**
  String get appName;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @shops.
  ///
  /// In en, this message translates to:
  /// **'Shops'**
  String get shops;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// No description provided for @buyNow.
  ///
  /// In en, this message translates to:
  /// **'Buy Now'**
  String get buyNow;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @orderHistory.
  ///
  /// In en, this message translates to:
  /// **'Order History'**
  String get orderHistory;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @inventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventory;

  /// No description provided for @sales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get sales;

  /// No description provided for @ads.
  ///
  /// In en, this message translates to:
  /// **'Ads'**
  String get ads;

  /// No description provided for @shopInfo.
  ///
  /// In en, this message translates to:
  /// **'Shop Info'**
  String get shopInfo;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternet;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @popularProducts.
  ///
  /// In en, this message translates to:
  /// **'Popular Products'**
  String get popularProducts;

  /// No description provided for @showAll.
  ///
  /// In en, this message translates to:
  /// **'Show All'**
  String get showAll;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for products, shops...'**
  String get searchHint;

  /// No description provided for @sponsored.
  ///
  /// In en, this message translates to:
  /// **'Sponsored'**
  String get sponsored;

  /// No description provided for @shopNow.
  ///
  /// In en, this message translates to:
  /// **'Shop Now'**
  String get shopNow;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back,'**
  String get welcomeBack;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @totalProductsCount.
  ///
  /// In en, this message translates to:
  /// **'Total Products'**
  String get totalProductsCount;

  /// No description provided for @totalOrdersCount.
  ///
  /// In en, this message translates to:
  /// **'Total Orders'**
  String get totalOrdersCount;

  /// No description provided for @totalRevenue.
  ///
  /// In en, this message translates to:
  /// **'Total Revenue'**
  String get totalRevenue;

  /// No description provided for @activeCustomers.
  ///
  /// In en, this message translates to:
  /// **'Active Customers'**
  String get activeCustomers;

  /// No description provided for @salesOverTime.
  ///
  /// In en, this message translates to:
  /// **'Sales Over Time'**
  String get salesOverTime;

  /// No description provided for @monthlyOrderCount.
  ///
  /// In en, this message translates to:
  /// **'Monthly Order Count'**
  String get monthlyOrderCount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @googleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get googleSignIn;

  /// No description provided for @googleSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up with Google'**
  String get googleSignUp;

  /// No description provided for @summerCollection.
  ///
  /// In en, this message translates to:
  /// **'Summer Collection'**
  String get summerCollection;

  /// No description provided for @discount50.
  ///
  /// In en, this message translates to:
  /// **'50% Off Now'**
  String get discount50;

  /// No description provided for @newArrivals.
  ///
  /// In en, this message translates to:
  /// **'New Arrivals'**
  String get newArrivals;

  /// No description provided for @checkNow.
  ///
  /// In en, this message translates to:
  /// **'Check Now'**
  String get checkNow;

  /// No description provided for @exclusiveDeals.
  ///
  /// In en, this message translates to:
  /// **'Exclusive Deals'**
  String get exclusiveDeals;

  /// No description provided for @limitedTime.
  ///
  /// In en, this message translates to:
  /// **'Limited Time'**
  String get limitedTime;

  /// No description provided for @beautySale.
  ///
  /// In en, this message translates to:
  /// **'Beauty Sale'**
  String get beautySale;

  /// No description provided for @upTo70Off.
  ///
  /// In en, this message translates to:
  /// **'Up to 70% Off'**
  String get upTo70Off;

  /// No description provided for @techDeals.
  ///
  /// In en, this message translates to:
  /// **'Tech Deals'**
  String get techDeals;

  /// No description provided for @latestGadgets.
  ///
  /// In en, this message translates to:
  /// **'Latest Gadgets'**
  String get latestGadgets;

  /// No description provided for @homeDecor.
  ///
  /// In en, this message translates to:
  /// **'Home Decor'**
  String get homeDecor;

  /// No description provided for @modernFurniture.
  ///
  /// In en, this message translates to:
  /// **'Modern Furniture'**
  String get modernFurniture;

  /// No description provided for @fitnessGear.
  ///
  /// In en, this message translates to:
  /// **'Fitness Gear'**
  String get fitnessGear;

  /// No description provided for @stayActive.
  ///
  /// In en, this message translates to:
  /// **'Stay Active'**
  String get stayActive;

  /// No description provided for @bookFair.
  ///
  /// In en, this message translates to:
  /// **'Book Fair'**
  String get bookFair;

  /// No description provided for @bestSellers.
  ///
  /// In en, this message translates to:
  /// **'Best Sellers'**
  String get bestSellers;

  /// No description provided for @fashionWeek.
  ///
  /// In en, this message translates to:
  /// **'Fashion Week'**
  String get fashionWeek;

  /// No description provided for @trendyStyles.
  ///
  /// In en, this message translates to:
  /// **'Trendy Styles'**
  String get trendyStyles;

  /// No description provided for @gamingZone.
  ///
  /// In en, this message translates to:
  /// **'Gaming Zone'**
  String get gamingZone;

  /// No description provided for @newConsoles.
  ///
  /// In en, this message translates to:
  /// **'New Consoles'**
  String get newConsoles;

  /// No description provided for @kitchenware.
  ///
  /// In en, this message translates to:
  /// **'Kitchenware'**
  String get kitchenware;

  /// No description provided for @premiumCookware.
  ///
  /// In en, this message translates to:
  /// **'Premium Cookware'**
  String get premiumCookware;

  /// No description provided for @smartWatches.
  ///
  /// In en, this message translates to:
  /// **'Smart Watches'**
  String get smartWatches;

  /// No description provided for @healthTracking.
  ///
  /// In en, this message translates to:
  /// **'Health Tracking'**
  String get healthTracking;

  /// No description provided for @audioGear.
  ///
  /// In en, this message translates to:
  /// **'Audio Gear'**
  String get audioGear;

  /// No description provided for @premiumSound.
  ///
  /// In en, this message translates to:
  /// **'Premium Sound'**
  String get premiumSound;

  /// No description provided for @productDetails.
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get productDetails;

  /// No description provided for @inStock.
  ///
  /// In en, this message translates to:
  /// **'In Stock'**
  String get inStock;

  /// No description provided for @outOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get outOfStock;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @unavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get unavailable;

  /// No description provided for @selectQuantity.
  ///
  /// In en, this message translates to:
  /// **'Select Quantity'**
  String get selectQuantity;

  /// No description provided for @stockCount.
  ///
  /// In en, this message translates to:
  /// **'Stock: {count}'**
  String stockCount(String count);

  /// No description provided for @rateThisProduct.
  ///
  /// In en, this message translates to:
  /// **'Rate this product'**
  String get rateThisProduct;

  /// No description provided for @tapStarsToRate.
  ///
  /// In en, this message translates to:
  /// **'Tap stars to rate'**
  String get tapStarsToRate;

  /// No description provided for @youRated.
  ///
  /// In en, this message translates to:
  /// **'You rated {rating} stars'**
  String youRated(String rating);

  /// No description provided for @addedToCart.
  ///
  /// In en, this message translates to:
  /// **'{count} items added to cart'**
  String addedToCart(String count);

  /// No description provided for @welcomeBackTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBackTitle;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue to your account'**
  String get signInSubtitle;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get noAccount;

  /// No description provided for @createAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountTitle;

  /// No description provided for @joinCommunity.
  ///
  /// In en, this message translates to:
  /// **'Join our community today'**
  String get joinCommunity;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @createPassword.
  ///
  /// In en, this message translates to:
  /// **'Create Password'**
  String get createPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @accountCreated.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully!'**
  String get accountCreated;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get orContinueWith;

  /// No description provided for @orSignUpWith.
  ///
  /// In en, this message translates to:
  /// **'or sign up with'**
  String get orSignUpWith;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all fields'**
  String get fillAllFields;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get invalidCredentials;

  /// No description provided for @welcomeShopOwner.
  ///
  /// In en, this message translates to:
  /// **'Welcome, Shop Owner! Sign in successful!'**
  String get welcomeShopOwner;

  /// No description provided for @myCart.
  ///
  /// In en, this message translates to:
  /// **'My Cart'**
  String get myCart;

  /// Number of items in shop
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String itemsCount(Object count);

  /// No description provided for @clearCartTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear Cart?'**
  String get clearCartTitle;

  /// No description provided for @clearCartConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove all items from your cart?'**
  String get clearCartConfirm;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @personalProfile.
  ///
  /// In en, this message translates to:
  /// **'Personal Profile'**
  String get personalProfile;

  /// No description provided for @orderPlacedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Order Placed Successfully!'**
  String get orderPlacedSuccessfully;

  /// No description provided for @itemRemoved.
  ///
  /// In en, this message translates to:
  /// **'{name} removed from cart'**
  String itemRemoved(String name);

  /// No description provided for @emptyCart.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get emptyCart;

  /// No description provided for @emptyCartSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Looks like you haven\'t added any products to your cart yet. Start shopping to fill it up!'**
  String get emptyCartSubtitle;

  /// No description provided for @startShopping.
  ///
  /// In en, this message translates to:
  /// **'Start Shopping'**
  String get startShopping;

  /// No description provided for @proceedToCheckout.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Checkout'**
  String get proceedToCheckout;

  /// No description provided for @continueShopping.
  ///
  /// In en, this message translates to:
  /// **'Continue Shopping'**
  String get continueShopping;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @shipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get shipping;

  /// No description provided for @orderSuccess.
  ///
  /// In en, this message translates to:
  /// **'Order placed successfully!'**
  String get orderSuccess;

  /// No description provided for @willBeCharged.
  ///
  /// In en, this message translates to:
  /// **'{amount} will be charged'**
  String willBeCharged(String amount);

  /// No description provided for @productDescription.
  ///
  /// In en, this message translates to:
  /// **'High-quality {name} designed for exceptional performance. Crafted with premium materials and attention to detail, this product offers reliability and style. Perfect for everyday use with features that enhance your experience.'**
  String productDescription(String name);

  /// No description provided for @stockStatus.
  ///
  /// In en, this message translates to:
  /// **'Stock: {status}'**
  String stockStatus(String status);

  /// No description provided for @electronics.
  ///
  /// In en, this message translates to:
  /// **'Electronics'**
  String get electronics;

  /// No description provided for @accessories.
  ///
  /// In en, this message translates to:
  /// **'Accessories'**
  String get accessories;

  /// No description provided for @cosmetics.
  ///
  /// In en, this message translates to:
  /// **'Cosmetics'**
  String get cosmetics;

  /// No description provided for @groceries.
  ///
  /// In en, this message translates to:
  /// **'Groceries'**
  String get groceries;

  /// No description provided for @fashion.
  ///
  /// In en, this message translates to:
  /// **'Fashion'**
  String get fashion;

  /// No description provided for @featuredShops.
  ///
  /// In en, this message translates to:
  /// **'Featured Shops'**
  String get featuredShops;

  /// No description provided for @visitShop.
  ///
  /// In en, this message translates to:
  /// **'Visit Shop'**
  String get visitShop;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @management.
  ///
  /// In en, this message translates to:
  /// **'Management'**
  String get management;

  /// No description provided for @ordersManagement.
  ///
  /// In en, this message translates to:
  /// **'Orders Management'**
  String get ordersManagement;

  /// No description provided for @revenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get revenue;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @views.
  ///
  /// In en, this message translates to:
  /// **'Views'**
  String get views;

  /// No description provided for @manageProducts.
  ///
  /// In en, this message translates to:
  /// **'Manage Products'**
  String get manageProducts;

  /// No description provided for @manageProductsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add, edit or remove products'**
  String get manageProductsSubtitle;

  /// No description provided for @manageAds.
  ///
  /// In en, this message translates to:
  /// **'Manage Ads'**
  String get manageAds;

  /// No description provided for @manageAdsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create and track advertisements'**
  String get manageAdsSubtitle;

  /// No description provided for @manageInventory.
  ///
  /// In en, this message translates to:
  /// **'Manage Inventory'**
  String get manageInventory;

  /// No description provided for @manageInventorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track stock and supplies'**
  String get manageInventorySubtitle;

  /// No description provided for @viewAllOrders.
  ///
  /// In en, this message translates to:
  /// **'View All Orders'**
  String get viewAllOrders;

  /// No description provided for @viewAllOrdersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'See complete order history'**
  String get viewAllOrdersSubtitle;

  /// No description provided for @shopInfoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your shop details'**
  String get shopInfoSubtitle;

  /// No description provided for @shopOwner.
  ///
  /// In en, this message translates to:
  /// **'Shop Owner'**
  String get shopOwner;

  /// No description provided for @exportAllOrders.
  ///
  /// In en, this message translates to:
  /// **'Export All Orders'**
  String get exportAllOrders;

  /// No description provided for @refreshOrders.
  ///
  /// In en, this message translates to:
  /// **'Refresh Orders'**
  String get refreshOrders;

  /// No description provided for @refreshingOrders.
  ///
  /// In en, this message translates to:
  /// **'Refreshing orders...'**
  String get refreshingOrders;

  /// No description provided for @exportingOrders.
  ///
  /// In en, this message translates to:
  /// **'Exporting {count} {filter} orders...'**
  String exportingOrders(int count, String filter);

  /// No description provided for @preparingFile.
  ///
  /// In en, this message translates to:
  /// **'Preparing your {format} file'**
  String preparingFile(String format);

  /// No description provided for @exportSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Export Successful!'**
  String get exportSuccessful;

  /// No description provided for @yourFileIsReady.
  ///
  /// In en, this message translates to:
  /// **'Your {format} file is ready:'**
  String yourFileIsReady(String format);

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview:'**
  String get preview;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @fileDownloadedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'{format} file downloaded successfully!'**
  String fileDownloadedSuccessfully(String format);

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @dropHereToExport.
  ///
  /// In en, this message translates to:
  /// **'Drop here to export'**
  String get dropHereToExport;

  /// No description provided for @last7Days.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days performance'**
  String get last7Days;

  /// No description provided for @orderTrends.
  ///
  /// In en, this message translates to:
  /// **'Order trends over last 6 months'**
  String get orderTrends;

  /// No description provided for @topSellingProducts.
  ///
  /// In en, this message translates to:
  /// **'Top Selling Products'**
  String get topSellingProducts;

  /// No description provided for @bestPerformingItems.
  ///
  /// In en, this message translates to:
  /// **'Best performing items'**
  String get bestPerformingItems;

  /// No description provided for @categoryRevenue.
  ///
  /// In en, this message translates to:
  /// **'Category Revenue'**
  String get categoryRevenue;

  /// No description provided for @revenueDistribution.
  ///
  /// In en, this message translates to:
  /// **'Revenue distribution by category'**
  String get revenueDistribution;

  /// No description provided for @inventoryLevels.
  ///
  /// In en, this message translates to:
  /// **'Inventory Levels'**
  String get inventoryLevels;

  /// No description provided for @facialCleansing.
  ///
  /// In en, this message translates to:
  /// **'Facial Cleansing'**
  String get facialCleansing;

  /// No description provided for @splash.
  ///
  /// In en, this message translates to:
  /// **'Splash'**
  String get splash;

  /// No description provided for @shampoo.
  ///
  /// In en, this message translates to:
  /// **'Shampoo'**
  String get shampoo;

  /// No description provided for @passionOrchidPerfume.
  ///
  /// In en, this message translates to:
  /// **'Passion Orchid Perfume'**
  String get passionOrchidPerfume;

  /// No description provided for @profileInfo.
  ///
  /// In en, this message translates to:
  /// **'Profile Info'**
  String get profileInfo;

  /// No description provided for @usernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Username *'**
  String get usernameLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email *'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @genderLabel.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get genderLabel;

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get addressLabel;

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location (Google Maps)'**
  String get locationLabel;

  /// No description provided for @myWishlist.
  ///
  /// In en, this message translates to:
  /// **'My Wishlist'**
  String get myWishlist;

  /// No description provided for @wishlistEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your wishlist is empty'**
  String get wishlistEmpty;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirm;

  /// No description provided for @loggedOut.
  ///
  /// In en, this message translates to:
  /// **'Logged out successfully!'**
  String get loggedOut;

  /// No description provided for @chooseProfilePhoto.
  ///
  /// In en, this message translates to:
  /// **'Choose Profile Photo'**
  String get chooseProfilePhoto;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get profileUpdated;

  /// No description provided for @mapsError.
  ///
  /// In en, this message translates to:
  /// **'Could not open Google Maps'**
  String get mapsError;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @tapToChangePhoto.
  ///
  /// In en, this message translates to:
  /// **'Tap to change photo'**
  String get tapToChangePhoto;

  /// No description provided for @mapPreview.
  ///
  /// In en, this message translates to:
  /// **'Map Preview'**
  String get mapPreview;

  /// No description provided for @coordinatesLabel.
  ///
  /// In en, this message translates to:
  /// **'Coordinates'**
  String get coordinatesLabel;

  /// No description provided for @coordinatesSaved.
  ///
  /// In en, this message translates to:
  /// **'Coordinates saved from Google Maps'**
  String get coordinatesSaved;

  /// No description provided for @googleMapsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Google Maps Placeholder'**
  String get googleMapsPlaceholder;

  /// No description provided for @mapLocation.
  ///
  /// In en, this message translates to:
  /// **'Map Location'**
  String get mapLocation;

  /// No description provided for @latitudeLabel.
  ///
  /// In en, this message translates to:
  /// **'Lat'**
  String get latitudeLabel;

  /// No description provided for @longitudeLabel.
  ///
  /// In en, this message translates to:
  /// **'Lng'**
  String get longitudeLabel;

  /// No description provided for @editLocation.
  ///
  /// In en, this message translates to:
  /// **'Edit Location'**
  String get editLocation;

  /// No description provided for @locationLabelWithColon.
  ///
  /// In en, this message translates to:
  /// **'Location: {location}'**
  String locationLabelWithColon(String location);

  /// No description provided for @coordinatesLabelWithColon.
  ///
  /// In en, this message translates to:
  /// **'Coordinates: {lat}, {lng}'**
  String coordinatesLabelWithColon(String lat, String lng);

  /// No description provided for @orderItemFormat.
  ///
  /// In en, this message translates to:
  /// **'• {name} (x{quantity})'**
  String orderItemFormat(String name, String quantity);

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @dropUsLine.
  ///
  /// In en, this message translates to:
  /// **'Drop us a line anytime, and we\'ll get back to you as soon as possible!'**
  String get dropUsLine;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @phoneNumberExample.
  ///
  /// In en, this message translates to:
  /// **'+961 71 503 235'**
  String get phoneNumberExample;

  /// No description provided for @emailExample.
  ///
  /// In en, this message translates to:
  /// **'info@diraya.dev'**
  String get emailExample;

  /// No description provided for @followUs.
  ///
  /// In en, this message translates to:
  /// **'Follow Us'**
  String get followUs;

  /// No description provided for @stayConnected.
  ///
  /// In en, this message translates to:
  /// **'Stay connected with us on social media'**
  String get stayConnected;

  /// No description provided for @getInTouch.
  ///
  /// In en, this message translates to:
  /// **'Get In Touch With Us!'**
  String get getInTouch;

  /// No description provided for @fillOutForm.
  ///
  /// In en, this message translates to:
  /// **'Fill out the form below to send us a message.'**
  String get fillOutForm;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @messageLabel.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get messageLabel;

  /// No description provided for @messageSentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Message sent successfully!'**
  String get messageSentSuccessfully;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'SEND MESSAGE'**
  String get sendMessage;

  /// No description provided for @locationMapPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Location Map Placeholder'**
  String get locationMapPlaceholder;

  /// No description provided for @trackOrdersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track and manage all your orders in one place'**
  String get trackOrdersSubtitle;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order Number #{id}'**
  String orderNumber(Object id);

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @shipped.
  ///
  /// In en, this message translates to:
  /// **'Shipped'**
  String get shipped;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'CANCELLED'**
  String get cancelled;

  /// No description provided for @canceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get canceled;

  /// No description provided for @itemsInOrder.
  ///
  /// In en, this message translates to:
  /// **'{count} items in this order'**
  String itemsInOrder(Object count);

  /// No description provided for @moreItems.
  ///
  /// In en, this message translates to:
  /// **'+{count} more items'**
  String moreItems(Object count);

  /// No description provided for @totalAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmountLabel;

  /// No description provided for @delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered;

  /// No description provided for @submitLocation.
  ///
  /// In en, this message translates to:
  /// **'Submit location: {location}'**
  String submitLocation(Object location);

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @allCategories.
  ///
  /// In en, this message translates to:
  /// **'All categories'**
  String get allCategories;

  /// No description provided for @skinCare.
  ///
  /// In en, this message translates to:
  /// **'Skin Care'**
  String get skinCare;

  /// No description provided for @noProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No products found'**
  String get noProductsFound;

  /// No description provided for @emptyProductsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your filters or add a new product'**
  String get emptyProductsSubtitle;

  /// No description provided for @updateProduct.
  ///
  /// In en, this message translates to:
  /// **'Update Product'**
  String get updateProduct;

  /// No description provided for @searchProductsHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name...'**
  String get searchProductsHint;

  /// No description provided for @productUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Product updated successfully!'**
  String get productUpdatedSuccessfully;

  /// No description provided for @productAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Product added successfully!'**
  String get productAddedSuccessfully;

  /// No description provided for @fillRequiredFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields (*)'**
  String get fillRequiredFields;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @customerInformation.
  ///
  /// In en, this message translates to:
  /// **'Customer Information'**
  String get customerInformation;

  /// No description provided for @selectNewStatusFor.
  ///
  /// In en, this message translates to:
  /// **'Select new status for {id}'**
  String selectNewStatusFor(String id);

  /// No description provided for @orderStatusUpdatedTo.
  ///
  /// In en, this message translates to:
  /// **'Order {id} status updated to {status}'**
  String orderStatusUpdatedTo(String id, String status);

  /// No description provided for @exportOrdersTitle.
  ///
  /// In en, this message translates to:
  /// **'Export Orders'**
  String get exportOrdersTitle;

  /// No description provided for @dragToExportHint.
  ///
  /// In en, this message translates to:
  /// **'Drag format to export zone or click to export'**
  String get dragToExportHint;

  /// No description provided for @updateOrderStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Order Status'**
  String get updateOrderStatusTitle;

  /// No description provided for @exportZone.
  ///
  /// In en, this message translates to:
  /// **'Drop format here to export'**
  String get exportZone;

  /// No description provided for @exportAs.
  ///
  /// In en, this message translates to:
  /// **'Export as {format}'**
  String exportAs(String format);

  /// No description provided for @ordersExported.
  ///
  /// In en, this message translates to:
  /// **'Orders exported as {format}'**
  String ordersExported(String format);

  /// No description provided for @pendingStatus.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pendingStatus;

  /// No description provided for @shopInformation.
  ///
  /// In en, this message translates to:
  /// **'Shop Information'**
  String get shopInformation;

  /// No description provided for @basicInformation.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basicInformation;

  /// No description provided for @ownerName.
  ///
  /// In en, this message translates to:
  /// **'Owner Name'**
  String get ownerName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @shopDescription.
  ///
  /// In en, this message translates to:
  /// **'Shop Description'**
  String get shopDescription;

  /// No description provided for @socialMedia.
  ///
  /// In en, this message translates to:
  /// **'Social Media'**
  String get socialMedia;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @shopImages.
  ///
  /// In en, this message translates to:
  /// **'Shop Images'**
  String get shopImages;

  /// No description provided for @shopLogo.
  ///
  /// In en, this message translates to:
  /// **'Shop Logo'**
  String get shopLogo;

  /// No description provided for @coverImage.
  ///
  /// In en, this message translates to:
  /// **'Cover Image'**
  String get coverImage;

  /// No description provided for @shopSettings.
  ///
  /// In en, this message translates to:
  /// **'Shop Settings'**
  String get shopSettings;

  /// No description provided for @shopStatus.
  ///
  /// In en, this message translates to:
  /// **'Shop Status'**
  String get shopStatus;

  /// No description provided for @productLimit.
  ///
  /// In en, this message translates to:
  /// **'Product Limit'**
  String get productLimit;

  /// No description provided for @shopCreatedAt.
  ///
  /// In en, this message translates to:
  /// **'Shop Created At'**
  String get shopCreatedAt;

  /// No description provided for @saveShopInfo.
  ///
  /// In en, this message translates to:
  /// **'Save Shop Information'**
  String get saveShopInfo;

  /// No description provided for @shopInfoSaved.
  ///
  /// In en, this message translates to:
  /// **'Shop information saved successfully!'**
  String get shopInfoSaved;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enterPhoneNumber;

  /// No description provided for @describeShop.
  ///
  /// In en, this message translates to:
  /// **'Describe your shop...'**
  String get describeShop;

  /// No description provided for @selectCategoriesHelp.
  ///
  /// In en, this message translates to:
  /// **'(Select one or more categories for your shop)'**
  String get selectCategoriesHelp;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'(Optional)'**
  String get optional;

  /// No description provided for @instagramUrl.
  ///
  /// In en, this message translates to:
  /// **'Instagram URL'**
  String get instagramUrl;

  /// No description provided for @facebookUrl.
  ///
  /// In en, this message translates to:
  /// **'Facebook URL'**
  String get facebookUrl;

  /// No description provided for @tiktokUrl.
  ///
  /// In en, this message translates to:
  /// **'TikTok URL'**
  String get tiktokUrl;

  /// No description provided for @shopLocation.
  ///
  /// In en, this message translates to:
  /// **'Shop Location'**
  String get shopLocation;

  /// No description provided for @logoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Optional (500x500px)'**
  String get logoSubtitle;

  /// No description provided for @coverSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Optional (1200x300px)'**
  String get coverSubtitle;

  /// No description provided for @productLimitHelp.
  ///
  /// In en, this message translates to:
  /// **'Maximum number of products allowed'**
  String get productLimitHelp;

  /// No description provided for @createdAtHelp.
  ///
  /// In en, this message translates to:
  /// **'This cannot be changed'**
  String get createdAtHelp;

  /// No description provided for @couldNotOpenMaps.
  ///
  /// In en, this message translates to:
  /// **'Could not open maps'**
  String get couldNotOpenMaps;

  /// No description provided for @homeGarden.
  ///
  /// In en, this message translates to:
  /// **'Home & Garden'**
  String get homeGarden;

  /// No description provided for @foodBeverage.
  ///
  /// In en, this message translates to:
  /// **'Food & Beverage'**
  String get foodBeverage;

  /// No description provided for @sports.
  ///
  /// In en, this message translates to:
  /// **'Sports'**
  String get sports;

  /// No description provided for @books.
  ///
  /// In en, this message translates to:
  /// **'Books'**
  String get books;

  /// No description provided for @toys.
  ///
  /// In en, this message translates to:
  /// **'Toys'**
  String get toys;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @accessDownloadsDirectoryError.
  ///
  /// In en, this message translates to:
  /// **'Could not access downloads directory'**
  String get accessDownloadsDirectoryError;

  /// No description provided for @addStaticImage.
  ///
  /// In en, this message translates to:
  /// **'Add Static\nImage'**
  String get addStaticImage;

  /// No description provided for @errorLoadingImage.
  ///
  /// In en, this message translates to:
  /// **'Error loading image'**
  String get errorLoadingImage;

  /// No description provided for @expirationDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Expiration Date*'**
  String get expirationDateLabel;

  /// No description provided for @expirationDateDescription.
  ///
  /// In en, this message translates to:
  /// **'Expiration Date* - (Set by Admin)'**
  String get expirationDateDescription;

  /// No description provided for @noDynamicAdImages.
  ///
  /// In en, this message translates to:
  /// **'No dynamic ad images added yet'**
  String get noDynamicAdImages;

  /// No description provided for @clickAddImagesButton.
  ///
  /// In en, this message translates to:
  /// **'Click \"Add Images\" button below to add images'**
  String get clickAddImagesButton;

  /// No description provided for @dynamicImagesCount.
  ///
  /// In en, this message translates to:
  /// **'Images: {count}/{limit}'**
  String dynamicImagesCount(String count, String limit);

  /// No description provided for @staticAdPlan.
  ///
  /// In en, this message translates to:
  /// **'Static Ad Plan'**
  String get staticAdPlan;

  /// No description provided for @dynamicAdPlan.
  ///
  /// In en, this message translates to:
  /// **'Dynamic Ad Plan'**
  String get dynamicAdPlan;

  /// No description provided for @addImagesToDynamicAdPlan.
  ///
  /// In en, this message translates to:
  /// **'Add Images to Dynamic Ad Plan'**
  String get addImagesToDynamicAdPlan;

  /// No description provided for @maxImagesReached.
  ///
  /// In en, this message translates to:
  /// **'Maximum {limit} images reached for Dynamic Ad Plan'**
  String maxImagesReached(String limit);

  /// No description provided for @addUpToImages.
  ///
  /// In en, this message translates to:
  /// **'Add up to {limit} images for Dynamic Ad Plan'**
  String addUpToImages(String limit);

  /// No description provided for @manageProductsTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage Products'**
  String get manageProductsTitle;

  /// No description provided for @addProduct.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get addProduct;

  /// No description provided for @editProduct.
  ///
  /// In en, this message translates to:
  /// **'Edit Product'**
  String get editProduct;

  /// No description provided for @productNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Product Name *'**
  String get productNameLabel;

  /// No description provided for @priceLabel.
  ///
  /// In en, this message translates to:
  /// **'Price *'**
  String get priceLabel;

  /// No description provided for @salePriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Sale Price'**
  String get salePriceLabel;

  /// No description provided for @quantityLabel.
  ///
  /// In en, this message translates to:
  /// **'Quantity *'**
  String get quantityLabel;

  /// No description provided for @categoriesLabel.
  ///
  /// In en, this message translates to:
  /// **'Categories *'**
  String get categoriesLabel;

  /// No description provided for @weightOptional.
  ///
  /// In en, this message translates to:
  /// **'Weight (Optional)'**
  String get weightOptional;

  /// No description provided for @addNewWeight.
  ///
  /// In en, this message translates to:
  /// **'Add New Weight'**
  String get addNewWeight;

  /// No description provided for @weightHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 250g'**
  String get weightHint;

  /// No description provided for @addNew.
  ///
  /// In en, this message translates to:
  /// **'Add New'**
  String get addNew;

  /// No description provided for @productStatusUpdated.
  ///
  /// In en, this message translates to:
  /// **'Product status updated!'**
  String get productStatusUpdated;

  /// No description provided for @beauty.
  ///
  /// In en, this message translates to:
  /// **'Beauty'**
  String get beauty;

  /// No description provided for @automotive.
  ///
  /// In en, this message translates to:
  /// **'Automotive'**
  String get automotive;

  /// No description provided for @jewelry.
  ///
  /// In en, this message translates to:
  /// **'Jewelry'**
  String get jewelry;

  /// No description provided for @pets.
  ///
  /// In en, this message translates to:
  /// **'Pets'**
  String get pets;

  /// No description provided for @searchCategoriesHint.
  ///
  /// In en, this message translates to:
  /// **'Search categories...'**
  String get searchCategoriesHint;

  /// No description provided for @browseByCategory.
  ///
  /// In en, this message translates to:
  /// **'Browse products by category'**
  String get browseByCategory;

  /// No description provided for @categoriesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} categories'**
  String categoriesCount(Object count);

  /// No description provided for @noCategoriesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No categories available'**
  String get noCategoriesAvailable;

  /// No description provided for @noCategoriesFound.
  ///
  /// In en, this message translates to:
  /// **'No categories found'**
  String get noCategoriesFound;

  /// No description provided for @categoriesWillAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Categories will appear here'**
  String get categoriesWillAppearHere;

  /// No description provided for @noResultsFor.
  ///
  /// In en, this message translates to:
  /// **'No results for \"\$query\"'**
  String noResultsFor(Object query);

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// No description provided for @recentOrders.
  ///
  /// In en, this message translates to:
  /// **'Recent Orders'**
  String get recentOrders;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @updateStatus.
  ///
  /// In en, this message translates to:
  /// **'Update Status'**
  String get updateStatus;

  /// No description provided for @orderId.
  ///
  /// In en, this message translates to:
  /// **'Order ID'**
  String get orderId;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statusLabel;

  /// No description provided for @updateProfilePhoto.
  ///
  /// In en, this message translates to:
  /// **'Update Profile Photo'**
  String get updateProfilePhoto;

  /// No description provided for @browseAsUser.
  ///
  /// In en, this message translates to:
  /// **'Browse as User'**
  String get browseAsUser;

  /// No description provided for @deleteProductTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Product'**
  String get deleteProductTitle;

  /// No description provided for @deleteProductConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"? This action cannot be undone.'**
  String deleteProductConfirm(Object name);

  /// No description provided for @deletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'{name} deleted successfully'**
  String deletedSuccessfully(Object name);

  /// No description provided for @categoryRequired.
  ///
  /// In en, this message translates to:
  /// **'At least one category is required'**
  String get categoryRequired;

  /// No description provided for @imageRequired.
  ///
  /// In en, this message translates to:
  /// **'At least one image is required'**
  String get imageRequired;

  /// No description provided for @customBrandHint.
  ///
  /// In en, this message translates to:
  /// **'Enter custom brand name'**
  String get customBrandHint;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addPhoto;

  /// No description provided for @productImagesLabel.
  ///
  /// In en, this message translates to:
  /// **'Product Images *'**
  String get productImagesLabel;

  /// No description provided for @addOneToThreeImages.
  ///
  /// In en, this message translates to:
  /// **'Add 1-3 images'**
  String get addOneToThreeImages;

  /// No description provided for @adsManagement.
  ///
  /// In en, this message translates to:
  /// **'Ads Management'**
  String get adsManagement;

  /// No description provided for @adsConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Ads Configuration'**
  String get adsConfiguration;

  /// No description provided for @viewEditAdsPlans.
  ///
  /// In en, this message translates to:
  /// **'View and edit your Ads Plans.'**
  String get viewEditAdsPlans;

  /// No description provided for @expirationDate.
  ///
  /// In en, this message translates to:
  /// **'Expiration Date*'**
  String get expirationDate;

  /// No description provided for @setBySuperAdmin.
  ///
  /// In en, this message translates to:
  /// **'Set by Super Admin'**
  String get setBySuperAdmin;

  /// No description provided for @adsLimitLabel.
  ///
  /// In en, this message translates to:
  /// **'Ads Limit (0 to disable)'**
  String get adsLimitLabel;

  /// No description provided for @staticAdImageLabel.
  ///
  /// In en, this message translates to:
  /// **'Static Ad Image (Optional)'**
  String get staticAdImageLabel;

  /// No description provided for @dynamicAdImagesLabel.
  ///
  /// In en, this message translates to:
  /// **'Dynamic Ad Images ({count}/{limit})'**
  String dynamicAdImagesLabel(String count, String limit);

  /// No description provided for @noDynamicAds.
  ///
  /// In en, this message translates to:
  /// **'No dynamic ad images added yet'**
  String get noDynamicAds;

  /// No description provided for @clickAddImages.
  ///
  /// In en, this message translates to:
  /// **'Click \"Add Images\" button below to add images'**
  String get clickAddImages;

  /// No description provided for @downloadToSave.
  ///
  /// In en, this message translates to:
  /// **'Click download button to save, delete to remove'**
  String get downloadToSave;

  /// No description provided for @adsSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Ads images saved successfully!'**
  String get adsSavedSuccessfully;

  /// No description provided for @adsLimitError.
  ///
  /// In en, this message translates to:
  /// **'Dynamic Ad Images count ({count}) must match Ads Limit ({limit})'**
  String adsLimitError(String count, String limit);

  /// No description provided for @noStaticImageError.
  ///
  /// In en, this message translates to:
  /// **'No static image to download'**
  String get noStaticImageError;

  /// No description provided for @storagePermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Storage permission is required to download images'**
  String get storagePermissionRequired;

  /// No description provided for @enableStoragePermission.
  ///
  /// In en, this message translates to:
  /// **'Please enable storage permission in app settings'**
  String get enableStoragePermission;

  /// No description provided for @downloadSuccess.
  ///
  /// In en, this message translates to:
  /// **'Image downloaded successfully to Downloads folder'**
  String get downloadSuccess;

  /// No description provided for @downloadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to download image: {error}'**
  String downloadError(Object error);

  /// No description provided for @adsLimitDisabledByAdmin.
  ///
  /// In en, this message translates to:
  /// **'Ads limit is disabled (set to 0) by Super Admin'**
  String get adsLimitDisabledByAdmin;

  /// No description provided for @inventoryManagement.
  ///
  /// In en, this message translates to:
  /// **'Inventory Management'**
  String get inventoryManagement;

  /// No description provided for @productsOverview.
  ///
  /// In en, this message translates to:
  /// **'Products Overview'**
  String get productsOverview;

  /// No description provided for @manageStockLevels.
  ///
  /// In en, this message translates to:
  /// **'Manage stock levels for all products in your inventory.'**
  String get manageStockLevels;

  /// No description provided for @totalProducts.
  ///
  /// In en, this message translates to:
  /// **'Total Products'**
  String get totalProducts;

  /// No description provided for @lowStock.
  ///
  /// In en, this message translates to:
  /// **'Low Stock'**
  String get lowStock;

  /// No description provided for @inStockCount.
  ///
  /// In en, this message translates to:
  /// **'{count} in stock'**
  String inStockCount(String count);

  /// No description provided for @inventoryUpdated.
  ///
  /// In en, this message translates to:
  /// **'Inventory updated successfully!'**
  String get inventoryUpdated;

  /// No description provided for @cancelOrder.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order'**
  String get cancelOrder;

  /// No description provided for @cancelOrderConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel order {id}? This action cannot be undone.'**
  String cancelOrderConfirmation(String id);

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yesCancelOrder.
  ///
  /// In en, this message translates to:
  /// **'Yes, Cancel Order'**
  String get yesCancelOrder;

  /// No description provided for @orderCanceled.
  ///
  /// In en, this message translates to:
  /// **'Order {id} has been canceled'**
  String orderCanceled(String id);

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'UNDO'**
  String get undo;

  /// No description provided for @deleteOrderConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete order {id}?'**
  String deleteOrderConfirm(String id);

  /// No description provided for @shopsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Shops Found'**
  String shopsCount(int count);

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get clearFilters;

  /// No description provided for @discoverShops.
  ///
  /// In en, this message translates to:
  /// **'Discover Shops'**
  String get discoverShops;

  /// No description provided for @browseCuratedVendors.
  ///
  /// In en, this message translates to:
  /// **'Browse our curated vendors'**
  String get browseCuratedVendors;

  /// No description provided for @searchShopsHint.
  ///
  /// In en, this message translates to:
  /// **'Search shops by name...'**
  String get searchShopsHint;

  /// No description provided for @noShopsFound.
  ///
  /// In en, this message translates to:
  /// **'No shops found'**
  String get noShopsFound;

  /// No description provided for @noShopsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No shops available'**
  String get noShopsAvailable;

  /// No description provided for @shopsWillAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Shops will appear here'**
  String get shopsWillAppearHere;

  /// Number of products in a shop
  ///
  /// In en, this message translates to:
  /// **'{count} products'**
  String productCount(Object count);

  /// Number of shop views
  ///
  /// In en, this message translates to:
  /// **'{views} views'**
  String viewsCount(Object views);

  /// No description provided for @searchInShopHint.
  ///
  /// In en, this message translates to:
  /// **'Search in shop...'**
  String get searchInShopHint;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brand;

  /// No description provided for @priceRange.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get priceRange;

  /// No description provided for @noProductsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No products available'**
  String get noProductsAvailable;

  /// Number of items in cart
  ///
  /// In en, this message translates to:
  /// **'{count} in cart'**
  String inCartCount(Object count);

  /// No description provided for @skincare.
  ///
  /// In en, this message translates to:
  /// **'Skincare'**
  String get skincare;

  /// No description provided for @masks.
  ///
  /// In en, this message translates to:
  /// **'Masks'**
  String get masks;

  /// No description provided for @toners.
  ///
  /// In en, this message translates to:
  /// **'Toners'**
  String get toners;

  /// No description provided for @suncare.
  ///
  /// In en, this message translates to:
  /// **'Suncare'**
  String get suncare;

  /// No description provided for @lipCare.
  ///
  /// In en, this message translates to:
  /// **'Lip Care'**
  String get lipCare;

  /// No description provided for @bodyCare.
  ///
  /// In en, this message translates to:
  /// **'Body Care'**
  String get bodyCare;

  /// No description provided for @cleansers.
  ///
  /// In en, this message translates to:
  /// **'Cleansers'**
  String get cleansers;

  /// No description provided for @essences.
  ///
  /// In en, this message translates to:
  /// **'Essences'**
  String get essences;

  /// No description provided for @discoverProductsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Discover our complete collection'**
  String get discoverProductsSubtitle;

  /// No description provided for @allBrands.
  ///
  /// In en, this message translates to:
  /// **'All Brands'**
  String get allBrands;

  /// No description provided for @minPrice.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get minPrice;

  /// No description provided for @maxPrice.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get maxPrice;

  /// Number of products found in search results
  ///
  /// In en, this message translates to:
  /// **'{count} products found'**
  String productsFound(Object count);

  /// No description provided for @adjustFiltersHint.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your filters or search'**
  String get adjustFiltersHint;

  /// No description provided for @sportsOutdoors.
  ///
  /// In en, this message translates to:
  /// **'Sports & Outdoors'**
  String get sportsOutdoors;

  /// No description provided for @foodBeverages.
  ///
  /// In en, this message translates to:
  /// **'Food & Beverages'**
  String get foodBeverages;

  /// No description provided for @beautyHealth.
  ///
  /// In en, this message translates to:
  /// **'Beauty & Health'**
  String get beautyHealth;

  /// No description provided for @booksMedia.
  ///
  /// In en, this message translates to:
  /// **'Books & Media'**
  String get booksMedia;

  /// No description provided for @shippingMethod.
  ///
  /// In en, this message translates to:
  /// **'Shipping Method'**
  String get shippingMethod;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @shippingAddress.
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get shippingAddress;

  /// No description provided for @orderItems.
  ///
  /// In en, this message translates to:
  /// **'Order Items'**
  String get orderItems;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @generated.
  ///
  /// In en, this message translates to:
  /// **'Generated'**
  String get generated;

  /// No description provided for @ordersReport.
  ///
  /// In en, this message translates to:
  /// **'ORDERS REPORT'**
  String get ordersReport;

  /// No description provided for @ordersDocument.
  ///
  /// In en, this message translates to:
  /// **'Orders Document'**
  String get ordersDocument;

  /// No description provided for @ordersCount.
  ///
  /// In en, this message translates to:
  /// **'Orders Count'**
  String get ordersCount;

  /// No description provided for @itemsOrdered.
  ///
  /// In en, this message translates to:
  /// **'Items Ordered'**
  String get itemsOrdered;

  /// No description provided for @orderDate.
  ///
  /// In en, this message translates to:
  /// **'Order Date'**
  String get orderDate;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get filterPending;

  /// No description provided for @filterShipped.
  ///
  /// In en, this message translates to:
  /// **'Shipped'**
  String get filterShipped;

  /// No description provided for @filterCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get filterCompleted;

  /// No description provided for @filterCanceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get filterCanceled;

  /// No description provided for @orderStatus.
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get orderStatus;

  /// No description provided for @customerInfo.
  ///
  /// In en, this message translates to:
  /// **'Customer Information'**
  String get customerInfo;

  /// No description provided for @itemName.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get itemName;

  /// No description provided for @qty.
  ///
  /// In en, this message translates to:
  /// **'Qty'**
  String get qty;

  /// No description provided for @shippingFee.
  ///
  /// In en, this message translates to:
  /// **'Shipping Fee'**
  String get shippingFee;

  /// No description provided for @taxes.
  ///
  /// In en, this message translates to:
  /// **'Taxes'**
  String get taxes;

  /// No description provided for @shippingInfo.
  ///
  /// In en, this message translates to:
  /// **'Shipping Information'**
  String get shippingInfo;

  /// No description provided for @contactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInfo;

  /// No description provided for @paymentInfo.
  ///
  /// In en, this message translates to:
  /// **'Payment Information'**
  String get paymentInfo;

  /// No description provided for @orderNotes.
  ///
  /// In en, this message translates to:
  /// **'Order Notes'**
  String get orderNotes;

  /// No description provided for @noNotes.
  ///
  /// In en, this message translates to:
  /// **'No additional notes'**
  String get noNotes;

  /// No description provided for @totalOrders.
  ///
  /// In en, this message translates to:
  /// **'Total Orders'**
  String get totalOrders;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// No description provided for @backToDashboard.
  ///
  /// In en, this message translates to:
  /// **'Back to Dashboard'**
  String get backToDashboard;

  /// No description provided for @filterBy.
  ///
  /// In en, this message translates to:
  /// **'Filter By'**
  String get filterBy;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// No description provided for @clearAllFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear All Filters'**
  String get clearAllFilters;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @attributes.
  ///
  /// In en, this message translates to:
  /// **'Attributes'**
  String get attributes;

  /// No description provided for @selectColor.
  ///
  /// In en, this message translates to:
  /// **'Select Color'**
  String get selectColor;

  /// No description provided for @colorSelected.
  ///
  /// In en, this message translates to:
  /// **'Color Selected'**
  String get colorSelected;

  /// No description provided for @selectWeight.
  ///
  /// In en, this message translates to:
  /// **'Select Weight'**
  String get selectWeight;

  /// No description provided for @itemAdded.
  ///
  /// In en, this message translates to:
  /// **'item(s) added to cart'**
  String get itemAdded;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
