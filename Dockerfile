FROM java:8

WORKDIR /opt/graphhopper

RUN wget https://graphhopper.com/public/releases/graphhopper-web-3.0.jar

ADD files /opt/graphhopper

VOLUME ["/data", "/cache"]

EXPOSE 8989

CMD ["/opt/graphhopper/starter.sh"]