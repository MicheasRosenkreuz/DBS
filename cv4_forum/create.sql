
CREATE TABLE Tema (
     id_tema Integer NOT NULL, 
     spravce Integer,
     nazev NVarChar(100) NOT NULL UNIQUE, 
)
go

CREATE TABLE Uzivatel (
      id_uzivatel Integer Identity,
      [login] NVarChar(50) NOT NULL,
      [password] NVarChar(50) NOT NULL,
  PRIMARY KEY (id_uzivatel)
)
go

CREATE TABLE Prihlaseni (
      id_uzivatel Integer NOT NULL,
      id_tema Integer NOT NULL,
      naposledy Datetime,
  CONSTRAINT PK_Prihlaseni PRIMARY KEY (id_uzivatel, id_tema) 
)
go



ALTER TABLE Tema ADD CONSTRAINT PK_Tema PRIMARY KEY(id_tema)
go
ALTER TABLE Uzivatel ADD CONSTRAINT UQ_Login UNIQUE([login])
go
ALTER TABLE Prihlaseni ADD CONSTRAINT FK_Tema FOREIGN KEY(id_tema) REFERENCES Tema(id_tema) ON DELETE NO ACTION 
go
ALTER TABLE Tema ADD CONSTRAINT FK_Spravce FOREIGN KEY(spravce) REFERENCES Uzivatel(id_uzivatel) ON DELETE SET NULL
go
ALTER TABLE Prihlaseni ADD CONSTRAINT FK_Uzivatel FOREIGN KEY(id_uzivatel) REFERENCES Uzivatel(id_uzivatel) ON DELETE CASCADE
go

/*
DROP TABLE Tema
DROP TABLE Uzivatel 
DROP TABLE Prihlaseni 
*/

INSERT INTO Tema (id_tema, nazev, spravce) VALUES (1, 'Jak nakladat hermelin', 1)
go
INSERT INTO Uzivatel ([login], [password]) VALUES ('Gurman', HashBytes('MD5','nakladamrad'))
go