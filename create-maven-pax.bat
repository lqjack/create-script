cd %~dp0
call pax-create-project -g org.ideawork.osgiapp -a osgiapp -v 1.0.0
cd osgiapp
call pax-create-module -g org.ideawork.osgiapp -a osgiapp-login -v 1.0.0
cd osgiapp-login
call pax-create-bundle -p org.ideawork.osgiapp.login.dto -n osgiapp-login-dto -g org.ideawork.osgiapp.login -v 1.0.0 
call pax-create-bundle -p org.ideawork.osgiapp.login.domain -n osgiapp-login-domain -g org.ideawork.osgiapp.login -v 1.0.0 -- -Djunit "-Dactivator=false"
call pax-create-bundle -p org.ideawork.osgiapp.login.repository.impl -n osgiapp-login-repository-impl -g org.ideawork.osgiapp.login -v 1.0.0 -- -Djunit "-Dactivator=false"
call pax-create-bundle -p org.ideawork.osgiapp.login.service -n osgiapp-login-service -g org.ideawork.osgiapp.login -v 1.0.0 
call pax-create-bundle -p org.ideawork.osgiapp.login.service.impl -n osgiapp-login-service-impl -g org.ideawork.osgiapp.login -v 1.0.0 -- -Djunit "-Dactivator=false"
cd ..
call pax-create-bundle -p org.ideawork.osgiapp.webapp -n osgiapp-webapp -g org.ideawork.osgiapp -v 1.0.0 -- -Djunit "-Dactivator=false"

call pax-wrap-jar -g mysql -a mysql-connector-java -v 5.1.16

call mvn pax:import-bundle -DgroupId=org.apache.felix -DartifactId=org.apache.felix.webconsole -Dversion=3.1.8
call mvn pax:import-bundle -DgroupId=org.apache.felix -DartifactId=org.apache.felix.http.webconsole -Dversion=3.1.8 -DimportTransitive=true -DimportOptional=true -DwidenScope=true 
call mvn pax:import-bundle -DgroupId=org.apache.felix -DartifactId=org.apache.felix.scr   -Dversion=1.6.0
call mvn pax:import-bundle -DgroupId=org.apache.felix -DartifactId=org.apache.felix.scr -Dversion=1.6.0 -DimportTransitive=true -DimportOptional=true -DwidenScope=true 

call mvn pax:import-bundle -DgroupId=org.apache.felix -DartifactId=org.apache.felix.http.jetty -Dversion=2.2.0
call mvn pax:import-bundle -DgroupId=org.apache.felix -DartifactId=org.apache.felix.http.jetty -Dversion=2.2.0 -DimportTransitive=true -DimportOptional=true -DwidenScope=true 

mvn clean install pax:provision

pause
