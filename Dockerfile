# 베이스 이미지를 작성한다.
FROM ubuntu:14.04

# 작성자 정보를 입력한다.
MAINTAINER "hur.yeongseon <yshur@yeongseon.com>"

# 이미지를 설명한다.
LABEL "purpose"="webserver pratice"

# apt 업데이트 후 필요한 패키지를 설치한다. 이후 사용했던 apt 캐시를 삭제한다.
# -qq 옵선은 quiet 옵션의 2단계로 로깅 정보를 삭제해 주고, --no-install-recommands 옵션을 통해 apt가 자동으로 권장 패키지를 설치하지 않게 하여 꼭 필요한 패키지만 설치된다.
RUN apt-get update && \
    apt-get install apache2 -y -qq --no-install-recommands && \
    apt-get clean -y && \
    apt-get autoremove -y && \
    rm -rfv /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 해당 경로로 이동한다. (없는 경우 자동 생성)
WORKDIR /var/www/html

# WORKDIR을 통해 이동된 경로에 호스트 파일인 index.html을 복사한다. (COPY 가능)
ADD index.html .
ADD docker_logo.png .

# 커테이너의 80번 포트를 열어준다
EXPOSE 80

# 컨테이너 실행 시 자동으로 아파치 데몬을 실행한다.
CMD apachectl -D FOREGROUND
