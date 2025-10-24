# 베이스 이미지 선택
FROM openjdk:21-ea-slim

# 환경 변수 설정
ENV APP_ROOT_PATH=/DMS/application/apps
ENV JAR_NAME=demo1-0.0.1-SNAPSHOT-plain.jar

WORKDIR /DMS

# 타임존 설정을 위해 tzdata 설치
RUN apt-get update && apt-get install -y tzdata

# 타임존 설정
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 애플리케이션 파일 복사
COPY build/libs/${JAR_NAME} $APP_ROOT_PATH/$JAR_NAME

# 환경변수 설정
ENV JAVA_HOME /usr/local/openjdk-21
ENV PATH $JAVA_HOME/bin:$PATH

# 애플리케이션 실행
CMD ["sh", "-c", "java -Xms${MEMORY}m -Xmx${MEMORY}m -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8 -Dconsole.encoding=UTF-8 -jar $APP_ROOT_PATH/$JAR_NAME --spring.profiles.active=$SPRING_PROFILE"]