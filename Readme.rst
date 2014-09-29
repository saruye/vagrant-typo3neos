======================
TYPO3 Neos Vagrant Box
======================

This Vagrant Box is based on the work of Thomas Layh (2013).

Description
===========

Will install the current master of TYPO3 Neos including all required setups for the server environment.

Installation
============

1. Download and install Vagrant and VirtualBox

* http://downloads.vagrantup.com/
* https://www.virtualbox.org/wiki/Downloads

*Tested with Vagrant 1.6.3 and VirtualBox 4.3.12 on Mac OS X*

2. Install required plugins

	.. code::

		vagrant plugin install librarian
		vagrant plugin install librarian-chef
		vagrant plugin install vagrant-vbguest
		vagrant plugin install vagrant-librarian-chef
		vagrant plugin install vagrant-omnibus


3. Clone this repository and change into the project directory git creates

4. Install required cookbooks

	.. code::

		librarian-chef install

5. Add to your host file

	.. code::

		192.168.23.4 typo3.neos

6. Run

	.. code::

		vagrant up

7. Call the page http://typo3.neos/setup and complete the setup using the TYPO3 Neos setup tool

	.. code::

		Username: root
		Password: root

8. Shutdown with

	.. code::

		vagrant suspend

9. Restart with

	.. code::

		vagrant resume
