#!/bin/bash

java -version
if [ $? != 0 ];then
	echo "请安装配置java环境！"
fi

mvn -v
if [ $? != 0 ];then
	echo "请安装并配置maven环境！"
fi

pax-create-project -g org.ideawork.osgiapp -a osgiapp -v 1.0.0
cd osgiapp
pax-create-module -g org.ideawork.osgiapp -a osgiapp-login -v 1.0.0
cd osgiapp-login
echo "module"
pax-create-bundle -p org.ideawork.osgiapp.login.dto -n osgiapp-login-dto -g org.ideawork.osgiapp.login -v 1.0.0 
echo "dto"
pax-create-bundle -p org.ideawork.osgiapp.login.domain -n osgiapp-login-domain -g org.ideawork.osgiapp.login -v 1.0.0 -- -Djunit "-Dactivator=false"
echo "domain"
pax-create-bundle -p org.ideawork.osgiapp.login.repository.impl -n osgiapp-login-repository-impl -g org.ideawork.osgiapp.login -v 1.0.0 -- -Djunit "-Dactivator=false"
pax-create-bundle -p org.ideawork.osgiapp.login.service -n osgiapp-login-service -g org.ideawork.osgiapp.login -v 1.0.0 
echo "repo.imp"
pax-create-bundle -p org.ideawork.osgiapp.login.service.impl -n osgiapp-login-service-impl -g org.ideawork.osgiapp.login -v 1.0.0 -- -Djunit "-Dactivator=false"
cd ..
pax-create-bundle -p org.ideawork.osgiapp.webapp -n osgiapp-webapp -g org.ideawork.osgiapp -v 1.0.0 -- -Djunit "-Dactivator=false"
mvn clean install eclipse:eclipse  pax:provision
done
