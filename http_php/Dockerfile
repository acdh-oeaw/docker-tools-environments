# Image for serving HTTP/PHP environment:
# Apache is running using the ITK module so
# --cap-add=SYS_NICE --cap-add=DAC_READ_SEARCH docker privileges are required
FROM acdh/http
MAINTAINER Mateusz Żółtak <mateusz.zoltak@oeaw.ac.at>

# install software
# enableing the ITK module is a little tricky (requires MPM event module to be
#   disabled first), so it takes 3 lines of code
RUN apt-get update && \
  apt-get install -y php5-cli libapache2-mod-php5 php5-pgsql php5-mysql php5-gd php5-recode php5-readline php5-json php5-curl php5-gmp php5-ldap php5-odbc php5-sqlite php5-xsl php5-xmlrpc php5-intl php-pear && \
  apt-get clean

# expose
EXPOSE 80

