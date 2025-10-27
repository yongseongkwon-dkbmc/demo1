# 베이스 이미지 선택
FROM openjdk:21-jdk-slim

# 환경 변수 설정
ENV APP_ROOT_PATH=/NEXEN_CRM/application/apps
ENV JAR_NAME=nx-spring-batch-0.0.1-SNAPSHOT.jar
#ENV MEMORY=1028
WORKDIR /var/jenkins_home/workspace/nx-spring-batch
#
# # 타임존 설정을 위해 tzdata 설치
# RUN apt-get update && apt-get install -y tzdata
#
# # 타임존 설정
# ENV TZ=Asia/Seoul
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# # 타임존 환경변수 설정

ENV TZ=Asia/Seoul

# tzdata 설치 및 타임존 설정
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 임시 주석
# 애플리케이션 파일 복사
# COPY lib/libsapjco3.so /usr/lib/libsapjco3.so
# RUN chmod 777 /usr/lib/libsapjco3.so
# libsapjco3.so가 복사되었는지 확인
# RUN ls -al /usr/lib
# COPY build/libs/${JAR_NAME} $APP_ROOT_PATH/$JAR_NAME

# openjdk 17 설치
#RUN apt-get update
#RUN apt-get install -y openjdk-17-jdk

# 환경변수 설정
ENV JAVA_HOME /opt/java/openjdk
ENV PATH $JAVA_HOME/bin:$PATH

WORKDIR /NEXEN_CRM

# 애플리케이션 실행
CMD ["sh", "-c", "java -Xms${MEMORY}m -Xmx${MEMORY}m -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8 -Dconsole.encoding=UTF-8 -jar $APP_ROOT_PATH/$JAR_NAME --spring.profiles.active=$SPRING_PROFILE"]
