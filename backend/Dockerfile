FROM openjdk:17-jdk-alpine

ARG JAR_FILE=src/*.jar

COPY ./src/tic-tac-toe.jar tic-tac-toe.jar
ENTRYPOINT ["java", "-jar"]
CMD ["/tic-tac-toe.jar"]
