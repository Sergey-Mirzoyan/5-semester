from faker import Faker
import random

fake = Faker()
fake = Faker('ru_RU')
for i in range(1, 110):
    habbited, s_x, s_y = random.randint(0, 1), random.randint(6, 30), random.randint(6, 30)
    if habbited == 0:
        price = s_x * s_y * random.randint(150, 175)/100 * 10000
        print(i, ';', fake.name(),';',fake.city(), ";", "Без построек", ";", price, ';',fake.latitude(), ';',fake.longitude())
    else:
        price = s_x * s_y * random.randint(100, 125)/100 * 10000
        print(i, ';', fake.name(),';',fake.city(), ";","Есть постройки ",";", price, ';',fake.latitude(), ';',fake.longitude())
