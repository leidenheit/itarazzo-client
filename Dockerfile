# Dockerfile to build and run the Itarazzo Client script

FROM maven:3.8.1-openjdk-17-slim

# meta
LABEL maintainer="leidenheit <X: @leidenheit>"
LABEL version="0.1.0"
LABEL description="Itarazzo Client for running workflow tests based on Arazzo Specifications"
LABEL license="Apache-2.0"

# create non-root user with group
RUN groupadd -g 1001 -r runners && useradd -u 1001 -r -g runners itarazzobot && \
    # create necessary directories and set appropriate permissions
    mkdir -p /itarazzo/target /itarazzo/resources /home/itarazzobot/.m2/repository && \
    chown -R itarazzobot:runners /itarazzo /home/itarazzobot/.m2

# set working directory
WORKDIR /itarazzo

# copy sources and set ownership
COPY --chown=itarazzobot:runners . /itarazzo
COPY --chown=itarazzobot:runners src/main/resources/init/entrypoint.sh /entrypoint.sh

# make script executable
RUN chmod +x /entrypoint.sh

# switch to non-root user
USER itarazzobot

# fire it up
ENTRYPOINT ["/entrypoint.sh"]

# debug: keep container running if entrypoint script ends
#CMD ["tail", "-f", "/dev/null"]
