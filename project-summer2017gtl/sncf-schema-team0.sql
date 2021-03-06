-- Sample schema for Summer 2017 GTL project
-- Be sure to put use your own team number in place of team0.
-- Please double check for correctness.

drop database if exists sncf_team0;
create database sncf_team0;
use sncf_team0;

-- any user_id not in customer table is an admin
-- admins are only added by DBA, not by the train reservation application
create table user (
  user_id int primary key auto_increment,
  email char(32) unique not null,
  password char(128) not null,
  first_name varchar(32),
  last_name varchar(64)
);

create table address (
  address_id int primary key auto_increment,
  line1 varchar(32),
  line2 varchar(32),
  city varchar(32),
  state char(16),
  post_code char(16),
  country char(16)
);

create table customer (
  customer_id int primary key auto_increment,
  user_id int not null,
  address_id int not null,
  birthdate date,
  credit_card_no char(17) not null,
  credit_card_expiry date,

  foreign key (user_id) references user(user_id)
    on update cascade
    on delete cascade,
  foreign key (address_id) references address(address_id)
    on update cascade
    on delete restrict
);

create table trip (
  trip_id int primary key auto_increment,
  customer_id int,
  price decimal(5,2),

  foreign key (customer_id) references customer(customer_id)
    on update cascade
    on delete restrict
);

create table passenger (
  passenger_id int primary key auto_increment,
  first_name varchar(32),
  last_name varchar(64),
  birthdate date,
  trip_id int not null,

  foreign key (trip_id) references trip(trip_id)
    on update cascade
    on delete restrict
);

create table station (
  station_id int primary key auto_increment,
  name varchar(16) unique not null,
  address_id int,

  foreign key (address_id) references address(address_id)
    on update cascade
    on delete restrict
);

create table train (
  train_id int primary key auto_increment,
  capacity int not null,
  price_per_km double not null
);

create table stop (
  stop_id int primary key auto_increment,
  train_id int not null,
  station_id int not null,
  arrival_time time, -- each train will have a null arrival_time for its origination stop
  departure_time time, -- each train will have a null departure_time for its terminus stop
  distance int, -- distance from origin

  foreign key (station_id) references station(station_id)
    on update cascade
    on delete restrict,
  foreign key (train_id) references train(train_id)
    on update cascade
    on delete cascade
);

-- Design 1
create table trip_train (
  trip_id int primary key auto_increment,
  embark1_stop_id int not null,
  disembark1_stop_id int not null,
  embark2_stop_id int
  disembark2_stop_id int,

  foreign key (embark_stop_id) references stop(stop_id)
    on update cascade
    on delete restrict,
  foreign key (disembark_stop_id) references stop(stop_id)
    on update cascade
    on delete restrict
);

-- Design 2
create table trip_stop (
  trip_id int,
  stop_id int,

  primary key (trip_id, stop_id),
  foreign key (trip_id) references trip(trip_id),
  foreign key (stop_id) references stop(stop_id)
);
