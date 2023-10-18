abort;
DROP TABLE car CASCADE;

DROP TABLE IF EXISTS Car;
DROP TABLE IF EXISTS Status;
DROP TABLE IF EXISTS CarType;
DROP TABLE IF EXISTS CarWheel;
DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee
(
	userName		VARCHAR(20)		PRIMARY KEY,
	password		VARCHAR(40)		NOT NULL,
	firstName		VARCHAR(20)		NOT NULL,
	lastName		VARCHAR(20)		NOT NULL,
	phoneNo			VARCHAR(20)		NOT NULL,
	email			VARCHAR(100),
	postalAddress	VARCHAR(200)
);

INSERT INTO Employee VALUES ('jswift', 	'111','James', 	'Swift', 	'0422834091', 'jamesswift@hotmail.com',	'7 Tesolin Way Westgate QLD');
INSERT INTO Employee VALUES ('mchan', 	'222','Maggie', 'Chan', 	'0449123875', 'maggie_chan@msn.com', 	'28 Greenway St Townsville QLD');
INSERT INTO Employee VALUES ('opalster','333','Oliver', 'Palster', 	'0433981245', 'oliver.p@hotmail.com', 	'12 North Terrace Hobart TAS');
INSERT INTO Employee VALUES ('jkeller', '444','Jack', 	'Keller',	'0451389100', 'jkeller72@msn.com', 		'19/10 George St Sydney NSW');
INSERT INTO Employee VALUES ('ktaylor', '555','Ken', 	'Taylor', 	'0477934342', 'nbrown@mrc.com.au', 		'6 North Terrace Queensland QLD');
INSERT INTO Employee VALUES ('mmiller', '666','Maggie', 'Miller', 	'0411248453', 'mmiller@mrc.com.au', 	'5/208 Castlehigh St Newtown NSW');
INSERT INTO Employee VALUES ('jdavis', 	'777','Jamie', 	'Davis', 	'0422349845', 'jdavis@mrc.com.au', 		'3 Greenfell Way Summerhill NSW');
INSERT INTO Employee VALUES ('njohnson','888','Neil', 	'Johnson', 	'0455989822', 'njohnson@mrc.com.au', 	'49 North Terrace Queensland QLD');
INSERT INTO Employee VALUES ('glenna',	'999','Glenn',	'Anthony',	'0413834588', 'ganderson@mrc.com.au', 	'1/15 Castlehigh St Newtown NSW');
INSERT INTO Employee VALUES ('cbowtel', '123','Carie', 	'Bowtel', 	'0481773921', 'cbowtel59@gmail.com', 	'12 Glenfield St Eastgarden NSW');

CREATE TABLE Status
(
	statusID		SERIAL	PRIMARY KEY,
	statusName		VARCHAR(20) UNIQUE NOT NULL,
	statusDesc		VARCHAR(50)	NOT NULL
);

INSERT INTO Status VALUES (1, 'New Stock', 'Newly purchased car');
INSERT INTO Status VALUES (2, 'Hire Ready', 'Car ready for hire');
INSERT INTO Status VALUES (3, 'Hired', 'Car on hire');
INSERT INTO Status VALUES (4, 'Repair', 'Car being repaired');
INSERT INTO Status VALUES (5, 'Unavailable', 'Car not available due to other reasons');
INSERT INTO Status VALUES (6, 'Write Off', 'Car has been written off');

CREATE TABLE CarType
(
	carTypeID		SERIAL	PRIMARY KEY,
	carTypeName		VARCHAR(10)	UNIQUE NOT NULL,
	carTypeDesc		VARCHAR(30)	NOT NULL
);

INSERT INTO CarType VALUES (1, 'Sedan', 'Sedan');
INSERT INTO CarType VALUES (2, 'SUV', 'Sport Utility Vehicles');
INSERT INTO CarType VALUES (3, 'MPV', 'Multi-Purpose Vehicles');

CREATE TABLE CarWheel
(
	carWheelID		SERIAL	PRIMARY KEY,
	carWheelName	VARCHAR(10)	UNIQUE NOT NULL,
	carWheelDesc	VARCHAR(30)	NOT NULL
);

INSERT INTO CarWheel VALUES (1, '2WD', 'Two Wheel Drive');
INSERT INTO CarWheel VALUES (2, '4WD', 'Four Wheel Drive');
INSERT INTO CarWheel VALUES (3, 'AWD', 'All Wheel Drive');

CREATE TABLE Car
(
	carID			SERIAL		PRIMARY KEY,
	make			VARCHAR(30) NOT NULL,
	model			VARCHAR(30) NOT NULL,
	statusID		INTEGER		NOT NULL REFERENCES Status,
	carTypeID		INTEGER		NOT NULL REFERENCES CarType,
	carWheelID		INTEGER		REFERENCES CarWheel,
	purchaseDate	DATE		NOT NULL,
	managedBy		VARCHAR(20) REFERENCES Employee,
	description		VARCHAR(400)
);
                                                                                                                                     
INSERT INTO Car (make, model, statusid, cartypeid, carwheelid, purchasedate, managedby, description) VALUES ('Audi','A4',1,1,NULL,TO_DATE('19/03/2020', 'DD/MM/YYYY'),NULL,'The A4 combines a satisfying driving experience, standard all-wheel drive, and a stout build in an understated yet elegant premium sedan.');
INSERT INTO Car (make, model, statusid, cartypeid, carwheelid, purchasedate, managedby, description) VALUES ('Audi','Q3',3,2,2,TO_DATE('12/02/2019', 'DD/MM/YYYY'),'mchan','The Audi Q7 is a large luxury SUV available in just the one five-door wagon body style and features both luxurious appointments and dynamic styling.');
INSERT INTO Car (make, model, statusid, cartypeid, carwheelid, purchasedate, managedby, description) VALUES ('Hyundai','i30',4,1,1,TO_DATE('08/08/2021', 'DD/MM/YYYY'),'opalster','The stylish i30 range is loaded with equipment, including great smartphone integration and a broad active safety suite.');
INSERT INTO Car (make, model, statusid, cartypeid, carwheelid, purchasedate, managedby, description) VALUES ('Kia','Carnival',5,3,NULL,TO_DATE('02/07/2019', 'DD/MM/YYYY'),'cbowtel','Featuring a wealth of class-leading technology and first-class comfort for eight, the Carnival redefines the People Mover category.');
INSERT INTO Car (make, model, statusid, cartypeid, carwheelid, purchasedate, managedby, description) VALUES ('Kia','Sportage',2,2,3,TO_DATE('10/03/2023', 'DD/MM/YYYY'),'jswift','Fusing a long, extremely athletic body with an unstoppable attitude, the redesigned Sportage is the new benchmark medium SUV.');
INSERT INTO Car (make, model, statusid, cartypeid, carwheelid, purchasedate, managedby, description) VALUES ('Mazda','CX-5',6,2,1,TO_DATE('11/09/2021', 'DD/MM/YYYY'),'mmiller','Backed up by a pair of high-tech four-cylinder petrol engines (2.0- and 2.5-litre) and impressive road manners it has s become an Aussie family favourite.');
INSERT INTO Car (make, model, statusid, cartypeid, carwheelid, purchasedate, managedby, description) VALUES ('Mazda','CX-9',4,2,3,TO_DATE('01/02/2020', 'DD/MM/YYYY'),'njohnson','The Mazda CX-9 is a large family SUV that offers a compelling combination of space, handsome exterior styling, and a high-quality cabin.');
INSERT INTO Car (make, model, statusid, cartypeid, carwheelid, purchasedate, managedby, description) VALUES ('Mercedes-Benz','V Class',1,3,NULL,TO_DATE('20/10/2021', 'DD/MM/YYYY'),'jswift','The V-Class has an expressive exterior design resulting from the interplay of striking lines and large, smooth surfaces.');
INSERT INTO Car (make, model, statusid, cartypeid, carwheelid, purchasedate, managedby, description) VALUES ('Volvo','Polestar 2',2,1,1,TO_DATE('03/04/2021', 'DD/MM/YYYY'),'jswift','The Polestar 2 is an EV hatchback that evolves into a more tempting Tesla alternative thanks to updates and fine-tuning.');
INSERT INTO Car (make, model, statusid, cartypeid, carwheelid, purchasedate, managedby, description) VALUES ('Volvo','Polestar 3',1,2,3,TO_DATE('10/03/2023', 'DD/MM/YYYY'),'jswift',NULL);
INSERT INTO Car (make, model, statusid, cartypeid, carwheelid, purchasedate, managedby, description) VALUES ('Tesla','Model 3',2,1,1,TO_DATE('17/11/2019', 'DD/MM/YYYY'),'mmiller','Model 3 is designed for electric-powered performance, with quick acceleration, long range and fast charging.');
INSERT INTO Car (make, model, statusid, cartypeid, carwheelid, purchasedate, managedby, description) VALUES ('Tesla','Model Y',1,2,2,TO_DATE('28/07/2021', 'DD/MM/YYYY'),NULL,'Model Y is capable in rain, snow, mud and off-road. The Model Y is based on the Model 3 sedan platform.');
INSERT INTO Car (make, model, statusid, cartypeid, carwheelid, purchasedate, managedby, description) VALUES ('Toyota','Camry',3,1,NULL,TO_DATE('06/06/2017', 'DD/MM/YYYY'),'jdavis','Australia''s most popular mid-size sedan delivers knock-out value, with room for the whole family');
INSERT INTO Car (make, model, statusid, cartypeid, carwheelid, purchasedate, managedby, description) VALUES ('Toyota','RAV4',3,2,2,TO_DATE('03/12/2019', 'DD/MM/YYYY'),'cbowtel',NULL);

COMMIT;


select * from Car;