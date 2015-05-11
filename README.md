EPP/REPP Web Client
===================

This application connects to any domain registry that is compatible 
with Extensible Provisioning Protocol (EPP) version 1.0 
(described by [RFC 5730](https://tools.ietf.org/html/rfc5730))

EPP web client is built on Ruby on Rails without database.
All request goes strictly over EPP or REPP.


Installation
------------

Usual Rails 4 app installation, 
rbenv install is under [Debian system setup](../../../registry/blob/master/doc/debian_build_doc.md)

Manual demo install and database setup:

    # at your server
    cd /home/registry
    git clone https://github.com/internetee/EPP-web-client.git demo-webclient
    cd demo-webclient
    rbenv local 2.2.1
    bundle
    cp current/config/application-example.yml shared/config/application.yml # and edit it
    cp config/secrets-example.yml config/secrets.yml # and generate your own key with 'rake secret'
    bundle exec rake assets:precompile

Production install

    # at your local machine
    git clone https://github.com/internetee/EPP-web-client.git webclient
    cd webclient
    rbenv local 2.2.1
    gem install mina
    mina pr setup # one time, only creates missing directories
    ssh webclient
    # at your server
    cd webclient
    # You can generate secret keys with 'bundle exec rake secret'
    cp current/config/secrets-example.yml shared/config/secrets.yml # and edit it
    cp current/config/application-example.yml shared/config/application.yml # and edit it
    exit
    # at your local machine
    mina pr deploy # this is command you use in every application code update

For Apache, epp web client goes to port 443 in production, /etc/apache2/sites-enabled/webclient.conf short example:

    <VirtualHost *:443>
      ServerName webclient.example.com
      ServerAdmin admin@example.com

      PassengerRoot /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini
      PassengerRuby /home/registry/.rbenv/shims/ruby
      PassengerEnabled on
      PassengerMinInstances 1
      PassengerMaxPoolSize 10
      PassengerPoolIdleTime 0
      PassengerMaxRequests 1000

      RailsEnv production
      DocumentRoot /home/registry/webclient/current/public
      
      # Possible values include: debug, info, notice, warn, error, crit,
      LogLevel info
      ErrorLog /var/log/apache2/webclient.error.log
      CustomLog /var/log/apache2/webclient.access.log combined
      
      SSLEngine On
      SSLCertificateFile    /etc/ssl/certs/your.crt
      SSLCertificateKeyFile /etc/ssl/private/your.key
      SSLCertificateChainFile /etc/ssl/certs/your-chain-fail.pem
      SSLCACertificateFile /etc/ssl/certs/ca.pem
      SSLCARevocationFile /home/registry/registry/shared/ca/crl/crl.pem
      # Uncomment this when upgrading to apache 2.4:
      # SSLCARevocationCheck chain

      SSLProtocol TLSv1
      SSLHonorCipherOrder On
      SSLCipherSuite RC4-SHA:HIGH:!ADH

      <Directory /home/registry/webclient/current/public>
        # comment out if Apache 2.4 or newer
        Allow from all

        # uncomment if Apache 2.4 or newer
        # Require all granted

        Options -MultiViews
      </Directory>

      SSLVerifyClient none
      SSLVerifyDepth 1
      SSLCACertificateFile /home/registry/registry/shared/ca/certs/ca.crt.pem

      RequestHeader set SSL_CLIENT_S_DN_CN ""

      <Location /sessions>
        SSLVerifyClient require
        RequestHeader set SSL_CLIENT_S_DN_CN "%{SSL_CLIENT_S_DN_CN}s"
      </Location> 
    </VirtualHost>

### Certificates setup

* [Certificates setup](../../../registry/blob/master/doc/certificates.md)

Deployment
----------

* [Debian build](../../../registry/blob/master/doc/debian_build_doc.md)
* [Application build and update](../../../registry/blob/master/doc/application_build_doc.md)
