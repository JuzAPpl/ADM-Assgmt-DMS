DROP TABLE Compensate;
DROP TABLE Supply;
DROP TABLE Resources;
DROP TABLE Supplier;
DROP TABLE Treatment;
DROP TABLE Staff;
DROP TABLE Patient;
DROP TABLE Victim;
DROP TABLE Occur;
DROP TABLE Disaster;
DROP TABLE Citizen;
DROP TABLE City;
DROP TABLE State;

CREATE TABLE State(
	StateID	 	VARCHAR(10)	NOT NULL,
	StateName 	VARCHAR(20) NOT NULL,
	PRIMARY KEY (StateID)
);

CREATE TABLE City(
	CityID		VARCHAR(10)	NOT NULL,
	CityName	VARCHAR(50)	NOT NULL,
	StateID		VARCHAR(10) NOT NULL,
	PRIMARY	KEY	(CityID),
	CONSTRAINT FK_StateID_City FOREIGN KEY (StateID) REFERENCES State(StateID)
);

CREATE TABLE Citizen(
	ICNumber	VARCHAR(15)	NOT NULL,
	CitizenName	VARCHAR(100),
	ContactNum	VARCHAR(15),
	Status		VARCHAR(20),
	Address		VARCHAR(100),
	CityID		VARCHAR(10),
	PRIMARY KEY	(ICNumber),
	CONSTRAINT FK_CityID_Citizen FOREIGN KEY	(CityID) REFERENCES City(CityID)
);

CREATE TABLE Disaster(
	DisasterID	VARCHAR(15) NOT NULL,
	DisasterType VARCHAR(50),
	DisasterDesc VARCHAR(100),
	PRIMARY KEY	(DisasterID)
);

CREATE TABLE Occur(
	OccurID		VARCHAR(15) NOT NULL,
	OccurDate	DATE	DEFAULT SYSDATE,
	CityID		VARCHAR(10),
	DisasterID	VARCHAR(15),
	PRIMARY KEY (OccurID),
	CONSTRAINT FK_CityID_Occur FOREIGN KEY (CityID) REFERENCES City(CityID),
	CONSTRAINT FK_DisasterID_Occur FOREIGN KEY	(DisasterID) REFERENCES Disaster(DisasterID)
);

CREATE TABLE Supplier(
	SupplierID	VARCHAR(15) NOT NULL,
	SupplierName VARCHAR(50),
	ContactNum	VARCHAR(15),
	PRIMARY KEY (SupplierID)
);

CREATE TABLE Resources(
	ResourceID VARCHAR(15) NOT NULL,
	ResourceType VARCHAR(50),
	Stock	NUMBER(10),
	PRIMARY KEY (ResourceID)
);

CREATE TABLE Supply(
	SupplierID	VARCHAR(15) NOT NULL,
	ResourceID VARCHAR(15) NOT NULL,
	PRIMARY KEY (ResourceID, SupplierID),
	CONSTRAINT FK_SupplierID_Supply FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
	CONSTRAINT FK_ResourceID_Supply FOREIGN KEY (ResourceID) REFERENCES Resources(ResourceID)
);

CREATE TABLE Victim(
	VictimID	VARCHAR(15) NOT NULL,
	RegisterDate	DATE	DEFAULT SYSDATE,
	Status		VARCHAR(20),
	ICNumber	VARCHAR(15),
	OccurID		VARCHAR(15),
	PRIMARY KEY (VictimID),
	CONSTRAINT FK_ICNumber_Victim FOREIGN KEY (ICNumber) REFERENCES Citizen(ICNumber),
	CONSTRAINT FK_OccurID_Victim FOREIGN KEY (OccurID) REFERENCES Occur(OccurID)
);

CREATE TABLE Patient(
	PatientID	VARCHAR(15) NOT NULL,
	Status		VARCHAR(20),
	RegisterDate	DATE	DEFAULT SYSDATE,
	VictimID	VARCHAR(15),
	PRIMARY KEY (PatientID),
	CONSTRAINT FK_VictimID_Patient FOREIGN KEY (VictimID) REFERENCES Victim(VictimID)
);

CREATE TABLE Staff(
	StaffID		VARCHAR(15) NOT NULL,
	Role		VARCHAR(20),
	RecruitDate	DATE,
	Status		VARCHAR(20),
	ICNumber	VARCHAR(15),
	PRIMARY KEY (StaffID),
	CONSTRAINT FK_ICNumber_Staff FOREIGN KEY (ICNumber) REFERENCES Citizen(ICNumber)
);

CREATE TABLE Treatment(
	PatientID	VARCHAR(15) NOT NULL,
	StaffID		VARCHAR(15) NOT NULL,
	TreatmentDate	DATE,
	PRIMARY KEY (PatientID, StaffID),
	CONSTRAINT FK_PatientID_Treatment FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
	CONSTRAINT FK_StaffID_Treatment FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

CREATE TABLE Compensate(
	CompensateID	VARCHAR(15) NOT NULL,
	DistributeDate	DATE,
	Status			VARCHAR(20),
	Quantity		NUMBER(20),
	OccurID			VARCHAR(15),
	StaffID			VARCHAR(15),
	ResourceID 		VARCHAR(15),
	PRIMARY KEY (CompensateID),
	CONSTRAINT FK_OccurID_Compensate FOREIGN KEY (OccurID) REFERENCES Occur(OccurID),
	CONSTRAINT FK_StaffID_Compensate FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
	CONSTRAINT FK_ResourceID_Compensate FOREIGN KEY (ResourceID) REFERENCES Resources(ResourceID)
);