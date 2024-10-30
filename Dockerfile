FROM maven:3.8.1-openjdk-17-slim

# meta
LABEL maintainer="leidenheit <X: @leidenheit>"
LABEL version="0.1.0"
LABEL description="Itarazzo Client for running workflow tests based on the Arazzo Specification"
LABEL license="Apache-2.0"

# create nonroot user with group
RUN groupadd -r runners && useradd -r -g runners itarazzobot

# create workdir and set permission
WORKDIR /itarazzo
RUN chown itarazzobot:runners /itarazzo

# create sub directories in order to prevent permission issues
RUN mkdir -p /itarazzo/target
RUN chown itarazzobot:runners /itarazzo/target
RUN mkdir -p /itarazzo/resources
RUN chown itarazzobot:runners /itarazzo/resources

# copy sources
COPY --chown=itarazzobot:runners . .
COPY --chown=itarazzobot:runner src/main/resources/init/entrypoint.sh /entrypoint.sh

# make script executable
RUN chmod +x /entrypoint.sh

# switch to non-root user
USER itarazzobot

# fire it up
ENTRYPOINT ["/entrypoint.sh"]
