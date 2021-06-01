class Category{

  Category({
    this.name = '',
    this.imagePath = '',
    this.reduction = 0,
  });

  String name;
  String imagePath;
  int reduction;

  static List<Category> rewardListe = <Category>[
    Category(
      imagePath: 'images/Reward/Beer-OClock.jpg',
      name: "BEER O'CLOCK",
      reduction: 10,
    ),
    Category(
      imagePath: 'images/Reward/laCave.jpg',
      name: 'LA CAVE',
      reduction: 10,
    ),
    Category(
      imagePath: 'images/Reward/crazyClock.jpg',
      name: 'CRAZY CLOCK',
      reduction: 10,
    ),
    Category(
      imagePath: 'images/Reward/moon.jpg',
      name: 'LE MOON',
      reduction: 10,
    ),
    Category(
      imagePath: 'images/Reward/glacier-des-alpes.jpg',
      name: 'GLACIER DES ALPES',
      reduction: 10,
    ),
    Category(
      imagePath: 'images/Reward/barberousse.jpg',
      name: 'BARBEROUSSE',
      reduction: 10,
    ),
  ];
}