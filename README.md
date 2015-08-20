# Train System

##### , August 20 2015

#### By Vaughn Dice & Janice Laset-Parkerson

## Description
The application allows train system operators to add, update and delete information. It also allows train riders to read information regarding when and where they can ride a train.


## Setup

* git clone https://github.com/janicelaset/train_system.git
* run ruby app.rb
* navigate to localhost:4567 in your web browser

Create databases and tables:

Database: train_system

Table: cities
name | id
------+----

Table: trains
name | id
------+----

Table: stops
train_id | city_id | eta
----------+---------+-----

Please visit (heroku app link) to use the application.

## Technologies Used

* Sinatra
* Capybara
* rspec
* Postgres   


### Legal

Copyright (c) 2015 Vaughn Dice & Janice Laset-Parkerson

This software is licensed under the MIT license.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
