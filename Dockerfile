FROM alpine:3.9
RUN apk add --no-cache mysql-client
RUN mysqldump --version
ADD ping.sh .
ADD clone.sh .
RUN chmod +x ping.sh
RUN chmod +x clone.sh
CMD sh clone.sh
