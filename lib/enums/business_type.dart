part of 'enums.dart';

enum BusinessType {
  restaurant('Restaurant', true),
  cafeAndCoffe('Cafe and Coffee', true),
  clothingStore('Clothing Store', false),
  bookStore('Book Store', false),
  electronicsStore('Electronics Store', false),
  sportsEquipmentStore('Sports Equipment Store', false),
  toyStore('Toy Store', false),
  jewelryStore('Jewelry Store', false),
  flowerShop('Flower Shop', false),
  kitchenEquipmentStore('Kitchen Equipment Store', false),
  electricalEquipmentStore('Electrical Equipment Store', false),
  gardenEquipmentStore('Garden Equipment Store', false),
  musicEquipmentStore('Music Equipment Store', false),
  computerEquipmentStore('Computer Equipment Store', false),
  securityEquipmentStore('Security Equipment Store', false),
  photographyEquipmentStore('Photography Equipment Store', false),
  householdEquipmentStore('Household Equipment Store', false),
  outdoorEquipmentStore('Outdoor Equipment Store', false),
  officeEquipmentStore('Office Equipment Store', false),
  electronicEquipmentStore('Electronic Equipment Store', false),
  foodCourt('Food Court', true),
  bakery('Bakery', true),
  carWorkshop('Car Workshop', false),
  bikeWorkshop('Bike Workshop', false),
  motorcycleWorkshop('Motorcycle Workshop', false),
  furnitureGallery('Furniture Gallery', false),
  beautySalon('Beauty Salon', false),
  storageWarehouse('Storage Warehouse', false),
  bookPublisher('Book Publisher', false),
  photographyService('Photography Service', false),
  graphicDesignService('Graphic Design Service', false),
  landscapingService('Landscaping Service', false),
  securityService('Security Service', false),
  massageService('Massage Service', false),
  contentWritingService('Content Writing Service', false),
  translationService('Translation Service', false),
  musicStudio('Music Studio', false),
  artStudio('Art Studio', false),
  laundryDryCleaning('Laundry and Dry Cleaning', false),
  digitalMarketingService('Digital Marketing Service', false),
  teachingService('Teaching Service', false),
  eventManagementService('Event Management Service', false),
  mobileAppDevelopmentService('Mobile App Development Service', false),
  interiorDesignService('Interior Design Service', false),
  clinic('Clinic', false),
  onlineFitnessService('Online Fitness Service', false),
  petShop('Pet Shop', false),
  cateringService('Catering Service', true),
  businessConsultingService('Business Consulting Service', false);

  const BusinessType(this.value, this.isFood);
  final String value;
  final bool isFood;

  factory BusinessType.fromValue(String value) {
    switch (value) {
      case 'Restaurant':
        return restaurant;
      case 'Cafe and Coffee':
        return cafeAndCoffe;
      case 'Clothing Store':
        return clothingStore;
      case 'Book Store':
        return bookStore;
      case 'Electronics Store':
        return electronicsStore;
      case 'Sports Equipment Store':
        return sportsEquipmentStore;
      case 'Toy Store':
        return toyStore;
      case 'Jewelry Store':
        return jewelryStore;
      case 'Flower Shop':
        return flowerShop;
      case 'Kitchen Equipment Store':
        return kitchenEquipmentStore;
      case 'Electrical Equipment Store':
        return electricalEquipmentStore;
      case 'Garden Equipment Store':
        return gardenEquipmentStore;
      case 'Music Equipment Store':
        return musicEquipmentStore;
      case 'Computer Equipment Store':
        return computerEquipmentStore;
      case 'Security Equipment Store':
        return securityEquipmentStore;
      case 'Photography Equipment Store':
        return photographyEquipmentStore;
      case 'Household Equipment Store':
        return householdEquipmentStore;
      case 'Outdoor Equipment Store':
        return outdoorEquipmentStore;
      case 'Office Equipment Store':
        return officeEquipmentStore;
      case 'Electronic Equipment Store':
        return electronicEquipmentStore;
      case 'Food Court':
        return foodCourt;
      case 'Bakery':
        return bakery;
      case 'Car Workshop':
        return carWorkshop;
      case 'Bike Workshop':
        return bikeWorkshop;
      case 'Motorcycle Workshop':
        return motorcycleWorkshop;
      case 'Furniture Gallery':
        return furnitureGallery;
      case 'Beauty Salon':
        return beautySalon;
      case 'Storage Warehouse':
        return storageWarehouse;
      case 'Book Publisher':
        return bookPublisher;
      case 'Photography Service':
        return photographyService;
      case 'Graphic Design Service':
        return graphicDesignService;
      case 'Landscaping Service':
        return landscapingService;
      case 'Security Service':
        return securityService;
      case 'Massage Service':
        return massageService;
      case 'Content Writing Service':
        return contentWritingService;
      case 'Translation Service':
        return translationService;
      case 'Music Studio':
        return musicStudio;
      case 'Art Studio':
        return artStudio;
      case 'Laundry and Dry Cleaning':
        return laundryDryCleaning;
      case 'Digital Marketing Service':
        return digitalMarketingService;
      case 'Teaching Service':
        return teachingService;
      case 'Event Management Service':
        return eventManagementService;
      case 'Mobile App Development Service':
        return mobileAppDevelopmentService;
      case 'Interior Design Service':
        return interiorDesignService;
      case 'Clinic':
        return clinic;
      case 'Online Fitness Service':
        return onlineFitnessService;
      case 'Pet Shop':
        return petShop;
      case 'Catering Service':
        return cateringService;
      case 'Business Consulting Service':
        return businessConsultingService;
      default:
        return restaurant;
    }
  }
}
