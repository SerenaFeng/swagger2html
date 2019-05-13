FROM openjdk:8-jre-alpine
MAINTAINER SerenaFeng

WORKDIR /home

RUN apk update && \
    apk add ca-certificates wget bash asciidoctor && \
    update-ca-certificates && \
    wget -O swagger2markup.jar https://jcenter.bintray.com/io/github/swagger2markup/swagger2markup-cli/1.3.3/swagger2markup-cli-1.3.3.jar

COPY ./convert.sh ./
RUN chmod +x ./convert.sh

ENV JAVA_OPTS="-Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8"

CMD ["./convert.sh"]

