from dkundel/sslaunch

WORKDIR /sdk-starter-kits/java

RUN  apt-get install -y maven

RUN echo "Downloading SDK Starter Java"
RUN wget -O java.zip "https://github.com/TwilioDevEd/sdk-starter-java/archive/master.zip"

RUN echo "Unzipping SDK Starter Java"
RUN unzip java.zip
RUN rm java.zip

WORKDIR /sdk-starter-kits/java/sdk-starter-java-master
RUN ls -l
RUN cp .env.example .env

EXPOSE 4567
RUN mvn install
RUN mvn package

CMD ["java","-jar","target/sdk-starter-1.0-SNAPSHOT.jar"]
