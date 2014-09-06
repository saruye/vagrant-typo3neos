======================
TYPO3 Neos Vagrant Box
======================

This Vagrant Box is based on the work of Thomas Layh (2013).

Description
===========

Will install the current master of TYPO3 Neos including all required setups for the server environment.

Installation
============

*Tested with Vagrant 1.6.3 and VirtualBox 4.3.12 on Mac OS X*

1. Download the Vagrant installer from http://downloads.vagrantup.com/

2. Install required plugins

	.. code::

		vagrant plugin install chef
		vagrant plugin install librarian
		vagrant plugin install librarian-chef
		vagrant plugin install vagrant-vbguest
		vagrant plugin install vagrant-librarian-chef
		vagrant plugin install vagrant-omnibus

3. Install required cookbooks

	.. code::

		librarian-chef install

4. Add to your host file

	.. code::

		192.168.23.4 typo3.neos

5. Run

	.. code::

		vagrant up

6. Call the page http://typo3.neos/setup and complete the setup using the TYPO3 Neos setup tool

	.. code::

		Username: root
		Password: root

7. Shutdown with

	.. code::

		vagrant suspend

8. Restart with

	.. code::

		vagrant resume
