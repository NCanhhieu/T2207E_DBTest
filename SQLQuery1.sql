--2. Create table based on the above design.
create table AsmT_Categories(
	CateID varchar(6) primary key,
	CateName nvarchar(100) not null unique ,
	Description nvarchar(200)  
);
create table AsmT_Parts(
    PartID int primary key identity(1,1),
	PartName nvarchar(100) not null,
	Description nvarchar(1000) ,
	Price decimal(12,4) not null check(Price >= 0) default 0,
	Quantity int check(Quantity >= 0) default 0 ,
	Warranty int check(Warranty >= 1) default 1 ,
	Photo nvarchar(200) check(Photo like 'photo/%') Default  'photo/nophoto.png',
	CateID varchar(6) foreign key references  AsmT_Categories(CateID) not null
	);

--3. Insert into each table at least three records.
insert into AsmT_Categories(CateID,CateName,Description) 
values('A01',N'Ram',N'bộ nhớ ram'),('B02',N'CPU',N' Bộ phận xử lý trung tâm '),('C03',N'HDD',N'ổ cứng');

insert into AsmT_Parts(CateID,PartName,Description,Price,Quantity,Warranty,Photo) 
values('A01',N'Ram Corsair Vengeance LED',N' ram của Corsair dòng Vengeance', 80, 10, 3, N'photo/RamCVl.jpg'),
('A01',N'Ram G.Skill TridentZ Royal',N'ram của G.Skill dòng TridentZ',180, 3, 8, N'photo/RamGTR.jpg'),
('B02', N'Intel Core i', N'dòng core i',60,20, 4, N'photo/CoreI.png' ),
('B02', N'Intel Xeon', N'dòng Xeon',110, 10, 12, N'photo/Xeon.png' ),
('C03',N'Toshiba', N'dòng MD04ABA400V', 25, 70, 3, N'photo/Xeon.png'),
('C03', N'HGST', N'HUH728080ALE600', 50 , 60, 3, N'photo/Xeon.png');

--4. List all parts in the store with price > 100$.
select * from AsmT_Parts  where Price > 100 

--5. List all parts of the category ‘CPU’.
select * from AsmT_Parts  where CateID  in ( select CateID from AsmT_Categories where CateName like 'CPU' )

--6. Create a view v_Parts contains the following information (PartID, PartName, CateName,Price, Quantity) from table Parts and Categories.
 create view v_Parts as
select A.PartID, A.PartName, B.CateName , A.Price , A.Quantity  from AsmT_Parts A
left join AsmT_Categories B on A.CateID = B.CateID;
 

--7. Create a view v_TopParts about 5 parts with the most expensive price.
create view v_TopParts as
select Top 5 PartName , Price  from AsmT_Parts A order by Price desc;
 select * from v_TopParts

