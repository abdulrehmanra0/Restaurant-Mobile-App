import '../models/product_model.dart';

class SampleData {
  // A static list of products to be used throughout the app.
  static final List<Product> products = [
    Product(
      id: '1',
      name: 'Chicken Burger',
      shortDescription: 'Spicy & Juicy',
      longDescription:
          'A deliciously juicy chicken patty with a spicy kick, topped with fresh lettuce, tomatoes, and our secret sauce, all served on a toasted sesame seed bun. A true classic that never disappoints.',
      imagePath: 'assets/images/chicken_burger.png',
      bannerImagePath: 'assets/images/burger_banner.png',
      price: 310.00,
      rating: 4.8,
      orderCount: 2100,
      isPopular: true,
    ),
    Product(
      id: '2',
      name: 'Salmon Salad',
      shortDescription: 'Healthy & Fresh',
      longDescription:
          'A healthy and refreshing mix of crisp greens, cherry tomatoes, cucumbers, and onions, topped with a perfectly grilled salmon fillet. Drizzled with a light lemon vinaigrette.',
      imagePath: 'assets/images/salmon_salad.jpg',
      price: 285.00,
      rating: 4.6,
      orderCount: 1500,
    ),
    Product(
      id: '3',
      name: 'Caesar Salad',
      shortDescription: 'Classic Taste',
      longDescription:
          'Crisp romaine lettuce, crunchy croutons, and freshly grated Parmesan cheese, all tossed in our signature creamy Caesar dressing. A timeless favorite.',
      imagePath: 'assets/images/caesar_salad.jpg',
      price: 250.00,
      rating: 4.5,
      orderCount: 1800,
    ),
    Product(
      id: '4',
      name: 'Margherita Pizza',
      shortDescription: 'Fresh & Cheesy',
      longDescription:
          'A classic Italian pizza with a thin crust, topped with fresh tomato sauce, mozzarella cheese, basil leaves, and a drizzle of olive oil. Simple yet bursting with flavor.',
      imagePath: 'assets/images/margherita_pizza.jpg',
      price: 450.00,
      rating: 4.7,
      orderCount: 1200,
      isPopular: true,
    ),
    Product(
      id: '5',
      name: 'Grilled  Wrap',
      shortDescription: 'Tasty & Portable',
      longDescription:
          'Tender grilled chicken breast wrapped in a soft tortilla with crisp lettuce, avocado, tomatoes, and a creamy ranch dressing. Perfect for a quick meal on the go.',
      imagePath: 'assets/images/chicken_wrap.jpg',
      price: 280.00,
      rating: 4.4,
      orderCount: 900,
    ),
    Product(
      id: '6',
      name: 'Lava Cake',
      shortDescription: 'Rich & Decadent',
      longDescription:
          'A warm, gooey chocolate cake with a molten center, served with a scoop of vanilla ice cream and a sprinkle of powdered sugar. A dessert lover’s dream.',
      imagePath: 'assets/images/chocolate_lava_cake.jpg',
      price: 200.00,
      rating: 4.9,
      orderCount: 800,
      isPopular: true,
    ),
    Product(
      id: '7',
      name: 'Mango Smoothie',
      shortDescription: 'Cool & Refreshing',
      longDescription:
          'A creamy blend of ripe mangoes, yogurt, and a touch of honey, served chilled. The perfect refreshing drink for any time of day.',
      imagePath: 'assets/images/mango_smoothie.jpg',
      price: 150.00,
      rating: 4.3,
      orderCount: 600,
    ),
    Product(
      id: '8',
      name: 'BBQ Beef Ribs',
      shortDescription: 'Smoky & Tender',
      longDescription:
          'Slow-cooked beef ribs slathered in a tangy BBQ sauce, served with coleslaw and crispy fries. A hearty meal for meat lovers.',
      imagePath: 'assets/images/bbq_ribs.jpg',
      price: 550.00,
      rating: 4.8,
      orderCount: 1100,
    ),
    Product(
      id: '9',
      name: 'Vegetarian Sushi',
      shortDescription: 'Fresh & Flavorful',
      longDescription:
          'A delightful mix of avocado, cucumber, carrots, and cream cheese wrapped in sushi rice and nori. Served with soy sauce and wasabi.',
      imagePath: 'assets/images/veggie_sushi.png',
      price: 320.00,
      rating: 4.5,
      orderCount: 700,
    ),
    Product(
      id: '10',
      name: 'Iced Latte',
      shortDescription: 'Smooth & Creamy',
      longDescription:
          'A chilled espresso drink mixed with milk and a hint of vanilla, served over ice. Perfect for coffee enthusiasts.',
      imagePath: 'assets/images/iced_latte.jpg',
      price: 180.00,
      rating: 4.4,
      orderCount: 500,
    ),
  ];

  // Featured special offer
  static final Product specialOffer = products[0]; // Chicken Burger
}

// import '../models/product_model.dart';

// class SampleData {
//   // A static list of products to be used throughout the app.
//   static final List<Product> products = [
//     Product(
//       id: '1',
//       name: 'Chicken Burger',
//       shortDescription: 'Spicy & Juicy',
//       longDescription:
//           'A deliciously juicy chicken patty with a spicy kick, topped with fresh lettuce, tomatoes, and our secret sauce, all served on a toasted sesame seed bun. A true classic that never disappoints.',
//       imagePath:
//           'assets/images/chicken_burger.png', // You need to add these images
//       bannerImagePath:
//           'assets/images/burger_banner.png', // Add this banner image
//       price: 310.00,
//       rating: 4.8,
//       orderCount: 2100, // Represent 2000+ as an integer
//       isPopular: true,
//     ),
//     Product(
//       id: '2',
//       name: 'Salmon Salad',
//       shortDescription: 'Healthy & Fresh',
//       longDescription:
//           'A healthy and refreshing mix of crisp greens, cherry tomatoes, cucumbers, and onions, topped with a perfectly grilled salmon fillet. Drizzled with a light lemon vinaigrette.',
//       imagePath: 'assets/images/salmon_salad.jpg', // Add this image
//       price: 285.00,
//       rating: 4.6,
//       orderCount: 1500,
//     ),
//     Product(
//       id: '3',
//       name: 'Caesar Salad',
//       shortDescription: 'Classic Taste',
//       longDescription:
//           'Crisp romaine lettuce, crunchy croutons, and freshly grated Parmesan cheese, all tossed in our signature creamy Caesar dressing. A timeless favorite.',
//       imagePath: 'assets/images/caesar_salad.jpg', // Add this image
//       price: 250.00,
//       rating: 4.5,
//       orderCount: 1800,
//     ),
//   ];

//   // You can also define a specific banner here
//   static final Product specialOffer = products[0]; // Let's feature the burger
// }
