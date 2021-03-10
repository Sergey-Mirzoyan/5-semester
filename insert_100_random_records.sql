BULK INSERT MangaDB.dbo.manga
FROM 'C:\Users\serge\Desktop\Базы данных\Manga.csv'
WITH (DATAFILETYPE = 'char', FIRSTROW = 2, FIELDTERMINATOR = '@', ROWTERMINATOR = '0x0a', CODEPAGE = 1251);
GO 

BULK INSERT MangaDB.dbo.MangaArtist
FROM 'C:\Users\serge\Desktop\Базы данных\MangaArtist.csv'
WITH (DATAFILETYPE = 'char', FIRSTROW = 2, FIELDTERMINATOR = '@', ROWTERMINATOR = '0x0a');
GO 

BULK INSERT MangaDB.dbo.PublishingHouse
FROM 'C:\Users\serge\Desktop\Базы данных\PublishingHouse.csv'
WITH (DATAFILETYPE = 'char', FIRSTROW = 2, FIELDTERMINATOR = '@', ROWTERMINATOR = '0x0a');
GO 

BULK INSERT MangaDB.dbo.Publication
FROM 'C:\Users\serge\Desktop\Базы данных\Publication.csv'
WITH (DATAFILETYPE = 'char', FIRSTROW = 2, FIELDTERMINATOR = '@', ROWTERMINATOR = '0x0a');
GO 