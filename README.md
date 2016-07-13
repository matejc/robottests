Description
===========

Run robot tests every 5min inside docker with phantomjs


Build & Run
===========

    docker build -t my/tests .
    docker run --rm -p 5000:5000 -v `pwd`/extra:/tests/extra -it my/tests:latest


Example
=======

    ./sites/blog.matejc.com/basic.robot


Links
=====

  - http://rtomac.github.io/robotframework-selenium2library/doc/Selenium2Library.html


AngularJS support
=================

  - https://pypi.python.org/pypi/robotframework-extendedselenium2library/0.9.1
  - https://rickypc.github.io/robotframework-extendedselenium2library/doc/ExtendedSelenium2Library.html
