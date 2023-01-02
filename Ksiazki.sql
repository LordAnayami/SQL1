/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     2021-10-10 12:40:22                          */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Autorstwo') and o.name = 'FK_AUTORSTW_AUTORSTWO_KSIAZKI')
alter table Autorstwo
   drop constraint FK_AUTORSTW_AUTORSTWO_KSIAZKI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Autorstwo') and o.name = 'FK_AUTORSTW_AUTORSTWO_AUTOR')
alter table Autorstwo
   drop constraint FK_AUTORSTW_AUTORSTWO_AUTOR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('AUTOR')
            and   type = 'U')
   drop table AUTOR
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Autorstwo')
            and   name  = 'Autorstwo2_FK'
            and   indid > 0
            and   indid < 255)
   drop index Autorstwo.Autorstwo2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Autorstwo')
            and   name  = 'Autorstwo_FK'
            and   indid > 0
            and   indid < 255)
   drop index Autorstwo.Autorstwo_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Autorstwo')
            and   type = 'U')
   drop table Autorstwo
go

if exists (select 1
            from  sysobjects
           where  id = object_id('KSIAZKI')
            and   type = 'U')
   drop table KSIAZKI
go

/*==============================================================*/
/* Table: AUTOR                                                 */
/*==============================================================*/
create table AUTOR (
   ID_autor             numeric              identity,
   Imie_autor           varchar(15)          not null,
   Nazwisko_autor       varchar(15)          not null,
   constraint PK_AUTOR primary key nonclustered (ID_autor)
)
go

/*==============================================================*/
/* Table: Autorstwo                                             */
/*==============================================================*/
create table Autorstwo (
   ID_ksiazki           numeric              not null,
   ID_autor             numeric              not null,
   constraint PK_AUTORSTWO primary key (ID_ksiazki, ID_autor)
)
go

/*==============================================================*/
/* Index: Autorstwo_FK                                          */
/*==============================================================*/
create index Autorstwo_FK on Autorstwo (
ID_ksiazki ASC
)
go

/*==============================================================*/
/* Index: Autorstwo2_FK                                         */
/*==============================================================*/
create index Autorstwo2_FK on Autorstwo (
ID_autor ASC
)
go

/*==============================================================*/
/* Table: KSIAZKI                                               */
/*==============================================================*/
create table KSIAZKI (
   ID_ksiazki           numeric              identity,
   Nazwa_ksiazki        varchar(15)          not null,
   Tematyka             varchar(20)          not null,
   Data_wydania         datetime             not null,
   Data_wypozyczenia    datetime             not null,
   constraint PK_KSIAZKI primary key nonclustered (ID_ksiazki)
)
go

alter table Autorstwo
   add constraint FK_AUTORSTW_AUTORSTWO_KSIAZKI foreign key (ID_ksiazki)
      references KSIAZKI (ID_ksiazki)
go

alter table Autorstwo
   add constraint FK_AUTORSTW_AUTORSTWO_AUTOR foreign key (ID_autor)
      references AUTOR (ID_autor)
go

