#
# FlowWeb Dockerfile
#
# https://github.com/FlowCI/flow-web
#
FROM flowci/flow-web-base:latest

MAINTAINER admin@flow.ci

# add env to docker
ENV FLOW_WEB_SOURCE=/tmp/flow-web
ENV FLOW_WEB_DIR=/var/www/flow-web
ENV FLOW_WEB_API=:FLOWCI:
# taobao proxy
ENV PHANTOMJS_CDNURL=https://npm.taobao.org/mirrors/phantomjs/
ENV SASS_BINARY_SITE=https://npm.taobao.org/mirrors/node-sass/

COPY . $FLOW_WEB_SOURCE
COPY ./docker/nginx.conf /etc/nginx/sites-enabled/default
COPY ./docker/flow-web.sh $FLOW_WEB_DIR/flow-web.sh

WORKDIR $FLOW_WEB_SOURCE

# install yarn and install package
RUN 	yarn config set registry 'https://registry.npm.taobao.org' \
		&& yarn install \
        && npm run build \
        && mkdir -p $FLOW_WEB_DIR \
        && cp -r $FLOW_WEB_SOURCE/dist/* $FLOW_WEB_DIR 


WORKDIR $FLOW_WEB_DIR

CMD bash $FLOW_WEB_DIR/flow-web.sh && nginx -g 'daemon off;'