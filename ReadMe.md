# Introduction #

reHour provides consulting companies and organizations a way to keep track the time spent by their people doing work to their clients. reHour allows consultants to logon and input their working hours anytime and anywhere via a web-based interface. Detailed and summary reports can then be generated easily by a click of a button. reHour can serve multiple projects and consultants at the same time.

reHour is an Open Source project written in Ruby on Rails.

# Requirements #

  * Rails >= 2.3.4
  * Ruby
  * MySQL (or SQLite)
  * SVN for checking out code

# Installation #

I'm still working on creating a downloadable version of the package. For the mean time, you need to checkout the source code:

> a. Check out code:

> `$ svn checkout http://rehour.googlecode.com/svn/trunk/ rehour`
> `$ cd rehour`

> b. Copy and edit the database config file:

> `$ cp config/database.yml.example config/database.yml`
> `$ vi config/database.yml`

> c. Create the database:

> `$ rake db:create`

> d. Create the database schema:

> `$ rake db:migrate`

> e. Load the require data:

> `$ rake db:seed`

> f. Run server:

> `$ ruby script/server`

You're done! You can login using the default admin account:

> Username: admin
> Password: admin1

# Credits #

Thies Edeling
http://ehour.nl/

# License #

== MIT License

Copyright (c) 2009-2010 Diwa del Mundo

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.