08.01.2017
* EPP XML schema "eis-1.0.xsd" replaced with "ee-1.1.xsd"

16.12.2016
* EPP XML schema namespace "urn:ietf:params:xml:ns:epp-1.0" replaced with "https://epp.tld.ee/schema/epp-ee-1.0.xsd"
* EPP XML schema contact-eis-1.0 replaced with contact-ee-1.1

17.05.2016

* Removed dependency on epp-xml gem on rubygems and redirected to locally maintained version  https://github.com/internetee/epp-xml
* Added option to set verifyed element for domain registrant change and domain delete

20.07.2015

* Example mina/deploy.rb renamed to mina/deploy-example.rb in order to not overwrite local deploy scripts

12.05.2015

* Update ruby version to 2.2.2

11.05.2015

* Registrar: only dev can skip pki login certificate, 
  please be sure all application.yml and apache conf is correctly setup for pki
* Updated Apache confing readme: updated location directive

16.03.2015

* Ruby upgraded to version 2.2.1, 
  added RBENV upgrade howto to debian doc at: registry_repo/doc/debian_build_doc.md

27.02.2015

* Simplified config/application-example.yml, 
  now system will check if all required settings are present in application.yml 

25.02.2015

* Now certs are turned on, please follow documentation at registry repo registry/doc/certificates.md
* Add cert_path and key_path to config/application.yml

30.01.2015

* Add `session_timeout: 1800 # seconds` to application.yml

19.01.2015

* Upgraded to Rails 4.2 and new ruby 2.2.0, please be sure rbenv has ruby 2.2.0 installed
  NB! Update you passenger deb install, it should have recent fix for ruby 2.2.0
* Added config/application-example.yml file for reference
* Removed config/initialize/epp_host.rb and replaced with config/application.yml,
  please update your config/application.yml accordingly to your env.
* Staging env added, please change apache conf in staging servers to "RailsEnv staging"
  Then you need to add or update staging section in
  --> config/application.yml
  --> config/secrets.yml
  --> config/application.yml
  They all have example files with name exapmle present.
