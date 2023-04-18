FROM maven:3.8.3-openjdk-17 AS build
RUN mkdir -p workspace
WORKDIR workspace
COPY pom.xml /workspace
COPY src /workspace/src
COPY client /workspace/client
RUN mvn -f pom.xml clean install -DskipTests=true


FROM amazoncorretto:17
COPY --from=build /workspace/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]