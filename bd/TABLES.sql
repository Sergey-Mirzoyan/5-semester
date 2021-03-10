USE MangaDB
GO

CREATE TABLE Manga
(
	id INT NOT NULL PRIMARY KEY,
	Name VARCHAR(85),
	Description VARCHAR(200),
	Count_of_sales INT,
	Count_of_chapters INT,
	Chapter_release_format VARCHAR(85)
);

--ѕропустить опр дату рождени€ (кому 18 лет)
--
CREATE TABLE MangaArtist
(
	id INT NOT NULL PRIMARY KEY,
	Name_Surname VARCHAR(85),
	Nickname VARCHAR(85),
	Birth_Date DATE,
	id_Assistant INT,
	CONSTRAINT FK_Mangaka_Assistant FOREIGN KEY (id_Assistant) REFERENCES MangaArtist (id)
);

CREATE TABLE PublishingHouse
(
	id INT NOT NULL PRIMARY KEY,
	Name VARCHAR(85) ,
	Creation_year INT,
	Adress VARCHAR(85)
);

CREATE TABLE Publication
(
	id_manga INT NOT NULL PRIMARY KEY,
	id_Manga_Artist INT,
	id_Publishing_House INT,
	status VARCHAR(85),
	End_year_of_publication INT,
	Rating FLOAT
	CONSTRAINT FK_Publication_manga FOREIGN KEY (id_manga) REFERENCES manga (id),
	CONSTRAINT FK_Publication_MangaArtist FOREIGN KEY (id_Manga_Artist) REFERENCES MangaArtist (id),
	CONSTRAINT FK_Publication_PublishingHouse FOREIGN KEY (id_Publishing_House) REFERENCES PublishingHouse (id),
	
);

CREATE TABLE Characters
(
	id int NOT NULL PRIMARY KEY,
	FirstName nvarchar(30),
	LastName nvarchar(40),
	manga_id int NOT NULL,
	CONSTRAINT FK_Characters_manga FOREIGN KEY (manga_id) REFERENCES manga (id)
) ;
select Chapter_release_format
from Manga

Alter table dbo.Manga
Add CONSTRAINT Chapter_release_format
CHECK (Chapter_release_format LIKE '1 (in|every) (month|week|year|few month)' );

Alter table dbo.MangaArtist
Add CONSTRAINT Birth_Date
CHECK (Birth_Date >= '2001-12-24');

ALTER TABLE dbo.Publication ADD
CONSTRAINT Rating CHECK (Rating >= 0.0 AND Rating <= 10.0);
GO


-- count of written mangas by every artist
Select Name_Surname, count(*) 
from MangaArtist group by Name_Surname