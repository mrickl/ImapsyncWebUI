# ImapsyncWebUI


# German
Dies ist das Repostiory für das Docker Container "Imapsyncwithwebui"

Imapsync with WebUI ist eine Kombination aus dem Imapsync von https://imapsync.lamiral.info/ und seiner WebUI.

Da es bisher nur das Imapsync als Docker gab, aber bisher nicht in Kombination mit der WebUI habe ich dieses Docker Container gebaut.

Der Webserver Port innerhalb des Containers ist Port 80. 

Installtion des Containers: 

# Code 
docker run -d --name imapsync -p 80:80 mrickl/imapsyncwithwebui

# English

This is the repostiory for the Docker container "Imapsyncwithwebui".

Imapsync with WebUI is a combination of the Imapsync from https://imapsync.lamiral.info/ and his WebUI.

Since so far there was only the Imapsync as Docker, but so far not in combination with the WebUI .

The web server port inside the container is port 80. 

Installtion of the container: 

docker run -d --name imapsync -p 80:80 mrickl/imapsyncwithwebui
